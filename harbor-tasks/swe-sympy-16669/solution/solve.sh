#!/bin/bash
set -e

echo "Applying reference fix for SymPy Indexed printing bug..."

# Navigate to the cloned SymPy repo inside the workspace
cd /workspace/sympy

# Use Python to insert the _print_Indexed method into PythonCodePrinter
python3 -c '
filepath = "sympy/printing/pycode.py"
with open(filepath, "r") as f:
    content = f.read()

# Locate the PythonCodePrinter class
target = "class PythonCodePrinter(AbstractPythonCodePrinter):"
if target in content and "_print_Indexed" not in content:
    # We will inject the method right inside the class body
    method_code = """
    def _print_Indexed(self, expr):
        base, *index = expr.args
        return "{}[{}]".format(str(base), ", \".join([self._print(ind) for ind in index]))
"""
    # Insert it right after the class declaration
    new_content = content.replace(target, target + method_code)
    with open(filepath, "w") as f:
        f.write(new_content)
    print("SUCCESS: Injected _print_Indexed into sympy/printing/pycode.py")
else:
    print("WARNING: Method already exists or class definition not found.")
'
