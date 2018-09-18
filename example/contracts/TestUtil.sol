pragma solidity ^0.4.24;

contract TestUtil {

    constructor() public {
    }

    uint constant POPCNT_MULT = 0x0000000000002000000000100000000008000000000400000000020000000001;
    uint constant POPCNT_MASK = 0x0001041041041041041041041041041041041041041041041041041041041041;
    uint constant POPCNT_MODULO = 0x3F;

    function getRollUnder(uint betMask) pure public returns (uint) {
        return ((betMask * POPCNT_MULT) & POPCNT_MASK) % POPCNT_MODULO;
    }

    function getMMM(uint betMask) pure public returns (uint m, uint mm, uint mmm) {
        m = betMask * POPCNT_MULT;
        mm = (betMask * POPCNT_MULT) & POPCNT_MASK;
        mmm = ((betMask * POPCNT_MULT) & POPCNT_MASK) % POPCNT_MODULO;
    }

    function getResult(uint reveal, bytes32 blockHash, uint modulo) pure public returns (bytes encodePack, bytes32 entropy, uint dice) {
        encodePack = abi.encodePacked(reveal, blockHash);
        entropy = keccak256(encodePack);
        dice = uint(entropy) % modulo;
    }

    function getEcrecover(bytes32 msgHash, uint8 v, bytes32 r, bytes32 s) pure public returns (address) {
        return ecrecover(msgHash, v, r, s);
    }

    function getHash(bytes32 message) pure public returns (bytes, bytes32) {
        return (abi.encodePacked(message), keccak256(abi.encodePacked(message)));
    }

    struct A {
        uint128 one;
        uint two;
        uint128 three;
    }
    A public dataA;

    struct B {
        uint128 one;
        uint128 three;
        uint two;
    }
    B public dataB;

    function testSlot() public {
        dataA = A(1,2,3);
    }

    function testSlotB() public {
        dataB = B(1,2,3);
    }



    bytes32 public str = "init";

    bytes32 s = "bingo";

    function testSM() public {
        str = s;
    }

}
