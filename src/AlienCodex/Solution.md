# solution - AlienCodex

`bytes32[] public codex;` this is declared on slot 3 of the storage. 
 Step-1 : call the function ``makeContact()` to make `contract` true.
 Step-2 : call `retract()`, as the current length og the array is 0, it will cause the underflow situation and make the length of the array as 2^256
 Step-3 : call the `revise()` with `i = 2^256-j` and `_content = uint256(uint160(player_address))` select j such as it writes on the slot 0, here the first element of the array will be at slot `keccak256(abi.encode(n))` so using this calculate the j such that it writes on the slot 0 where the owner variable resides.

Now why is this happening?

This is caused because of the underflow issue in the `retract()` function which makes the length of the array `2^256` because there are 2^256 slots in smart contract storage, so the array holds all the slots in the storage now. So any slot can be overwritten by the using the function `revise()`