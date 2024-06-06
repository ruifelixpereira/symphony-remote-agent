# Notes for the remote agent deployment scenario


## 1. Target name, role name and provider name

It's worth to remark that the name of the Target must match the name of the binding role and the name of the binding role needs to match the name of the provider in the Symphony agent configuration. the same way, in the Solution, the component type needs to match the name of the binding role. The picture below ilustrates these matches.

![names](names.png)


## 2. Target selectors

When we define a Target we can define properties that can be used to filter the targets that will be selected by the Solution. In the example below, the target properties `location` and `scenario` are defined:

```json
{
    "spec": {
        "displayName": "remote-cmd",
        "properties": {
            "location": "remote-cmd",
            "scenario": "demo"
        },
        "topologies": [
            {
                "bindings": [
                    {
                        "role": "remote-cmd",
                        "provider": "providers.target.proxy",
                        "config": {
                            "name": "proxy",
                            "serverUrl": "http://localhost:8098/v1alpha2/solution/"
                        }
                    }
                ]
            }
        ]
    }
}
```

We can create an Instance of a Solution directly on this Target. This would be the Instance snippet for it where we reference the target by its name:

```json
...
    "solution": "demo-solution",
    "target": {
        "name": "remote-cmd"
    }
...
```

Or we can use a selector to reference the target. In this case, the selector is based on the `scenario` property:

```json
...
    "solution": "demo-solution",
    "target": {
        "selector": {
            "scenario": "demo"
        }
    },
...
```
