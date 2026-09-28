# Bank Service Portal

## Experiment 10: Design & Implement an End-to-End DevOps Pipeline

This project is a simple Java web application that demonstrates an end-to-end DevOps workflow.

The application allows a user to:

- View basic bank facilities
- Select a banking service
- Enter name
- Enter contact number
- Submit a service request
- Receive a successful confirmation page

### Available Services

1. Bank Balance Checking
2. Bank Transfer
3. File Complaint
4. UPI Setup

The project intentionally does not use login, payment gateways, a database, microservices or complicated frontend frameworks. The main objective is the DevOps pipeline.

---

## Technology Stack

- HTML
- CSS
- JSP
- Java Servlet
- Java 21
- Apache Tomcat 10.1
- Maven
- Git
- GitHub
- Jenkins
- Docker
- Kubernetes
- Minikube
- Nagios Core

The project uses Jakarta Servlet API 6.0 with provided scope.

---

## Project Structure

```text
bank-service-portal/
│
├── pom.xml
├── Dockerfile
├── deployment.yaml
├── service.yaml
├── .gitignore
├── README.md
│
└── src/
    └── main/
        ├── java/
        │   └── com/
        │       └── bank/
        │           └── BankServiceRequestServlet.java
        │
        └── webapp/
            ├── index.jsp
            └── WEB-INF/
                └── web.xml
```

---

# 1. Prerequisites

Install:

- JDK 21
- Maven
- Git
- Docker
- Kubernetes
- Minikube
- kubectl
- Jenkins
- Nagios Core

Check Java:

```bash
java -version
```

Expected:

```text
java version "21..."
```

Check Maven:

```bash
mvn -version
```

The Java version shown by Maven should be Java 21.

---

# 2. Maven Build

Open a terminal inside the project directory.

Run:

```bash
mvn clean package
```

Expected important output:

```text
BUILD SUCCESS
```

The generated WAR file will be:

```text
target/bank-service-portal.war
```

---

# 3. Run on Tomcat

Install Apache Tomcat 10.1 with Java 21.

Copy:

```text
target/bank-service-portal.war
```

to Tomcat:

```text
apache-tomcat/webapps/
```

Start Tomcat:

Linux/macOS:

```bash
./bin/startup.sh
```

Windows:

```bat
bin\startup.bat
```

Open:

```text
http://localhost:8080/
```

Because the WAR is deployed as ROOT.war by Docker, the Docker version opens directly at `/`.

---

# 4. Test the Application

On the home page:

1. Select a service.
2. Enter name.
3. Enter a 10-digit contact number.
4. Click Submit Service Request.

The Servlet processes the POST request.

Successful result:

```text
Request Submitted Successfully!
```

The confirmation page also displays the selected service, name and contact number.

---

# 5. Git and GitHub

Initialize Git:

```bash
git init
```

Set the main branch:

```bash
git branch -M main
```

Add files:

```bash
git add .
```

Commit:

```bash
git commit -m "Initial Bank Service Portal project"
```

Create a GitHub repository named:

```text
bank-service-portal
```

Add the GitHub remote:

```bash
git remote add origin https://github.com/YOUR_USERNAME/bank-service-portal.git
```

Push:

```bash
git push -u origin main
```

Verify that GitHub contains:

- pom.xml
- Dockerfile
- deployment.yaml
- service.yaml
- .gitignore
- README.md
- src/

---

# 6. Jenkins

## Job name

Create a Jenkins job:

```text
Bank-Service-Portal-CI
```

A simple Freestyle Project is sufficient for the college demonstration.

## Source Code Management

Select:

```text
Git
```

Repository URL:

```text
https://github.com/YOUR_USERNAME/bank-service-portal.git
```

Branch:

```text
*/main
```

## Build

Use Maven.

Build command:

```text
clean package
```

If using an Execute Shell/Command build step instead, use:

```bash
mvn clean package
```

Jenkins should obtain the source from GitHub and run Maven.

Expected console result:

```text
BUILD SUCCESS
Finished: SUCCESS
```

This demonstrates:

```text
GitHub → Jenkins → Maven
```

---

# 7. Docker

First build the WAR:

```bash
mvn clean package
```

Build the Docker image:

```bash
docker build -t bank-service-portal:1.1 .
```

Check the image:

```bash
docker images
```

Run the container:

```bash
docker run -d --name bank-app -p 8081:8080 bank-service-portal:1.1
```

Check:

```bash
docker ps
```

Expected:

```text
bank-app
```

Open:

```text
http://localhost:8081/
```

The application should be visible.

To stop:

```bash
docker stop bank-app
```

To remove:

```bash
docker rm bank-app
```

This demonstrates:

```text
Maven WAR → Docker Image → Docker Container
```

---

# 8. Kubernetes with Minikube

Start Minikube:

```bash
minikube start
```

Make the locally built Docker image available to Minikube:

```bash
minikube image load bank-service-portal:1.1
```

Verify:

```bash
minikube image ls | grep bank-service-portal
```

Apply the Deployment:

```bash
kubectl apply -f deployment.yaml
```

Apply the Service:

```bash
kubectl apply -f service.yaml
```

Check deployments:

```bash
kubectl get deployments
```

Check pods:

```bash
kubectl get pods
```

Expected:

```text
2/2 Running
```

or two separate pods showing:

```text
Running
```

Check service:

```bash
kubectl get services
```

Expected NodePort:

```text
8080:30080/TCP
```

---

# 9. Open the Kubernetes Application

Use:

```bash
minikube service bank-service --url
```

This prints the URL provided by your Minikube setup.

Open that URL in a browser.

Alternative:

```bash
minikube service bank-service
```

The browser should display:

```text
Bank Service Portal
```

Test the service request form again.

---

# 10. Kubernetes Verification Commands

Deployment:

```bash
kubectl get deployment bank
```

Pods:

```bash
kubectl get pods -l app=bank
```

Service:

```bash
kubectl get service bank-service
```

Detailed information:

```bash
kubectl describe deployment bank
```

Logs:

```bash
kubectl logs -l app=bank
```

Expected architecture:

```text
bank-service
       |
       +---- Pod 1
       |
       +---- Pod 2
```

---

# 11. Nagios Monitoring

Nagios Core uses the `check_http` plugin to check whether an HTTP service responds.

First locate the plugin:

```bash
find /usr/local/nagios/libexec -name check_http
```

Usually it is:

```text
/usr/local/nagios/libexec/check_http
```

Test manually.

If the Kubernetes NodePort is reachable at localhost:

```bash
/usr/local/nagios/libexec/check_http -H 127.0.0.1 -p 30080
```

Expected:

```text
HTTP OK
```

If your Minikube driver does not expose the NodePort directly on localhost, use a port-forward for the monitoring demonstration:

```bash
kubectl port-forward service/bank-service 8080:8080
```

Keep that terminal running.

Then test:

```bash
/usr/local/nagios/libexec/check_http -H 127.0.0.1 -p 8080
```

Expected:

```text
HTTP OK
```

---

# 12. Nagios Configuration

The exact Nagios file locations can vary by installation. In the standard source installation requested in this practical, the main configuration is commonly:

```text
/usr/local/nagios/etc/nagios.cfg
```

Create a configuration file:

```text
/usr/local/nagios/etc/objects/bank.cfg
```

Use:

```text
define host {
    use                     generic-host
    host_name               bank-server
    alias                   Bank Service Portal Host
    address                 127.0.0.1
}

define service {
    use                     generic-service
    host_name               bank-server
    service_description     Bank Service Portal
    check_command           check_http!-p 8080 -u /
}
```

Make sure `nagios.cfg` includes the custom configuration:

```text
cfg_file=/usr/local/nagios/etc/objects/bank.cfg
```

If your Nagios installation already has an `objects` directory include rule, use that instead of adding a duplicate rule.

---

# 13. Validate Nagios Configuration

Run:

```bash
nagios -v /usr/local/nagios/etc/nagios.cfg
```

The important result is:

```text
Total Warnings: 0
Total Errors:   0
```

If validation succeeds, restart Nagios:

```bash
systemctl restart nagios
```

or, depending on installation:

```bash
service nagios restart
```

Open the Nagios web interface.

The service should appear as:

```text
Bank Service Portal
```

with status:

```text
OK
```

The description shown in Nagios is:

```text
Bank Service Portal
```

The monitored application itself is the Bank Service Portal.

---

# 14. Complete DevOps Flow

The practical demonstrates:

```text
                 GitHub
                    |
                    v
                 Jenkins
                    |
                    v
                  Maven
                    |
                    v
              WAR Application
                    |
                    v
                 Docker
                    |
                    v
               Kubernetes
                    |
                    v
       Online Banking Application
                    |
                    v
                 Nagios
                 Monitoring
```

Short form:

```text
GitHub → Jenkins → Maven → Docker → Kubernetes → Application → Nagios
```

---

# 15. Demonstration Checklist

Before the practical demonstration, verify:

```text
[ ] Application opens in browser
[ ] Banking services are visible
[ ] Service request form works
[ ] Confirmation page appears
[ ] GitHub repository is visible
[ ] Jenkins Bank-Service-Portal-CI job exists
[ ] Jenkins gets code from GitHub
[ ] Jenkins BUILD SUCCESS is visible
[ ] Maven WAR exists
[ ] Docker image exists
[ ] Docker container runs
[ ] Minikube is running
[ ] Kubernetes deployment exists
[ ] Two pods are Running
[ ] NodePort service exists
[ ] Application opens through Kubernetes
[ ] Nagios is running
[ ] Nagios configuration validation shows 0 warnings
[ ] Nagios shows Bank Service Portal as OK
```

---

# 16. Common Problems

## Problem: mvn is not recognized

Check:

```bash
mvn -version
```

Install Maven and add Maven's `bin` directory to PATH.

Also check:

```bash
java -version
```

Java must be 21.

---

## Problem: WAR file is not generated

Run:

```bash
mvn clean package
```

Look for:

```text
BUILD SUCCESS
```

Then check:

```text
target/bank-service-portal.war
```

---

## Problem: Docker says target WAR does not exist

Run Maven first:

```bash
mvn clean package
```

Then:

```bash
docker build -t bank-service-portal:1.1 .
```

---

## Problem: Docker container exits

Check:

```bash
docker ps -a
```

Then:

```bash
docker logs bank-app
```

The most common cause is an incorrect WAR or Tomcat configuration.

---

## Problem: Kubernetes shows ImagePullBackOff

Because this project uses a local Minikube image, load the image:

```bash
minikube image load bank-service-portal:1.1
```

Then verify:

```bash
minikube image ls | grep bank-service-portal
```

The Deployment intentionally uses:

```yaml
imagePullPolicy: Never
```

---

## Problem: Kubernetes has fewer than 2 running pods

Check:

```bash
kubectl get pods
```

Then:

```bash
kubectl describe pods
```

and:

```bash
kubectl get events --sort-by=.lastTimestamp
```

---

## Problem: NodePort does not open

Check:

```bash
kubectl get service bank-service
```

Then use:

```bash
minikube service bank-service --url
```

---

## Problem: Nagios says CRITICAL

First test HTTP manually:

```bash
/usr/local/nagios/libexec/check_http -H 127.0.0.1 -p 8080
```

If using NodePort:

```bash
/usr/local/nagios/libexec/check_http -H 127.0.0.1 -p 30080
```

Make sure the Kubernetes application is actually reachable from the Nagios machine.

---

# 17. Viva Explanation

## GitHub

GitHub is used to store and manage the project's source code.

It also provides version control through Git and allows Jenkins to obtain the latest source code.

Simple answer:

> GitHub stores our source code and provides version control and collaboration.

---

## Jenkins

Jenkins is used for continuous integration and build automation.

It automatically gets the project from GitHub and runs Maven.

Simple answer:

> Jenkins automates the build process whenever the source code is changed.

Pipeline part:

```text
GitHub → Jenkins → Maven
```

---

## Maven

Maven is the Java build tool.

It downloads dependencies, compiles Java code and packages the web application as a WAR file.

Command:

```bash
mvn clean package
```

Output:

```text
target/bank-service-portal.war
```

Simple answer:

> Maven builds the Java project and creates the deployable WAR file.

---

## Docker

Docker packages the application and Tomcat server into a container.

The same container can be run consistently on different systems.

Simple answer:

> Docker containerizes the application so it can run in a consistent environment.

---

## Kubernetes

Kubernetes manages containers.

In this project it runs two replicas of the application and exposes them using a NodePort Service.

Simple answer:

> Kubernetes deploys and manages our Docker containers and provides scalability and service access.

---

## Nagios

Nagios is the monitoring tool.

It checks whether the web application is responding over HTTP.

Simple answer:

> Nagios monitors the application and reports whether the HTTP service is OK or has a problem.

---

# 18. What is an End-to-End DevOps Pipeline?

**Answer:**

> An end-to-end DevOps pipeline automates the software lifecycle from source code management through build, containerization, deployment and monitoring.

For this project:

```text
GitHub
   ↓
Jenkins
   ↓
Maven
   ↓
Docker
   ↓
Kubernetes
   ↓
Bank Service Portal
   ↓
Nagios
```

---

# 19. One-Minute Viva Explanation

> Our project is an Bank Service Portal developed using Java Servlet, JSP and HTML/CSS. A user can select a banking service, enter their name and contact number, and submit a request. The Servlet processes the request and displays a confirmation page.
>
> We use GitHub for source-code management. Jenkins obtains the code and performs the Maven build. Maven creates the WAR file. Docker packages the WAR with Tomcat into a container. Kubernetes deploys two replicas of the Docker application. Finally, Nagios monitors the application's HTTP availability.
>
> Therefore, the complete flow is GitHub, Jenkins, Maven, Docker, Kubernetes, running application and Nagios monitoring. This demonstrates an end-to-end DevOps pipeline.

---

## 20. Important Naming Note

The practical statement uses two names:

- **Bank Service Portal / Bank Service Portal** — the actual application.
- **Bank / bank-service-portal** — the required repository, artifact, image and Kubernetes names.

This project keeps the required technical names exactly as specified so your commands and expected screenshots match the practical sheet, while the user-facing application is clearly an **Bank Service Portal**.
