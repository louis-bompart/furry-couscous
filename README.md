# Environment

- `sfdx-cli/7.58.2 win32-x64 node-v12.16.3`
- API 48

# What's going on?

When trying to create a **managed** package version with Second Generation Packaging (2GP) with this class while running the code-checks:
```java
global with sharing class VersionClass {
    global static void controlMethod() {
        String foo = 'someString';
    }

    global static void versionMethod() {
        Version packageVersion = System.requestVersion();
    }
}
```

the following error occur when calling the method containing `System.requestVersion();` <sup>1</sup>
```
(1) Apex Test Failure: Class.foobarbaz.VersionClass.versionMethod: line 8, column 1
  Class.foobarbaz.TestVersionClass.test_versionMethod: line 17, column 1 System.ProcedureException: Method is not supported from an unmanaged namespace
```
Such error does not occur with the First Generation Packaging.

# How to reproduce?
Two 'variables' are used in the following steps, please do changes them to fit the one that you have. They are the devhub username (devhub being the org described as such [here](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_dev2gp_before_know_orgs.htm)) and the namespace.
1. Clone this repo
2. Set yourself up with 2GP (see [Before You Create Second-Generation Managed Packages](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_dev2gp_before.htm)) 
3. Run `sfdx force:package:version:create -v yourdevhuborg@example.com -x -p YourPackageNamespace -c`.
The command will log in the console a version creation request Id starting with 08, use it for the next steps.
4. Run `sfdx force:package:version:create:report -i yourVersionCreationRequestId -v yourdevhuborg@example.com`. If the Status in the report is not Success or Error (normally the latter), please wait a bit and re-run the command.
5. Assert that you have `Method is not supported from an unmanaged namespace` as an error when checked.

# What's the expected behavior?

We expect the managed package version to be created without any errors while using 2GP.

# Notes
1: This occurs outside of Apex test calls. We tested calling the method through a RemoteAction in a VisualForce Page, same stuff. But let's keep it simple for the example sake.