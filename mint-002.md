# mint-002

## 5 Key Degrading Multisig

## Motivation

Expanding upon the concept of a [2-of-3 key timed multisig](mint-001.md) [(mint-001)](mint-001.md), a 5 key timed multisig allows for multiple timelocks to be introduced for additional flexibility.

A timelock can be employed to allow a native 3-of-5 multisig to become 2-of-5, and eventually 1-of-5 for disaster recovery.

This can be employed by using a miniscript `tresh()` with seven conditions:

### 3 Layer Conditions to be satisfied using:

#### Base expressions (type B).

1. **timelock**: **after(**int**)**[^after] or **older(**int**)** - either **relative** or **absolute** [^timelock].

2. **timelock**: **after(**int**)** or **older(**int**)**[^older]  - either **relative** or **absolute** [^either].

#### Key expressions[^k_type] (type K).

1. **pk(**key1**)** [^pk_key1]

2. **pk(**key2**)** [^pk_key2]

3. **pk(**key3**)** [^pk_key3]

4. **pk(**key4**)** [^pk_key4]

5. **pk(**key5**)** [^pk_key5]

### More on Timelock Values

##### - The security of the descriptor template is not dependent on the value of a relative or absolute timelock, as it only impacts the duration of the timelock.

##### - For reference transactions on testnet, short duration timelocks have been used. In practice timelock values will differ.

##### - Relative timelock descriptors offer a structure that can persist across time, requiring a self-send to extend the timelock security, and thus offering a better ability to have standard timelock durations within templates.

##### - It is harder to set established timelock values with absolute timelock descriptors as they need to be regularly updated.

##### Suggested Relative Block Height Timelocks:

- **older(**32800**)** - Halfway point of block height relative timelock [^278days]

- **older(**65535**)** - Maximum duration of a block height relative timelock [^455days]

##### Suggested Relative Epoch Timmelocks:

- **older(**4224680**)** - Approximate Halfway point of epoch time relative timelock [^180days]

- **older(**4259839**)** - Maximum duration of an epoch time relative timelock [^388days]

Below is a reference diagram on how the 5 Key Time Layered Multisig
operates across time:

---
#### Layer 1

| $3 \space Key \space Layered \space Timelock$ | $Key_1$ | $Key_2$ | $Key_3$ |  $Key_4$ | $Key_5$ | $Timelock_1$ | $Timelock_2$ |
|:--|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|$Key_1  \space ... \space Key_5$ + $\space \space \space$ $Lock_1$ + $Lock_2$ | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png)| ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png)| ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/lock.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/lock.png) |

##### Valid Key Spend Conditions

##### 3 Key Combinations

|$Key_n$|$Key_1$|$Key_2$|$Key_3$|$Key_4$|$Key_5$|
|:---------|:--:|:--:|:--:|:--:|:--:|
|$Key_1  \space ... \space Key_5$| ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png)| ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png)|

### $Key_1$:

$\left[ Key_1 \space AND \space Key_2 \space AND \space Key_3 \right]$ OR

$\left[ Key_1 \space AND \space Key_2 \space AND \space Key_4 \right]$ OR

$\left[ Key_1 \space AND \space Key_2 \space AND \space Key_5 \right]$ OR

$\left[ Key_1 \space AND \space Key_3 \space AND \space Key_4 \right]$ OR

$\left[ Key_1 \space AND \space Key_4 \space AND \space Key_5 \right]$

### $Key_2$:

$\left[ Key_2 \space AND \space Key_3 \space AND \space Key_4 \right]$ OR

$\left[ Key_2 \space AND \space Key_3 \space AND \space Key_5 \right]$ OR

$\left[ Key_2 \space AND \space Key_4 \space AND \space Key_5 \right]$ OR

#### $Key_3$:

$\left[ Key_3 \space AND \space Key_4 \space AND \space Key_5 \right]$

---
##### Layer 2:

##### 2 Keys + $Timelock_1$ Expires

| $Key \space Combos \space and \space Timelock_1$ | $Key_1$ | $Key_2$ | $Key_3$ | $Key_4$ | $Key_5$ | $Timelock_1$ | $Timelock_2$ |
|:--|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|$Key_1  \space ... \space Key_5 \space + Timelock_1$| ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png)| ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png)| ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/unlock.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/lock.png) |

### $Key_1$:

$\left[ Key_1 \space AND \space Key_2 \space AND \space Timelock_1 \right]$ OR

$\left[ Key_1 \space AND \space Key_3 \space AND \space Timelock_1 \right]$ OR

$\left[ Key_1 \space AND \space Key_4 \space AND \space Timelock_1 \right]$ OR

$\left[ Key_1 \space AND \space Key_5 \space AND \space Timelock_1 \right]$
### $Key_2$:

$\left[ Key_2 \space AND \space Key_3 \space AND \space Timelock_1 \right]$ OR

$\left[ Key_2 \space AND \space Key_4 \space AND \space Timelock_1 \right]$ OR

$\left[ Key_2 \space AND \space Key_5 \space AND \space Timelock_1 \right]$
#### $Key_3$:

$\left[ Key_3 \space AND \space Key_4 \space AND \space Timelock_1 \right]$ OR

$\left[ Key_3 \space AND \space Key_5 \space AND \space Timelock_1 \right]$
#### $Key_4$:

$\left[ Key_4 \space AND \space Key_5 \space AND \space Timelock_1 \right]$

---
##### Layer 3:

##### 1 Key + $Timelock_1$ Expired + $Timelock_2$ Expired

| $Key \space + Timelocks$ | $Key_1$ | $Key_2$ | $Key_3$ |  $Key_4$ | $Key_5$ | $Timelock_1$ | $Timelock_2$ |
|:--|:--:|:--:|:--:|:--:|:--:|:--:|:--:|
|$Key_n \space + Timelock_1 \space + \space Timelock_2$| ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png)| ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/key.png)| ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/unlock.png) | ![assets/key.png](https://raw.githubusercontent.com/bitcoincore-dev/miniscript-templates/main/assets/unlock.png) |

### $Key_n$:

$\left[ Key_1 \space AND \space Timelock_1 \space AND \space Timelock_2 \right]$ OR

$\left[ Key_2 \space AND \space Timelock_1 \space AND \space Timelock_2 \right]$ OR

$\left[ Key_3 \space AND \space Timelock_1 \space AND \space Timelock_2 \right]$ OR

$\left[ Key_4 \space AND \space Timelock_1 \space AND \space Timelock_2 \right]$ OR

$\left[ Key_5 \space AND \space Timelock_1 \space AND \space Timelock_2 \right]$

---
# Example Miniscript Output Descriptor

## 5 Key Time Lock Multisig

### Relative Blockheight Timelock

#### Policy:

<code>thresh(3,pk(XPUB1),pk(XPUB2),pk(XPUB3),pk(XPUB4),pk(XPUB5),older(100),older(200))</code>

#### Miniscript:

<code>thresh(3,pk(XPUB1),s:pk(XPUB2),s:pk(XPUB3),s:pk(XPUB4),s:pk(XPUB5),sun:older(100),sun:older(200))</code>

#### Descriptor:

<code>wsh(thresh(3,pk(XPUB1),s:pk(XPUB2),s:pk(XPUB3),s:pk(XPUB4),s:pk(XPUB5),snu:older(100),snu:older(200)))</code>

[Reference Testnet
Transaction](https://mempool.space/testnet/tx/31e22b75d58323f7cfca225912a90d49ff959716babd9bad9fe6459a9f91b700)

### Absolute Blockheight Timelock

#### Policy:

<code>thresh(3,pk(XPUB1),pk(XPUB2),pk(XPUB3),pk(XPUB4),pk(XPUB5),after(1694563200),after(1694563200))</code>

#### Miniscript:

<code>thresh(3,pk(XPUB1),s:pk(XPUB2),s:pk(XPUB3),s:pk(XPUB4),s:pk(XPUB5),sun:after(1694563200),sun:after(1694563200))</code>

#### Descriptor:

<code>wsh(thresh(3,pk(XPUB1),s:pk(XPUB2),s:pk(XPUB3),s:pk(XPUB4),s:pk(XPUB5),snu:after(1694563200),snu:after(1694563200)))</code>

[Reference Testnet
Transaction](https://mempool.space/testnet/tx/d6e1dd2e35ffcf111f3868ee38d22e70b2439d7b3bc1db064fef6d25eee3c506)

### Absolute Epochtime Timelock

#### Policy:

<code>thresh(3,pk(XPUB1),pk(XPUB2),pk(XPUB3),pk(XPUB4),pk(XPUB5),after(1694563200),after(1694476800))</code>

#### Miniscript:

<code>thresh(3,pk(XPUB1),s:pk(XPUB2),s:pk(XPUB3),s:pk(XPUB4),s:pk(XPUB5),sun:after(1694563200),sun:after(1694476800))</code>

#### Descriptor:

<code>wsh(thresh(3,pk(XPUB1),s:pk(XPUB2),s:pk(XPUB3),s:pk(XPUB4),s:pk(XPUB5),snu:after(1694563200),snu:after(1694476800)))</code>

[Reference Testnet
Transaction](https://mempool.space/testnet/tx/caba0f5b81beac934aeed0b93a1a683bc86cf85b3bc935284404bfddb9ab0156)

### Relative Epochtime Timelock

#### Policy:

<code>thresh(3,pk(XPUB1),pk(XPUB2),pk(XPUB3),pk(XPUB4),pk(XPUB5),older(4194400),older(4194500))</code>

#### Miniscript:

<code>thresh(3,pk(XPUB1),s:pk(XPUB2),s:pk(XPUB3),s:pk(XPUB4),s:pk(XPUB5),sun:older(4194400),sun:older(4194500))</code>

#### Descriptor:

<code>wsh(thresh(3,pk(XPUB1),s:pk(XPUB2),s:pk(XPUB3),s:pk(XPUB4),s:pk(XPUB5),snu:older(4194400),snu:older(4194500)))</code>

<!-- REF: https://github.com/bitcoin-core/btcdeb -->
<!--
btcc XPUB1 OP_CHECKSIG OP_SWAP XPUB2 OP_CHECKSIG OP_ADD OP_SWAP XPUB3 OP_CHECKSIG OP_ADD OP_SWAP XPUB4 OP_CHECKSIG OP_ADD OP_SWAP XPUB5 OP_CHECKSIG OP_ADD OP_SWAP OP_IF 0x600040 OP_CHECKSEQUENCEVERIFY OP_0NOTEQUAL OP_ELSE 0 OP_ENDIF OP_ADD OP_SWAP OP_IF 0xc40040 OP_CHECKSEQUENCEVERIFY OP_0NOTEQUAL OP_ELSE 0 OP_ENDIF OP_ADD 0x03 OP_EQUAL
-->

<!--
055850554231ac7c055850554232ac937c055850554233ac937c055850554234ac937c055850554235ac937c6303600040b292670068937c6303c40040b292670068935387
-->

<!-- REF: https://github.com/bitcoin/bitcoin -->
<!--
bitcoin-cli decodescript 055850554231ac7c055850554232ac937c055850554233ac937c055850554234ac937c055850554235ac937c6303600040b292670068937c6303c40040b292670068935387
-->

<!--
{
  "asm": "5850554231 OP_CHECKSIG OP_SWAP 5850554232 OP_CHECKSIG OP_ADD OP_SWAP 5850554233 OP_CHECKSIG OP_ADD OP_SWAP 5850554234 OP_CHECKSIG OP_ADD OP_SWAP 5850554235 OP_CHECKSIG OP_ADD OP_SWAP OP_IF 4194400 OP_CHECKSEQUENCEVERIFY OP_0NOTEQUAL OP_ELSE 0 OP_ENDIF OP_ADD OP_SWAP OP_IF 4194500 OP_CHECKSEQUENCEVERIFY OP_0NOTEQUAL OP_ELSE 0 OP_ENDIF OP_ADD 3 OP_EQUAL",
  "desc": "raw(055850554231ac7c055850554232ac937c055850554233ac937c055850554234ac937c055850554235ac937c6303600040b292670068937c6303c40040b292670068935387)#qlhrfmh7",
  "type": "nonstandard",
  "p2sh": "2N9snNqcD2ukieyZAhhcLbKzu35zs6nDdTt",
  "segwit": {
    "asm": "0 700af21a4069fbb58551485ea12dcbc6a940ab3cb5407c99fc9e385bd997f98a",
    "desc": "wsh(raw(055850554231ac7c055850554232ac937c055850554233ac937c055850554234ac937c055850554235ac937c6303600040b292670068937c6303c40040b292670068935387))#a8v0jy32",
    "hex": "0020700af21a4069fbb58551485ea12dcbc6a940ab3cb5407c99fc9e385bd997f98a",
    "address": "tb1qwq90yxjqd8amtp23fp02ztwtc655p2euk4q8ex0uncu9hkvhlx9qzskc90",
    "type": "witness_v0_scripthash",
    "p2sh-segwit": "2N8Q8fowZsgSdByKcjHAWbvWDE6qXQPDkMw"
  }
}
-->

[Reference Testnet
Transaction](https://mempool.space/testnet/tx/747087e37aadf7965568d5efa0a02ccc328908539c99e30fcb1bb9631554e317)

(To Add Taproot descriptors once MiniTapScript is merged into Core)

[^278days]: **~278 days** ***assuming constant hashrate***

[^455days]: **~455 days** ***assuming constant hashrate***

[^180days]: **~180 days** ***6 months***

[^388days]: **~388 days**

<!--
               fragment     fragment       ->    Bitcoin Script
-->

[^pk_key1]: **`pk(key1) = c:pk_k(key1)`** --> **`<key1> CHECKSIG`**
[^pk_key2]: **`pk(key2) = c:pk_k(key2)`** --> **`<key2> CHECKSIG`**
[^pk_key3]: **`pk(key3) = c:pk_k(key3)`** --> **`<key3> CHECKSIG`**
[^pk_key4]: **`pk(key4) = c:pk_k(key4)`** --> **`<key4> CHECKSIG`**
[^pk_key5]: **`pk(key5) = c:pk_k(key5)`** --> **`<key5> CHECKSIG`**

[^abs_timelock]: **after(**int**)**, **older(**int**)**: Require that the **nLockTime** or **nSequence** value is at least (**int**).

[^rel_timelock]: **after(**int**)**, **older(**int**)**: Require that the **nLockTime** or **nSequence** value is at least (**int**).

[^timelock]: **NUM** cannot be **0**.

[^older]: **older(**n**)** = **<n>** **CHECKSEQUENCEVERIFY**

[^after]: **after(**n**)** = **<n>** **CHECKLOCKTIMEVERIFY**

[^either]: either **relative**[^rel_timelock] or **absolute**[^abs_timelock]

[^k_type]: **Key** expressions (**K Type**) take their inputs from the top of the stack, but instead of verifying a condition directly they always push a public key onto the stack, for which a signature is still required to satisfy the expression. **A "K" can be converted into a "B" using the c: wrapper (CHECKSIG)**. <!-- P. Wuille -->
