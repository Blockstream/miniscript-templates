      Miniscript Template: 4
      Title: Multi Institutional Multisig (Two Agent)
      Created: 2023-10-02

Name of Template {#name_of_template}
================

Multi Institutional Custody

Goal to be achieved by template {#goal_to_be_achieved_by_template}
===============================

To provide a more robust method of securing Bitcoin across multiple
stakeholders, with a sovereign recovery path for the owner of the
Bitcoin after a contract has expired.

For this template, we are assuming a 3 institution model.

  Institution Name   Role
  ------------------ ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  Principle          This entity has title and ownership of the Bitcoin. This template is designed in such a way that after a contract with the other institutions has expired, access to the Bitcoin can be returned to them with use of the \"Master Keys\", expanded upon below.
  Primary Agent      This entity is the primary point of contact with the principle. Throughout a contract with the principle, they are a required signer at every stage with the exception of the sovereign recovery layer.
  Secondary Agent    This entity provides an added distribution of risk such that keys being compromised by the primary agent is not sufficient for movement of Bitcoin. Additionally, in the event the Principle has lost access to all of their keys, they can work with the Primary Agent to recover Bitcoin prior to the Sovereign Recovery Layer being activated.

Currently, multi-institutional custody has been achieved with legacy
multisig, where a principal can give one or more keys to agents.
Principals may not be in a position to hold any or all of their own
private keys for their Bitcoin. This can be due to various factors such
as technical competency, the regulatory landscape, or perceived risk.
Agents such as custodians (where all keys are managed by an agent) or
collaborative custodians (where keys are divided between the principal
and agent) enable those who are neither able nor willing to hold Bitcoin
entirely on their own to still use the Bitcoin network.

Agents add value by participating in Bitcoin transactions with their
key(s) whenever a principal wants to spend Bitcoin and lacks sufficient
private keys to directly broadcast a transaction. In the custodian
model, a principal requests a withdrawal, and the agent executes the
transaction on the principal\'s behalf. In the collaborative custody
model, the division of keys allows for disaster recovery: a principal
can lose one or more keys but still maintain access to their Bitcoin.
Typically, agents hold a minority of keys to prevent unilateral spending
without the cooperation of the principal. This results in a default
security model in which the principal maintains sovereign, unilateral
control of their Bitcoin at all times. For instance, in a 2-of-3
multisig setup, a principal holds two keys, while an agent holds one. At
any time, the principal can use their two keys to sign a transaction.

Although the custodian and collaborative custodian models suffice for
many use-cases, this template aims to bolster security and
recoverability by employing timelocks and \"thresholds of thresholds.\"
These features allow not just for external risk distribution across
multiple key-holding entities but also internal risk distribution within
a single institution.

For example, in a legacy 2-of-3 multisig where one key is held by an
agent and two by the principal, compromising the agent\'s key impairs
the institution\'s signing ability. By employing thresholds of
thresholds, both the principal and the agent can have their own 2-of-3
multisig setups, requiring signatures from both to spend Bitcoin. This
architecture prevents a single key\'s compromise at the agent\'s end
from incapacitating an institution\'s signing ability. Additionally,
security breaches involving the principal\'s keys don\'t result in
immediate Bitcoin loss, enabling agents to implement governance and
security checks before signing, thus blocking rogue transactions.

Timelocks further mitigate risks, allowing for the recovery of Bitcoin
even if principals or agents lose a majority&mdash;or all&mdash;of their
keys. Advanced key aggregation techniques like MuSig2 or FROST/ROAST can
further distribute risk, though they are beyond this template\'s scope.

Given that principals are often not experts in Bitcoin key management,
they are, all else being equal, more likely to mishandle key material.
Therefore, this template allows for a one-month window during which
multiple institutions can collaborate to recover a principal&rsquo;s
Bitcoin, providing a better solution than a custodian model, where only
one institution can sign off on transactions. In dire situations,
principals can also pre-sign transactions before these disaster recovery
pathways become available.

Upon contract expiration between a principal and an agent, a \"Sovereign
Recovery\" path becomes available, allowing the principal to opt out of
this multi-institutional arrangement. This uses a 2-of-3 legacy multisig
setup, in which the principal can control all three keys or delegate
some to agents. The keys for this sovereign recovery layer are the
\"Master Keys\" defined in the template.

Layred Security {#layred_security}
===============

A visual representation of this template\'s different spending
conditions are best summarized as a table, where each row (called a
\"layer\") representing how the different spending paths become
available in chronological order. To spend the bitcoin at any given
layer, all conditions must be satisfied for key key set present within
that layer:

  Layer Number   Layer Name                  Timelock   Principle Key Set   Primary Agent Key Set   Secondary Agent Key Set
  -------------- --------------------------- ---------- ------------------- ----------------------- -------------------------
  Layer 1        \"Happy Path\"              None       2 of 3              2 of 3                  1 of 3
  Layer 2        \"End of Term\"             365 Days   1 of 3              2 of 3                  1 of 3
  Layer 3        \"Principle Compromised\"   395 Days   None                2 of 3                  1 of 3
  Layer 4        \"Emergency Recovery\"      410 Days   None                1 of 3                  1 of 3
  Layer 5        \"Sovereign Recovery\"      425 Days   2 of 3              None                    None

While this is modeled on a 1 year contract, layers extend past 365 days
to provide disaster recovery windows to aid the principle in recovering
the bitcoin while the agent may still be liable for the safe keeping of
the Bitcoin.

Timelock Durations {#timelock_durations}
==================

This template is modeled on a 1 year contract, since it is based on a
calendar duration and not a blockheight duration, absolute epoch
timestamp timelocks are utilized for the layered security.

Based on a given start date, this is The use of absolute epoch timestamp
timelocks would look as follows:

  Layer     Epoch Timestamp Increment   Epoch Timestamp Cumulative   Duration
  --------- --------------------------- ---------------------------- -------------------------------
  Layer 1   0                           0                            N/A
  Layer 2   31536000                    31536000                     1 Year
  Layer 3   2592000                     34128000                     395 Days (\~1 Year & 30 Days)
  Layer 4   1296000                     35424000                     410 Days (\~1 Year & 45 Days)
  Layer 5   1296000                     36720000                     425 Days (\~1 Year & 60 Days)

Miniscript Policy {#miniscript_policy}
=================

Key Definitions:

-   P1 = Principle Key 1
-   P2 = Principle Key 2
-   P3 = Principle Key 3

<!-- -->

-   A1 = Agent Key 1
-   A2 = Agent Key 2
-   A3 = Agent Key 3

<!-- -->

-   SA1 = Secondary Agent Key 1
-   SA2 = Secondary Agent Key 2
-   SA3 = Secondary Agent Key 3

<!-- -->

-   M1 = Master Key 1
-   M2 = Master Key 2
-   M3 = Master Key 3

Time 2 - When Layer 2 is Active Time 3 - When Layer 3 is Active Time 4 -
When Layer 4 is Active Time 5 - When Layer 5 is Active

`   or(99@thresh(3,thresh(2,pk(P1),pk(P2),pk(P3),after(Time 2),after(Time 3)),thresh(2,pk(A1),pk(A2),pk(A3),after(Time 4)),thresh(1,pk(SA1),pk(SA2),pk(SA3))),1@and(thresh(2,pk(M1),pk(M2),pk(M3)),after(Time 5)))`

Compiled Output Descriptor:

`   wsh(or_i(and_v(v:thresh(2,pkh(M1),a:pkh(M2),a:pkh(M3)),after(Time 5)),and_v(v:multi(1,SA1,SA2,SA3),and_v(v:thresh(2,pk(A1),s:pk(A2),s:pk(A3),snu:after(Time 4)),thresh(2,pk(P1),s:pk(P2),s:pk(P3),snu:after(Time 2),snu:after(Time 3))))))`

Reference Transactions {#reference_transactions}
======================

Assumptions: Starting date of contract was January 1st, 2022
(1640995200). This means the timelock duration for each layer is as
follows:

For example, if a contract started on January 1st 2022, the following
epoch timestamp values would be used:

  Calendar Date   Epoch Timestamp
  --------------- -----------------
  Jan 1 2022      1640995200
  Jan 1 2023      1672531200
  Jan 31 2023     1675123200
  Feb 15 2023     1676419200
  March 2 2023    1677715200

-   Layer 1 Transaction

Signed by:

-   Principle keys 1 & 2
-   Agent keys 1 and 2
-   Sub agent key 1

[Reference
TX](https://mempool.space/testnet/tx/ccacb4d1cc6b3f7f22db47c89c9af1c44324dd60c678963981bad8a76e24cee3)

-   Layer 2 Transaction

Signed by:

-   Principle keys 1
-   Agent keys 1 and 2
-   Sub agent key 1

[Reference
TX](https://mempool.space/testnet/tx/6e52089daa97a7b1a677590fac9005a8d087dfd1b1610c7fefa1f0e56b1b29ef)

-   Layer 3 Transaction

Signed by:

-   Agent keys 1 and 2
-   Sub agent key 1

[Reference
TX](https://mempool.space/testnet/tx/0c644c8152749e0b8e1e827dccd1470194e2b9562a495633cd6e38f70697eb35)

-   Layer 4 Transaction

Signed by:

-   Agent key 1
-   Sub agent key 1

[Reference
TX](https://mempool.space/testnet/tx/c3c1118c4e890ca224c8b459357576b0b60d708ad3d61a427fcea3db18807298)

-   Layer 5 Transaction

Signed by:

-   Master Key 1 & 2

[Reference
TX](https://mempool.space/testnet/tx/857f4fed4c98169daaae18198e6c0bba692df9d7f505a19bbb9b243784430e6a)

(To be updated with a taproot descriptor format once minitapscript is
merged into core)