# RiseDataLabs---technical-assessment

This repository documents how I created a Harbor task around a real SymPy bug and how I approached the challenge from setup to verification.

## Challenge Summary

The task I built reproduces and fixes a SymPy issue where `PythonCodePrinter` could not print `Indexed` objects such as `A[i]`.

The finished task is in [harbor-tasks/swe-sympy-16669](harbor-tasks/swe-sympy-16669).

## Why I Chose SWE-bench

I chose SWE-bench because it mirrors a real software engineering workflow: identify a bug in an existing codebase, understand the surrounding implementation, reproduce the failure, make a minimal fix, and verify the result with tests. That made it a strong fit for demonstrating how I solve debugging tasks in a structured way.

Before building the task, I reviewed the SWE-bench repository to understand how the task flow, environment setup, and verification process work. I also watched the Harbor task explainer video so I could understand how Harbor tasks are structured and executed.

## How I Solved It

My approach was to keep the task minimal and focused:

1. I first tried installing Harbor with `uv tool install harbor`.
2. That failed because the default Python version was too new for one of Harbor's dependencies.
3. I fixed that by installing Python 3.13 and reinstalling Harbor with that interpreter.
4. I then created the Harbor task folder structure under `harbor-tasks/swe-sympy-16669`.
5. I wrote the task instructions in [instruction.md](harbor-tasks/swe-sympy-16669/instruction.md) so the challenge was clear and reproducible.
6. I defined the task environment in [environment/Dockerfile](harbor-tasks/swe-sympy-16669/environment/Dockerfile) and pinned SymPy to the correct release branch.
7. I added the verifier in [tests/test.sh](harbor-tasks/swe-sympy-16669/tests/test.sh) so the fix could be checked automatically.
8. I added the reference solution in [solution/solve.sh](harbor-tasks/swe-sympy-16669/solution/solve.sh).
9. I verified that `PythonCodePrinter().doprint(A[i])` succeeds for `Indexed` inputs.

## What the Task Contains

The task is intentionally small and targeted:

```text
harbor-tasks/swe-sympy-16669/
├── instruction.md
├── task.toml
├── environment/
│   └── Dockerfile
├── tests/
│   └── test.sh
└── solution/
    └── solve.sh
```

## How to Run It

I run the Harbor task with a low turn limit to avoid hitting the free-model rate limit:

```bash
harbor run -p swe-sympy-16669 \
    -a terminus-2 \
    --model openrouter/openrouter/free \
    --ak max_turns=3
```

I use `max_turns=3` so the run stays short and avoids the rate-limit issue I hit with other API-backed free LLM runs.

If you want to run the environment or verify the task manually, the Dockerfile expects SymPy to be available at `/workspace/sympy`.

### Optional Manual Setup

```bash
docker build -f harbor-tasks/swe-sympy-16669/environment/Dockerfile -t sympy-16669 .
docker run --rm -it sympy-16669 bash
```

Inside the container, you can run the reference solution and verifier directly:

```bash
bash /path/to/your/copied/solution/solve.sh
bash /path/to/your/copied/tests/test.sh
```

## Outcome

I enjoyed the challenge and learned a great deal from it. More importantly, it gave me practice with reading an upstream repository, understanding the task framework, and turning a bug report into a minimal, testable solution.
