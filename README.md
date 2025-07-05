# Task 4: Jenkins Installation with Helm on Minikube

## 🧩 Technologies Used
- Minikube (Kubernetes)
- Helm
- Jenkins
- Jenkins Configuration as Code (JCasC)

---

## ✅ Objectives Covered

| Criteria | Status |
|---------|--------|
| Helm Installation and Verification | ✅ Helm Installed and Verified. Deployed NGINX from Bitnami repo (10 points) |
| Cluster Requirements | ✅ PVC Configured. Minikube storage class used (10 points) |
| Jenkins Installation | ✅ Jenkins Installed via Helm. Installed in `jenkins` namespace (40 points) |
| Jenkins Accessible | ✅ via `minikube service jenkins -n jenkins` |
| Jenkins Configuration | ✅ Configuration Persisted. PVC mounted to `/var/jenkins_home` (10 points) |
| Verification | ✅ Hello World Job via JCasC. Declared in `values.yaml` (15 points) |
| Additional Tasks  | ✅ Authentication Secured. Admin credentials in Kubernetes Secret (15 points) |
| GitHub Actions | ❌ Not required on Minikube |

---

## 🚀 How to Deploy

```bash
chmod +x install_jenkins_minikube.sh
./install_jenkins_minikube.sh

![{06D14324-93F5-4687-A019-745F0858CE03}](https://github.com/user-attachments/assets/d360e978-8d36-45ae-9aba-774077f5851e)
![{FDFD14B2-9530-4C07-86A3-A6A8777F5DD8}](https://github.com/user-attachments/assets/253c85e4-3aab-4b1c-9ee2-d8e165bfb698)
![{2A6F1277-7330-4D54-9A9E-D23B22F4D529}](https://github.com/user-attachments/assets/d31fe3b0-4bb0-44ca-b290-b777b389b661)
![{96347B1E-8BA7-4795-9D4E-CD6391330A71}](https://github.com/user-attachments/assets/6219238d-cfff-4d34-a27a-14a8fd64e9cf)
![{18E35A17-361A-4098-B37B-9DCBD6E5F6F6}](https://github.com/user-attachments/assets/7aa4124f-542e-4e43-a148-aaecd9f43415)
![{D761CD68-1AC2-42B7-AEF6-2050A8B0C261}](https://github.com/user-attachments/assets/4a61c83c-cc68-453e-9177-9ea4a1046787)
![image](https://github.com/user-attachments/assets/596ddba4-3788-441f-9de8-514e228b5e6c)



