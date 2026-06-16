------------------------------------------------
Azure-Terraform-Hub-and-spoke-DNS-Monitoring-Storage-account
------------------------------------------------

This project automates the deployment of a secure Azure environment using Terraform.

----------
Features
----------

Multiple Resource Groups across regions
Virtual Networks (VNets) and Subnets
Windows Virtual Machines
Azure Bastion for secure remote access
Azure Firewall and Firewall Policies
VNet Peering between regions
Azure Storage Account with Private Endpoint
Private DNS Zones and DNS Links
Azure Monitor and Log Analytics Workspace
Data Collection Rules (DCR) for VM monitoring
Terraform Outputs for infrastructure visibility

-------------
Technologies
-------------

Terraform
Microsoft Azure
Azure Virtual Network
Azure Firewall
Azure Bastion
Azure Monitor
Azure Storage
Private Endpoints
Private DNS Zones
Architecture

The environment deploys infrastructure across multiple Azure regions:

Central US (CUS)
North Central US (NCUS)
Mexico Central (MEX)

The design focuses on:

Network segmentation
Secure access through Bastion
Private connectivity using Private Endpoints
Centralized monitoring and logging
Inter-region communication through VNet Peering
Purpose

This project was developed as a hands-on Azure Cloud Engineering and Cloud Security lab to practice Infrastructure as Code (IaC), network security, monitoring, and Azure administration using Terraform.I built this project to strengthen my Azure and Terraform skills. Instead of deploying resources manually through the Azure portal, I automated the entire infrastructure using Infrastructure as Code. The project includes network segmentation with VNets and subnets, secure access through Azure Bastion, traffic filtering with Azure Firewall, private connectivity using Private Endpoints, centralized monitoring through Azure Monitor and Log Analytics, and multi-region connectivity using VNet Peering. This project helped me understand how enterprise Azure environments are designed, secured, and managed.
