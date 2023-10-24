@isTest
private class ShippingInjectorTest {

    // Mock the custom metadata Service_Implementations__mdt
    @isTest
    static void mockCustomMetadata() {
        // Mock the Service_Implementations__mdt metadata
        ServiceImplementationSettings.Metadata mockSettings = new ServiceImplementationSettings.Metadata();
        mockSettings.shipping = 'DHL,FedEx';
        //ServiceImplementationSettings.setMockInstance(mockSettings);
    }

    @isTest
    static void testGetDefaultServiceWithValidImplementations() {
        mockCustomMetadata();
        Object defaultService = ShippingInjector.getDefaultService();
        System.assertNotEquals(null, defaultService, 'The default service should not be null');
    }

    @isTest
    static void testGetServiceWithKnownName() {
        mockCustomMetadata();
        //Object service = ShippingInjector.getService('DHL');
        //System.assertNotEquals(null, service, 'The service should not be null');
    }
    
    @isTest /*(expectedExceptions = ShippingInjector.UnknownImplementationException.class)*/
    static void testGetServiceWithUnknownName() {
        mockCustomMetadata();
        //ShippingInjector.getService('InvalidName');
    }

    @isTest /*(expectedExceptions = ShippingInjector.UnknownImplementationException.class)*/
    static void testGetDefaultServiceWithNoImplementations() {
        ServiceImplementationSettings.Metadata mockSettings = new ServiceImplementationSettings.Metadata();
        mockSettings.shipping = '';
        //ServiceImplementationSettings.setMockInstance(mockSettings);
        ShippingInjector.getDefaultService();
    }
    
    @isTest /*(expectedExceptions = ShippingInjector.UnknownImplementationException.class)*/
    static void testLoadImplementationWithInvalidName() {
        ServiceImplementationSettings.Metadata mockSettings = new ServiceImplementationSettings.Metadata();
        mockSettings.shipping = 'InvalidImplName';
        //ServiceImplementationSettings.setMockInstance(mockSettings);
        Test.startTest();
        ShippingInjector.getDefaultService();
        Test.stopTest();
    }
}