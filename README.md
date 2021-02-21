# teleproxy

Replace a k8s deployment by a proxy to a pod in another cluster.

## Usage

```
teleproxy <opts>
```

**Options:**
- ``--source_context``: Kubectl context for the source.
- ``--source_deployment``: Deployment to be replaced by a proxy.
- ``--source_port``: Port to listen to in the source pod.

- ``--target_context``: Kubectl context for the destination.
- ``--target_pod``: Pod to redirect traffic to in the destination cluster.
- ``--target_port``: Port of the target pod where tele-proxy should redirect traffic.
