pragma solidity ^0.4.25;

contract MySimpleToken {
    /* State variables of the token */
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    /* An array with all balances for this token */
    mapping (address => uint256) public balanceOf;

    /* Manage the event related to the transfer */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    constructor(
        uint256 initialSupply,
        string memory _name,
        string memory _symbol,
        uint8 _decimals
        ) public {
        // Calculate the total supply by applying the number of decimal
        totalSupply = initialSupply ** uint256(_decimals);
        // Give the creator all initial tokens
        balanceOf[msg.sender] = totalSupply;

        // Set the name to display
        name = _name;
        // Set the symbol to display
        symbol = _symbol;
        // Set the decimal to display
        decimals = _decimals;
    }

    /* Send tokens */
    function transfer(address _to, uint256 _value) public {
        /* Check if sender has balance and for overflows */
        require(balanceOf[msg.sender] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        /* Add and subtract new balances */
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        /* Notify anyone listening that this transfer took place */
        emit Transfer(msg.sender, _to, _value);
    }

    /* Safe Nath function for addition */
    function safeAdd(uint256 a, uint256 b) internal pure returns (uint256) {
        require(a + b > a);
        return a + b;
    }

    /* Increase the total supply */
    function increaseSupply(uint256 value, address to) public returns (bool) {
        totalSupply = safeAdd(totalSupply, value);
        balanceOf[to] = safeAdd(balanceOf[to], value);
        emit Transfer(0, to, value);
        return true;
    }

    /* Safe Math function for subtraction */
    function safeSub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b < a);
        return a - b;
    }

    /* Decrease the total supply */
    function decreaseSupply(uint256 value, address from) public returns (bool) {
        balanceOf[from] = safeSub(balanceOf[from], value);
        totalSupply = safeSub(totalSupply, value);
        emit Transfer(from, 0, value);
        return true;
    }
}
