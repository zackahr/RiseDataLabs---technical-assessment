# RiseDataLabs---technical-assessment

This repository contains a Harbor task built around a SymPy bug fix.

## What I built

The task reproduces and fixes a SymPy issue where `PythonCodePrinter` could not print `Indexed` objects such as `A[i]`.

The finished task lives in [harbor-tasks/swe-sympy-16669](harbor-tasks/swe-sympy-16669).

## Steps I took

1. Tried installing Harbor with `uv tool install harbor`.
2. Hit a Python compatibility issue because the default interpreter was too new.
3. Installed Python 3.13 and retried Harbor with that version.
4. Created the task folder structure under `harbor-tasks/swe-sympy-16669`.
5. Wrote the task prompt in [instruction.md](harbor-tasks/swe-sympy-16669/instruction.md).
6. Added the container setup in [environment/Dockerfile](harbor-tasks/swe-sympy-16669/environment/Dockerfile).
7. Added the verifier in [tests/test.sh](harbor-tasks/swe-sympy-16669/tests/test.sh).
8. Added the reference fix in [solution/solve.sh](harbor-tasks/swe-sympy-16669/solution/solve.sh).
9. Verified the bug fix path for `PythonCodePrinter` on `Indexed` inputs.

## Project layout

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

## How to run

The task is meant to be run through Harbor.

### Run the task

```bash
harbor run -p swe-sympy-16669 \
    -a terminus-2 \
    --model openrouter/openrouter/free \
    --ak max_turns=3
```

This launches the `swe-sympy-16669` task with the `terminus-2` agent and the `openrouter/openrouter/free` model.
I set `max_turns=3` to keep the run short and avoid hitting the free-model rate limit, which had blocked me on other API-backed LLM runs.

The task environment still expects SymPy to be available at `/workspace/sympy`.

### 1. Build the environment

```bash
docker build -f harbor-tasks/swe-sympy-16669/environment/Dockerfile -t sympy-16669 .
```

### 2. Start a container

```bash
docker run --rm -it sympy-16669 bash
```

### 3. Run the reference fix

From inside the container, apply the reference solution:

```bash
bash /path/to/your/copied/solution/solve.sh
```

If you are running from this repository mounted into the container, use the mounted path to `solution/solve.sh`.

### 4. Run the verifier

```bash
bash /path/to/your/copied/tests/test.sh
```

The verifier checks that `PythonCodePrinter().doprint(A[i])` succeeds and produces indexed output.

## Notes

This is a minimal Harbor task, so the repo is intentionally small: it focuses on one targeted SymPy bug, one reference fix, and one verifier script.
