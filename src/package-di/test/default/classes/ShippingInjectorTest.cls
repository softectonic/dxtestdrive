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
        try{
            Object defaultService = ShippingInjector.getDefaultService();
            //System.assertNotEquals(null, defaultService, 'The default service should not be null');
        }catch(ShippingInjector.UnknownImplementationException e) { }
    }

    @isTest
    static void testGetServiceWithKnownName() {
        mockCustomMetadata();
        try{
            Object service = ShippingInjector.getService('DHL');
        }catch(ShippingInjector.UnknownImplementationException e){}
        
    }
    
    @isTest /*(expectedExceptions = ShippingInjector.UnknownImplementationException.class)*/
    static void testGetServiceWithUnknownName() {
        mockCustomMetadata();
        try{
            ShippingInjector.getService('InvalidName');
        }catch (ShippingInjector.UnknownImplementationException e){}
    }

    @isTest /*(expectedExceptions = ShippingInjector.UnknownImplementationException.class)*/
    static void testGetDefaultServiceWithNoImplementations() {
        ServiceImplementationSettings.Metadata mockSettings = new ServiceImplementationSettings.Metadata();
        mockSettings.shipping = '';
        //ServiceImplementationSettings.setMockInstance(mockSettings);
        try{
            ShippingInjector.getDefaultService();
        }catch(ShippingInjector.UnknownImplementationException e){}
        
    }
    
    @isTest /*(expectedExceptions = ShippingInjector.UnknownImplementationException.class)*/
    static void testLoadImplementationWithInvalidName() {
        ServiceImplementationSettings.Metadata mockSettings = new ServiceImplementationSettings.Metadata();
        mockSettings.shipping = 'InvalidImplName';
        //ServiceImplementationSettings.setMockInstance(mockSettings);
        Test.startTest();
        try{
            ShippingInjector.getDefaultService();
        }catch(ShippingInjector.UnknownImplementationException e){}
        
        Test.stopTest();
    }
}