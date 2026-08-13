What happens after terraform apply?

Terraform will:

Install the kube-prometheus-stack Helm chart.
Helm will create:
Prometheus
Grafana
Alertmanager
Prometheus Operator
kube-state-metrics
node-exporter
Prometheus will start collecting cluster metrics.
Grafana will be ready to display dashboards.
In the next step, we'll expose Grafana and Prometheus through your existing ALB using grafana-ingress.tf and prometheus-ingress.tf.



























Difference Between Monitoring and Logging

Suppose your API is failing.

Prometheus tells you
CPU = 90%

Memory = 70%

HTTP 500 = 250

Latency = 5 sec

It tells you there is a problem.

But it doesn't tell you why.

Logs tell you
Database connection timeout

↓

SQLException

↓

NullPointerException

↓

Kafka timeout

Now you know the reason.

Logging Architecture
Application Pods

        │

stdout / stderr

        │

        ▼

Promtail

        │

Reads logs from every node

        │

        ▼

Loki

        │

Stores logs

        │

        ▼

Grafana

        │

Search Logs
Why Promtail?

Imagine you have

20 Pods

Each pod generates logs.

Example

api-gateway

↓

1000 logs/minute

workspace

↓

800 logs/minute

account

↓

500 logs/minute

Someone has to collect them.

That is

Promtail
Promtail

Promtail runs as a

DaemonSet

One Pod

per

Node.

Example

Node 1

↓

Promtail

↓

Reads logs

--------------------

Node 2

↓

Promtail

↓

Reads logs
How does it read logs?

Every container writes logs

stdout

stderr

Kubernetes stores them

/var/log/pods

or

/var/log/containers

Promtail continuously watches

those folders.

Loki

Promtail doesn't store logs.

It sends them to

Loki

Think of Loki as

Prometheus

↓

for logs

Instead of storing

CPU

Memory

it stores

Application Logs
Grafana

Grafana connects to

Prometheus

+

Loki

Now one dashboard can show

CPU

Memory

AND

Logs
Complete Flow
Application

↓

stdout

↓

Promtail

↓

Loki

↓

Grafana
Example

Suppose

/api/login

returns

500

Grafana dashboard

shows

HTTP 500 increased

Click

Explore

↓

Loki

Immediately see

NullPointerException

↓

JwtService

↓

Token expired

Problem solved.

Why Loki?

Interview Question ⭐⭐⭐⭐⭐

Why Loki instead of Elasticsearch?

Good answer

Loki stores only log metadata (labels) in its index, while the log content is stored separately. This makes it much lighter, cheaper, and easier to operate than Elasticsearch. Since we already use Grafana, Loki integrates naturally with our monitoring stack.
















Flow
terraform apply
        │
        ▼
Helm installs kube-prometheus-stack
        │
        ▼
Grafana starts
        │
        ▼
Reads dashboards section in values.yaml
        │
        ▼
Downloads dashboards from Grafana.com
        │
        ▼
Creates dashboards automatically
        │
        ▼
Ready to use
After deployment

Open:

https://grafana.snapcart.dev

You'll automatically see dashboards for:

Kubernetes Cluster
Node Exporter
Spring Boot
JVM
ArgoCD
Jenkins

without importing anything manually.

This is the approach I'd recommend for your project because it keeps the Terraform code simple while still provisioning dashboards automatically. If later you create custom dashboards, then you can switch to the ConfigMap/JSON approach for version-controlling your own dashboard definitions.