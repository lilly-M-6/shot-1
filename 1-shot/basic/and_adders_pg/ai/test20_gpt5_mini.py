#!/usr/bin/env python3
"""
End-to-end masking script:

- Loads unmasked_pyranet8.v
- Extracts each Verilog module
- Applies a PROLEAD-safe first-order masking prompt
- Calls GPT (gpt-4o-mini)
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
def load_unmasked_examples(verilog_path):
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
    "You are a hardware masking generator. "
    "You convert unmasked Boolean circuits into first-order secure "
    "masked circuits using 2-share Boolean masking. "
    "You output ONLY synthesizable Verilog and nothing else."
)

USER_PROMPT_PREFIX = """You are converting an unmasked combinational Verilog module into a
FIRST-ORDER (d = 1) Boolean-masked version using EXACTLY TWO SHARES.

CRITICAL DEFINITIONS:
• A signal x is represented as x = x0 ^ x1
• x0 and x1 must NEVER be recombined inside the module
• Randomness is ONLY allowed inside masked AND operations

ABSOLUTE RULES (violations = incorrect output):

1) LINEAR OPERATIONS (XOR, NOT, wire assignments)
   • Must be applied share-wise
   • MUST NOT use randomness
   • MUST NOT mix x0 and x1
   Examples:
     y = a ^ b       → y0 = a0 ^ b0,  y1 = a1 ^ b1
     y = ~a          → y0 = ~a0,      y1 = ~a1
     y = a           → y0 = a0,       y1 = a1

2) NON-LINEAR OPERATION (AND) — THIS IS THE ONLY PLACE RANDOMNESS IS ALLOWED
   Replace every (a & b) with EXACTLY this structure:

     Inputs:  a0, a1, b0, b1, rN
     Outputs: c0, c1

     p00 = a0 & b0
     p01 = a0 & b1
     p10 = a1 & b0
     p11 = a1 & b1

     c0 = p00 ^ p01 ^ rN
     c1 = p11 ^ p10 ^ rN

   • Exactly ONE fresh randomness input per AND
   • rN must appear in BOTH output shares
   • No clocks, no registers, no always blocks

3) STRUCTURAL REQUIREMENTS:
   • Combinational logic only
   • Synthesizable Verilog only
   • Do NOT use: always, posedge, negedge, clk, $random, generate, for
   • Do NOT use DOM, HPC, or pipeline stages
   • Do NOT reference outputs on RHS

4) MODULE INTERFACE:
   • Module name must be: <original_name>_masked
   • Inputs:
       - One port per share for each original input (x0, x1)
       - One randomness input rN PER AND (r0, r1, r2, …)
   • Outputs:
       - One port per share for each original output (y0, y1)

5) FORBIDDEN PATTERNS (MUST NOT APPEAR):
   • (a0 ^ a1) or any recombination of shares
   • Randomness used outside masked AND
   • Both output shares being identical
   • Outputs depending on both x0 and x1
   • Unused randomness inputs

OUTPUT FORMAT:
• Output ONLY valid Verilog
• NO comments
• NO explanations
• NO markdown fences

NOW MASK THIS MODULE:

<original_code>

"""


def build_user_prompt(prefix, code):
    return (
        prefix
        + "\n\nNOW MASK THIS MODULE:\n```verilog\n"
        + code
        + "\n```"
    )


# ------------------------------------------------------------
#  GPT call
# ------------------------------------------------------------
def mask_with_gpt(client, full_prompt):
    response = client.chat.completions.create(
        model="gpt-4o-mini",
        temperature=0.1,
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
    print("   PyraNet → GPT → PROLEAD-Safe Masking")
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

    for idx, ex in enumerate(examples[20:21], 1):
        print(f"[{idx}/{len(examples)}] Masking module: {ex['name']}")

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
    print("✓ Done.\n")

    print("===============================================")
    print("               COMPLETE")
    print("===============================================")


if __name__ == "__main__":
    main()
