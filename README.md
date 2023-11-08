# Starknet Foundry Issue

This repository helps reproduce an issue with Starknet Foundry found when using the cheatcode `start_mock_call` to mock a call to another contract using the syscall `call_contract_syscall` instead of a dispatcher.

To reproduce, run the tests:
```
$ scarb test
```

The test that calls a function that uses the dispatcher to interact with another contract (`mock_call_with_dispatcher`) passes while the test that calls a function that uses the syscall to interact with the same contract/function (`mock_call_with_syscall`) fails with the following error message:

```
Failure data:
    Got an exception while executing a hint:
    Error in the called contract (0x07b8b723eae99e0877d4895592fa02e5249e9e38959316c04b18cd76887c4df0):
Error at pc=0:416:
Got an exception while executing a hint:
    Requested contract address ContractAddress(PatriciaKey(StarkFelt("0x0000000000000000000000000000000000000000000000000000000000000008"))) is not deployed.
Cairo traceback (most recent call last):
Unknown location (pc=0:165)
```