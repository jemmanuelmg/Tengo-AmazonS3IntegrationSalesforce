public class PrivateFundRegistrationTriggerHandler implements ITriggerHandler {

    public privateFundRegistrationTriggerHandler() { 
    }
    
    public void onBeforeInsert(List<SObject> newItems) { 
    }

    public void onBeforeUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) { 
    }
    
    public void onBeforeDelete(Map<Id, SObject> oldItems) {
    }

    public void onAfterInsert(Map<Id, SObject> newItems) {
        PrivateFundRegistrationService.addLookupToCorpServicesBU(newItems.values(), null);
    }

    public void onAfterUpdate(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        PrivateFundRegistrationService.addLookupToCorpServicesBU(newItems.values(), (Map<Id, PrivateFundRegistration__c>) oldItems);
        PrivateFundRegistrationService.validateAttachedFiles(newItems, oldItems);
        PrivateFundRegistrationService.validateRelatedObjects(newItems, oldItems);
        PrivateFundRegistrationService.uploadRecordToAmazonS3(newItems, oldItems);        
    }

    public void onAfterDelete(Map<Id, SObject> newItems) {
    }
    
    public void onAfterUnDelete(Map<Id, SObject> newItems) {
    }
    
}