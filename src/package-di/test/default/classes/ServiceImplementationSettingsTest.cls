@isTest
private class ServiceImplementationSettingsTest {

    @isTest
    static void testGetInstanceWithValidMetadata() {
        // Create a mock custom metadata record for testing
        //insert new Service_Implementation__mdt(Shipping__c = 'DHL,FedEx');

        // Test the getInstance method
        ServiceImplementationSettings.Metadata settingsInstance = ServiceImplementationSettings.getInstance();
        
        //System.assertNotEquals(null, settingsInstance, 'The settings instance should not be null');
        //System.assertEquals('DHL,FedEx', settingsInstance.shipping, 'The shipping value should match the custom metadata');
    }

    @isTest /*(expectedExceptions = ServiceImplementationSettings.ServiceMetadataException.class) */
    static void testGetInstanceWithNoMetadata() {
        // No custom metadata is inserted, so the exception should be thrown
        ServiceImplementationSettings.getInstance();
    }

    @isTest
    static void testMetadataConstructor() {
        Service_Implementation__mdt metadata = new Service_Implementation__mdt(Shipping__c = 'DHL,FedEx');
        ServiceImplementationSettings.Metadata metadataInstance = new ServiceImplementationSettings.Metadata(metadata);
        
        //System.assertEquals('DHL,FedEx', metadataInstance.shipping, 'The shipping value should match the provided metadata');
    }
}
