# AzureLab
My submission for the Cybersecurity Bootcamp: Project 1. A fully functioning and secure Azure environment.
## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

AzureLab/Diagrams/AzureDiagram.png

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Ansible files may be used to install only certain pieces of it, such as Filebeat.

!(https://github.com/spoffenb/AzureLab/blob/main/Ansible/install-elk.txt "")

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly flexible, in addition to restricting access to the network.
- What aspect of security do load balancers protect? Load Balancers protect the environment's accessability by normal users. If one VM server is experiencing unexpected errors or is down for scheduled maintenance, the load balancer will direct traffic to a VM server that is still up and active. What is the advantage of a jump box? While a jumpbox is exposed to the public internet, it controls access to the other machines by allowing connections from specific IP addresses and forwarding to those machines. Forcing all traffic through a single node or jumpbox and securing it is a great example of the 'fanning in' practice.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the jumpbox and system network.
- Filebeat helps generate and organize log files to send to Logstash and Elasticsearch. Specifically, it logs information about the file system. including which files have changed and when.
- Metricbeat is a lightweight shipper that periodically collects metrics from the OS and from services running on the server(s). Outputs to Elastisearch or Logstash.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.1   | Linux            |
| Web-1    | Server   | 10.0.0.5   | Linux            |
| Web-2    | Server   | 10.0.0.6   | Linux            |
| Web-3    | Server   | 10.0.0.7   | Linux            |
| ELKVM    | ELK      | 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 107.4.188.197

Machines within the network can only be accessed by the Jump Box.
- My Home machine can access the ELK VM through the Ansible Jump Box using the IP 107.4.188.197

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible | Allowed IP Addresses |
|----------------------|---------------------|----------------------|
| Allow -RDP           | No                  | 107.4.188.197        |
| SSH_Allow_Personal_IP| No                  | 107.4.188.197        |
| SSH_from_Jump_Box    | Yes                 | 10.0.0.4             |
| AllowPort80MyIP      | No                  | 107.4.188.197        |
| Port_5601            | No                  | 107.4.188.197        |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- It can easily be repeatable using the saved .yml files located within this project.

The playbook implements the following tasks:
- Install docker.io
- Install pip3
- Install Docker python module
- Direct the VM to allocate more memory
- Download and launch a docker elk container
- Enable service docker on startup

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

!(https://github.com/spoffenb/AzureLab/blob/main/Images/docker_ps_afterELK.png "")

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5
- 10.0.0.6
- 10.0.0.7

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- These beats allow us to monitor logs indicated by the user to alert if any changes are made to a log or file contained within. This helps to keep record of the services running on each server as well as the operating system.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the ansible-config.txt file to /etc/ansible
- Update the ansible-config.txt file to include the IP addresses to be added as hosts.
	- ex: <IP_Address> ansible_python_interpreter=/usr/bin/python3

- Run the playbook, and navigate to http://<ELKVM_IP>:5601/app/kibana to check that the installation worked as expected.
	- ex: http://104.43.201.36:5601/app/kibana#/home

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it?_
- ansible-playbook.txt is the ansible playbook. Copy it into /etc/ansible/ansible-playbook.yml (May need to create an empty 'ansible-playbook.yml' file before copying. This can be done using the 'nano' command)

- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?_
-You would update the /etc/ansible/hosts file. Under the [webservers] section, add your target VM IP addresses for the machines that you want to install DVWA on.
	- ex:  [webservers]
 	       ## alpha.example.org
 	       ## beta.example.org
  	       ## 10.0.0.5 ansible_python_interpreter=/usr/bin/python3
  	       ## 10.0.0.6 ansible_python_interpreter=/usr/bin/python3
- For the ELK VM You would still edit the /etc/ansible/hosts file but add target VM IP address(s) to the [elk] section 
	- ex: [elk]
	      ## alpha.example.org
 	      ## beta.example.org
  	      ## 10.1.0.4 ansible_python_interpreter=/usr/bin/python3

- _Which URL do you navigate to in order to check that the ELK server is running?
- http://<ELKVM_IP>:5601/app/kibana
	ex: http://104.43.201.36:5601/app/kibana#/home

- Commands you may need:
	- Use ansible playbook <playbook-filename.yml> to run playbook
	- Nano -l <playbook-filename.yml> to update files
	- 'Ctrl X' to exit and 'y' to save
