# Miniscript Templates


## About

[Miniscript](https://bitcoin.sipa.be/miniscript/) is a language for composing Bitcoin Scripts in a structured way, facilitating analysis, composition, and generic signing. It's a simplified, composable subset of Bitcoin's Script language. Developed to overcome limitations in writing complex spending conditions directly in Bitcoin Script, it enables formal verification and offers a more human-friendly interface.

## Goals

- Have reviewed templates that leverage miniscript to assure there are not unintended ways of executing a valid spend beyond the intended miniscript policy.
- Have standardized usages of miniscript to streamline software and hardware wallet integrations.
- Have uniform on-chain usage of miniscript templates for better privacy.

## Submission Format

1. Name of Template
2. Goal to be achieved by template
3. Example Miniscript Output Descriptor

## Deployment Requirements

The descriptors published in MinT documents are parameterized templates, not directly importable descriptors. Each deployment must substitute its own public keys or xpubs, verified key origins and derivation paths, absolute timelock values, and descriptor checksum.

All key positions in an instantiated witness script must resolve to distinct public keys controlled by their designated participants. Implementations should reject duplicate public keys and unintended cross-role key reuse. Operational verification of independent key generation and control remains part of the participants' key ceremony.

Backups must preserve the complete instantiated descriptor, including its checksum, all public keys or xpubs, key origins, derivation paths, timelock values, and role assignments. Retaining only the threshold number of private signing devices may be insufficient to reconstruct recovery witnesses that use `pkh` fragments.

All `after(T)` conditions are absolute `OP_CHECKLOCKTIMEVERIFY` constraints, not delays measured from when funds enter a vault. A transaction satisfying `after(T)` must set `nLockTime` to at least `T` and use a non-final input sequence. For timestamp locktimes, BIP-113 permits confirmation when the median time past of the previous block is greater than the transaction's `nLockTime`.

Before funding, implementations must verify that each epoch value matches its stated UTC date, that all timelocks are in the intended chronological order, and that the descriptor has not already reached a recovery period. Expired descriptors must not be reused unless immediately available recovery is intended.
