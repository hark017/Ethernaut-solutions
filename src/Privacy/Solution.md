# Solution-Privacy
```
await web3.eth.getStorageAt(contract.address, 4)
```
Use this command in the console to get `bytes32 data[2]` and then call the `unlock` function with first 16 bytes of the above 32bytes data. Fixed sized arrays are store its elements in sequence and not at another location which is used in the `bytes32[]`. 
