# K8S cluster with EC2

Creating K8S cluster with EC2 instances

## Logs

Master

```
eval "$( tf output -raw master_ssh_command )"
tf output -json worker_ssh_command | jq -r 'first' 
```

## Refs

- The original code from [Medium post](https://medium.com/@yakuphanbilgic3/project-creating-a-kubernetes-cluster-with-terraform-on-aws-6896f78e20ea)