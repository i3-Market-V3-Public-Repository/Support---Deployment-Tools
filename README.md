# i3M Deployment GitLab Project

Ansible playbook to automatize i3m artifacts deployment. This readme details the deployment of the BESU Network.

## BESU

- **Explorer**: <http://95.211.3.244:8547>
- **Playbook**: <https://gitlab.com/i3-market/code/i3m-deployment/-/tree/besu-nodes/playbooks/besu.yml>
- **AWX**: <http://95.211.3.249:19000/#/projects/30/details>
- **Nexus**: <http://95.211.3.251:8081/#browse/browse:i3m-raw:besu>

### Links 

Explorer: <http://95.211.3.244:8547>  
P2P: (tcp+udp)  

    95.211.3.244:30303  
    95.211.3.249:30303  
    95.211.3.250:30303  
    95.211.3.251:30303  

RPC-HTTP: tcp  

    95.211.3.244:8545  
    95.211.3.249:8545  
    95.211.3.250:8545  
    95.211.3.251:8545  
  
RCP-WS: tcp

    95.211.3.244:8546  
    95.211.3.249:8546  
    95.211.3.250:8546  
    95.211.3.251:8546  

### AWX

#### Credentials

Generate a new credential to connect via SSH to each host.  

> Name: upc_rafael.genes  
> Description: SSH to nodes with user upc_rafael.genes  
> Credential Type: Machine  
> Username: upc_rafael.genes  
> Password: Encrypted  
> Privilege Escalation Method: sudo  
> Privilege Escalation Username: root  
> Privilege Escalation Password: Encrypted  

#### Project

Generate a new project to link the gitlab branch with the deployment.  

> Name: i3m-deployement-BESU-nodes  
> Description: Besu nodes deployment  
> Organization: I3M  
> Source Control Type: Git  
> Source Control URL: <https://gitlab.com/i3-market/code/i3m-deployment.git>  
> Source Control Branch: besu-nodes  
> Source Control Credential: Scm: i3M-SCM-credentials   
> Playbook Directory: _30__i3m_deployement_besu_nodes  

#### Template

Generate a new template to manage the job execution for this project.

> Name: template-i3m-besu  
> Description: BESU node deployment  
> Job Type: run  
> Organization: I3M  
> Inventory: i3M-inventory  
> Project: i3m-deployement-BESU-nodes  
> Playbook: playbooks/besu.yml  
> Verbosity: 1 (Verbose)  
> Options: Enable Privilege Escalation  
> Credentials: SSH: upc_rafael.genes  
> Variables:  

```yml
---
 IMAGE_BESU: "hyperledger/besu:21.1.6"
 RPC_API_METHODS: "ETH,NET,IBFT,WEB3"
 VOLUME: "/var/besu"
 PORT_P2P: 30303
 PORT_HTTP: 8545
 PORT_WS: 8546
 NEXUS_USER: "i3m-nexus"
 NEXUS_PASS: "XXXX"
 URL_GENESIS: "http://95.211.3.251:8081/repository/i3m-raw/besu/genesis.json"
 URL_KEY1: "http://95.211.3.251:8081/repository/i3m-raw/besu/accounts/0xXXXX"
 URL_KEY2: "http://95.211.3.251:8081/repository/i3m-raw/besu/accounts/0xXXXX"
 URL_KEY3: "http://95.211.3.251:8081/repository/i3m-raw/besu/accounts/0xXXXX"
 URL_KEY4: "http://95.211.3.251:8081/repository/i3m-raw/besu/accounts/0xXXXX"
 BOOTNODE: "enode://0xf2102d06488bb5b693fb85465c2bc316c5bf2a23a3c1f1dfb9e20733c67f7c41279a09f0f6c11a6964f0d0bf8ae85484e253e1196606b168faf77ffbfc081374@95.211.3.244:30303?discport=30303"
```

## Network preparation

- Detail: <https://besu.hyperledger.org/en/stable/Tutorials/Private-Network/Create-IBFT-Network>

Steps:
 - Download besu 21.1.6
 - Create Network folder
 - Create 20 accounts
 - Create custom ibftConfigFile.json from template with:
    - gasLimit: 12.5M
    - accounts: Add previous accounts with enought ether.
    - blockperiodsecond: 60s
 - Generate genesis.json
 - Execute command: /bin/besu operator generate-blockchain-config --config-file=ibftConfigFile.json --to=networkFiles
 - Upload to Nexus genesis.json, accounts and node keys.
 
 generate-accounts.sh  
```bash
#!/bin/bash

BESU=../../bin/besu

for i in {1..20}
do
  echo "Generating account $i"

  $BESU --data-path=$i public-key export-address --to=$i/key.address
  $BESU --data-path=$i public-key export --to=$i/key.pub

  mv $i $(cat $i/key.address)
done

find . -name '*.address' -delete
```

### Network accounts

Several accounts are created from the genesis with lots of ether. This enables each partner to own one unique account, which facilitates the audition of the smart contracts. The following list shows the asociated partner that owns each account. Please, if you want to use one of them, select an unassigned one and update this documentation with your email to ensure anyone uses your account and also you could receive notifications in case of some updates/troubles to the network. The asociated private keys are stored on the Nexus: <http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts>.


| Account | Responsible |
| ------ | ------ |
| [0x0b6804081649a4b1bdd50abe23a21bc414855432](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x0b6804081649a4b1bdd50abe23a21bc414855432) | rafael.genes@upc.edu |
| [0x17bd12c2134afc1f6e9302a532efe30c19b9e903](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x17bd12c2134afc1f6e9302a532efe30c19b9e903) | j.hernandez@upc.edu |
| [0x2b6b29ba1ef1db1e1f38a34a612fbcf772577934](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x2b6b29ba1ef1db1e1f38a34a612fbcf772577934) | vladimir.rogojin@guardtime.com |
| [0x2e3592788eb9154914f87e4bb82011042aad5da8](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x2e3592788eb9154914f87e4bb82011042aad5da8) | |
| [0x2fc9e73f77ae2fd542fc121aafbcb80f4ffc8f63](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x2fc9e73f77ae2fd542fc121aafbcb80f4ffc8f63) | |
| [0x410ff996d668ee5d6116cb4dccb215f977594f5f](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x410ff996d668ee5d6116cb4dccb215f977594f5f) | |
| [0x50c0f1e9acf797a3c12a749634224368ebc1f59a](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x50c0f1e9acf797a3c12a749634224368ebc1f59a) | |
| [0x580d142d0c2958d843499553275e427da4ab7eb5](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x580d142d0c2958d843499553275e427da4ab7eb5) | |
| [0x584ffadc1556ef6238c533fc4926e15c12b46976](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x584ffadc1556ef6238c533fc4926e15c12b46976) | |
| [0x69a7fb032b7e224137bb62568e9b4ae14b5571fe](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x69a7fb032b7e224137bb62568e9b4ae14b5571fe) | |
| [0x836e50b77cd47fda2b4f5767813f52a927c9e661](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x836e50b77cd47fda2b4f5767813f52a927c9e661) | |
| [0x92a901de58337269c5e9b04e3e11048b6097382b](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0x92a901de58337269c5e9b04e3e11048b6097382b) | |
| [0xacf8f592c1c66b8ef43afcba7c8fed1c5a61e400](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0xacf8f592c1c66b8ef43afcba7c8fed1c5a61e400) | |
| [0xadb9c7eef77a46efa226112e90e7631dab05833b](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0xadb9c7eef77a46efa226112e90e7631dab05833b) | |
| [0xc4242494568410b61e6e6807a5ae3bf4b9d873bd](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0xc4242494568410b61e6e6807a5ae3bf4b9d873bd) | |
| [0xc95c3a7c81696186b0102663747291100349ebf4](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0xc95c3a7c81696186b0102663747291100349ebf4) | |
| [0xca269076733baf4206640c81d7336d5c5ac65bb2](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0xca269076733baf4206640c81d7336d5c5ac65bb2) | |
| [0xcbe4b0704dbb74227ecde3d00c455066dd415e3a](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0xcbe4b0704dbb74227ecde3d00c455066dd415e3a) | |
| [0xdb0ce68babc145b18786c2d820b8cccc40e1a4f5](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0xdb0ce68babc145b18786c2d820b8cccc40e1a4f5) | |
| [0xf13c943289ecec5da84ecaea198165aabd465e58](http://95.211.3.251:8081/#browse/browse:i3m-raw:besu/accounts/0xf13c943289ecec5da84ecaea198165aabd465e58) | |
