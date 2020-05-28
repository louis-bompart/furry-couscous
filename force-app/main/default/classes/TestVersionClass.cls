@IsTest
private class TestVersionClass {
    // We see that calling a method is not what causing the problem.
    @IsTest
    static void test_controlMethod(){
        Test.startTest();
        
        VersionClass.controlMethod();

        Test.stopTest();
    }

    @IsTest
    static void test_versionMethod(){
        Test.startTest();
        
        VersionClass.versionMethod(); //Oh no.

        Test.stopTest();
    }

}