<!-- 
sed -i      's/.md/.html/' index.html >/dev/null
sed -i  ''  's/.md/.html/' index.html >/dev/null ## macos
-->

<table>
<thead>
<tr class="header">
<th><a href="."><img src="https://avatars.githubusercontent.com/u/7424983?s=30" alt="miniscript templates (MinT)" /></a></th>
<th><a href="mint-000.md">000</a></th>
<th><a href="mint-001.md">001</a></th>
<th><a href="mint-002.md">002</a></th>
</tr>
</thead>
</table>


<H1>

<center>Submission Format</center>

</H1>

## Name of Template [^mint] [^mintt]

### Proposed Timelock Usage

### Goal to be achieved by template

<!-- clear and concise outcomes -->
A 3-of-3 that turns into a 2-of-3 after 90 days

<!-- clear and concise outcomes -->
##### Detailed Explanation

Provide a detailed explanation. This will ease the review process as well as inform other developers how to implement the template.

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

<tbody>
<tr class="odd">
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=50" title="logo-50" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=50" title="logo-50" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=50" title="logo-50" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=50" title="logo-50" alt="Alt Image Text" /></a></td>
</tr><br>
<tr class="even">
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-30" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-30" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-30" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-30" alt="Alt Image Text" /></a></td>
</tr><br>
<tr class="odd">
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-20" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-20" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-20" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-20" alt="Alt Image Text" /></a></td>
</tr><br>
<tr class="even">
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-10" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-10" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-10" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-10" alt="Alt Image Text" /></a></td>
</tr>
</tbody>

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
<center>
<tbody>
<tr class="odd">
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=50" title="logo-50" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=50" title="logo-50" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=50" title="logo-50" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=50" title="logo-50" alt="Alt Image Text" /></a></td>
</tr><br>
<tr class="even">
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-30" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-30" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-30" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-30" alt="Alt Image Text" /></a></td>
</tr><br>
<tr class="odd">
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-20" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-20" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-20" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-20" alt="Alt Image Text" /></a></td>
</tr><br>
<tr class="even">
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-10" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-10" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-10" alt="Alt Image Text" /></a></td>
<td style="text-align: center;"><a href=""><img src="https://avatars.githubusercontent.com/u/7424983?s=30" title="logo-10" alt="Alt Image Text" /></a></td>
</tr>
</tbody>
</center>
</p>
</details>

<!-- footnotes -->

[^mint]: Miniscript Template (MinT)
[^mintt]: MiniTapscript Template (MinTT)
