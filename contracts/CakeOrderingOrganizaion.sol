pragma solidity ^0.4.24;

import "@thetta/core/contracts/DaoClient.sol";
import "@thetta/core/contracts/DaoBase.sol";

import "./CakeByer.sol";
import "./Bakery.sol";


contract CakeOrderingOrganizaion is CakeByer, DaoClient {
	bytes32 public constant BUY_SOME_CAKE = keccak256("buySomeCake");
	DaoBase public daoBase;
	Bakery public bakery;

	constructor(Bakery _bakery, DaoBase _daoBase) public DaoClient(_daoBase){
		bakery = _bakery;
		daoBase = _daoBase;
	}

	function buySomeCake() public isCanDo(BUY_SOME_CAKE) {
		buySomeCakeInternal(bakery);
	}

	function setPermissions(address _boss, address _user) public {
		// Add some address (user or contract) to Employee group
		daoBase.addGroupMember("Managers", _boss); 
		daoBase.allowActionByAddress(daoBase.ISSUE_TOKENS(), _boss);

		// This will allow any address that is a member of "Managers" group 
		// to execute "issueTokens" method:
		daoBase.allowActionByAnyMemberOfGroup(BUY_SOME_CAKE, "Managers");
		        
		// To allow specific address to execute action without any voting:
		daoBase.allowActionByAddress(BUY_SOME_CAKE, _user);
	}
}