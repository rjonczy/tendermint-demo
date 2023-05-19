# tendermint-demo
Demo of tendermint (cosmos sdk)

## Overview

Goal of this demo is to deploy and show running Cosmos SDK chain with 4 validator nodes.

## Infrastructure

Infrastructure for this demo:
- 4 virtual machine running on Microsoft Azure cloud

IaC code used to provisioned this infrastructure is available [here](./terraform/azure/)

Nodes:
- `tendermint-node-0.demo.jonczy.dev`
- `tendermint-node-1.demo.jonczy.dev`
- `tendermint-node-2.demo.jonczy.dev`
- `tendermint-node-3.demo.jonczy.dev`

## Automations

2 automations were used, based on *Github Actions*:
- [`.github/workflows/setup_node.yml`](.github/workflows/setup_node.yml)
- [`.github/workflows/terraform_azure.yml`](.github/workflows/terraform_azure.yml)

First automation is used to provision Azure infrastructure via terraform
Second automation is used to configure virtual machines via Ansible. Setup of network is based on this [Ansile role](https://github.com/hyphacoop/cosmos-ansible)



## Network

```
    chain_version: v9.0.3
    chain_id: cosmos-rjonczy
```
Four validator nodes that have the following voting power:

| Validator moniker | Voting power | Node                        |
| :---------------: | :----------: | ----------------------------------------------- |
|  `validator-30`   |     30%      | `tendermint-node-0.demo.jonczy.dev` |
|  `validator-22`   |     22%      | `tendermint-node-1.demo.jonczy.dev` |
|  `validator-18`   |     18%      | `tendermint-node-2.demo.jonczy.dev` |
|  `validator-30`   |     30%      | `tendermint-node-3.demo.jonczy.dev` |

### Logs

This are logs from one of the nodes. We can see that network is progressing.

```
# journalctl -fu cosmovisor
May 19 18:41:27 tendermint-node-3 cosmovisor[1706]: 6:41PM INF received complete proposal block hash=F7E1BA79481C8BA3719F8380440DD75077181D8C9957BE1A3ADD1456F6B7783A height=445 module=consensus
May 19 18:41:27 tendermint-node-3 cosmovisor[1706]: 6:41PM INF finalizing commit of block hash={} height=445 module=consensus num_txs=0 root=D09604C033F6D985E41DD5EB3B3EB36EB08AF5DA2004BA79F4D1E11A7B3AEF2E
May 19 18:41:27 tendermint-node-3 cosmovisor[1706]: 6:41PM INF minted coins from module account amount=22uatom from=mint module=x/bank
May 19 18:41:27 tendermint-node-3 cosmovisor[1706]: 6:41PM INF executed block height=445 module=state num_invalid_txs=0 num_valid_txs=0
May 19 18:41:27 tendermint-node-3 cosmovisor[1706]: 6:41PM INF commit synced commit=436F6D6D697449447B5B323030203134362031393820313538203734203133342032343220313837203238203830203138382035352039382033203232392031303520353920393120313236203133352034312031323620363120313533203436203420323039203131372032313820313332203231362032305D3A3142447D
May 19 18:41:27 tendermint-node-3 cosmovisor[1706]: 6:41PM INF committed state app_hash=C892C69E4A86F2BB1C50BC376203E5693B5B7E87297E3D992E04D175DA84D814 height=445 module=state num_txs=0
May 19 18:41:27 tendermint-node-3 cosmovisor[1706]: 6:41PM INF indexed block exents height=445 module=txindex
May 19 18:41:32 tendermint-node-3 cosmovisor[1706]: 6:41PM INF Timed out dur=4979.322032 height=446 module=consensus round=0 step=1
May 19 18:41:32 tendermint-node-3 cosmovisor[1706]: 6:41PM INF received proposal module=consensus proposal={"Type":32,"block_id":{"hash":"BC86E8B0FE89C20DFC33FFC512E46B4181789C822104F9241A905BF8A9007F79","parts":{"hash":"9834CC7D6F785643514D27B2F39049861AA22955597C8FA53F648A89CCAA31C1","total":1}},"height":446,"pol_round":-1,"round":0,"signature":"xFtccrKJBsuyXLRRw7O5bzR4/QthJUyNbpmSq05Q4SfuMS+n/XsZ2Ueq3f+daLzplZW8/JXWP77ayQVo3jNJBg==","timestamp":"2023-05-19T22:41:32.900944085Z"}
May 19 18:41:32 tendermint-node-3 cosmovisor[1706]: 6:41PM INF received complete proposal block hash=BC86E8B0FE89C20DFC33FFC512E46B4181789C822104F9241A905BF8A9007F79 height=446 module=consensus
May 19 18:41:33 tendermint-node-3 cosmovisor[1706]: 6:41PM INF finalizing commit of block hash={} height=446 module=consensus num_txs=0 root=C892C69E4A86F2BB1C50BC376203E5693B5B7E87297E3D992E04D175DA84D814
May 19 18:41:33 tendermint-node-3 cosmovisor[1706]: 6:41PM INF minted coins from module account amount=22uatom from=mint module=x/bank
May 19 18:41:33 tendermint-node-3 cosmovisor[1706]: 6:41PM INF executed block height=446 module=state num_invalid_txs=0 num_valid_txs=0
May 19 18:41:33 tendermint-node-3 cosmovisor[1706]: 6:41PM INF commit synced commit=436F6D6D697449447B5B323133203234203630203134372031363220323420333320343120313930203834203234372031313720323438203234362037302032323120363020313233203738203136382032312032303120383720313838203136322032313420313830203334203133372031333620313433203130305D3A3142457D
May 19 18:41:33 tendermint-node-3 cosmovisor[1706]: 6:41PM INF committed state app_hash=D5183C93A2182129BE54F775F8F646DD3C7B4EA815C957BCA2D6B42289888F64 height=446 module=state num_txs=0
May 19 18:41:33 tendermint-node-3 cosmovisor[1706]: 6:41PM INF indexed block exents height=446 module=txindex
May 19 18:41:38 tendermint-node-3 cosmovisor[1706]: 6:41PM INF Timed out dur=4980.073735 height=447 module=consensus round=0 step=1
May 19 18:41:38 tendermint-node-3 cosmovisor[1706]: 6:41PM INF received proposal module=consensus proposal={"Type":32,"block_id":{"hash":"A71CAA08A195AB0C45334394B5DDDB4445D296328317C18349304EDC4E054D9D","parts":{"hash":"92D4CC3E8BA28342292CDF25EDB2DC3EF8611017CA87DF09B2632FBDDC2A333A","total":1}},"height":447,"pol_round":-1,"round":0,"signature":"9XN//pGEQekYhrHxVtDBo/55m5OT96gF43KGoNZmYiw12HGAdqon02oY5D0d7dfxTJB8JR9JSc7a84+yJo+XAw==","timestamp":"2023-05-19T22:41:38.2511293Z"}
May 19 18:41:38 tendermint-node-3 cosmovisor[1706]: 6:41PM INF received complete proposal block hash=A71CAA08A195AB0C45334394B5DDDB4445D296328317C18349304EDC4E054D9D height=447 module=consensus
May 19 18:41:38 tendermint-node-3 cosmovisor[1706]: 6:41PM INF finalizing commit of block hash={} height=447 module=consensus num_txs=0 root=D5183C93A2182129BE54F775F8F646DD3C7B4EA815C957BCA2D6B42289888F64
May 19 18:41:38 tendermint-node-3 cosmovisor[1706]: 6:41PM INF minted coins from module account amount=22uatom from=mint module=x/bank
May 19 18:41:38 tendermint-node-3 cosmovisor[1706]: 6:41PM INF executed block height=447 module=state num_invalid_txs=0 num_valid_txs=0
May 19 18:41:38 tendermint-node-3 cosmovisor[1706]: 6:41PM INF commit synced commit=436F6D6D697449447B5B33392033362032323720313830203234332034372031323720323433203137352031393120323234203935203230312032343120323533203232342039203234203439203235332032333520313931203634203130332031323420353520313432203233332030203137332034342034315D3A3142467D
May 19 18:41:38 tendermint-node-3 cosmovisor[1706]: 6:41PM INF committed state app_hash=2724E3B4F32F7FF3AFBFE05FC9F1FDE0091831FDEBBF40677C378EE900AD2C29 height=447 module=state num_txs=0
May 19 18:41:38 tendermint-node-3 cosmovisor[1706]: 6:41PM INF indexed block exents height=447 module=txindex
May 19 18:41:43 tendermint-node-3 cosmovisor[1706]: 6:41PM INF Timed out dur=4980.252536 height=448 module=consensus round=0 step=1
May 19 18:41:43 tendermint-node-3 cosmovisor[1706]: 6:41PM INF received proposal module=consensus proposal={"Type":32,"block_id":{"hash":"4ED7BFBC7A8EC24B499A2A055CD3E1EC7827B0BC6BF17597F5B9CA8E6C15BB7C","parts":{"hash":"E0DDC9BD56335B2045706E1CD6DE4EE482A393A23CFB235ACBEFC78C4C7FFAC2","total":1}},"height":448,"pol_round":-1,"round":0,"signature":"AArnYyzkapmmvz+aIzzE54IKUWqDDhRbUync4Frk+XUBmlHeCBT+xkD18Y2ktWbwJ4Alu92n01EKvToO7mTODw==","timestamp":"2023-05-19T22:41:43.589461474Z"}
May 19 18:41:43 tendermint-node-3 cosmovisor[1706]: 6:41PM INF received complete proposal block hash=4ED7BFBC7A8EC24B499A2A055CD3E1EC7827B0BC6BF17597F5B9CA8E6C15BB7C height=448 module=consensus
May 19 18:41:43 tendermint-node-3 cosmovisor[1706]: 6:41PM INF finalizing commit of block hash={} height=448 module=consensus num_txs=0 root=2724E3B4F32F7FF3AFBFE05FC9F1FDE0091831FDEBBF40677C378EE900AD2C29
May 19 18:41:43 tendermint-node-3 cosmovisor[1706]: 6:41PM INF minted coins from module account amount=22uatom from=mint module=x/bank
May 19 18:41:43 tendermint-node-3 cosmovisor[1706]: 6:41PM INF executed block height=448 module=state num_invalid_txs=0 num_valid_txs=0
May 19 18:41:43 tendermint-node-3 cosmovisor[1706]: 6:41PM INF commit synced commit=436F6D6D697449447B5B3136372032362031393320392031323120323438203232342031333920343320323434203235302035322031323020353820383020313736203132382033382031323520313520373120313838203132312031313320323232203636203232312039362031303820323535203139372032345D3A3143307D
May 19 18:41:43 tendermint-node-3 cosmovisor[1706]: 6:41PM INF committed state app_hash=A71AC10979F8E08B2BF4FA34783A50B080267D0F47BC7971DE42DD606CFFC518 height=448 module=state num_txs=0
May 19 18:41:43 tendermint-node-3 cosmovisor[1706]: 6:41PM INF indexed block exents height=448 module=txindex
May 19 18:41:45 tendermint-node-3 cosmovisor[1706]: 6:41PM INF Ensure peers module=pex numDialing=0 numInPeers=0 numOutPeers=3 numToDial=7
May 19 18:41:45 tendermint-node-3 cosmovisor[1706]: 6:41PM INF We need more addresses. Sending pexRequest to random peer module=pex peer={"Data":{},"Logger":{}}
```
