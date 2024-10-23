# JETTON DEX CONTRACT

This repository contains a **decentralized exchange (DEX)** smart contract for swapping two specific jettons: **A** and **B**. The contract dynamically calculates the price of one jetton in terms of the other based on the current liquidity, ensuring precise pricing using a decimal factor for accuracy.

## Contract Features

- **Jetton Swaps**: Allows swapping between two specific jettons: A and B.
- **Price Calculation**: Price is determined based on the amount of jettons in the liquidity pool, using a precision factor of **1e9** for accuracy.
- **Liquidity Control**: The contract rejects swaps if it doesn't have enough liquidity to support the trade.
- **Admin Liquidity Addition**: Only the admin can add jettons A or B to the liquidity pool.
- **Error Handling**: Incorrect jettons or failed swaps are refunded back to the user.

### Formula for Price Calculation

For swaps from **B** to **A**, the price of jetton A in terms of jetton B is calculated as follows:

```csharp
price = (amountOfJettonAOnContract * decimal) / amountOfJettonBOnContract
```
Where decimal = 1e9 is used for precision. When performing a swap of amountOfTokenBToSwap, the amount of jetton A returned to the user is calculated as:

```
amountOfJettonA = (amountOfJettonAOnContract * decimal / amountOfJettonBOnContract) * amountOfTokenBToSwap / decimal
```

## Example
### Assume the contract holds:

10 jettons A
2 jettons B
A user sends 1 jetton B to swap for A. The amount of jettons A they will receive is calculated as:

```
amountOfJettonA = (10 * 1e9 / 2) * 1 / 1e9 = 5 jettons A
```
If the user attempts to send 3 jettons B, the contract will reject the transaction since it doesn't have the 15 jettons A (3 * 5) needed to fulfill the swap.

### Admin Functionality

- Liquidity Addition: The admin can add liquidity to the contract by sending jettons A and B to the pool.

- Admin Restrictions: Admin cannot perform swaps and can only manage liquidity.

#### Methods

- Swap Jettons

Users can initiate a swap by sending an amount of jetton A or B.

For a B -> A swap, the contract calculates the price of A and checks for liquidity sufficiency.

Successful swaps result in the user receiving the appropriate jettons. If liquidity is insufficient, the user's jettons are refunded.

- Admin Liquidity Add

Admin can send jettons A or B to the contract to add to the pool's liquidity.

- Jetton Balance Getter

The contract provides a getter to query the current balance of jettons A and B held by the contract.

- Price Getter

The contract allows querying the current price of jetton A in terms of jetton B, or vice versa.

- Usage

## Deployment

Compile the contract using the preferred blockchain compiler.

Deploy the contract and specify the jetton addresses for A and B.

The admin can initialize the liquidity pool by sending jettons A and B.

### Swap Jettons

Users can send a message to the contract with the amount of jettons B (or A) they want to swap.

The contract will handle the swap and return the appropriate jettons if sufficient liquidity is available.

### Getters

- getJettonBalances: Returns the current balances of jettons A and B.

- getPrice: Returns the price of jetton A in terms of B, or vice versa.

### Error Handling

If a user sends jettons other than A or B, the contract throws an error.

If the contract doesn't have enough liquidity for a swap, the transaction is rejected, and the jettons are refunded.

### Development and Testing

To develop and test the contract, follow these steps:

Install the required blockchain development tools (e.g., blockchain simulator or testnet environment).

Compile and deploy the contract to a test environment.

Simulate swaps and liquidity additions to test functionality.

####Example of Swap and Liquidity Addition

### Add liquidity (by admin)

admin_send_jetton_a 100

admin_send_jetton_b 50

### Swap jettons (by user)

user_swap_b_to_a 5  # Swaps 5 jettons B for jettons A

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contact
If you need help or interest, contact here: [@shiny0103](https://t.me/shiny0103)

