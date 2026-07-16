FROM python:3.12-slim

RUN apt-get update && apt-get install -y git

# Clone SymPy at the right commit for this issue
RUN git clone https://github.com/sympy/sympy.git /workspace/sympy
WORKDIR /workspace/sympy
RUN git checkout sympy-1.12

# Install editable
RUN pip install -e .[dev]

WORKDIR /workspace
