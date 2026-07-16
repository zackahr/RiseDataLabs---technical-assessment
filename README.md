# RiseDataLabs---technical-assessment

# Harbor Installation Documentation

## Overview
This document records the steps taken to install **Harbor** (AI agent evaluation framework) and the issues encountered during the process.

## Installation Steps

### 1. Initial Attempt
I first tried to install Harbor using the recommended method:

```bash
uv tool install harbor

if Failed because Python 3.14 too new for litellm.

###FIX

uv python install 3.13
uv tool install --python 3.13 harbor


