# mint-005

## 3 Key Joint Custody

## Motivation

To provide a custody arrangement in which an owner of bitcoin (Principal) is able to secure bitcoin by working with an Agent. Unlike existing collaborative custody models up to this point, **where bitcoin keys WITHIN a multisig threshold are shared between Principals and agents**, a joint custody model by default requires a threshold of keys by both the Agent & Principal for movement of funds.

This introduces a concept of "Negative Control" where, by default, funds are not able to be moved unless both the Principal and Agent sign the transaction.

In the event the Principal loses access to all of their keys, a Secondary Agent is available to work with the Primary Agent such that funds can be recovered after a set period of time.

In the unlikely event the Principal has lost 2 of their 3 keys, a timelock enabled threshold allows only 1 of 3 Principal keys to be signed (instead of 2), while still requiring the Primary Agent's 2-of-3 signature.

Finally, in the event the Principal no longer wishes to work with the agent, say after a contract expires, the custody defers to a set of recovery keys, which can be held either by the Principal, or their own delegated managers of the recovery keys. As a result, when enough time has passed, the Principal is able to move bitcoin unilaterally without having the Agent sign key material.

### More on Timelock Values

There are three timelocks used for this MinT:

1. `smallest_epoch_timestamp` - The smallest epoch timestamp timelock enables an "Asset Recovery" period such that only one of the Principal keys is required to sign.

2. `between_epoch_timestamp` - The epoch timestamp value in between the smallest and largest epoch timestamp enables an "Emergency Recovery Path". In the event the Principal has lost all of their keys, the Primary Agent and Secondary Agent can work together to recover the bitcoin in the Joint Custody vault.

3. `largest_epoch_timestamp` - The largest epoch timestamp, signifying the expiration of the contract, where the Principal is able to unilaterally withdraw their bitcoin from the joint custody vault.

### Keys

In total, there are 10 keys in use for the 3 Key Joint Custody Vault, they are as follows:

| Key Names | Description | Key Abbreviations | Key Symbol |
|:--|:--:|:--:|:--:|
|Principal Keys 1,2,3 | These keys belong to the owner of the bitcoin. They are used as the default keys the Principal uses to transact bitcoin for the length of the relationship with the agent in the Joint Custody vault. | $PK_1$, $PK_2$, $PK_3$ | <div align="center"> ![Blue Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png) </div> |
|Primary Agent Keys 1,2,3 | These keys belong to the agent, who the Principal has engaged with to facilitate the securing of bitcoin for a determined set of time. | $PAK_1$, $PAK_2$, $PAK_3$ | <div align="center"> ![Green Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png) </div> |
|Secondary Agent Key | This key is held by a 3rd party unassociated with the other keys, in the event the Principal has lost a majority of their keys, can sign transactions with the Primary Agent to move funds after a designated "Recovery Period" has started. | $SAK$ | <div align="center"> ![Red Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/83a8c241b2c2cf7ee940570aa97d8b0e1d751f55/assets/key_red.png) </div> |
|Recovery Keys 1,2,3 | These keys in practice belong to the Principal, they may even be keys related to the Principal Keys with a different derivation path, but can also be delegated key holders. After the initial Joint Custody vault agreement has ended, the recovery keys can unilaterally be used to withdraw money from the vault. | $RK_1$, $RK_2$, $RK_3$ | <div align="center"> ![Gray Key](https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png) </div> |



Below are reference diagrams on how the 3 Key Joint Custody operates across time:

---

### Joint Custody Summary Layers

Layer is used as an abstraction to segment the different eligible spending conditions, going in an ascending order of timelock values. At the start, only "Layer 1" is accessible for spending funds, over time, other spending conditions become available, but this does not restrict the ability to spend from a preceding layer.

| Layer | Layer Name                | Key Set 1                      | Condition Between Sets | Key Set 2          | Timelock Condition | Timelock                        |
|:-----:|:-------------------------:|:------------------------------:|:----------------------:|:------------------:|:------------------:|:-------------------------------:|
| 1     | Default Spending Path     | $PK_1$, $PK_2$, $PK_3$ (2 of 3)| AND                    | $PAK_1$, $PAK_2$, $PAK_3$ (2 of 3)| N/A            | None                            |
| 2     | Asset Recovery Path   | $PK_1$, $PK_2$, $PK_3$ (1 of 3)     | AND                    | $PAK_1$, $PAK_2$, $PAK_3$  (2 of 3)         | AND               | After (`smallest_epoch_timestamp`) |
| 3     | Emergency Recovery Path    | $PAK_1$, $PAK_2$, $PAK_3$ (2 of 3)| AND                 | $SAK$           | AND               | After (`between_epoch_timestamp`)                            |
| 4     | Sovereign Recovery Path   | $RK_1$, $RK_2$, $RK_3$ (2 of 3)| None | None              | AND               | After (`largest_epoch_timestamp`)  |

### Layer 1
<table>
  <tr>
    <th>Default Spending Path</th>
    <th colspan="3" style="text-align:center;">2 of 3 PKs</th>
    <th colspan="3" style="text-align:center;">2 of 3 PAKs</th>
  </tr>
  <tr>
    <td></td>
    <td align="center">PK<sub>1</sub></td>
    <td align="center">PK<sub>2</sub></td>
    <td align="center">PK<sub>3</sub></td>
    <td align="center">PAK<sub>1</sub></td>
    <td align="center">PAK<sub>2</sub></td>
    <td align="center">PAK<sub>3</sub></td>
  </tr>
  <tr>
    <td align="center">2 of 3 PKs AND 2 of 3 PAKs</td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK3"></td>
  </tr>
</table>

#### Valid Layer 1 Spend Conditions
| Spending Scenario | $PK_1$ | $PK_2$ | $PK_3$ | $PAK_1$ | $PAK_2$ | $PAK_3$ |
|-------------------|:------:|:------:|:------:|:-------:|:-------:|:-------:|
| Scenario 1        | ✅      | ✅      |        | ✅       | ✅       |         |
| Scenario 2        | ✅      |        | ✅      | ✅       | ✅       |         |
| Scenario 3        | ✅      | ✅      |        |         | ✅       | ✅       |
| Scenario 4        |        | ✅      | ✅      | ✅       | ✅       |         |
| Scenario 5        | ✅      |        | ✅      |         | ✅       | ✅       |
| Scenario 6        |        | ✅      | ✅      |         | ✅       | ✅       |
| Scenario 7        | ✅      | ✅      |        | ✅       |         | ✅       |
| Scenario 8        | ✅      |        | ✅      | ✅       |         | ✅       |
| Scenario 9        |        | ✅      | ✅      | ✅       |         | ✅       |


#### Layer 2
<table>
  <tr>
    <th>Asset Recovery Path</th>
    <th colspan="3" style="text-align:center;">1 of 3 PKs</th>
    <th colspan="3" style="text-align:center;">2 of 3 PAKs</th>
    <th>BIP-113 time greater than <code>`smallest_epoch_timestamp`</code></th>
  </tr>
  <tr>
    <td></td>
    <td align="center">PK<sub>1</sub></td>
    <td align="center">PK<sub>2</sub></td>
    <td align="center">PK<sub>3</sub></td>
    <td align="center">PAK<sub>1</sub></td>
    <td align="center">PAK<sub>2</sub></td>
    <td align="center">PAK<sub>3</sub></td>
    <td align="center"></td>
  </tr>
  <tr>
    <td align="center">1 of 3 PKs AND 2 of 3 PAKs AND BIP-113 time is greater than <code>`smallest_epoch_timestamp`</code></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_blue.png" alt="PK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/unlock.png" alt="Timelock"></td>
  </tr>
</table>


##### Valid Layer 2 Spend Conditions
| Spending Scenario | PK_1 | PK_2 | PK_3 | PAK_1 | PAK_2 | PAK_3 | BIP-113 greater than `smallest_epoch_timestamp` |
|-------------------|:----:|:----:|:----:|:-----:|:-----:|:-----:|:-----------------------------------:|
| Scenario 10       | ✅    |      |      | ✅     | ✅     |       | ✅                                   |
| Scenario 11       | ✅    |      |      | ✅     |       | ✅     | ✅                                   |
| Scenario 12       | ✅    |      |      |       | ✅     | ✅     | ✅                                   |
| Scenario 13       |      | ✅    |      | ✅     | ✅     |       | ✅                                   |
| Scenario 14       |      | ✅    |      | ✅     |       | ✅     | ✅                                   |
| Scenario 15       |      | ✅    |      |       | ✅     | ✅     | ✅                                   |
| Scenario 16       |      |      | ✅    | ✅     | ✅     |       | ✅                                   |
| Scenario 17       |      |      | ✅    | ✅     |       | ✅     | ✅                                   |
| Scenario 18       |      |      | ✅    |       | ✅     | ✅     | ✅                                   |

#### Layer 3:
<table>
  <tr>
    <th>Emergency Recovery Path</th>
    <th colspan="3" style="text-align:center;">2 of 3 PAKs</th>
    <th style="text-align:center;">1 SAK</th>
    <th>BIP-113 time greater than <code>`between_epoch_timestamp`</code></th>
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
    <td align="center">2 of 3 PAKs AND SAK AND after BIP-113 time is greater than <code>`between_epoch_timestamp`</code></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_green.png" alt="PAK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/83a8c241b2c2cf7ee940570aa97d8b0e1d751f55/assets/key_red.png" alt="SAK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/unlock.png" alt="Timelock"></td>
  </tr>
</table>

##### Valid Layer 3 Spend Conditions
| Spending Scenario | PAK_1 | PAK_2 | PAK_3 | SAK | BIP-113 time greater than  (between_epoch_timestamp) |
|-------------------|:-----:|:-----:|:-----:|:---:|:----------------------------------:|
| Scenario 19       | ✅     | ✅     |       | ✅  | ✅                                  |
| Scenario 20       | ✅     |       | ✅     | ✅  | ✅                                  |
| Scenario 21       |       | ✅     | ✅     | ✅  | ✅                                  |                                |

#### Layer 4:
<table>
  <tr>
    <th>Sovereign Recovery Path</th>
    <th colspan="3" style="text-align:center;">2 of 3 RKs</th>
    <th style="text-align:center;">Network BIP-113 time greater than <code>`largest_epoch_timestamp`</code></th>
  </tr>
  <tr>
    <td></td>
    <td align="center">RK<sub>1</sub></td>
    <td align="center">RK<sub>2</sub></td>
    <td align="center">RK<sub>3</sub></td>
    <td align="center"></td>
  </tr>
  <tr>
    <td align="center">2 of 3 RKs AND after BIP-113 time is greater than <code>`largest_epoch_timestamp`</code></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png" alt="RK1"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png" alt="RK2"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/key_gray.png" alt="RK3"></td>
    <td align="center"><img src="https://raw.githubusercontent.com/Rob1Ham/miniscript-templates/main/assets/unlock.png" alt="Timelock"></td>
  </tr>
</table>

##### Valid Layer 4 Spend Conditions
| Spending Scenario | RK_1 | RK_2 | RK_3 | Timelock (largest_epoch_timestamp) |
|-------------------|:----:|:----:|:----:|:----------------------------------:|
| Scenario 22       | ✅    | ✅    |      | ✅                                  |
| Scenario 23       | ✅    |      | ✅    | ✅                                  |
| Scenario 24       |      | ✅    | ✅    | ✅                                  |

---
# Example Miniscript Output Descriptor
For this example, the `smallest_epoch_timestamp` is: 1753488000 (July 26, 2025 00:00:00 UTC), the `between_epoch_timestamp` is: 1766880000 (December 28, 2025 00:00:00 UTC) and `largest_epoch_timestamp` is: 1770768000 (February 11, 2026 00:00:00 UTC)

- MINT-005 Output Descriptor:
<code>wsh(andor(multi(2,$PAK_1$,$PAK_2$,$PAK_3$),or_i(and_v(v:pkh($SAK$),after(`between_epoch_timestamp`)),thresh(2,pk($PK_1$),s:pk($PK_2$),s:pk($PK_3$),snl:after(`smallest_epoch_timestamp`))),and_v(v:thresh(2,pkh($RK_1$),a:pkh($RK_2$),a:pkh($RK_3$)),after(`largest_epoch_timestamp`))))</code>

- Source Policy (FOR REFERENCE PURPOSES ONLY):
<code>"or(99@and(thresh(2,pk($PAK_1$),pk($PAK_2$),pk($PAK_3$)),or(99@thresh(2,pk($PK_1$),pk($PK_2$),pk($PK_3$),after(`smallest_epoch_timestamp`)),and(pk($SAK$),after(`between_epoch_timestamp`)))),and(thresh(2,pk($RK_1$),pk($RK_2$),pk($RK_3)),after(`largest_epoch_timestamp`)))"</code>

## Layer 1 Example Spend

Signed by: $PK_2$, $PK_3$, $PAK_1$, $PAK_2$

[Reference Testnet Transaction](https://mempool.space/signet/tx/8b5d80b6b9adf6dc2d0f83372e77b81150e67689a0119348f8cbbea1121afd97)

## Layer 2 Example Spend
Signed by: $PK_2$, $PAK_1$, $PAK_2$

[Reference Testnet Transaction](https://mempool.space/signet/tx/07cbd89200f05dd68ade5f10f9f6e212278f7bd1dd0b494039fe99752eb10d46)

## Layer 3 Example Spend
Signed by: $PAK_1$, $PAK_2$, $SAK$

[Reference Testnet Transaction](https://mempool.space/signet/tx/a10a5962098e5912887137735c39a39e921e7f9cdf65e68062aed4bd72988dc7)

## Layer 4 Example Spend
Signed by: $RK_1$, $RK_2$

[Reference Testnet Transaction](https://mempool.space/signet/tx/1de409327398bcdcb9e5bb1dc31a52a77e9567a4ce17ff794e8cb76e201833c6)