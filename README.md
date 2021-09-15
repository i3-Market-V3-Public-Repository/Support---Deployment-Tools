# i3M Deployment GitLab Project

Ansible playbooks to automatize i3m artifacts deployment.  

## BESU

- **Explorer**: <http://95.211.3.244:8547>
- **Branch**: <https://gitlab.com/i3-market/code/i3m-deployment/-/tree/besu-nodes>  
- **Playbook**: <https://gitlab.com/i3-market/code/i3m-deployment/-/tree/besu-nodes/playbooks/besu.yml>
- **AWX**: <http://95.211.3.249:19000/#/projects/30/details>
- **Nexus**: <http://95.211.3.251:8081/#browse/browse:i3m-raw:besu>

### Links 

Explorer: http://95.211.3.244:8547
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
> Source Control URL: https://gitlab.com/i3-market/code/i3m-deployment.git  
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
 RPC_API_METHODS: "ETH,NET,IBFT"
 VOLUME: "/var/besu"
 PORT_P2P: 30303
 PORT_HTTP: 8545
 PORT_WS: 8546
 NEXUS_USER: "i3m-nexus"
 NEXUS_PASS: "i3m.nexus"
 URL_GENESIS: "http://95.211.3.251:8081/repository/i3m-raw/besu/genesis.json"
 URL_KEY1: "http://95.211.3.251:8081/repository/i3m-raw/besu/0x76cedbc9bb3954a9a692f3918453672cdbd55b0d/key"
 URL_KEY2: "http://95.211.3.251:8081/repository/i3m-raw/besu/0x8b3a1c3488d1542ca07620fd3fa3d4097b54e432/key"
 URL_KEY3: "http://95.211.3.251:8081/repository/i3m-raw/besu/0xc96cce4367bad18abb6f87fd6413505181e2f5e6/key"
 URL_KEY4: "http://95.211.3.251:8081/repository/i3m-raw/besu/0xd34ff9b692e2c78d0f80805d972d9a5188298703/key"
 BOOTNODE: "enode://e60ff1c0ff85f4302faef47d870f9e71fbc27c408fd0a0d83965831a774b1c48c759326497f5f16e376380856ad549e35245c0f78af5d6d1dc4bcda014b5bccc@95.211.3.244:30303?discport=30303"
```

## Network preparation

- Detail: <https://besu.hyperledger.org/en/stable/Tutorials/Private-Network/Create-IBFT-Network>

Steps:
 - Download besu 21.1.6
 - Create folder and ibftConfigFile.json
 - Edit ibftConfigFile.json to set blockperiodsecond to 60
 - Execute command: /bin/besu operator generate-blockchain-config --config-file=ibftConfigFile.json --to=networkFiles --private-key-file-name=key
 - Upload genesis.json and key structure to Nexus.
 
