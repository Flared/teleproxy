# teleproxy

Replace a k8s deployment by a proxy to a pod in another cluster.

Teleproxy works by replacing your local deployment by a pod running `kubectl port-forward` pointing to another cluster. We use it at Flare Systems to keep our developement setup light and still be able to quickly connect our test apps to a more realistic "staging" environment.

![Deployment diagram](https://raw.githubusercontent.com/Flared/teleproxy/main/deployment_diagram.svg)

## Dependencies

- kubectl
- telepresence
- jq

## Usage

```
teleproxy <opts>
```

**Options:**
- ``--source_context``: Kubectl context for the source.
- ``--source_deployment``: Deployment to be replaced by a proxy.
- ``--source_port``: Port to listen to in the source pod.

- ``--target_context``: Kubectl context for the destination.
- ``--target_deployment|--target_pod``: Pod or deployment to redirect traffic to in the destination cluster.
- ``--target_port``: Port of the target pod where tele-proxy should redirect traffic.


**Example:**
```
./teleproxy  \
    --source_context=minikube \
    --source_deployment=app \
    --source_port=80 \
    --target_context=staging \
    --target_deployment=app \
    --target_port=80
```

## Debugging

**kubectl auth to destination cluster**: Teleproxy launches kubectl in a docker container. The teleproxy container must be able to connect to your destination cluster. Depending on your setup, it won't work out of the box. Teleproxy tries to make it easier for you by mounting some configuration files such as `~/.aws` and by forwarding some environment variables but this list is not exhaustive and may require some adjustments. Feel free to contribute to this by modifying the script's `docker_options` and by adding your required tools to the `Dockerfile`.

## Roadmap

**Swapping Statefulsets:** Teleproxy was based on an internal Flare Systems tool which supports swapping statefulsets using our fork of telepresence. You may take a look at it [here](https://github.com/flared/telepresence/tree/flare-master). We haven't added Statefulset support to teleproxy as we prefer to target upstream telepresence with this tool.
