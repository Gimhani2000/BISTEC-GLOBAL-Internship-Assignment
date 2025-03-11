# BISTEC-GLOBAL-Internship-Assignment

## Overview
This project sets up an Azure Kubernetes Service (AKS) cluster using **Azure Bicep** and deploys a full-stack application with a React frontend, Spring Boot backend, and MySQL database.

## Steps

### 1. Set Up the AKS Cluster
- Used **Azure Bicep** to provision an AKS cluster.
- Created a resource group and deployed a cluster with 2 nodes.
- Configured `kubectl` to interact with the cluster.

### 2. Containerized the Application
- Created Docker images for the backend, frontend, and MySQL database.
- Pushed images to an Azure Container Registry (ACR).

### 3. Deployed to Kubernetes
- Wrote Kubernetes manifests for the backend, frontend, and database.
- Deployed the services using `kubectl apply -f`.

### 4. Verification
- Checked that all pods were running.
- Retrieved the frontend service’s external IP and accessed the app.

## How to Check
1. Run `kubectl get svc` to find the external IP.
2. Open a browser and visit `http://<EXTERNAL_IP>`.
