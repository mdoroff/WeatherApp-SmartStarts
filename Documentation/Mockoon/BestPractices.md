# Best Practices

- It is recommended to include the config file everyone is using within the project repository itself, probably in something like a folder "Mockoon/" within the root
- That folder can also include a sub folder for pre build json data responses, if desired.
- Someone should work closely with the backend team to define the different API schemas, once the schema is known then routes should be created in Mockoon to match the agreed upon schema. For reference, here are the docs for Mockoon's templating system [docs](https://mockoon.com/docs/latest/templating/overview/)
- You can enable Mockoon to work over TLS but in practice there probably isn't much need as it only runs from your localhost. If you do enable TLS you may need to mess with your app transport settings as the certs used are most likely self signed and will fail without modifying app transport settings for an exception.