def repo="https://shailendra14k.github.io/sample-helm-chart/"
pipeline {
  agent{
    label 'helm'
  }

  stages{

    stage("add helm repo") {
      steps {
        sh "helm repo add shailendra ${repo}"
      }
    }
  
    stage("Deploy to Dev") {
      steps {
        script{
          openshift.withCluster(){
            sh "/usr/bin/helm upgrade --install helm-app shailendra/sample-app --values dev/values.yaml -n dev --wait"
          }
        }
      }
    }
  
    state("Test Dev") {
      steps {
        script {
          sh "sleep 10"
        }
      }
    }
  
    stage("Deploy to UAT") {
      steps {
        script{
          openshift.withCluster(){
            sh "/usr/bin/helm upgrade --install helm-app shailendra/sample-app --values uat/values.yaml -n uat --wait"
          }
        }
      }
    }

  }
}
