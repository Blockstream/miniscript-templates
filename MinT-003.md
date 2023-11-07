      Miniscript Template: 3
      Title: Multi Institutional Multisig (One Agent)
      Created: 2023-09-16

Name of Template {#name_of_template}
================

Multi Institutional Custody TBD Name

Goal to be achieved by template {#goal_to_be_achieved_by_template}
===============================

Very similar to Template 003, but the secondary agent is only a
participatory signer for layers 3 & 4, for principle compromised assets.

For previty, skipping over the context shared for template 003 as the
background is the same.

Layred Security {#layred_security}
===============

This is the same as Template 003, with the exception of layers 1 & 2 no
longer having a 1 of 3 for the secondary agent key set.

  Layer Number   Layer Name                  Timelock   Principle Key Set   Primary Agent Key Set   Secondary Agent Key Set
  -------------- --------------------------- ---------- ------------------- ----------------------- -------------------------
  Layer 1        \"Happy Path\"              None       2 of 3              2 of 3                  None
  Layer 2        \"End of Term\"             365 Days   1 of 3              2 of 3                  None
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

-   M1 = Recovery Key 1
-   M2 = Recovery Key 2
-   M3 = Recovery Key 3

Time 2 - When Layer 2 is Active Time 3 - When Layer 3 is Active Time 4 -
When Layer 4 is Active Time 5 - When Layer 5 is Active

`   or(99@thresh(2,thresh(2,pk(A1),pk(A2),pk(A3),after(Time 4)),or(10@thresh(2,pk(P1),pk(P2),pk(P3),after(Time 2)),and(thresh(1,pk(SA1),pk(SA2),pk(SA3)),after(Time 3)))),and(thresh(2,pk(M1),pk(M2),pk(M3)),after(Time 5)))`

Compiled Output Descriptor:

`   wsh(or_i(and_v(v:thresh(2,pkh(M1),a:pkh(M2),a:pkh(M3)),after(Time 5)),and_v(v:thresh(2,pk(A1),s:pk(A2),s:pk(A3),snl:after(Time 4)),or_i(and_v(v:thresh(1,pkh(SA1),a:pkh(SA2),a:pkh(SA3)),after(Time 3)),thresh(2,pk(P1),s:pk(P2),s:pk(P3),snl:after(Time 2))))))`

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

Signed By:

-   Principle Keys 1 & 2
-   Agent Keys 1 & 2

[Reference
TX](https://mempool.space/testnet/tx/db089555614b8f677cb3e63c03dca45e3418d91b317117552513a7dafc9c0e9c)

-   Layer 2 Transaction

Signed By:

-   Principle Key 1
-   Agent Keys 1 & 2

[Reference
TX](https://mempool.space/testnet/tx/ed3ec79fc26ca68f11043efee0d400fcac295b71e5173438c4fcc2280c6b30a2)

-   Layer 3 Transaction

Signed by

-   Agent keys 1 and 2
-   Sub agent key 1

[Reference
TX](https://mempool.space/testnet/tx/fac3dfef524edcfa4c0e38857456ca4b4a7c345f30a77b2bd0e736a1db19d08c)

-   Layer 4 Transaction

Signed by:

-   Agent key 1
-   Sub agent key 1

[Reference
TX](https://mempool.space/testnet/tx/978e158b46dd7d1dca86c20041b2706c058faac772a7ae2ccb786d7a249fa075)

-   Layer 5 Transaction
-   Signed by Recovery Key 1 and 2:

[Reference
TX](https://mempool.space/testnet/tx/7a3a78f097bac0a50fb4439d529d592f8687a2f52980db580888aaf9ae71259a)
