/**
 * Stub Apex Controller enabling runtime DI for its implementaiton via another package
 **/
public with sharing class ShippingController {

    @AuraEnabled
    public static String getTrackingNumber(String serviceName) { 
        // Delegate to runtime class implementation defined in the Custom Metadata from another package
        return ((IShippingService) ShippingInjector.getService(serviceName)).generateTrackingNumber();
    }
}