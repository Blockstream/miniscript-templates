# mint-007

## 1 Key Joint Custody

## Motivation

This template is similar to [mint-005.md](mint-005.md), with the difference being that the Principal uses a single key instead of a 2-of-3 multisig. This simplifies key management for the Principal while enabling robust joint custody.


### More on Timelock Values

There are two timelocks used for this MinT:

1. `smallest_epoch_timestamp` - The smallest epoch timestamp timelock enables an "Emergency Recovery Path". In the event the Principal has lost their key, the Primary Agent and Secondary Agent can work together to recover the bitcoin in the Joint Custody vault.

2. `largest_epoch_timestamp` - The largest epoch timestamp, signifying the expiration of the contract, where the Principal is able to unilaterally withdraw their bitcoin from the joint custody vault using the Recovery Key.

### Keys

In total, there are 6 keys in use for the 1 Key Joint Custody Vault, they are as follows:

| Key Names | Description | Key Abbreviations | Key Symbol |
|:--|:--:|:--:|:--:|
|Principal Key | This key belongs to the owner of the bitcoin. It is used as the default key the Principal uses to transact bitcoin for the length of the relationship with the Primary Agent in the Joint Custody vault. | $PK$ | <div align="center"> ![Blue Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png) </div> |
|Primary Agent Keys 1,2,3 | These keys belong to the Primary Agent, who the Principal has engaged with to facilitate the securing of bitcoin for a determined set of time. A 2-of-3 threshold is required from these keys in all collaborative spending paths. | $PAK_1$, $PAK_2$, $PAK_3$ | <div align="center"> ![Green Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png) </div> |
|Secondary Agent Key | This key is held by a 3rd party unassociated with the other keys. In the event the Principal has lost their key, this key can sign transactions with the Primary Agent to move funds after a designated "Recovery Period" has started. | $SAK$ | <div align="center"> ![Red Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/83a8c241b2c2cf7ee940570aa97d8b0e1d751f55/assets/key_red.png) </div> |
|Recovery Key | This key in practice belongs to the Principal, it may even be a key related to the Principal Key with a different derivation path, but can also be a delegated key holder. After the Joint Custody vault agreement has ended, the Recovery Key can unilaterally be used to withdraw money from the vault. | $RK$ | <div align="center"> ![Gray Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png) </div> |



Below are reference diagrams on how the 1 Key Joint Custody Vault operates across time:

---

### 1 Key Joint Custody Summary Layers

Layer is used as an abstraction to segment the different eligible spending conditions, going in an ascending order of timelock values. At the start, only "Layer 1" is accessible for spending funds, over time, other spending conditions become available, but this does not restrict the ability to spend from a preceding layer.

| Layer | Layer Name                | Key Set 1                      | Condition Between Sets | Key Set 2          | Timelock Condition | Timelock                        |
|:-----:|:-------------------------:|:------------------------------:|:----------------------:|:------------------:|:------------------:|:-------------------------------:|
| 1     | Default Spending Path     | $PAK_1$, $PAK_2$, $PAK_3$ (2 of 3)| AND                    | $PK$               | N/A                | None                            |
| 2     | Emergency Recovery Path   | $PAK_1$, $PAK_2$, $PAK_3$ (2 of 3)| AND                    | $SAK$              | AND                | After (`smallest_epoch_timestamp`) |
| 3     | Sovereign Recovery Path   | $RK$                           | None                   | None               | AND                | After (`largest_epoch_timestamp`)  |

### Layer 1
<table>
  <tr>
    <th>Default Spending Path</th>
    <th colspan="3" style="text-align:center;">2 of 3 PAKs</th>
    <th style="text-align:center;">1 PK</th>
  </tr>
  <tr>
    <td></td>
    <td align="center">PAK<sub>1</sub></td>
    <td align="center">PAK<sub>2</sub></td>
    <td align="center">PAK<sub>3</sub></td>
    <td align="center">PK</td>
  </tr>
  <tr>
    <td align="center">2 of 3 PAKs AND PK</td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK"></td>
  </tr>
</table>

#### Valid Layer 1 Spend Conditions
| Spending Scenario | $PAK_1$ | $PAK_2$ | $PAK_3$ | $PK$ |
|-------------------|:------:|:------:|:------:|:----:|
| Scenario 1        | ✅      | ✅      |        | ✅    |
| Scenario 2        | ✅      |        | ✅      | ✅    |
| Scenario 3        |        | ✅      | ✅      | ✅    |


#### Layer 2
<table>
  <tr>
    <th>Emergency Recovery Path</th>
    <th colspan="3" style="text-align:center;">2 of 3 PAKs</th>
    <th style="text-align:center;">1 SAK</th>
    <th>BIP-113 time greater than <code>`smallest_epoch_timestamp`</code></th>
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
    <td align="center">2 of 3 PAKs AND SAK AND BIP-113 time is greater than <code>`smallest_epoch_timestamp`</code></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/83a8c241b2c2cf7ee940570aa97d8b0e1d751f55/assets/key_red.png" alt="SAK"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/unlock.png" alt="Timelock"></td>
  </tr>
</table>


##### Valid Layer 2 Spend Conditions
| Spending Scenario | $PAK_1$ | $PAK_2$ | $PAK_3$ | $SAK$ | BIP-113 greater than `smallest_epoch_timestamp` |
|-------------------|:------:|:------:|:------:|:-----:|:-----------------------------------------------:|
| Scenario 4        | ✅      | ✅      |        | ✅     | ✅                                               |
| Scenario 5        | ✅      |        | ✅      | ✅     | ✅                                               |
| Scenario 6        |        | ✅      | ✅      | ✅     | ✅                                               |

#### Layer 3:
<table>
  <tr>
    <th>Sovereign Recovery Path</th>
    <th style="text-align:center;">1 RK</th>
    <th style="text-align:center;">Network BIP-113 time greater than <code>`largest_epoch_timestamp`</code></th>
  </tr>
  <tr>
    <td></td>
    <td align="center">RK</td>
    <td align="center"></td>
  </tr>
  <tr>
    <td align="center">RK AND after BIP-113 time is greater than <code>`largest_epoch_timestamp`</code></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png" alt="RK"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/unlock.png" alt="Timelock"></td>
  </tr>
</table>

##### Valid Layer 3 Spend Conditions
| Spending Scenario | $RK$ | BIP-113 time greater than (`largest_epoch_timestamp`) |
|-------------------|:----:|:-----------------------------------------------------:|
| Scenario 7        | ✅    | ✅                                                     |

---
# Example Miniscript Output Descriptor

- MINT-007 Output Descriptor:
<code>wsh(andor(multi(2,$PAK_1$,$PAK_2$,$PAK_3$),or_d(pk($PK$),and_v(v:pk($SAK$),after(`smallest_epoch_timestamp`))),and_v(v:pkh($RK$),after(`largest_epoch_timestamp`))))</code>

- Source Policy (FOR REFERENCE PURPOSES ONLY):
<code>"or(99@and(thresh(2,pk($PAK_1$),pk($PAK_2$),pk($PAK_3$)),or(pk($PK$),and(pk($SAK$),after(`smallest_epoch_timestamp`)))),and(pk($RK$),after(`largest_epoch_timestamp`)))"</code>

## Reference Implementation

For the reference testnet transactions below, the following epoch timestamps were used:
- `smallest_epoch_timestamp`: 1733011200 (December 1, 2024 00:00:00 UTC)
- `largest_epoch_timestamp`: 1736899200 (January 15, 2025 00:00:00 UTC)

## Layer 1 Example Spend

Signed by: $PAK_1$, $PAK_2$, $PK$

[Reference Testnet Transaction](https://mempool.space/signet/tx/a6a63180b843761fee3217e18b31473ddaee690ca9fdfabaca1a01737a68a373)

## Layer 2 Example Spend

Signed by: $PAK_1$, $PAK_2$, $SAK$

[Reference Testnet Transaction](https://mempool.space/signet/tx/47807141fe971834c8f8e483dfc20338aecc55af796c534d4855e578c00d59b8)

## Layer 3 Example Spend

Signed by: $RK$

[Reference Testnet Transaction](https://mempool.space/signet/tx/cd353c14985451911d4bbd37327fd99a759f26f4dc36e4ee8efb23ae23b8389c)

