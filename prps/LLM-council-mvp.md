# PRP: LLM Council MVP

## Overview
Build a multi-model consensus system. One prompt fans out to N language models in parallel, responses are collected, and a selectable judge LLM synthesises the best output.

## Stories

### Story 1: Core Engine — Parallel Model Dispatch
**Files to create/edit:**
- `scripts/council/council.py` (NEW — main engine)
- `scripts/council/config.json` (NEW — model registry)

**Requirements:**
1. Create `scripts/council/config.json` with model definitions:
   - Each model: name, provider (ollama/anthropic/openai/google/perplexity), endpoint, model_id, is_local flag
   - Default models: llama3.1:70b, gemma2:9b, jake-model (local), claude-sonnet, gemini-pro, gpt-4o, perplexity (cloud)
2. Create `scripts/council/council.py`:
   - Load API keys from `/home/deepifyai/Documents/code/.env` using dotenv
   - Async parallel dispatch using `asyncio` + `aiohttp`
   - Ollama models: POST to `http://localhost:11434/api/generate` (or OpenAI-compat `/v1/chat/completions`)
   - Cloud models: Use OpenAI-compatible endpoints where possible (Anthropic needs its own client)
   - Collect: response text, model name, latency_ms, token count (if available)
   - Timeout per model: 60s (skip slow models, don't block)
   - Return list of `ModelResponse` objects
3. Model selection flags:
   - `--local` = only local Ollama models
   - `--all` = all models (local + cloud)
   - `--models sonnet,gpt4o,70b` = specific models by short name
   - Default = local models + sonnet + gemini (balanced cost/quality)

**Validation:**
- Run with `--local` flag, confirm 3 Ollama models respond
- Run with `--models sonnet` flag, confirm Anthropic API call works
- All responses collected with timing data

---

### Story 2: Judge System — Score, Compare, Synthesise
**Files to create/edit:**
- `scripts/council/judge.py` (NEW — judge logic)
- `scripts/council/prompts/` (NEW — judge prompt templates)

**Requirements:**
1. Create judge prompt templates as text files in `scripts/council/prompts/`:
   - `best_of_n.txt` — Score each response 1-10 on accuracy, completeness, clarity. Return the best with reasoning.
   - `synthesis.txt` — Extract the best parts from each response. Weave into a single superior answer. Cite which model contributed what.
   - `consensus.txt` — Identify claims all models agree on. Flag disagreements. Output only consensus facts.
   - `debate.txt` — Evaluate arguments from each side. Declare winner with reasoning. Note strongest arguments from each.
2. Create `scripts/council/judge.py`:
   - Takes: original prompt, list of ModelResponse objects, mode (best_of_n/synthesis/consensus/debate), judge_model
   - Loads the appropriate prompt template, injects model responses
   - Calls judge model (default: ollama/llama3.1:70b)
   - `--judge opus` overrides to Anthropic Opus 4.5 via API
   - `--judge sonnet` overrides to Anthropic Sonnet via API
   - `--judge 70b` explicit local (same as default)
   - Returns: JudgeOutput with final_answer, scores dict, reasoning, mode
3. Structured output: judge must return JSON with clear fields

**Validation:**
- Run synthesis mode with 3 local model responses, 70B judge — get merged output
- Run best_of_n — get scored responses with winner declared
- Run with `--judge sonnet` — confirm cloud judge works

---

### Story 3: CLI Wrapper + Logging
**Files to create/edit:**
- `scripts/council/cli.py` (NEW — CLI entry point)
- `scripts/council/logger.py` (NEW — save deliberations)

**Requirements:**
1. Create `scripts/council/cli.py`:
   - Argparse CLI: `python3 cli.py "prompt" [--mode MODE] [--judge MODEL] [--models M1,M2] [--local] [--all] [--verbose]`
   - Default mode: synthesis
   - Default judge: 70b
   - Default models: local + sonnet + gemini
   - Pretty-print output: show judge's final answer, then optionally (--verbose) show individual model responses and scores
   - Show cost estimate and total latency at the end
2. Create `scripts/council/logger.py`:
   - Save each council run to `dashboard/data/council/YYYY-MM-DD-HHMMSS.json`
   - Include: prompt, mode, judge_model, all model responses, judge output, timing, cost estimate
   - Create `dashboard/data/council/` directory if not exists
3. Create a convenience wrapper: `scripts/council/run.sh`
   - Sources .env, runs `python3 cli.py "$@"`

**Validation:**
- `bash scripts/council/run.sh --local "What is RAG?"` returns a synthesised answer
- `bash scripts/council/run.sh --all --judge opus --mode consensus "Is Python faster than Rust?"` uses all models + Opus judge
- Deliberation JSON saved to dashboard/data/council/
- `--verbose` shows all individual responses

## Technical Notes
- Use `aiohttp` for async HTTP (pip install aiohttp)
- Anthropic client: use raw HTTP to `/v1/messages` endpoint with API key
- OpenAI client: use raw HTTP to `/v1/chat/completions`
- Google Gemini: use `generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent`
- Perplexity: OpenAI-compatible endpoint at `api.perplexity.ai`
- All API keys in `/home/deepifyai/Documents/code/.env`
- ARM64 compatible — no special wheels needed (pure Python + aiohttp)
