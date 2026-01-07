from datasets import load_dataset
from pathlib import Path
import re

dataset = load_dataset("bnadimi/PyraNet-Verilog")
train = dataset["train"]

OUT_FILE = Path("pyranet_maskable_13.v")
NUM_EXAMPLES = 20

def is_maskable(code: str) -> bool:
    forbidden = [
        "always",
        "posedge",
        "negedge",
        "clk",
        "clock",
        "reset",
        "rst",
        "case",
        "for",
        "while"
    ]

    # must contain an AND
    if "&" not in code:
        return False

    for kw in forbidden:
        if re.search(rf"\b{kw}\b", code):
            return False

    # avoid giant modules
    if len(code.splitlines()) > 40:
        return False

    return True


count = 0

with OUT_FILE.open("w") as f:
    for i, item in enumerate(train):
        code = item["code"].strip()

        if not is_maskable(code):
            continue

        f.write(f"// ===== PyraNet maskable example {count} (dataset index {i}) =====\n")
        f.write(code)
        f.write("\n\n")

        count += 1
        if count == NUM_EXAMPLES:
            break

print(f"Saved {count} maskable modules to {OUT_FILE.resolve()}")
