# Environment

- `sfdx-cli/7.58.2 win32-x64 node-v12.16.3`
- API 48

# What's going on?

When trying to create a **managed** packaged version with Second Generation Packaging (2GP) with this class:
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

# What's the expected behavior?

We expect the managed package version to be created without any errors while using 2GP.

# Notes
1: This occurs outside of Apex test calls. We tested calling the method through a RemoteAction in a VisualForce Page, same stuff. But let's keep it simple for the example sake.