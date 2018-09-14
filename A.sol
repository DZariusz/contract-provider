pragma solidity ^0.4.24;

import './interfaces/IB.sol';
import './ContractProviderConnector.sol';

contract A is ContractProviderConnector {


    function foo ()
    returns (bool success) {

        IB b = IB(getContract('B'));
        b.boo();

        return true;

    }

}