# Terraform Azure
Deploy resources in Microsoft Azure with Terraform!

## Implement an AVD Infrastructure

Welcome to Implementing an Azure Virtual Desktop Infrastructure. In this Lab I am using PowerShell, Azure PowerShell, Azure CLI and Terraform. All of the exercise files should continue to be valid on the current major version of each platform.

## Using the files

The configuration files are divided into directories. I try whenever possible to keep the structure simple.

## Prerequisites

I really do hope you'll follow along and gain some hands on experience with AVD. Here are the prerequisites you'll need in place to use the exercise files:

* Azure CLI
* PowerShell 7.x
* Terraform 1.8.x
* Azure subscription
* Entra ID tenant


### Terraform?

HashiCorp Terraform is an open source tool for infrastructure management and automation. It allows users to define 
infrastructure as code using a declarative configuration language called HashiCorp Configuration Language (HCL). 
Terraform supports a variety of cloud platforms, including Amazon Web Services, Microsoft Azure, Google Cloud Platform, 
VMware and OpenStack, as well as a variety of other services and vendors. With Terraform, users can track, test and 
automatically deploy infrastructure changes, resulting in faster and more reliable deployment of applications and services.

## Assumptions

Most of the scripts assume you are using the `westeurope` region. But you should be able to update all of them to work with your preferred region.

## COST $ $ $

Resources in Azure are **not free** and as such running through the exercises will cost you money. I recommend shutting down VMs when they are not in use. You can also choose smaller VM sizes or pick a lower tier of storage for the OS disk. Special care should be taken with Azure Firewall deployment, which cannot be "turned off" and costs about $1.25 per hour. Azure Bastion also costs about $0.19 per hour, which isn't that bad, but can still cause some bills if you leave it in place.

## Conclusion

Find me on Twitter ([@tomvideo2brain](https://twitter.com/tomvideo2brain)) or drop an issue in this repository. Good luck and happy building!

Tom