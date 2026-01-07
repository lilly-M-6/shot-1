#!/usr/bin/env python3
"""
End-to-end masking script:

- Loads pyranet_maskable_13.v
- Extracts each Verilog module
- Applies a PROLEAD-safe first-order masking prompt
- Calls GPT-5-mini
- Saves masked results to JSON
"""

import os
import re
import json
from pathlib import Path
from datetime import datetime
from openai import OpenAI


# ------------------------------------------------------------
#  OpenAI client (env var only)
# ------------------------------------------------------------
def get_openai_client():
    api_key = os.getenv("OPENAI_API_KEY")
    if not api_key:
        raise RuntimeError("OPENAI_API_KEY environment variable not set.")
    return OpenAI(api_key=api_key)


# ------------------------------------------------------------
#  Load unmasked Verilog modules
# ------------------------------------------------------------
def load_unmasked_examples(verilog_path: Path):
    if not verilog_path.exists():
        raise FileNotFoundError(f"Verilog file not found: {verilog_path}")

    text = verilog_path.read_text()

    pattern = re.compile(
        r"(module\s+[A-Za-z0-9_]+\s*\([^)]*\)\s*;[\s\S]*?endmodule)",
        re.MULTILINE
    )

    modules = pattern.findall(text)

    examples = []
    for idx, block in enumerate(modules, 1):
        name_match = re.search(r"module\s+([A-Za-z0-9_]+)", block)
        name = name_match.group(1) if name_match else f"module_{idx}"

        examples.append({
            "id": f"unpyr_{idx}",
            "name": name,
            "code": block
        })

    return examples


# ------------------------------------------------------------
#  PROLEAD-safe masking prompt
# ------------------------------------------------------------
SYSTEM_MESSAGE = (
    "You are a hardware masking transformation tool. "
    "You convert unmasked, purely combinational Boolean Verilog modules "
    "into first-order secure masked equivalents using 2-share Boolean masking. "
    "You output ONLY synthesizable Verilog and nothing else."
)


USER_PROMPT_PREFIX = """You are converting an UNMASKED, COMBINATIONAL Verilog module into a
FIRST-ORDER (d = 1) Boolean-masked version using EXACTLY TWO SHARES.

THE INPUT MODULE:
• Is purely combinational
• May contain AND (&), OR (|), XOR (^), and NOT (~)
• Contains NO clocks, always blocks, or control flow
• Uses bitwise (not logical) operators only

You must produce a FUNCTIONALLY EQUIVALENT masked module.

====================================================
MASKING MODEL (MANDATORY)
====================================================

• Each signal x is represented as: x = x0 ^ x1
• x0 and x1 must NEVER be recombined inside the module
• All masking must be local and explicit
• Randomness is ONLY permitted inside masked AND operations

====================================================
BOOLEAN NORMALIZATION RULES
====================================================

Before masking, you MUST conceptually normalize logic so that:
• The ONLY non-linear operation is AND (&)

Specifically:
• OR must be rewritten as: a | b = a ^ b ^ (a & b)
• XOR remains XOR
• NOT remains NOT
• Do NOT introduce any new Boolean functionality
• Do NOT optimize or simplify expressions
• Preserve the original structure as much as possible

====================================================
MASKING RULES
====================================================

1) LINEAR OPERATIONS (XOR, NOT, wire assignments)
   • Must be applied share-wise
   • MUST NOT use randomness
   • MUST NOT mix shares

2) NON-LINEAR OPERATION (AND)
   Every AND must be replaced with EXACTLY this structure:

     p00 = a0 & b0
     p01 = a0 & b1
     p10 = a1 & b0
     p11 = a1 & b1

     c0 = p00 ^ p01 ^ rN
     c1 = p11 ^ p10 ^ rN

   • Exactly ONE fresh randomness input per AND
   • rN must appear in BOTH output shares
   • Randomness must NOT appear anywhere else

====================================================
STRUCTURAL REQUIREMENTS
====================================================

• Combinational logic only
• Synthesizable Verilog only
• Do NOT use:
    always, posedge, negedge, clk, reset,
    $random, generate, for, while
• Do NOT reference outputs on the RHS
• Do NOT introduce registers or state
• Do NOT reorder logic unless required for masking

====================================================
MODULE INTERFACE
====================================================

• Module name: <original_name>_masked

• Inputs:
    - One port per share for each original input (x0, x1)
    - One randomness input rN for EACH AND (r0, r1, r2, ...)

• Outputs:
    - One port per share for each original output (y0, y1)

• All randomness inputs must be USED
• No unused wires or ports

====================================================
FORBIDDEN PATTERNS (MUST NOT APPEAR)
====================================================

• Any recombination of shares (x0 ^ x1)
• Randomness outside masked AND logic
• Identical output shares
• Outputs depending on both x0 and x1
• Logical operators (&&, ||, !)

====================================================
OUTPUT FORMAT
====================================================

• Output ONLY valid Verilog
• NO comments
• NO explanations
• NO markdown fences

====================================================
NOW MASK THIS MODULE:

<original_code>
"""


def build_user_prompt(prefix: str, code: str) -> str:
    return prefix.replace("<original_code>", code)


# ------------------------------------------------------------
#  GPT call
# ------------------------------------------------------------
def mask_with_gpt(client: OpenAI, full_prompt: str):
    response = client.chat.completions.create(
        model="gpt-5-mini",
        messages=[
            {"role": "system", "content": SYSTEM_MESSAGE},
            {"role": "user", "content": full_prompt}
        ]
    )

    return {
        "masked_code": response.choices[0].message.content,
        "finish_reason": response.choices[0].finish_reason
    }


# ------------------------------------------------------------
#  MAIN
# ------------------------------------------------------------
def main():
    script_dir = Path(__file__).parent
    unmasked_file = script_dir / "pyranet_maskable_13.v"

    print("\n===============================================")
    print("   PyraNet → GPT-5-Mini → PROLEAD-Safe Masking")
    print("===============================================\n")

    print(f"Loading unmasked modules from: {unmasked_file}")
    examples = load_unmasked_examples(unmasked_file)
    print(f"→ Found {len(examples)} modules.\n")

    client = get_openai_client()

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    outfile = script_dir / f"masked_results_{timestamp}.json"

    results = {
        "timestamp": timestamp,
        "model": "gpt-5-mini",
        "modules": []
    }

    for idx, ex in enumerate(examples[5:19], 1):
        print(f"[{idx}] Masking module: {ex['name']}")

        user_prompt = build_user_prompt(USER_PROMPT_PREFIX, ex["code"])
        gpt_result = mask_with_gpt(client, user_prompt)

        results["modules"].append({
            "id": ex["id"],
            "module_name": ex["name"],
            "original_code": ex["code"],
            "masked_code": gpt_result["masked_code"],
            "finish_reason": gpt_result["finish_reason"]
        })

    print(f"\nSaving masked results → {outfile}")
    outfile.write_text(json.dumps(results, indent=2))
    print("✓ Done.")

    print("\n===============================================")
    print("               COMPLETE")
    print("===============================================")


if __name__ == "__main__":
    main()
