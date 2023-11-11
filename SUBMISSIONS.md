<!-- header -->

<!-- add the link to your template in navigation README.md -->

<center>

|[![miniscript templates (MinT)](https://avatars.githubusercontent.com/u/7424983?s=30)]()|[000](mint-000.md)|[001](mint-001.md)|[002](mint-002.md)|
|----------|----------|----------|----------|

</center>

<!-- additional navigation

|[003](mint-003.md)|[004](mint-004.md)|[005](mint-005.md)|[006](mint-006.md)|
|----------|----------|----------|----------|

-->

<!-- additional navigation

|[007](mint-007.md)|[008](mint-008.md)|[008](mint-009.md)|[009](mint-009.md)|
|----------|----------|----------|----------|

-->

<H1>

<center>Submission Format</center>

</H1>

## Name of Template[^mint] [^mintt]

### Proposed Timelock Usage

### Goal to be achieved by template

<!-- clear and concise outcomes -->
A 3-of-3 that turns into a 2-of-3 after 90 days

<!-- clear and concise outcomes -->
##### Detailed Explaination

Prvide a detailed explaination. This will ease the review process as well as inform other developers how to implement the template.

#### Policy:
<!-- copy and pastable -->

    thresh(3, pk(key_1), pk(key_2), pk(key_3), older(12960))

#### Output:
<!-- copy and pastable -->

    thresh(3, pk(key_1), s:pk(key_2), s:pk(key_3), sln:older(12960))

#### Cost Analysis:

> Script: 122 WU
> 
> Input: 166.250000 WU
> 
> Total: 288.250000 WU

<h4>

Resulting Bitcoin Script:

</h4>

    <key_1> OP_CHECKSIG OP_SWAP <key_2> OP_CHECKSIG OP_ADD OP_SWAP <key_3>
    OP_CHECKSIG OP_ADD OP_SWAP OP_IF
      0
    OP_ELSE
      <a032> OP_CHECKSEQUENCEVERIFY OP_0NOTEQUAL
    OP_ENDIF
    OP_ADD 3 OP_EQUAL

### Example Transaction:

`   `[`https://mempool.space/testnet/tx/13a204ec065f76878ee1f59f79b3eb2cea2b3fda4d8938e6cfa6a8394d090769`](https://mempool.space/testnet/tx/13a204ec065f76878ee1f59f79b3eb2cea2b3fda4d8938e6cfa6a8394d090769)

### Additional Notes:

> provide code examples
> 

> provide test vectors
> 

> provide graphics to add detail
> 
|[![miniscript templates (MinT)](https://avatars.githubusercontent.com/u/7424983?s=100)]()|[![miniscript templates (MinT)](https://avatars.githubusercontent.com/u/7424983?s=100)]()|[![miniscript templates (MinT)](https://avatars.githubusercontent.com/u/7424983?s=100)]()|[![miniscript templates (MinT)](https://avatars.githubusercontent.com/u/7424983?s=100)]()|
|:--------:|:--------:|:--------:|:--------:|
|[![Alt Image Text][logo-50]]()|[![Alt Image Text][logo-50]]()|[![Alt Image Text][logo-50]]()|[![Alt Image Text][logo-50]]()|
|[![Alt Image Text][logo-30]]()|[![Alt Image Text][logo-30]]()|[![Alt Image Text][logo-30]]()|[![Alt Image Text][logo-30]]()|
|[![Alt Image Text][logo-20]]()|[![Alt Image Text][logo-20]]()|[![Alt Image Text][logo-20]]()|[![Alt Image Text][logo-20]]()|
|[![Alt Image Text][logo-10]]()|[![Alt Image Text][logo-10]]()|[![Alt Image Text][logo-10]]()|[![Alt Image Text][logo-10]]()|
> provide methods of testing
> 
> provide methods of analysis

<hr>

### ***Author/s:***

[![github profile](https://avatars.githubusercontent.com/u/548488?s=50)]()

[github.com/sipa](https://github.com/sipa)


### ***Co-Author:***

[![github profile](https://avatars.githubusercontent.com/u/548488?s=50)]()

[github.com/sipa](https://github.com/sipa)

### ***Co-Author:***

[![github profile](https://avatars.githubusercontent.com/u/548488?s=50)]()

[github.com/sipa](https://github.com/sipa)

### Additional Links:

[1. example](https://github.com/sipa/miniscript/tree/master )

[2. example](https://github.com/sipa/miniscript/blob/master/bitcoin/script/miniscript.h)

### websites:

[bitcoin.sipa.be/miniscript](https://bitcoin.sipa.be/miniscript)

[bitcoin.sipa.be](https://bitcoin.sipa.be)


<!-- navigation example, logos, markdown syntax  -->
<!-- remove prior to submission -->

<hr>
<details>
<summary>Blockstream Research</summary>
<p>

|[![miniscript templates (MinT)](https://avatars.githubusercontent.com/u/7424983?s=100)]()|[![miniscript templates (MinT)](https://avatars.githubusercontent.com/u/7424983?s=100)]()|[![miniscript templates (MinT)](https://avatars.githubusercontent.com/u/7424983?s=100)]()|[![miniscript templates (MinT)](https://avatars.githubusercontent.com/u/7424983?s=100)]()|
|:--------:|:--------:|:--------:|:--------:|
|[![Alt Image Text][logo-50]]()|[![Alt Image Text][logo-50]]()|[![Alt Image Text][logo-50]]()|[![Alt Image Text][logo-50]]()|
|[![Alt Image Text][logo-30]]()|[![Alt Image Text][logo-30]]()|[![Alt Image Text][logo-30]]()|[![Alt Image Text][logo-30]]()|
|[![Alt Image Text][logo-20]]()|[![Alt Image Text][logo-20]]()|[![Alt Image Text][logo-20]]()|[![Alt Image Text][logo-20]]()|
|[![Alt Image Text][logo-10]]()|[![Alt Image Text][logo-10]]()|[![Alt Image Text][logo-10]]()|[![Alt Image Text][logo-10]]()|

<!--uncomment ![Alt Image Text][logo-100] -->
 
[logo-100]: https://avatars.githubusercontent.com/u/7424983?s=100 "logo-100"

<!--uncomment  ![Alt Image Text][logo-50] -->
 
[logo-50]: https://avatars.githubusercontent.com/u/7424983?s=50 "logo-50"

<!--uncomment ![Alt Image Text][logo-30] -->
 
[logo-30]: https://avatars.githubusercontent.com/u/7424983?s=30 "logo-30"

<!--uncomment ![Alt Image Text][logo-20] -->

[logo-20]: https://avatars.githubusercontent.com/u/7424983?s=30 "logo-20"

<!--uncomment ![Alt Image Text][logo-10] -->

[logo-10]: https://avatars.githubusercontent.com/u/7424983?s=30 "logo-10"

</p>
</details>

<!-- footnotes -->

[^mint]: Miniscript Template (MinT)
[^mintt]: MiniTapscript Template (MinTT)
[^use-at-your-own-risk]: Use at your own risk.
