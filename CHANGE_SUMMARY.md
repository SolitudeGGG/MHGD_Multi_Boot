# Change Summary

## 2026-03-03
- **Testbench width alignment:** Updated `tb/tb.v` to derive `TOTAL_WIDTH`, `INT_WIDTH`, and `FRAC_WIDTH` from `IN_WIDTH`/`IN_FRAC` so the testbench drives full 40-bit input words expected by `TOP`. This prevents undriven upper bits from appearing as `z` during truncation of `y`, `H`, `v`, and `grad`.

## Tests
- No build or test scripts found in the repository to run.
