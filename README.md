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
