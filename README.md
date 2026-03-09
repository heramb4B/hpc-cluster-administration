![HPC](https://img.shields.io/badge/HPC-Cluster%20Administration-blue)
![Slurm](https://img.shields.io/badge/Scheduler-Slurm%20%7C%20OpenPBS-green)
![GPU](https://img.shields.io/badge/GPU-H200%20%7C%20A100-red)
![Scale](https://img.shields.io/badge/Scale-3200%2B%20Nodes-orange)

# HPC Cluster Administration - Production Documentation

**Real-world HPC infrastructure documentation from 11+ enterprise deployments**

📍 **Experience Base:** C-DAC (3,200-node cluster), IISc ArtGarage, IITM, NCRA-TIFR, IUCAA, Tata Memorial, SLB, and more  
🔧 **Tech Stack:** xCAT, Slurm, OpenPBS, FreeIPA, Lustre, InfiniBand, NVIDIA H200/A100 GPUs  
📊 **Scale:** From research labs to 3,200+ node production clusters

---

## 🎯 About This Repository

This repository contains **production-grade documentation** created during hands-on work across **11+ client HPC environments** spanning research institutions, government labs, and corporate deployments.

Unlike theoretical guides, these documents are based on **real troubleshooting, actual deployments, and production incidents** — capturing what works in the field, not just what works in tutorials.

### What Makes This Different

✅ **Battle-tested procedures** from production environments  
✅ **Troubleshooting sections** from real incidents  
✅ **Multi-vendor integration** (HPE, Lenovo, Supermicro, NVIDIA)  
✅ **Scalability insights** from small labs to 3,200-node clusters  
✅ **GPU cluster specifics** (H200, A100 provisioning and troubleshooting)

---

## 📚 Documentation Collection

### Core Infrastructure Setup

#### [1. xCAT - Cluster Provisioning](./xCAT%20Installation.pdf)

**Production-tested on:** C-DAC Bengaluru (3,200 nodes), SLB, CABS

- Master node installation and configuration
- Node discovery and hardware management
- OS image deployment workflows
- Network boot (PXE) setup for heterogeneous hardware

#### [2. xCAT Verification & Troubleshooting](./xCAT%20Verification.pdf)

- Node status validation procedures
- Common provisioning failures and fixes
- Hardware inventory verification
- Network configuration troubleshooting

---

### Time Synchronization

#### [3. Chrony NTP - Time Sync](./Chrony%20NTP%20Server%20&%20Client%20Configuration%20with%20xCAT.pdf)

**Why it matters:** Critical for distributed job scheduling and log correlation

- Master-node Chrony server setup
- xCAT-integrated client deployment
- Verification and drift monitoring
- Troubleshooting clock skew issues

---

### Identity & Access Management

#### [4. FreeIPA - Centralized Identity](./FreeIPA_Server_&_Client_Configuration.pdf)

**Production-tested on:** IISc ArtGarage, CABS, RRI

- FreeIPA server installation and realm setup
- Client enrollment automation (see [automation script](./enroll_node.sh))
- LDAP integration for user management
- Kerberos authentication configuration
- **Automation:** [FreeIPA Client Enrollment Script](./enroll_node.sh) — Auto-enrolls compute nodes from master

#### [5. NIS - Legacy Identity Management](<./NIS_(Network_Information_Service)_Server_&_Client_Configuration.pdf>)

**When to use:** Legacy systems or simple setups

- NIS server configuration
- Client integration
- Migration path from NIS → FreeIPA

---

### Storage & File Systems

#### [6. NFS - Network File System](./NFS_-_Client_and_Server_Config.pdf)

**Production configs from:** NCRA, IUCAA, IIT Hyderabad

- NFS server setup for shared storage
- Client-side mount configuration
- Performance tuning for HPC workloads
- Export management and permissions

**Note:** For large-scale parallel storage, see Lustre (covered in [HPC General Documentation](./High_Performance_Computing.pdf))

---

### Job Schedulers

#### [7. Slurm - Modern Workload Manager](./Slurm_Installation,_Configuration_and_Concepts.pdf)

**Production-tested on:** C-DAC Bengaluru, SLB

- Controller and compute node setup
- Partition and QoS configuration
- Job submission and monitoring
- Resource limits and fair-share scheduling
- Integration with xCAT provisioning

#### [8. OpenPBS - Professional Job Scheduler](./OpenPBS_Concepts,_Config_&_Installation.pdf)

**Production-tested on:** NCRA-TIFR, IISc ArtGarage

- PBS server installation
- Queue configuration and policies
- Job arrays and dependencies
- Accounting and reporting

**🔀 Slurm vs PBS:** Both documented for environment-specific requirements

---

### Specialized Deployments

#### [9. GPU Node Troubleshooting](./GPU_NODE_Troubleshooting_Documentation.pdf)

**Real incidents from:** IISc ArtGarage (January 2026)

- Disk space exhaustion on GPU nodes
- Docker image/container cleanup procedures
- PBS job monitoring during live GPU workloads
- HPCM image capture failures (rsync disk issues)
- Docker mom_logs directory exclude flags

#### [10. H200 GPU Provisioning & IB Switch Config](./H200_Configuration_and_IB_Switch_Conf_ACREC+IISc_ArtGarage.pdf)

**Real deployment from:** ACTREC Tata Memorial, IISc (February 2026)

- NVIDIA MLNX-OS InfiniBand switch firmware upgrade (3.10.5000 → 3.11.4002)
- HPCM-based H200 GPU node provisioning workflow
- Serial console monitoring during node deployment
- Boot verification and troubleshooting

---

### 📖 Comprehensive Reference

#### [11. High Performance Computing - Complete Guide](./High_Performance_Computing.pdf)

**67 pages covering:**

- **Architecture:** Head nodes, compute nodes, storage systems, networking (InfiniBand vs Ethernet)
- **Hardware:** RAID technologies (0/1/5/6/10), server components, GPU compute
- **Storage:** Lustre parallel filesystem, NFS, performance comparison
- **Software Stack:** OS selection, MPI implementations, job schedulers
- **GPU Computing:** CUDA, cuDNN, NCCL, TensorRT full stack
- **Applications:** Ansys, Abaqus, Gaussian, TensorFlow installation guides
- **Physical Setup:** Step-by-step from Bill of Materials to production

**This is the foundational document** — start here if you're new to HPC.

---

## 🛠️ Automation Scripts

### FreeIPA Client Enrollment

**File:** [`enroll_node.sh`](./enroll_node.sh)

Automates FreeIPA client installation and enrollment across compute nodes from master node.

**Usage:**

```bash
# On master node
./enroll_node.sh <node_hostname>

# Example
./enroll_node.sh compute01
```

**Features:**

- Automatic package installation
- Realm join with error handling
- SSH key-based remote execution
- Idempotent (safe to re-run)

---

## 🏗️ Real-World Deployment Experience

### Client Environments Documented

| Organization               | Cluster Scale       | Key Technologies                       | Focus Area                    |
| -------------------------- | ------------------- | -------------------------------------- | ----------------------------- |
| **C-DAC Bengaluru**        | 3,200 nodes, 5 pods | Lustre, InfiniBand, Multi-level fabric | Massive-scale orchestration   |
| **C-DAC Pune**             | Medium              | JBOD, RAID, BMC/iLOS                   | Storage & hardware management |
| **IISc ArtGarage**         | GPU cluster         | H200 nodes, PBS, Docker, HPCM          | GPU troubleshooting           |
| **ACTREC (Tata Memorial)** | H200 GPUs           | HPCM, InfiniBand switch upgrade        | Medical research HPC          |
| **NCRA-TIFR**              | Research            | PBS scheduling                         | Astrophysics workloads        |
| **SLB**                    | Enterprise          | Slurm, cluster re-installation         | Oil & gas HPC                 |
| **IITM**                   | Research            | Red Hat OpenShift                      | Container orchestration       |
| **RRI Bengaluru**          | Research            | Preventive maintenance, monitoring     | System health checks          |
| **IUCAA**                  | Research            | Hard disk troubleshooting              | Storage reliability           |
| **CABS Bengaluru**         | Research            | Parallel File System, GPUs             | Bioinformatics HPC            |
| **Sulzer**                 | Corporate           | App installation, re-deployment        | Engineering simulation        |

---

## 🎓 Continuous Learning

**Currently pursuing:**

- Linux RHCSA (Red Hat Certified System Administrator)
- Altair PBS Professional
- Altair HPCWorks
- Altair InsightPro

---

## 🤝 How to Use This Repository

### For HPC Administrators

1. **Start with** [High Performance Computing guide](./High_Performance_Computing.pdf) for foundational concepts
2. **Deploy using** component-specific guides (xCAT, Slurm, FreeIPA, etc.)
3. **Troubleshoot with** the GPU and H200 documents for GPU-specific issues
4. **Automate using** the FreeIPA enrollment script as a template

### For Students/Learners

- Documents include **concepts** alongside **procedures** — understand the "why" not just the "how"
- **Real-world context** from production deployments
- **Troubleshooting sections** teach you what goes wrong in practice

### For Interviewers/Recruiters

This repository demonstrates:

- ✅ Production HPC experience across 11+ enterprise environments
- ✅ Documentation skills (200+ pages of technical writing)
- ✅ System administration (provisioning, identity, storage, scheduling)
- ✅ GPU cluster expertise (H200/A100 deployment and troubleshooting)
- ✅ Automation mindset (scripting for efficiency)
- ✅ Multi-vendor integration (HPE, Lenovo, Supermicro, NVIDIA)

---

## 📬 Contact & Collaboration

**Author:** Heramb Kondhare  
**Role:** HPC Systems Engineer  
**Experience:** 11+ client HPC deployments (September 2025 - March 2026)

💼 **LinkedIn:** [https://www.linkedin.com/in/heramb-k/]  
📧 **Email:** [heramb_k@citilindia.com]  
🌐 **Portfolio:** [https://heramb4b.github.io/portfolio/]

<!-- **Open to:**

- HPC infrastructure consulting
- Technical writing collaborations
- Knowledge sharing and mentorship -->

---

## ⭐ If This Helped You

If you found these documents useful:

- ⭐ **Star this repository**
- 🔀 **Fork it** for your own reference
- 📣 **Share it** with your HPC community
- 💬 **Open issues** for questions or corrections

---

## 📄 License

This documentation is shared for **educational and reference purposes**.

**Attribution:** When using or adapting this content, please credit the original author and link back to this repository.

**Usage:**  
✅ Personal learning and reference  
✅ Internal company documentation (with attribution)  
✅ Academic/research use  
❌ Direct commercial resale of documentation

---

## 🙏 Acknowledgments

These documents wouldn't exist without:

- **Client organizations** who provided real-world learning opportunities
- **Senior engineers** at deployment sites who shared their expertise
- **The HPC community** for open knowledge sharing

---

## 📈 Repository Stats

![GitHub stars](https://img.shields.io/github/stars/heramb4B/hpc-cluster-administration?style=social)
![GitHub forks](https://img.shields.io/github/forks/heramb4B/hpc-cluster-administration?style=social)
![Last commit](https://img.shields.io/github/last-commit/heramb4B/hpc-cluster-administration)

**Last Updated:** March 2026  
**Total Documentation:** 200+ pages  
**Client Deployments:** 11+ organizations  
**Tech Stack Coverage:** 10+ core technologies

---

_"Documentation is a love letter you write to your future self."_ — Damian Conway
