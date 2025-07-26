# [DevOps Course](https://github.com/rolling-scopes-school/tasks/tree/master/devops)

## [Task 5: Simple Application Deployment with Helm](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_5.md)

## Repository Structure

```bash

.
├── flask_app\
│   ├── Dockerfile
│   ├── README.md
│   ├── main.py
│   ├── requirements.txt
│   └── test_application.py
├── helm-chart/
│    ├── flask-app/
│    │   ├── .helmignore
│    │   ├── templates/..
│    │   ├── Chart.yaml
│    │   └── values.yaml
│    └── jenkins
│        ├── jenkins/..
│        ├── CHANGELOG.md
│        ├── Chart.yaml
│        ├── README.md
│        ├── UPGRADING.md
│        ├── VALUES.md.gotmpl
│        └── values.yaml
├── monitoring/
│    ├── templates/
│    └── ...
├── .gitignore
├── Jenkinsfile
└── README.md
```
## Steps

1. Create Helm Chart. Create a Helm chart for your Application.
2. Deploy the Application.
Deploy the application using the Helm chart.
Ensure the application is accessible from the web browser.
3. Store Artifacts in Git. Store the application and Helm chart in your git repository.
4. Additional Tasks💫. Document the application setup and deployment process in a README file.

## Implementation
1. Create Docker Image
```
docker build -t mykola-flask-app .
```
2. Run locally to test
```
docker run -p 8080:8080 mykola-flask-app
```
3. Helm Chart Creation
```
helm create flask-app
```
3. Load Image into Minikube
```
minikube image load mykola-flask-app
```
4. Deploy Application via Helm
```
helm install flask-app ./flask-app
```
5. Verify service and access:
```
minikube service flask-app
```
6. Deploy Jenkins via Helm

```
helm repo add jenkins https://charts.jenkins.io
helm repo update
kubectl create namespace jenkins
helm upgrade --install jenkins jenkins/jenkins -n jenkins -f jenkins-values.yaml
```
7. Access Jenkins 
```
minikube service jenkins -n jenkins --url
```

8. Configuration
Jenkins jobs and settings through JCasC in the Helm chart values file jenkins-values.yaml
"Hello World" freestyle job created automatically via JCasC configuration
Confirm Jenkins pods are running with `kubectl get pods -n jenkins`

## Used Commands
```
# Start minikube
minikube start

# Build Docker image
docker build -t mykola-flask-app .

# Load image into minikube
minikube image load mykola-flask-app

# Install Helm chart
helm install flask-app ./flask-app

# Open service in browser
minikube service flask-app

# Deploy Jenkins via Helm
helm repo add jenkins https://charts.jenkins.io
helm repo update
kubectl create namespace jenkins
helm upgrade --install jenkins jenkins/jenkins -n jenkins -f jenkins-va
minikube service jenkins -n jenkins --url
```
#### Helm Deployment
```
helm upgrade --install flask-app ./helm_charts/flask-app
--set image.repository=your-repo/flask-app
--set image.tag=latest
--set serviceAccount.create=false
```
### Monitoring and Debugging
```
kubectl get pods -n jenkins
kubectl get service flask-app -n jenkins
curl [http://flask-app.jenkins.svc.cluster.local:8080/](http://flask-app.jenkins.svc.cluster.local:8080/)
```
