Jetton DEX Contract
This repository contains a simple decentralized exchange (DEX) smart contract for swapping two specific jettons: A and B. The contract determines the price of one jetton in terms of the other based on the quantities it holds, using a formula that accounts for decimalization for price accuracy.

Contract Features
Swaps are possible between two specific jettons: A and B.
Price is calculated based on the amount of jettons in the pool, with a precision of 1e9 to ensure accurate pricing.
The contract rejects swaps if the pool doesn't have enough liquidity to support the trade.
Admin can send jettons A or B to add liquidity to the pool.
The contract handles returning incorrect jettons or failed swaps by refunding the user.
Formula for Price Calculation
The price of jetton A in terms of jetton B for a swap B -> A is calculated as follows:

csharp
Copy code
price = (amountOfJettonAOnContract * decimal) / amountOfJettonBOnContract
Where decimal = 1e9 is used for precision. When performing a swap of amountOfTokenBToSwap, the amount of jetton A returned to the user is calculated as:

csharp
Copy code
amountOfJettonA = (amountOfJettonAOnContract * decimal / amountOfJettonBOnContract) * amountOfTokenBToSwap / decimal
Example
Assume the contract holds:

10 jettons A
2 jettons B
A user sends 1 jetton B to swap for A. The amount of jettons A they will receive is calculated as:

css
Copy code
amountOfJettonA = (10 * 1e9 / 2) * 1 / 1e9 = 5 jettons A
However, if the user tries to send 3 jettons B, the contract will reject the transaction since the contract doesn't have 15 jettons A (3 * 5) required for the swap.

Admin Functionality
The admin can add liquidity to the contract by sending jettons A and B to the contract. Only the admin can do this, and they cannot perform swaps themselves. All jettons received from the admin are added to the pool.

Methods
Swap Jettons
Users can call the contract with an amount of jetton A or B to initiate a swap.

For a B -> A swap, the price of A is calculated, and the contract checks if it has enough liquidity to fulfill the swap. If successful, jettons A are sent to the user; otherwise, jettons B are refunded.
Admin Liquidity Add
The admin can send jettons A or B to the contract to add to the pool's liquidity.

Jetton Balance Getter
The contract provides a getter to query the current balance of jettons A and B held in the contract.

Price Getter
The contract allows querying the current price of jetton A in terms of jetton B, or vice versa, depending on the request.

Usage
Deployment
Compile the contract using the preferred compiler for the blockchain.
Deploy the contract to the blockchain, specifying the jetton addresses for A and B.
Admin can send jettons A and B to the contract to initialize the liquidity pool.
Swap Jettons
Users can send a message to the contract with the desired amount of jettons B (or A) they want to swap. The contract will handle the swap, sending back the appropriate amount of jettons A (or B) if the swap can be fulfilled.

Getters
getJettonBalances: Returns the current balances of jettons A and B in the contract.
getPrice: Returns the current price of jetton A in terms of B or vice versa.
Error Handling
If a user sends jettons other than A or B, the contract throws an error.
If the contract does not have enough liquidity to fulfill a swap, the transaction is rejected, and the jettons sent by the user are refunded.
Development and Testing
To develop and test this contract, you will need to:

Install the required blockchain development tools (such as a blockchain simulator or a testnet environment).
Compile the contract and deploy it to a test environment.
Test the contract's functionality by simulating swaps and liquidity additions.
Example of Swap and Liquidity Addition
bash
Copy code
# Add liquidity (by admin)
admin_send_jetton_a 100
admin_send_jetton_b 50

# Swap jettons (user)
user_swap_b_to_a 5  # Swaps 5 jettons B for jettons A
License
This project is licensed under the MIT License - see the LICENSE file for details.
