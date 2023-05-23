# Example transactions

## Sending transaction from one validator to newly created address

Check addresses of validators
```
gaia@tendermint-node-0:~/.gaia/config$ gaiad keys list
- name: tendermint-node-1.demo.jonczy.dev
  type: local
  address: cosmos1efgzts92v4cmexa48nz2m2957f4tpsvkaq2nxh
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AkxW3iApQ2+tLcakhU8L/K8guIG3nGvigKWJyLl/95al"}'
  mnemonic: ""
- name: tendermint-node-2.demo.jonczy.dev
  type: local
  address: cosmos14x98kkp2zt50np6gatrgh7cujk5klghsyeer2r
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AhfQ0khTurSA3ihy8djDYMEElaBtmHTg52WlAfW7CGXy"}'
  mnemonic: ""
- name: tendermint-node-3.demo.jonczy.dev
  type: local
  address: cosmos12e3pv2tmf3auua79kupsmva0rnvzh2nq4x2492
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"A0YEwc+2x0MvGWPoZHOCFTavc0PT0gJtz+U/I3H+pUtU"}'
  mnemonic: ""
- name: validator
  type: local
  address: cosmos1jlpeh80xr9upp5z3nvypuzy6269ulyq9eez5td
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AiJcfnoz6HSQsK52VpM/P85a7kBM9o1b8q3jvpItGp7n"}'
  mnemonic: ""
```

Check balances of addresses
```
gaia@tendermint-node-0:~/.gaia/config$ gaiad query bank balances cosmos1efgzts92v4cmexa48nz2m2957f4tpsvkaq2nxh
balances:
- amount: "220000000"
  denom: uatom
pagination:
  next_key: null
  total: "0"
gaia@tendermint-node-0:~/.gaia/config$ gaiad query bank balances cosmos14x98kkp2zt50np6gatrgh7cujk5klghsyeer2r
balances:
- amount: "180000000"
  denom: uatom
pagination:
  next_key: null
  total: "0"
gaia@tendermint-node-0:~/.gaia/config$ gaiad query bank balances cosmos12e3pv2tmf3auua79kupsmva0rnvzh2nq4x2492
balances:
- amount: "300000000"
  denom: uatom
pagination:
  next_key: null
  total: "0"
gaia@tendermint-node-0:~/.gaia/config$ gaiad query bank balances cosmos1jlpeh80xr9upp5z3nvypuzy6269ulyq9eez5td
balances:
- amount: "300000000"
  denom: uatom
pagination:
  next_key: null
  total: "0"
```

Add new account 
```
gaia@tendermint-node-0:~/.gaia/config$ gaiad keys add recipient --keyring-backend test

- name: recipient
  type: local
  address: cosmos1w49wxraq23u74kgcua0r7sl74g7yg67ur88frx
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"Azsavlmm2odJucCNDUHf7u8O8gX/Vg1uXhYmuM4IHKBl"}'
  mnemonic: ""


**Important** write this mnemonic phrase in a safe place.
It is the only way to recover your account if you ever forget your password.

fossil ginger gravity certain daring subject paddle reject bone hurry debris square clump october festival budget honey retreat into kitchen develop inquiry stairs helmet
```

Save recipient address in var 
```
gaia@tendermint-node-0:~/.gaia/config$ RECIPIENT=$(gaiad keys show recipient -a --keyring-backend test)
gaia@tendermint-node-0:~/.gaia/config$ echo ${RECIPIENT}
cosmos1w49wxraq23u74kgcua0r7sl74g7yg67ur88frx
```

Send `10000uatom` from validator to newly created recipient
```
gaia@tendermint-node-0:~/.gaia/config$ gaiad tx bank send cosmos1efgzts92v4cmexa48nz2m2957f4tpsvkaq2nxh $RECIPIENT 10000uatom --chain-id cosmos-rjonczy --keyring-backend test --fees=300uatom
{"body":{"messages":[{"@type":"/cosmos.bank.v1beta1.MsgSend","from_address":"cosmos1efgzts92v4cmexa48nz2m2957f4tpsvkaq2nxh","to_address":"cosmos1w49wxraq23u74kgcua0r7sl74g7yg67ur88frx","amount":[{"denom":"uatom","amount":"10000"}]}],"memo":"","timeout_height":"0","extension_options":[],"non_critical_extension_options":[]},"auth_info":{"signer_infos":[],"fee":{"amount":[{"denom":"uatom","amount":"300"}],"gas_limit":"200000","payer":"","granter":""}},"signatures":[]}

confirm transaction before signing and broadcasting [y/N]: y
code: 0
codespace: ""
data: ""
events: []
gas_used: "0"
gas_wanted: "0"
height: "0"
info: ""
logs: []
raw_log: '[]'
timestamp: ""
tx: null
txhash: AC50F1BFF91B38CDF512602AEA314B283B8C1C107693BDC208B7B7D1696DBEB3

```

Check again balance of validator
```
gaia@tendermint-node-0:~/.gaia/config$ gaiad query bank balances cosmos1efgzts92v4cmexa48nz2m2957f4tpsvkaq2nxh
balances:
- amount: "219989700"
  denom: uatom
pagination:
  next_key: null
  total: "0"
```

Check again balance of new account (recipient)

```
gaia@tendermint-node-0:~/.gaia/config$ gaiad query bank balances ${RECIPIENT}
balances:
- amount: "10000"
  denom: uatom
pagination:
  next_key: null
  total: "0"
```
