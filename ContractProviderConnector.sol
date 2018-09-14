pragma solidity ^0.4.24;

import "../interfaces/IContractProvider.sol";

contract ContractProviderConnector {

  address private contractProvider;

  event LogSetCPAddress(address indexed executor, address indexed cp);

  modifier hasCPsetup {
    require( contractProvider != address(0) );
    _;
  }

  modifier fromRegistrator {
    address r = getContract('Registrator');
    require(msg.sender == r, "Caller is not a Registrator");
    _;
  }


  function setCPAddress(address _cp)
    public
    // fromOwner - in real implementation you should restrict access
    returns(bool) {

    require(contractProvider == address(0), "we already have contract provider set up");
    require(_cp != address(0), "address or contract provider can't be empty");
    contractProvider = _cp;

    // autocheck
    require(getContract('ContractProvider') == _cp, "Invalid address for ContractProvider");

    emit LogSetCPAddress(msg.sender, _cp);

    return true;
  }


  function getCP() public constant returns(address) {
    return contractProvider;
  }

  function getContract(bytes32 _name)
  hasCPsetup
  public
  view
  returns(address) {
    address a = IContractProvider(contractProvider).contracts(_name);
    require(a != address(0), "Contract does not exist");
    return a;
  }

}