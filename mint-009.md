# mint-009

## 2 Agent Joint Custody with Recovery

## Motivation

To provide a streamlined custody arrangement in which an owner of bitcoin (Principal) is able to secure bitcoin by working with a Primary Agent and Secondary Agent. During the normal custody path, funds can only be moved with authorization from both the Primary Agent and Secondary Agent key groups.

Unlike traditional multisig where keys are distributed equally, the normal custody path requires explicit cooperation between two distinct parties - typically a Principal's chosen service provider (Primary Agent) and a custody specialist (Secondary Agent).

After a predetermined custody period, a set of Principal-controlled Recovery Keys becomes available to move funds without either Agent. This recovery path reduces the risk of funds becoming permanently inaccessible if the normal agent path is unavailable.

### Key Characteristics

- **Dual Agent Authorization**: The normal custody path requires both Primary Agent (1-of-2) and Secondary Agent (2-of-3) authorization
- **True Negative Control**: Neither agent can move funds without the other through the normal custody path
- **Principal-Controlled Recovery**: After the recovery timelock, either of the Principal's two Recovery Keys can move funds without either Agent
- **Time-Bounded**: Recovery path activates after a specified date, allowing contract expiration

### More on Timelock Values

This MinT uses a single timelock for simplification:

1. `recovery_epoch_timestamp` - The recovery epoch timestamp enables a "Sovereign Recovery Path" where the Principal can use either Recovery Key to withdraw bitcoin without either Agent after the custody agreement has expired.

### Keys

In total, there are 7 keys in use for the 2 Agent Joint Custody Vault with Recovery, they are as follows:

| Key Names | Description | Key Abbreviations | Key Symbol |
|:--|:--:|:--:|:--:|
|Primary Agent Keys 1,2 | These keys belong to the Primary Agent - typically the Principal's chosen service provider (e.g., an exchange, payment processor, or financial institution). At least 1 of these 2 keys is required for any transaction during the custody period. | $PAK_1$, $PAK_2$ | <div align="center"> ![Blue Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png) </div> |
|Secondary Agent Keys 1,2,3 | These keys belong to the Secondary Agent - typically a specialized custody provider. At least 2 of these 3 keys are required for any transaction during the custody period. This provides operational redundancy while maintaining security. | $SAK_1$, $SAK_2$, $SAK_3$ | <div align="center"> ![Green Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png) </div> |
|Recovery Keys 1,2 | These keys belong to the Principal and provide sovereign fallback control after the timelock expires. Only 1 of 2 Recovery Keys is needed to spend after the timelock. | $RK_1$, $RK_2$ | <div align="center"> ![Gray Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png) </div> |

---

Below are reference diagrams on how the 2 Agent Joint Custody with Recovery operates across time:

---

### Joint Custody Summary Layers

Layer is used as an abstraction to segment the different eligible spending conditions, going in an ascending order of timelock values. At the start, only "Layer 1" is accessible for spending funds, over time, other spending conditions become available, but this does not restrict the ability to spend from a preceding layer.

| Layer | Layer Name                | Key Set 1                      | Condition Between Sets | Key Set 2          | Timelock Condition | Timelock                        |
|:-----:|:-------------------------:|:------------------------------:|:----------------------:|:------------------:|:------------------:|:-------------------------------:|
| 1     | Default Spending Path     | $PAK_1$, $PAK_2$ (1 of 2)| AND                    | $SAK_1$, $SAK_2$, $SAK_3$ (2 of 3)| N/A            | None                            |
| 2     | Sovereign Recovery Path   | $RK_1$, $RK_2$ (1 of 2)| None | None              | AND               | After (`recovery_epoch_timestamp`)  |

### Layer 1
<table>
  <tr>
    <th>Default Spending Path</th>
    <th colspan="2" style="text-align:center;">1 of 2 PAKs</th>
    <th colspan="3" style="text-align:center;">2 of 3 SAKs</th>
  </tr>
  <tr>
    <td></td>
    <td align="center">PAK<sub>1</sub></td>
    <td align="center">PAK<sub>2</sub></td>
    <td align="center">SAK<sub>1</sub></td>
    <td align="center">SAK<sub>2</sub></td>
    <td align="center">SAK<sub>3</sub></td>
  </tr>
  <tr>
    <td align="center">1 of 2 PAKs AND 2 of 3 SAKs</td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PAK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="SAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="SAK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="SAK3"></td>
  </tr>
</table>

#### Valid Layer 1 Spend Conditions
| Spending Scenario | $PAK_1$ | $PAK_2$ | $SAK_1$ | $SAK_2$ | $SAK_3$ |
|-------------------|:------:|:------:|:-------:|:-------:|:-------:|
| Scenario 1        | ✅      |        | ✅       | ✅       |         |
| Scenario 2        | ✅      |        | ✅       |         | ✅       |
| Scenario 3        | ✅      |        |         | ✅       | ✅       |
| Scenario 4        |        | ✅      | ✅       | ✅       |         |
| Scenario 5        |        | ✅      | ✅       |         | ✅       |
| Scenario 6        |        | ✅      |         | ✅       | ✅       |

**Explanation**: The Primary Agent selects one of their two keys (providing flexibility and redundancy), while the Secondary Agent must provide two of their three keys (ensuring institutional-grade security with operational continuity). This structure prevents either party from unilaterally moving funds while maintaining practical redundancy.

#### Layer 2:
<table>
  <tr>
    <th>Sovereign Recovery Path</th>
    <th colspan="2" style="text-align:center;">1 of 2 RKs</th>
    <th>BIP-113 time greater than <code>`recovery_epoch_timestamp`</code></th>
  </tr>
  <tr>
    <td></td>
    <td align="center">RK<sub>1</sub></td>
    <td align="center">RK<sub>2</sub></td>
    <td align="center"></td>
  </tr>
  <tr>
    <td align="center">1 of 2 RKs AND after BIP-113 time is greater than <code>`recovery_epoch_timestamp`</code></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png" alt="RK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png" alt="RK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/unlock.png" alt="Timelock"></td>
  </tr>
</table>

##### Valid Layer 2 Spend Conditions
| Spending Scenario | RK_1 | RK_2 | Timelock (recovery_epoch_timestamp) |
|-------------------|:----:|:----:|:----------------------------------:|
| Scenario 7        | ✅    |      | ✅                                  |
| Scenario 8        |      | ✅    | ✅                                  |

**Explanation**: After the recovery timelock expires, the Principal can use either Recovery Key to spend without either Agent. The normal dual-agent path remains available, but dual-agent authorization is no longer required because the sovereign recovery path is also available.

---
# Example Miniscript Output Descriptor

For this example, the `recovery_epoch_timestamp` is: 1727740800 (October 1, 2024, midnight UTC)

- MINT-009 Output Descriptor:
<code>wsh(andor(multi(1,$PAK_1$,$PAK_2$),multi(2,$SAK_1$,$SAK_2$,$SAK_3$),and_v(v:multi(1,$RK_1$,$RK_2$),after(`recovery_epoch_timestamp`))))</code>

- Source Policy (FOR REFERENCE PURPOSES ONLY):
<code>"or(and(thresh(2,pk($SAK_1$),pk($SAK_2$),pk($SAK_3$)),or(pk($PAK_1$),pk($PAK_2$))),and(after(`recovery_epoch_timestamp`),or(pk($RK_1$),pk($RK_2$))))"</code>

**Note:** `thresh(1,A,B)` and `or(A,B)` express the same authorization requirement. Rust Miniscript's semantic-policy parser rejects degenerate thresholds where `k = 1` or `k = n`, while its concrete-policy parser accepts `thresh(1,...)`. The normalized `or(...)` policy above is provided only as a semantic description of the spending rules. Compiling it is not guaranteed to reproduce the displayed output descriptor and may produce different script bytes, witness structure, fees, and addresses. The displayed output descriptor is authoritative and intentionally uses valid `multi(1,...)` fragments for its 1-of-2 keysets.

Spending semantics remain unchanged:
- Default path: 1-of-2 PAK AND 2-of-3 SAK.
- Recovery path: 1-of-2 RK AND after(`recovery_epoch_timestamp`).
- No authorization path is added or removed by representing the 1-of-2 requirements as `or(...)` in the source policy.

## Reference Implementation

**Test Network:** Bitcoin Signet

For the reference testnet transactions below, the following epoch timestamp was used:
- `recovery_epoch_timestamp`: 1727740800 (October 1, 2024 00:00:00 UTC)

## Layer 1 Example Spend

Signed by: $PAK_1$, $SAK_1$, $SAK_2$


[Reference Testnet Transaction](https://mempool.space/signet/tx/be2f19d0877237ec4fa900db79be2d9fdb469d60b6c6d3548da92cbef1210809)


## Layer 2 Example Spend

Signed by: $RK_1$


[Reference Testnet Transaction](https://mempool.space/signet/tx/392aaceada1f6e97688db3a9d447e06837aa68eac12bd8076571ffe5c7cd37c7)
