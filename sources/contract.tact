
contract JettonDex {
    // Constants
    uint256 constant DECIMAL = 1e9;

    // State variables
    uint128 public amountOfJettonAOnContract;
    uint128 public amountOfJettonBOnContract;
    address public admin;

    constructor(address _admin) public {
        admin = _admin;
    }

    // Modifier to allow only admin
    modifier onlyAdmin() {
        require(msg.sender == admin, "Not admin");
        _;
    }

    // Function to add Jettons (can only be called by admin)
    function addJettons(string jettonType, uint128 amount) public onlyAdmin {
        if (jettonType == "A") {
            amountOfJettonAOnContract += amount;
        } else if (jettonType == "B") {
            amountOfJettonBOnContract += amount;
        } else {
            revert("Invalid Jetton Type");
        }
    }

    // Function to swap Jetton B -> Jetton A
    function swapBToA(uint128 amountOfTokenBToSwap) public returns (uint128) {
        uint128 price = (amountOfJettonAOnContract * DECIMAL) / amountOfJettonBOnContract;
        uint128 amountOfJettonAToSend = (price * amountOfTokenBToSwap) / DECIMAL;

        if (amountOfJettonAToSend <= amountOfJettonAOnContract) {
            amountOfJettonAOnContract -= amountOfJettonAToSend;
            amountOfJettonBOnContract += amountOfTokenBToSwap;
            // Transfer Jetton A to user
            // (Here you would add the logic to send Jetton A to msg.sender)
            return amountOfJettonAToSend;
        } else {
            // Send back Jetton B to the user by reverting the transaction
            revert("Not enough Jetton A for swap");
        }
    }

    // Get the number of Jettons in the pool
    function getPoolAmounts() public view returns (uint128, uint128) {
        return (amountOfJettonAOnContract, amountOfJettonBOnContract);
    }

    // Get the price of either Jetton A or B
    function getPrice(string jettonType) public view returns (uint128) {
        if (jettonType == "A") {
            return (amountOfJettonAOnContract * DECIMAL) / amountOfJettonBOnContract;
        } else if (jettonType == "B") {
            return (amountOfJettonBOnContract * DECIMAL) / amountOfJettonAOnContract;
        } else {
            revert("Invalid Jetton Type");
        }
    }
}
