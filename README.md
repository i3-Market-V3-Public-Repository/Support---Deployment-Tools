# i3M Deployment GitLab Project

Ansible playbooks to automatize i3m artifacts deployment.  

## BESU

- **Branch**: <https://gitlab.com/i3-market/code/i3m-deployment/-/tree/besu-nodes>  
- **Playbook**: playbooks/besu.yml  

### besu.yml

```yml
- name: BESU preparation 
  hosts: all
  become: true
  tasks:
      # Volume folder creation on each host -> /var/besu
    - name: Creating data folder       
      file:
        path: "{{VOLUME}}"
        state: directory
        mode: '0775'    
        owner: 1000
        group: 1000
        recurse: yes
    
    # Get genesis.json from Nexus
    - name: Get config files from Nexus
      get_url:
        url: "{{URL_GENESIS}}"        
        url_username: "{{NEXUS_USER}}"
        url_password: "{{NEXUS_PASS}}"
        dest: "{{VOLUME}}/genesis.json"
        owner: 1000
        group: 1000        

- name: BESU deployment
  hosts: all
  become: true
  tasks:
    - name: Run docker image
      docker_container:
        name: besu
        image: hyperledger/besu:latest
        env:
          BESU_DATA_PATH: "/besu"
          BESU_GENESIS_FILE: "/besu/genesis.json"
          BESU_HOST_ALLOWLIST: "*"
          BESU_P2P_HOST: "0.0.0.0"
          BESU_RPC_HTTP_ENABLED: "true"
          BESU_RPC_HTTP_HOST: "0.0.0.0"
          BESU_RPC_HTTP_API: "{{RPC_API_METHODS}}"
          BESU_RPC_WS_ENABLED: "true"
          BESU_RPC_WS_HOST: "0.0.0.0"
          BESU_BOOTNODES: "{{BOOTNODE}}"
        volumes:
          - "{{VOLUME}}:/besu"
        ports:
          - "{{PORT_P2P}}:30303/udp"
          - "{{PORT_P2P}}:30303/tcp"
          - "{{PORT_HTTP}}:8545/tcp"
          - "{{PORT_WS}}:8546/tcp"
        state: started
```

### Nexus 

Upload via GUI the following files in the **i3m-raw** repository.  

- http://95.211.3.251:8081/repository/i3m-raw/besu/genesis.json  
- http://95.211.3.251:8081/repository/i3m-raw/besu/ibftConfigFile.json  

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
 RPC_API_METHODS: "ETH,NET,IBFT"
 VOLUME: "/var/besu"
 PORT_P2P: 30303
 PORT_HTTP: 8545
 PORT_WS: 8546
 NEXUS_USER: "i3m-nexus"
 NEXUS_PASS: "i3m.nexus"
 URL_GENESIS: "http://95.211.3.251:8081/repository/i3m-raw/besu/genesis.json"
 BOOTNODE: "enode://15c10a20c60accc577cdd2f941cfbc1671933811819d7b503f5c7bf25d370110014eba71f7b2d11c11c156bbe99457190608b66e2ac493cc2df8457ab9068d4e@95.211.3.244:30303?discport=30303"
```







