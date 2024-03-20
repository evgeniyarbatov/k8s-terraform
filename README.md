# K8S cluster with EC2

Creating K8S cluster with EC2 instances

## Commands

SSH:

```
eval "$( tf output -raw master_ssh )"
eval "$( tf output -raw worker_ssh )"
```

Logs:

```
eval "$( tf output -raw master_logs )"
tf output -json worker_logs | jq -r 'first' 
```

## Refs

- The original code from [Medium post](https://medium.com/@yakuphanbilgic3/project-creating-a-kubernetes-cluster-with-terraform-on-aws-6896f78e20ea)
