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


**Example:**
```
./teleproxy  \
    --source_context=minikube \
    --source_deployment=app \
    --source_port=80 \
    --target_context=staging \
    --target_pod=app-77697866c6-vsk59 \
    --target_port=80
```

## Debugging

**kubectl auth to destination cluster**: Teleproxy launches kubectl in a docker container. The teleproxy container must be able to connect to your destination cluster. Depending on your setup, it won't work out of the box. Teleproxy tries to make it easier for you by mounting some configuration files such as `~/.aws` but this list is not exhaustive and may require some adjustments.

## Roadmap

**Swapping Statefulsets:** Teleproxy was based on an internal Flare Systems tool which supports swapping statefulsets using our fork of telepresence. You may take a look at it [here](https://github.com/flared/telepresence). We haven't added Statefulset support to teleproxy as we prefer to target upstream telepresence with this tool.
