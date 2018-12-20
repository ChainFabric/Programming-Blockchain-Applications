pragma solidity >=0.4.25 <0.6.0;

contract MyERC20Token {
    /* State variables of the token */
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 _totalSupply;

    /* An array with all balances for this token */
    mapping (address => uint256) public balances;

    /* Owner of account approves the transfer of an amount to another account */
    mapping(address => mapping (address => uint256)) public allowed;

    /* Manage the event related to the transfer and the approval */
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint value);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    constructor(
        uint256 initialSupply,
        string memory _name,
        string memory _symbol,
        uint8 _decimals
        ) public {
        // Calculate the total supply by applying the number of decimal
        _totalSupply = initialSupply ** uint256(_decimals);
        // Give the creator all initial tokens
        balances[msg.sender] = _totalSupply;

       // Set the name to display
       name = _name;
       // Set the symbol to display
       symbol = _symbol;
       // Set the decimal to display
       decimals = _decimals;
       
       /* Notify anyone listening that this transfer took place */
       emit Transfer(address(0), msg.sender, _totalSupply);
    }

    /* Returns total supply */
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    /* Returns balance sheet for a specific account */
    function balanceOf(address _owner) public view returns (uint256 balance)  {
        return balances[_owner];
    }

    // Transfer the balance from owner's account to another account
    function transfer(address _to, uint256 _value) public returns (bool success) {
        /* Check if sender has balance and for overflows */
        require(balances[msg.sender] >= _value);
        require(balances[_to] + _value >= balances[_to]);

        /* Add and subtract new balances */
        balances[msg.sender] -= _value;
        balances[_to] += _value;

        /* Notify anyone listening that this transfer took place */
        emit Transfer(msg.sender, _to, _value);

        return true;
    }
    
    // Send '_value' amount from address '_from' to address '_to'.
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        /* Check if the '_to' address is not a contract creation address value */
        require(_to != address(0));
        /* Check if the balance sheet of the '_from' is equal or above of the '_value'. */
        require(balances[_from] >= _value);
        /* Check if amount to withdraw is below or equal to the amount to withdraw */
        require(allowed[_from][msg.sender] >= _value);
        
        balances[_to] += _value;
        balances[_from] -= _value;
        allowed[_from][msg.sender] -= _value;
        
        emit Transfer(_from, _to, _value);
        
        return true;
    }
 
    // Allow '_spender' to withdraw from your account, multiple times, up to the '_value' amount.
    // If this function is called again it overwrites the current allowance with '_value'.
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        
        return true;
    }
    
    // Check the '_value' amount an owner is allowed to a spender.
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }
}
