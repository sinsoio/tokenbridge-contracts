pragma solidity 0.4.24;

import "../../interfaces/IBlockReward.sol";
import "../../libraries/Address.sol";
import "../ValidatorsFeeManager.sol";
import "../BlockRewardBridge.sol";

contract FeeManagerErcToNative is ValidatorsFeeManager, BlockRewardBridge {
    function getFeeManagerMode() external pure returns (bytes4) {
        return 0xd7de965f; // bytes4(keccak256(abi.encodePacked("manages-both-directions")))
    }

    function onAffirmationFeeDistribution(address _rewardAddress, uint256 _fee) internal {
        _rewardAddress.transfer(_fee);
    }

    function onSignatureFeeDistribution(address _rewardAddress, uint256 _fee) internal {
        Address.safeSendValue(_rewardAddress, _fee);
    }

}
