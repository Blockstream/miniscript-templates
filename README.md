[![miniscript templates (MinT)
](https://avatars.githubusercontent.com/u/7424983?s=15) **miniscript-templates** ](https://github.com/Blockstream/miniscript-templates)


<center>

|[MinT-000](MinT-000.md)|[MinT-001](MinT-001.md)|[MinT-002](MinT-002.md)|[MinT-003](MinT-003.md)|[MinT-004](MinT-004.md)|
|----------|----------|----------|----------|----------|

|[MinT-999](MinT-999.md)|[MinTT-999](MinTT-999.md)|[MinTT-9999](MinTT-9999.md)|[MinTT-9999](MinTT-9999.md)|[MinTT-9999](MinTT-9999.md)|
|----------|----------|----------|----------|----------|

</center>

## About

[Miniscript](https://bitcoin.sipa.be/miniscript/) is a language for
composing Bitcoin [Script](https://en.bitcoin.it/wiki/Script) in a
structured way, facilitating analysis, composition, and generic signing.
It\'s a simplified, composable subset of the Bitcoin
[Script](https://en.bitcoin.it/wiki/Script) language. Developed to
overcome limitations in writing complex spending conditions directly in
Bitcoin [Script](https://en.bitcoin.it/wiki/Script), it enables formal
verification and offers a more human-friendly interface.

## Objective

1.  Each MinT provides an example of a common miniscript implementation.
2.  Each MinT is provided as is. While care is taken to ensure a high degree of quality. Developers and enthusiasts assume full responsibility for their usage[^use-at-your-own-risk].

3.  Have reviewed templates that leverage Miniscript to assure there are
    not unintended ways of executing a valid spend beyond the intended
    [Miniscript](https://raw.githubusercontent.com/bitcoin/bitcoin/master/src/script/miniscript.h)
    policy.

4.  Have standardized usages of Miniscript to streamline software and
    hardware wallet integrations.

5.  Have uniform on-chain usage of Miniscript templates for better
    privacy.

<H2>

Submission Format

</H2>

### Name of Template

Proposed Timelock Usage

### Goal to be achieved by template

A 3-of-3 that turns into a 2-of-3 after 90 days

`   NOTE: 144 blocks per day x 90 days = 12960 blocks`

### Miniscript Policy

Input:

    thresh(3, pk(key_1), pk(key_2), pk(key_3), older(12960))

Output:

    thresh(3, pk(key_1), s:pk(key_2), s:pk(key_3), sln:older(12960))

    Spending cost analysis

    Script: 122 WU
    Input: 166.250000 WU
    Total: 288.250000 WU

<h4>

Resulting Bitcoin Script structure

</h4>


    <key_1> OP_CHECKSIG OP_SWAP <key_2> OP_CHECKSIG OP_ADD OP_SWAP <key_3>
    OP_CHECKSIG OP_ADD OP_SWAP OP_IF
      0
    OP_ELSE
      <a032> OP_CHECKSEQUENCEVERIFY OP_0NOTEQUAL
    OP_ENDIF
    OP_ADD 3 OP_EQUAL

[testnet
tx](https://mempool.space/testnet/tx/13a204ec065f76878ee1f59f79b3eb2cea2b3fda4d8938e6cfa6a8394d090769)

`   `[`https://mempool.space/testnet/tx/13a204ec065f76878ee1f59f79b3eb2cea2b3fda4d8938e6cfa6a8394d090769`](https://mempool.space/testnet/tx/13a204ec065f76878ee1f59f79b3eb2cea2b3fda4d8938e6cfa6a8394d090769)

### Additional Links

[usage
example](https://github.com/sipa/miniscript/blob/master/bitcoin/script/miniscript.h)

### Additional Resources

[
github.com/sipa/miniscript/tree/master](https://github.com/sipa/miniscript/tree/master )

[
bitcoin.sipa.be/miniscript](https://bitcoin.sipa.be/miniscript )

<details>
<summary>Additional Links</summary>
<p>

#### Blockstream/miniscript-templates:

[![Additional Link](https://avatars.githubusercontent.com/u/7424983?s=100)](https://github.com/Blockstream/miniscript-templates)

</p>
</details>
