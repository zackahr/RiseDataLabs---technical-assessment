Fix the following bug in SymPy:

PythonCodePrinter does not support printing Indexed objects.

Reproduce with:
```python
from sympy import IndexedBase, Idx, pprint
from sympy.printing.pycode import PythonCodePrinter

A = IndexedBase('A')
i = Idx('i')

p = PythonCodePrinter()
print(p.doprint(A[i]))   # This currently fails
```

Your task: Modify the code so that PythonCodePrinter correctly handles Indexed and IndexedBase objects.

Make the change minimal. Run tests to verify.
