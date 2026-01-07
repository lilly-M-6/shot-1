from datasets import load_dataset
from pathlib import Path
import re

dataset = load_dataset("bnadimi/PyraNet-Verilog")
train = dataset["train"]

OUT_FILE = Path("pyranet_maskable_rewrite_or.v")
NUM_EXAMPLES = 20


# Word-based constructs (safe with \b)
FORBIDDEN_WORDS = [
    "always",
    "posedge",
    "negedge",
    "clk",
    "clock",
    "reset",
    "rst",
    "case",
    "for",
    "while",
    "if",
    "initial",      # testbenches
]

# Symbol-based constructs (string match only)
FORBIDDEN_SYMBOLS = [
    "?",            # ternary
    "&&",           # logical AND
    "||",           # logical OR
    "!"             # logical NOT
]


def is_trivial_and_or_half_adder(code: str) -> bool:
    """
    Reject trivial:
    - single AND gates
    - pure multi-input ANDs
    - half adders / PG blocks (XOR + AND)
    """
    c = re.sub(r"\s+", " ", code.lower())
    assign_count = len(re.findall(r"\bassign\b", c))

    # Single AND gate
    if assign_count == 1 and re.search(r"=\s*\w+\s*&\s*\w+\s*;", c):
        return True

    # Pure AND-only logic (includes multi-input AND)
    if "&" in c and "^" not in c and "|" not in c:
        return True

    # Half-adder / PG pattern
    xor_lines = re.findall(r"assign.*\^", c)
    and_lines = re.findall(r"assign.*&", c)
    if len(xor_lines) == 1 and len(and_lines) == 1:
        return True

    return False


def is_maskable_with_or_rewrite(code: str) -> bool:
    # Must contain nonlinear logic (AND or OR)
    if "&" not in code and "|" not in code:
        return False

    # Reject forbidden words
    for kw in FORBIDDEN_WORDS:
        if re.search(rf"\b{kw}\b", code):
            return False

    # Reject forbidden symbols
    for sym in FORBIDDEN_SYMBOLS:
        if sym in code:
            return False

    # Reject testbench system tasks
    if "$dump" in code or "$monitor" in code:
        return False

    # Optional: reject negated OR (can add later if needed)
    if re.search(r"~\s*\(.*\|.*\)", code):
        return False

    # Avoid very large modules
    if len(code.splitlines()) > 50:
        return False

    # Reject trivial logic
    if is_trivial_and_or_half_adder(code):
        return False

    # Require some structure
    if len(re.findall(r"\bassign\b", code)) < 2:
        return False

    return True


count = 0

with OUT_FILE.open("w") as f:
    for i, item in enumerate(train):
        code = item["code"].strip()

        if not is_maskable_with_or_rewrite(code):
            continue

        f.write(f"// ===== PyraNet maskable (OR-rewrite) example {count} (dataset index {i}) =====\n")
        f.write("// NOTE: Must be rewritten (| → ^ + &) before masking\n")
        f.write(code)
        f.write("\n\n")

        count += 1
        if count == NUM_EXAMPLES:
            break

print(f"Saved {count} OR-rewrite maskable modules to {OUT_FILE.resolve()}")
