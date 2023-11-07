      MinTT: 9999
      Title: MinTT-9999-mini-taproot-script
      Created: YYYY-MM-DD

### MinTT-9999-mini-taproot-script {#mintt_9999_mini_taproot_script}

Proposed Timelock Usage

### Summary

Miniscript is a language for writing (a subset of) Bitcoin Scripts in a
structured way, enabling analysis, composition, generic signing and
more.

Bitcoin Script is an unusual stack-based language with many edge cases,
designed for implementing spending conditions consisting of various
combinations of signatures, hash locks, and time locks. Yet despite
being limited in functionality it is still highly nontrivial to:

Given a combination of spending conditions, finding the most economical
script to implement it. Given two scripts, construct a script that
implements a composition of their spending conditions (e.g. a multisig
where one of the \"keys\" is another multisig). Given a script, find out
what spending conditions it permits. Given a script and access to a
sufficient set of private keys, construct a general satisfying witness
for it. Given a script, be able to predict the cost of spending an
output. Given a script, know whether particular resource limitations
like the ops limit might be hit when spending. Miniscript functions as a
representation for scripts that makes these sort of operations possible.
It has a structure that allows composition. It is very easy to
statically analyze for various properties (spending conditions,
correctness, security properties, malleability, \...). It can be
targeted by spending policy compilers (see below). Finally, compatible
scripts can easily be converted to Miniscript form - avoiding the need
for additional metadata for e.g. signing devices that support it.

Miniscript is designed for (P2SH-)P2WSH and Tapscript (as defined in
BIP342) embedded scripts. Most of its constructions work fine in P2SH as
well, but some of the (optional) security properties rely on
Segwit-specific rules. Furthermore, the implemented policy compilers
assume a Segwit-specific cost model.

Miniscript was designed and implemented by Pieter Wuille, Andrew
Poelstra, and Sanket Kanjalkar at Blockstream Research, but is the
result of discussions with several other people.

Links:

This website and C++ compiler: \[code\] Bitcoin Core compatible C++
implementation: \[code\] Rust-miniscript implementation: \[code\] Talk
about (an early version of) Miniscript at SBC\'19: \[video\]
\[transcript\] \[slides\]

2\. Goal to be achieved by template

[Miniscript](https://bitcoin.sipa.be/miniscript/) facilitates easier
access to utilizing timelocks in Bitcoin, it opens a new frontier in
Bitcoin security concerning the construction of more advanced Scripts.
This document aims to standardize timelock application across different
wallet solutions, focusing on wallet recovery and standardizing expected
timelock usage for streamlined hardware and software wallet interfaces.

In the event an output descriptor has been partially or fully lost,
minimizing the overall search space for expected timestamp values can
expedite recovery. General Miniscript usage supports any valid timelock
value, this proposal seeks to guide implementation to more user-friendly
practices.

Block height based Timelocks: {#block_height_based_timelocks}
=============================

Absolute block height based Timelocks {#absolute_block_height_based_timelocks}
-------------------------------------

**Proposal**: Set absolute block height-based timelocks as multiples of
100, always ending in 00.

Examples of valid Block Height Absolute Timelocks

-   after(1000)
-   after(50700)
-   after(82800)
-   after(615000)

Relative block height based Timelocks {#relative_block_height_based_timelocks}
-------------------------------------

**Proposal**: Make relative block height-based timelocks multiples of
100, except for the maximum value, 65,536 (2\^16).

-   older(100)
-   older(1500)
-   older(65535)

Epoch timestamp based Timelocks: {#epoch_timestamp_based_timelocks}
================================

Absolute Epochtime based Timelocks {#absolute_epochtime_based_timelocks}
----------------------------------

**Proposal**: To synchronize with real-world time rather than block
time, employ epoch timestamps that are divisible by 43200 (Noon GMT) or
86400 (Midnight GMT). Optimally, use multiples of 604800 for Thursday at
Midnight GMT.

**Limitation**: Avoid setting epoch timestamps beyond 2105 (4291704000)
to prevent any possible issue with related to its 32 bit unsigned
integer used for timestamps to happen in in February of 2106.

Propsoed Examples of valid Epoch Timestamp Absolute Timelocks

-   after(1694476800) September 12th, 2023 Midnight GMT
-   after(1694520000) September 12th, 2023 Noon GMT
-   after(2160172800) June 15th, 2038 Midnight GMT
-   after(2234779200) October 25th, 2040 Noon GMT

Relative Epochtime based Timelocks {#relative_epochtime_based_timelocks}
----------------------------------

Proposed Examples of valid Block Height Relative Timelocks:

Background:

-   Following
    [BIP68](https://github.com/bitcoin/bips/blob/master/bip-0068.mediawiki),
    relative epoch timestamp timelocks can only go as far out as
    33,554,431 seconds (1.06 years), as it is constrained by the same
    units as relative block height timelocks, 65,536 (2\^16), where each
    unit represents 512 seconds (8 minutes and 32 seconds) of time
    (65,356 units \* 512 seconds = 33,554,432 seconds).

<!-- -->

-   An Epoch Timestamp is not valid until the network\'s MTP (Median
    Time Past) of the past 11 blocks is greater than the epoch
    timestamp, MTP is defined in:
    [BIP113](https://github.com/bitcoin/bips/blob/master/bip-0113.mediawiki).

<!-- -->

-   The smallest value that can be used to have the miniscript compiler
    interpret a relative timelock is older(4194305) (calculated by
    following the BIP68 spec of: 1 \|= (1 \<\< 22)). This is a 1 unit
    timelock of duration 512 seconds.

<!-- -->

-   The maximum value for a relative epoch timelock is older(4259839)
    which is 65,535 unit timelock, resulting in 33,554,431 seconds, or
    388 days.

<!-- -->

-   The 512 second incrementor is a common multiple for the amount of
    seconds in 4 days, which is 675 units. To encourage intuitive usage
    of relative timelocks, they should be multiples of 675.

, an exception should be made for the largest possible epoch timestamp
relative timelock.

**Proposal**: Starting at 4194304, increment by 675 (4 days), for
relative epochtime timelocks, the maximum value being 4259839.

Propsoed Examples of valid Epoch Timestamp Absolute Timelocks

-   older(4194979) 4 days, minimum value
-   older(4214554) 120 days
-   older(4224679) 180 days
-   older(4255729) 364 days
-   older(4259839) 388 days, maximum value
