# Remote agent deployment scenario using an Instance

In this scenario, application deployment is carried out using a typical Symphony `target`, `solution` and `instance` combination. 

## Generic flow

1. Define your application as a Symphony `solution` object and your deployment target as a Symphony `target` object.

1. Define your deployment topology as a Symphony `instance` and create the object to trigger the reconciliation and deployment of the application.


## Sample artifacts
You can find sample artifacts in this repository under the `remote-target` folder:
| Artifact | Purpose |
|--------|--------|
| [instance.json](../remote-target/instance.json) | Instance definition (wrapped in a catalog) |
| [solution.json](../remote-target/solution.json) | Solution definition |
| [target.json](../remote-target/target.json) | Target definition |
| [s01-deploy-objects.sh](../remote-target/s01-deploy-objects.sh) | Shell script that deploys Symphony objects for target, solution, instance catalog and campaign (making REST calls to the Symphony API control plane) |
| [s02-validate-instance.sh](../remote-target/s02-validate-instance.sh) | Shell script that lists the defined instances (making REST calls to the Symphony API control plane) |


## Deployment steps

1. Edit Symphony target object in `target.json` and change `<YOUR REMOTE VM IP>` to the IP address of your remote VM running the Symphony agent.

1. Create Symphony objects using the provided shell script (make sure you validate if the variable `SYMPHONY_BASE_URL` defined in the script is pointing to your Symphony API control plane):
    ```bash
    ./s01-deploy-objects.sh
    ```

1. Observe the instance is created and the sample application is deployed (make sure you validate if the variable `SYMPHONY_BASE_URL` defined in the script is pointing to your Symphony API control plane):
    ```bash
    ./s02-validate-instance.sh # gets all instances

    [{"metadata":{"namespace":"default","name":"target-runtime-remote-cmd-instance"},"spec":{"solution":"target-runtime-remote-cmd-solution","target":{"name":"remote-cmd"},"generation":"1"},"status":{"provisioningStatus":{"operationId":"","status":"","error":{}},"lastModified":"0001-01-01T00:00:00Z"}}]

    cat /tmp/hello # the solution actually is just a shell command appending a line to this file

    2024.06.06-12:05:34 Campaign
    ...
    ```
