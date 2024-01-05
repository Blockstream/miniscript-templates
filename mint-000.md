# mint-000

## Proposed Timelock Usage

## Motivation

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

# Block height based Timelocks:

## Absolute block height based Timelocks

**Guideline**: Set absolute block height-based timelocks as multiples of
100, always ending in 00.

##### Examples of valid Block Height Absolute Timelocks

**<code>after(1000)</code>**

**<code>after(50700)</code>**

**<code>after(82800)</code>**

**<code>after(615000)</code>**

## Relative block height based Timelocks

**Guideline**: Make relative block height-based timelocks multiples of
100, except for the maximum value, 65,536 (2\^16).

**<code>older(100)</code>**

**<code>older(1500)</code>**

**<code>older(65535)</code>**

# Epoch timestamp based Timelocks:

## Absolute Epochtime based Timelocks

**Guideline**: To synchronize with real-world time rather than block
time, employ epoch timestamps that are divisible by 43200 (Noon GMT) or
86400 (Midnight GMT). Optimally, use multiples of 604800 for Thursday at
Midnight GMT.

**Limitation**: Avoid setting epoch timestamps beyond 2105 (4291704000)
to prevent any possible issue with related to its 32 bit unsigned
integer used for timestamps to happen in February of 2106.

##### Examples of valid Epoch Timestamp Absolute Timelocks

**<code>after(1694476800)</code>** ***September 12th, 2023 Midnight GMT***

**<code>after(1694520000)</code>** ***September 12th, 2023 Moon GMT***

**<code>after(2160172800)</code>** ***June 15th, 2038 Midnight GMT***

**<code>after(2234779200)</code>** ***October 25th, 2040 Noon GMT***

## Relative Epochtime based Timelocks

##### Examples of valid Block Height Relative Timelocks:

Background:

-   Following
    [BIP68](https://github.com/bitcoin/bips/blob/master/bip-0068.mediawiki),
    relative epoch timestamp timelocks can only go as far out as
    33,554,431 seconds (1.06 years), as it is constrained by the same
    units as relative block height timelocks, 65,536 (2\^16), where each
    unit represents 512 seconds (8 minutes and 32 seconds) of time
    (65,356 units \* 512 seconds = 33,554,432 seconds).

-   An Epoch Timestamp is not valid until the network\'s MTP (Median
    Time Past) of the past 11 blocks is greater than the epoch
    timestamp, MTP is defined in:
    [BIP113](https://github.com/bitcoin/bips/blob/master/bip-0113.mediawiki).

-   The smallest value that can be used to have the miniscript compiler
    interpret a relative timelock is older(4194305) (calculated by
    following the BIP68 spec of: 1 \|= (1 \<\< 22)). This is a 1 unit
    timelock of duration 512 seconds.

-   The maximum value for a relative epoch timelock is older(4259839)
    which is 65,535 unit timelock, resulting in 33,554,431 seconds, or
    388 days.

-   The 512 second incrementor is a common multiple for the amount of
    seconds in 4 days, which is 675 units. To encourage intuitive usage
    of relative timelocks, they should be multiples of 675.

An exception should be made<br>
- for the largest possible epoch timestamp relative timelock.

**Proposal**: Starting at 4194304, increment by 675 (4 days), for
relative epochtime timelocks, the maximum value being 4259839.

##### Examples of valid Epoch Timestamp Absolute Timelocks

**<code>older(4194979)</code>** ***4 days, minimum value***

**<code>older(4214554)</code>** ***120 days***

**<code>older(4224679)</code>** ***180 days***

**<code>older(4255729)</code>** ***364 days***

**<code>older(4259839)</code>** ***388 days, maximum value***
