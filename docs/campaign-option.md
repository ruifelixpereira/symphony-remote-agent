# Remote agent deployment scenario using a Campaign

In this scenario, application deployment is carried out using a Symphony `campaign`. 

## Generic flow

1. Define your application as a Symphony `solution` object and your deployment target as a Symphony `target` object.

2. Define your deployment topology as a Symphony `instance` object wrapped in a Symphony `catalog` object. 
    > **Note:** We use a catalog object instead of an instance object here because an instance object represents a desired state, which will trigger Symphony state reconciliation. In this case, however, we don’t want the state reconciliation to be triggered immediately. Hence, we capture the "intention of the desired state" in a catalog object. The intention will be "materialized" into an instance object only after the campaign is activated.

3. Define a Symphony `campaign` object that can execute several steps, including the `materialization` of an instance, and then drives application deployment.

4. Create an `activation` object to activate the campaign.


## Sample artifacts
You can find sample artifacts in this repository under the `remote-campaign` folder:
| Artifact | Purpose |
|--------|--------|
| [activation.json](../remote-campaign/activation.json) | Campaign activation |
| [campaign.json](../remote-campaign/campaign.json) | Campaign definition |
| [instance-catalog.json](../remote-campaign/instance-catalog.json) | Instance definition (wrapped in a catalog) |
| [solution.json](../remote-campaign/solution.json) | Solution definition |
| [target.json](../remote-campaign/target.json) | Target definition |
| [s01-deploy-objects.sh](../remote-campaign/s01-deploy-objects.sh) | Shell script that deploys Symphony objects for target, solution, instance catalog and campaign (making REST calls to the Symphony API control plane) |
| [s02-activate-campaign.sh](../remote-campaign/s02-activate-campaign.sh) | Shell script that activates the campaign (making REST calls to the Symphony API control plane) |
| [s03-validate-instance.sh](../remote-campaign/s03-validate-instance.sh) | Shell script that lists the defined instances (making REST calls to the Symphony API control plane) |

## Deployment steps

1. Create Symphony objects using the provided shell script (make sure you validate if the variable `SYMPHONY_BASE_URL` defined in the script is pointing to your Symphony API control plane):
    ```bash
    ./s01-deploy-objects.sh
    ```

2. Activate the campaign (make sure you validate if the variable `SYMPHONY_BASE_URL` defined in the script is pointing to your Symphony API control plane):
    ```bash
    ./s02-activate-campaign.sh
    ```

3. Observe the instance is created and the sample application is deployed (make sure you validate if the variable `SYMPHONY_BASE_URL` defined in the script is pointing to your Symphony API control plane):
    ```bash
    ./s03-validate-instance.sh # gets all instances

    [{"metadata":{"namespace":"default","name":"target-runtime-remote-campaign-cmd-instance"},"spec":{"solution":"target-runtime-remote-campaign-cmd-solution","target":{"name":"remote-cmd"},"generation":"1"},"status":{"provisioningStatus":{"operationId":"","status":"","error":{}},"lastModified":"0001-01-01T00:00:00Z"}}]

    cat /tmp/hello_campaign # the solution actually is just a shell command appending a line to this file

    2024.06.06-12:05:34 Campaign
    ...
    ```
