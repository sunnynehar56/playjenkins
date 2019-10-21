# playjenkins
Jenkins Playground

CI/CD Pipeline - We installed Kuberntes CLI plugin and added a sevice account, given rbac permissions as clusterwide admin
Taken the token for the svc account added and added it as a secret text to jenkins credentials.


https://github.com/jenkinsci/kubernetes-cli-plugin

For docker ECR registry we added AWS credentials to jenkins credentials. We used AW ECR plugin for this.

Plugins to be added in jenkins
- aws code deploy plugin
- kubernetes continours plugin
- amazon ECR
