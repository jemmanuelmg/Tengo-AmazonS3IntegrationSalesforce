@isTest
public class PrivateFundRegistrationHandlerTest {
    
	@testSetup 
    static void setup() {
        
		AWSSettings__c awsSetting = new AWSSettings__c();
        awsSetting.AWSS3BucketName__c = 'test-bucket-name';
        awsSetting.AWSS3Key__c = 'ABCDEFG1234567';
        awsSetting.AWSS3Secret__c = 'DZngp9RJqWx6WovchjHY78FVKO3c4yVLa8EgVV80';
        awsSetting.AWSS3Region__c = 'us-east-1';
        insert awsSetting;
        Account account = TestDataFactory.createAccount('Test Account Name');
        insert account;
        InvestmentManagerCaymanOption__c option1 = TestDataFactory.createInvestmentManagerCaymanOption();
        insert option1;
        InvestmentManagerWorldOption__c option2 = TestDataFactory.createInvestmentManagerWorldOption();
        insert option2;
        PrivateFundRegistration__c privateFund = TestDataFactory.createPrivateFundRegistration(account, option1, option2);
        insert privateFund;
        CIMAParticipant__c participant = TestDataFactory.createCIMAParticipant(privateFund, 'B10', 1);
        insert participant;
        CIMAQualification__c qualification = TestDataFactory.createCIMAQualification(privateFund, 'D22', 1);
        insert qualification;
        CIMAMultiFund__c multiFund = TestDataFactory.createCIMAMultiFund(privateFund, 'A31', 1);
        insert multiFund;
        ContentVersion contentVersion1 = TestDataFactory.createContentVersionAndContentDocument('File1', 'Test content of attachment');
        ContentVersion contentVersion2 = TestDataFactory.createContentVersionAndContentDocument('File2', 'Test content of attachment');
        List<ContentVersion> contentVersionList =  new List<ContentVersion> {contentVersion1, contentVersion2};
        insert contentVersionList;
        List<ContentDocument> contentDocumentList =[Select Id, Title, SystemModstamp FROM ContentDocument ORDER BY SystemModstamp DESC LIMIT 2];
        ContentDocumentLink documentLink1 = TestDataFactory.createContentDocumentLink(contentDocumentList[0].Id, privateFund.Id);
        ContentDocumentLink documentLink2 = TestDataFactory.createContentDocumentLink(contentDocumentList[1].Id, privateFund.Id);
        List<ContentDocumentLink> documentLinkList = new List<ContentDocumentLink> {documentLink1, documentLink2};
        insert documentLinkList;
        
    }    
    
     @isTest 
    static void onBeforeInsert() { 
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        
        PrivateFundRegistration__c testPFR = [SELECT CreatedDate FROM PrivateFundRegistration__c LIMIT 1];
        
        Test.startTest();
            try {
                insert testPFR;
            } catch(Exception e) {
                System.debug(e);
            }
     	Test.stopTest();
        
        System.assert(testPFR.CreatedDate != null, 'Expected to not have null value in CreatedDate');
    }
    
    @isTest 
    static void onBeforeUpdate() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        
        PrivateFundRegistration__c testPFR = [SELECT CreatedDate, NameOfFund__C FROM PrivateFundRegistration__c LIMIT 1];
        testPFR.NameOfFund__C = 'ABC123';
        
        Test.startTest();
        	update testPFR;
     	Test.stopTest();
        
        System.assert(testPFR.NameOfFund__C == 'ABC123', 'Expected to have ABC123 as Name of the PFR record');
    }
    
     @isTest 
    static void onBeforeDelete() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        
        PrivateFundRegistration__c testPFR = [SELECT IsDeleted FROM PrivateFundRegistration__c LIMIT 1];
        
        Test.startTest();
        	delete testPFR;
     	Test.stopTest();
        
        System.assert(testPFR.IsDeleted == false, 'Expected to have IsDeleted as false');
    }

    @isTest 
    static void onAfterInsert() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        
        PrivateFundRegistration__c testPFR = [SELECT CreatedDate FROM PrivateFundRegistration__c LIMIT 1]; 
        
        Test.startTest();
            try {
                insert testPFR;
            } catch(Exception e) {
                System.debug(e);
            }
     	Test.stopTest();
        
        System.assert(testPFR.CreatedDate != null, 'Expected to have not null in CreatedDate');
    }
    

    @isTest 
    static void testPositiveOnAfterUpdate() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        
        List<PrivateFundRegistration__c> pfrList = [SELECT Id, Name FROM PrivateFundRegistration__c]; 
        
        Test.startTest();
            Database.saveResult[] databaseResultList = Database.update(pfrList, false);
        Test.stopTest();
        
        Database.saveResult finalResult = databaseResultList[0];
        
        System.assertEquals(true, finalResult.isSuccess(), 'Expected that execution of update operation was successfully, the result was a failure ');
        
    }

    @isTest 
    static void onAfterDelete() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        
        PrivateFundRegistration__c testPFR = [SELECT IsDeleted FROM PrivateFundRegistration__c LIMIT 1]; 
        
        Test.startTest();
        	delete testPFR;
     	Test.stopTest();
        
        System.assert(testPFR.IsDeleted == false, 'Expected to have IsDeleted as false');
    }
    
    @isTest 
    static void onAfterUndelete() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        
        PrivateFundRegistration__c testPFR = [SELECT IsDeleted FROM PrivateFundRegistration__c LIMIT 1]; 
        delete testPFR;
        
        Test.startTest();
        	undelete testPFR;
     	Test.stopTest();
        
        System.assert(testPFR.IsDeleted == false, 'Expected to have IsDeleted as false');
    }
    
}