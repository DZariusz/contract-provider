pragma solidity ^0.4.24;


contract ContractProvider {

    mapping(bytes32 => address) public contracts;
    mapping(address => bytes32) public contractsByAddr;


    event LogAddContract(address indexed executor, bytes32 name, address addr);
    event LogRemoveContract(address indexed executor, bytes32 name, address addr);


    constructor() public {

        contracts['ContractProvider'] = address(this);
        contractsByAddr[address(this)] = 'ContractProvider';

    }



    function addContract(bytes32 _name, address _addr)
    public
    returns(bool) {

        require(_addr != address(0), "Contract address is empty");
        require(_name | 0 > 0, "Contract name is empty");

        require(contracts[_name] == address(0), "This name is already in use");
        require(contractsByAddr[_addr] | 0 == 0, "This address is already in use");

        contracts[_name] = _addr;
        contractsByAddr[_addr] = _name;

        emit LogAddContract(msg.sender, _name, _addr);

        return true;

    }

    function removeContract(bytes32 _name)
    public
    returns(bool) {

        address addr = contracts[_name];

        if(addr == address(0)) {
            return false;
        } else {
            delete contractsByAddr[addr];
            delete contracts[_name];

            emit LogRemoveContract(msg.sender, _name, addr);

            return true;
        }
    }
}