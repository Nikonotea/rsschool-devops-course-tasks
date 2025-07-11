# [DevOps Course](https://github.com/rolling-scopes-school/tasks/tree/master/devops)

## [Task 5: Simple Application Deployment with Helm](https://github.com/rolling-scopes-school/tasks/blob/master/devops/modules/3_ci-configuration/task_5.md)

## Repository Structure

```bash

.
├── flask_app\
│   ├── Dockerfile
│   ├── README.md
│   ├── main.py
│   └── requirements.txt
├── helm-chart/
│    └── flask-app/
│        ├── .helmignore
│        ├── templates/..
│        ├── Chart.yaml
│        └── values.yaml
├── .gitignore
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
docker run -p 8080:8080 my-flask-app
```
3. Helm Chart Creation
```
helm create flask-app
```
3. Load Image into Minikube
```
minikube image load my-flask-app
```
4. Deploy Application via Helm
```
helm install flask-app ./flask-app
```
5. Verify service and access:
```
minikube service flask-app
```

## Used Commands
```
# Start minikube
minikube start

# Build Docker image
docker build -t mykola-flask-app .

# Load image into minikube
minikube image load my-flask-app

# Install Helm chart
helm install flask-app ./flask-app

# Open service in browser
minikube service flask-app
```
