docker build -t satyamgrao007/lovable-jenkins-agent:latest -f Dockerfile.agent .
docker push satyamgrao007/lovable-jenkins-agent:latest




docker build -f Dockerfile.controller -t satyamgrao007/lovable-jenkins-controller:latest .

docker push satyamgrao007/lovable-jenkins-controller:latest



                Jenkins Controller
                        │
                        ▼
              ServiceAccount (jenkins)
                        │
                        ▼
                 RoleBinding
                        │
                        ▼
                     Role
                        │
                        ▼
               Kubernetes API Server
                        │
        ┌───────────────┼────────────────┐
        ▼               ▼                ▼
     Create Pods     Get Logs      Delete Pods