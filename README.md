# CAREX - Trail of Bits

## Fuzz tests for the ABDK Math 64.64 library using Echidna

## Before starting

Install Echidna 2.0.1:

- Install/upgrade [slither](https://github.com/crytic/slither): `pip3 install slither-analyzer --upgrade`
- Recommended option: [precompiled binaries](https://github.com/crytic/echidna/releases/tag/v2.0.1) (Linux and MacOS supported).
- Alternative option: [use docker](https://hub.docker.com/layers/echidna/trailofbits/echidna/v2.0.1/images/sha256-526df14f9a90ba5615816499844263e851d7f34ed241acbdd619eb7aa0bb8556?context=explore).

To start a Echidna fuzzing campaign use:

```
echidna-test Echidna-CAREX.sol --contract Test --config config.yaml
```
