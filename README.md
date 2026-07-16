# RiseDataLabs---technical-assessment

# Harbor Installation Documentation

## Overview
This document records the steps taken to install **Harbor** (AI agent evaluation framework) and the issues encountered during the process.

## Installation Steps

### 1. Initial Attempt
I first tried to install Harbor using the recommended method:

```bash
uv tool install harbor
```

if Failed because Python 3.14 too new for litellm.

### FIX

uv python install 3.13
uv tool install --python 3.13 harbor


# Harbor Tasks

## Progress

```bash
mkdir -p harbor-tasks/swe-sympy-16669
```

## Why this task

Very small fix
Good starting point
Real SWE-bench task

What the task is about
Project: SymPy
Bug: PythonCodePrinter cannot print Indexed objects (A[i,j])
Agent job: Fix the printer so it works, tests pass.
Simple. 1 file change.
Next: create full harbor task files.
Done.

# Harbor Tasks

## Next: Task Folder Structure

One Harbor task folder must have these main things:

```bash
swe-sympy-16669/
├── instruction.md          # What the agent is told to do
├── task.toml               # Config (name, timeout, resources, etc)
├── environment/            # Docker setup
│   └── Dockerfile
├── tests/                  # Verifier
│   └── test.sh
└── solution/               # Optional reference fix
    └── solve.sh
```


