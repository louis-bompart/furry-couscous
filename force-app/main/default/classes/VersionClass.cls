global with sharing class VersionClass {
    global static void controlMethod() {
        String foo = 'someString';
    }

    global static void versionMethod() {
        Version packageVersion = System.requestVersion();
    }
}