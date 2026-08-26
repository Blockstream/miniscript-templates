# mint-006

## 3 Key Joint Custody, Sovereign First

## Motivation

This vault is very similar to [mint-005.md](mint-005.md). The difference is the sequential order of the 3rd and 4th "layers", where the Principal is able to unilaterally move funds prior to the recovery layer. This is done for users who wish to make sure that funds will require the Principal to sign before the Primary Agent and Secondary Agent are able to move funds unilaterally. The recovery layer still exists to provide support to recover funds in the event the Principal has lost access to their keys.

**Key differences from MINT-005:** First, the layer ordering is changed — the Sovereign Recovery Path (Recovery Keys only) comes *before* the Emergency Recovery Path (Primary Agent + Secondary Agent), meaning the Principal can unilaterally move funds before the agents gain the ability to recover without the Principal. Second, the Primary Agent Keys (PAKs) are listed as Key Set 1 and the Principal Keys (PKs) as Key Set 2 in the summary table and layer diagrams, which is the reverse of MINT-005's column ordering. Together, these changes result in a different miniscript output descriptor.


### More on Timelock Values

There are three timelocks used for this MinT:

1. `smallest_epoch_timestamp` - The smallest epoch timestamp timelock enables a "Degraded Threshold Path" such that only one of the three Principal keys is required to sign (instead of two), while still requiring the Primary Agent 2-of-3.

2. `between_epoch_timestamp` - The epoch timestamp value in between the smallest and largest epoch timestamp enables a "Sovereign Recovery Path". At this point, the Principal (via their Recovery Keys) can unilaterally withdraw bitcoin from the vault using a 2-of-3 multisig.

3. `largest_epoch_timestamp` - The largest epoch timestamp, signifying the final emergency recovery period, where the Primary Agent and Secondary Agent can work together to recover the bitcoin in the Joint Custody vault.

### Keys

In total, there are 10 keys in use for the 3 Key Joint Custody, Sovereign First Vault, they are as follows:

| Key Names | Description | Key Abbreviations | Key Symbol |
|:--|:--:|:--:|:--:|
|Principal Keys 1,2,3 | These keys belong to the owner of the bitcoin. They are used as the default keys the Principal uses to transact bitcoin for the length of the relationship with the Primary Agent in the Joint Custody vault. After the first timelock, the requirement degrades from 2-of-3 to 1-of-3. | $PK_1$, $PK_2$, $PK_3$ | <div align="center"> ![Blue Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png) </div> |
|Primary Agent Keys 1,2,3 | These keys belong to the Primary Agent, who the Principal has engaged with to facilitate the securing of bitcoin for a determined set of time. A 2-of-3 threshold is always required from these keys in the collaborative spending paths. | $PAK_1$, $PAK_2$, $PAK_3$ | <div align="center"> ![Green Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png) </div> |
|Secondary Agent Key | This key is held by a 3rd party unassociated with the other keys. In the event both the Principal has lost all keys AND the Recovery Keys are unavailable, this key can sign transactions with the Primary Agent to move funds after the longest timelock period. | $SAK$ | <div align="center"> ![Red Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/83a8c241b2c2cf7ee940570aa97d8b0e1d751f55/assets/key_red.png) </div> |
|Recovery Keys 1,2,3 | These keys in practice belong to the Principal, they may even be keys related to the Principal Keys with a different derivation path, but can also be delegated key holders. After a middle timelock period, these recovery keys can unilaterally be used to withdraw money from the vault using a 2-of-3 multisig. | $RK_1$, $RK_2$, $RK_3$ | <div align="center"> ![Gray Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png) </div> |



Below are reference diagrams on how the 3 Key Joint Custody, Sovereign First Vault operates across time:

---

### Joint Custody Summary Layers

Layer is used as an abstraction to segment the different eligible spending conditions, going in an ascending order of timelock values. At the start, only "Layer 1" is accessible for spending funds, over time, other spending conditions become available, but this does not restrict the ability to spend from a preceding layer.

| Layer | Layer Name                | Key Set 1                      | Condition Between Sets | Key Set 2          | Timelock Condition | Timelock                        |
|:-----:|:-------------------------:|:------------------------------:|:----------------------:|:------------------:|:------------------:|:-------------------------------:|
| 1     | Default Spending Path     | $PAK_1$, $PAK_2$, $PAK_3$ (2 of 3)| AND                    | $PK_1$, $PK_2$, $PK_3$ (2 of 3)| N/A            | None                            |
| 2     | Degraded Threshold Path   | $PAK_1$, $PAK_2$, $PAK_3$ (2 of 3)| AND                    | $PK_1$, $PK_2$, $PK_3$ (1 of 3)| AND            | After (`smallest_epoch_timestamp`) |
| 3     | Sovereign Recovery Path   | $RK_1$, $RK_2$, $RK_3$ (2 of 3)| None                   | None               | AND                | After (`between_epoch_timestamp`)  |
| 4     | Emergency Recovery Path   | $PAK_1$, $PAK_2$, $PAK_3$ (2 of 3)| AND                    | $SAK$              | AND                | After (`largest_epoch_timestamp`)  |

### Layer 1
<table>
  <tr>
    <th>Default Spending Path</th>
    <th colspan="3" style="text-align:center;">2 of 3 PAKs</th>
    <th colspan="3" style="text-align:center;">2 of 3 PKs</th>
  </tr>
  <tr>
    <td></td>
    <td align="center">PAK<sub>1</sub></td>
    <td align="center">PAK<sub>2</sub></td>
    <td align="center">PAK<sub>3</sub></td>
    <td align="center">PK<sub>1</sub></td>
    <td align="center">PK<sub>2</sub></td>
    <td align="center">PK<sub>3</sub></td>
  </tr>
  <tr>
    <td align="center">2 of 3 PAKs AND 2 of 3 PKs</td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK3"></td>
  </tr>
</table>

#### Valid Layer 1 Spend Conditions
| Spending Scenario | $PAK_1$ | $PAK_2$ | $PAK_3$ | $PK_1$ | $PK_2$ | $PK_3$ |
|-------------------|:------:|:------:|:------:|:------:|:------:|:------:|
| Scenario 1        | ✅      | ✅      |        | ✅      | ✅      |        |
| Scenario 2        | ✅      | ✅      |        | ✅      |        | ✅      |
| Scenario 3        | ✅      | ✅      |        |        | ✅      | ✅      |
| Scenario 4        | ✅      |        | ✅      | ✅      | ✅      |        |
| Scenario 5        | ✅      |        | ✅      | ✅      |        | ✅      |
| Scenario 6        | ✅      |        | ✅      |        | ✅      | ✅      |
| Scenario 7        |        | ✅      | ✅      | ✅      | ✅      |        |
| Scenario 8        |        | ✅      | ✅      | ✅      |        | ✅      |
| Scenario 9        |        | ✅      | ✅      |        | ✅      | ✅      |


#### Layer 2
<table>
  <tr>
    <th>Degraded Threshold Path</th>
    <th colspan="3" style="text-align:center;">2 of 3 PAKs</th>
    <th colspan="3" style="text-align:center;">1 of 3 PKs</th>
    <th>BIP-113 time greater than <code>`smallest_epoch_timestamp`</code></th>
  </tr>
  <tr>
    <td></td>
    <td align="center">PAK<sub>1</sub></td>
    <td align="center">PAK<sub>2</sub></td>
    <td align="center">PAK<sub>3</sub></td>
    <td align="center">PK<sub>1</sub></td>
    <td align="center">PK<sub>2</sub></td>
    <td align="center">PK<sub>3</sub></td>
    <td align="center"></td>
  </tr>
  <tr>
    <td align="center">2 of 3 PAKs AND 1 of 3 PKs AND BIP-113 time is greater than <code>`smallest_epoch_timestamp`</code></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/unlock.png" alt="Timelock"></td>
  </tr>
</table>


##### Valid Layer 2 Spend Conditions
| Spending Scenario | $PAK_1$ | $PAK_2$ | $PAK_3$ | $PK_1$ | $PK_2$ | $PK_3$ | BIP-113 greater than `smallest_epoch_timestamp` |
|-------------------|:------:|:------:|:------:|:------:|:------:|:------:|:-----------------------------------------------:|
| Scenario 10       | ✅      | ✅      |        | ✅      |        |        | ✅                                               |
| Scenario 11       | ✅      | ✅      |        |        | ✅      |        | ✅                                               |
| Scenario 12       | ✅      | ✅      |        |        |        | ✅      | ✅                                               |
| Scenario 13       | ✅      |        | ✅      | ✅      |        |        | ✅                                               |
| Scenario 14       | ✅      |        | ✅      |        | ✅      |        | ✅                                               |
| Scenario 15       | ✅      |        | ✅      |        |        | ✅      | ✅                                               |
| Scenario 16       |        | ✅      | ✅      | ✅      |        |        | ✅                                               |
| Scenario 17       |        | ✅      | ✅      |        | ✅      |        | ✅                                               |
| Scenario 18       |        | ✅      | ✅      |        |        | ✅      | ✅                                               |

#### Layer 3:
<table>
  <tr>
    <th>Sovereign Recovery Path</th>
    <th colspan="3" style="text-align:center;">2 of 3 RKs</th>
    <th style="text-align:center;">Network BIP-113 time greater than <code>`between_epoch_timestamp`</code></th>
  </tr>
  <tr>
    <td></td>
    <td align="center">RK<sub>1</sub></td>
    <td align="center">RK<sub>2</sub></td>
    <td align="center">RK<sub>3</sub></td>
    <td align="center"></td>
  </tr>
  <tr>
    <td align="center">2 of 3 RKs AND after BIP-113 time is greater than <code>`between_epoch_timestamp`</code></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png" alt="RK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png" alt="RK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png" alt="RK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/unlock.png" alt="Timelock"></td>
  </tr>
</table>

##### Valid Layer 3 Spend Conditions
| Spending Scenario | $RK_1$ | $RK_2$ | $RK_3$ | BIP-113 time greater than (`between_epoch_timestamp`) |
|-------------------|:------:|:------:|:------:|:-----------------------------------------------------:|
| Scenario 19       | ✅      | ✅      |        | ✅                                                     |
| Scenario 20       | ✅      |        | ✅      | ✅                                                     |
| Scenario 21       |        | ✅      | ✅      | ✅                                                     |

#### Layer 4:
<table>
  <tr>
    <th>Emergency Recovery Path</th>
    <th colspan="3" style="text-align:center;">2 of 3 PAKs</th>
    <th style="text-align:center;">1 SAK</th>
    <th>BIP-113 time greater than <code>`largest_epoch_timestamp`</code></th>
  </tr>
  <tr>
    <td></td>
    <td align="center">PAK<sub>1</sub></td>
    <td align="center">PAK<sub>2</sub></td>
    <td align="center">PAK<sub>3</sub></td>
    <td align="center">SAK</td>
    <td align="center"></td>
  </tr>
  <tr>
    <td align="center">2 of 3 PAKs AND SAK AND after BIP-113 time is greater than <code>`largest_epoch_timestamp`</code></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/83a8c241b2c2cf7ee940570aa97d8b0e1d751f55/assets/key_red.png" alt="SAK"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/unlock.png" alt="Timelock"></td>
  </tr>
</table>

##### Valid Layer 4 Spend Conditions
| Spending Scenario | $PAK_1$ | $PAK_2$ | $PAK_3$ | $SAK$ | BIP-113 time greater than (`largest_epoch_timestamp`) |
|-------------------|:------:|:------:|:------:|:-----:|:-----------------------------------------------------:|
| Scenario 22       | ✅      | ✅      |        | ✅     | ✅                                                     |
| Scenario 23       | ✅      |        | ✅      | ✅     | ✅                                                     |
| Scenario 24       |        | ✅      | ✅      | ✅     | ✅                                                     |

---
# Example Miniscript Output Descriptor

- MINT-006 Output Descriptor:
<code>wsh(andor(multi(2,$PAK_1$,$PAK_2$,$PAK_3$),andor(pk($SAK$),after(`largest_epoch_timestamp`),thresh(2,pk($PK_1$),s:pk($PK_2$),s:pk($PK_3$),snl:after(`smallest_epoch_timestamp`))),and_v(v:thresh(2,pkh($RK_1$),a:pkh($RK_2$),a:pkh($RK_3$)),after(`between_epoch_timestamp`))))</code>

- Source Policy (FOR REFERENCE PURPOSES ONLY):
<code>"or(99@and(thresh(2,pk($PAK_1$),pk($PAK_2$),pk($PAK_3$)),or(thresh(2,pk($PK_1$),pk($PK_2$),pk($PK_3$),after(`smallest_epoch_timestamp`)),and(pk($SAK$),after(`largest_epoch_timestamp`)))),and(thresh(2,pk($RK_1$),pk($RK_2$),pk($RK_3$)),after(`between_epoch_timestamp`)))"</code>

## Reference Implementation

For the reference testnet transactions below, the following epoch timestamps were used:
- `smallest_epoch_timestamp`: 1688000400 (June 29, 2023 01:00:00 UTC)
- `between_epoch_timestamp`: 1704067200 (January 1, 2024 00:00:00 UTC)
- `largest_epoch_timestamp`: 1735689600 (January 1, 2025 00:00:00 UTC)

## Layer 1 Example Spend

Signed by: $PAK_1$, $PAK_2$, $PK_1$, $PK_2$

[Reference Testnet Transaction](https://mempool.space/signet/tx/cb5f6a595a77ac01afc9ac40641def2d6ae8978e7e9a12e7fc6b7dcb61ee901f)

## Layer 2 Example Spend

Signed by: $PAK_1$, $PAK_2$, $PK_1$

[Reference Testnet Transaction](https://mempool.space/signet/tx/7ea8816b5fcdb954836a60b699a71e3fbd54093f773ab818beb7767f60e40c14)

## Layer 3 Example Spend

Signed by: $RK_1$, $RK_2$

[Reference Testnet Transaction](https://mempool.space/signet/tx/a036f18e2888ab859bbd5547d717132aa1eefdebb78c53653c6c5d64680bc4a9)

## Layer 4 Example Spend

Signed by: $PAK_1$, $PAK_2$, $SAK$

[Reference Testnet Transaction](https://mempool.space/signet/tx/c3aaf3c0db07aa70a817953f12eb5b1b6b8ef25fd6c6cbb14b1c6189297a4763)
