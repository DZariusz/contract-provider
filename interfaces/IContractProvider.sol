pragma solidity ^0.4.24;


interface IContractProvider {

    function contracts(bytes32 _name) external view returns(address);
    function contractsByAddr(address _addr) external view returns(bytes32);

    function addContract(bytes32 _name, address _addr) external returns(bool);
    function removeContract(bytes32 _name) external returns(bool);
}