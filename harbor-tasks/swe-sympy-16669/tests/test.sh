#!/bin/bash
set -e

cd /workspace/sympy

# Run the specific test case and handle output in pure Python
python3 -c '
try:
    from sympy import IndexedBase, Idx
    from sympy.printing.pycode import PythonCodePrinter

    A = IndexedBase("A")
    i = Idx("i")

    p = PythonCodePrinter()
    result = p.doprint(A[i])
    print("Output:", result)

    # Verify the printer output
    if "A[" in result:
        with open("/tmp/reward.txt", "w") as f:
            f.write("1\n")
        print("PASS: Indexed printing works")
    else:
        with open("/tmp/reward.txt", "w") as f:
            f.write("0\n")
        print("FAIL: Output does not contain A[")
except Exception as e:
    print("FAIL: Script crashed with error:", e)
    with open("/tmp/reward.txt", "w") as f:
        f.write("0\n")
'

# Return the reward
cat /tmp/reward.txt
