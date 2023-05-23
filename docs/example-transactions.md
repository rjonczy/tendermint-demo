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

Transaction executed in block `56987`
```
May 23 06:45:26 tendermint-node-0 cosmovisor[1529]: 6:45AM INF received complete proposal block hash=F8F3DBE700B7BF2147DDE8F531E38F05645CFEE3D5DB5FF87C50CD8EF2566BBE height=56987 module=consensus
May 23 06:45:27 tendermint-node-0 cosmovisor[1529]: 6:45AM INF finalizing commit of block hash={} height=56987 module=consensus num_txs=1 root=BC7FE58805F670743AFA26149787764E08110DDE7D832B8AF5BCC2EA7E27A993
May 23 06:45:27 tendermint-node-0 cosmovisor[1529]: 6:45AM INF minted coins from module account amount=22uatom from=mint module=x/bank
May 23 06:45:27 tendermint-node-0 cosmovisor[1529]: 6:45AM INF executed block height=56987 module=state num_invalid_txs=0 num_valid_txs=1
May 23 06:45:27 tendermint-node-0 cosmovisor[1529]: 6:45AM INF commit synced commit=436F6D6D697449447B5B313439203230352035382032343120393720313435203639203230203220313032203932203833203235342031323120363520313736
20323130203533203138312035302031313220393020323235203139362032313320313933203533203135312032303720323920332038305D3A444539427D
May 23 06:45:27 tendermint-node-0 cosmovisor[1529]: 6:45AM INF committed state app_hash=95CD3AF16191451402665C53FE7941B0D235B532705AE1C4D5C13597CF1D0350 height=56987 module=state num_txs=1
May 23 06:45:27 tendermint-node-0 cosmovisor[1529]: 6:45AM INF indexed block exents height=56987 module=txindex
May 23 06:45:32 tendermint-node-0 cosmovisor[1529]: 6:45AM INF Timed out dur=4977.167929 height=56988 module=consensus round=0 step=1
May 23 06:45:32 tendermint-node-0 cosmovisor[1529]: 6:45AM INF received proposal module=consensus proposal={"Type":32,"block_id":{"hash":"702376A06FDBFCD8DA885672E9419CC3C7D06FA4B9AC08C27532463133D7F86B","parts":{"hash":"B2FE2EAC509EB1CA10EA5588CE547832945709F326FBC14436F3CC61E8BF37BC","total":1}},"height":56988,"pol_round":-1,"round":0,"signature":"bH+1vFSjwiQxUSH1Vt41yVxXptqJYkmWmndnWT6NYW8M0wd4pwPPjaTRjAPla/mByoKciqFM/t5toj0CFpAMAQ==","timestamp":"2023-05-23T10:45:32.293939051Z"}
```