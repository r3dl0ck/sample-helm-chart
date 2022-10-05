# sample-helm-chart

1. Installing Jenkins from OpenShift template
```
oc new-project jenkins
oc new-app --name jenkins  --template jenkins-ephemeral
oc get route
```

2. Prepare Jenkins agent with `helm` package:
```
oc new-app --name agent --strategy docker https://github.com/r3dl0ck/sample-helm-chart
```
3. Configure helm jenkins agent: 'Jenkins management -> Nodes -> Configure Clouds -> Pod Templates -> Add Pod Template':
```
Name: helm
Labels: helm

Container Template:
- Name: jnlp
- Docker image: image-registry.openshift-image-registry.svc:5000/jenkins/agent
- Working directory: /tmp
- Always pull image - check
- Arguments to pass to the command: $(JENKINS_SECRET) $(JENKINS_NAME)
- Command to run: clear box
- Arguments to pass to the command: clear box
```

4. Create Jenkins Pipeline
```
oc apply -f pipeline.yaml -n jenkins
```

5. Create projects:
```
oc new-project dev
oc new-project uat
```

6. Grant `edit` role to Jenkins service account:
oc policy add-role-to-user edit system:serviceaccount:jenkins:default -n dev
oc policy add-role-to-user edit system:serviceaccount:jenkins:default -n uat
```

7. Run new pipeline in Jenkins Console or use cli:
```
oc start-build buildconfig/sample-app-test
```
