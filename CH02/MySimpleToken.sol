/* Solidity version compatible with Mist 0.11.1 */
pragma solidity ^0.4.24;

contract MySimpleToken {
    /* State variables of the token */
    string public name;
    string public symbol;

    /* An array with all balances for this token */
    mapping (address => uint256) public balanceOf;

    /* Manage the event related to the transfer */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    constructor(
        uint256 initialSupply,
        string memory _name,
        string memory _symbol
        ) public {
        // Set the name to display
        name = _name;
        // Set the symbol to display
        symbol = _symbol;

        // Give the creator all initial tokens
        balanceOf[msg.sender] = initialSupply;
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
}
