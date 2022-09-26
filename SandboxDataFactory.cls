public with sharing class SandboxDataFactory {
        
    public static void performPrivateFundRegistrationSequence(String accountName) {
        
        Account account = TestDataFactory.createAccount(accountName);
        insert account;
        
        InvestmentManagerCaymanOption__c option1 = TestDataFactory.createInvestmentManagerCaymanOption();
        insert option1;
        
        InvestmentManagerWorldOption__c option2 = TestDataFactory.createInvestmentManagerWorldOption();
        insert option2;        
        
        PrivateFundRegistration__c privateFund = TestDataFactory.createPrivateFundRegistration(account, option1, option2);
        insert privateFund;
        
        CIMAParticipant__c participant1 = TestDataFactory.createCIMAParticipant(privateFund, 'B10', 1);
        CIMAParticipant__c participant2 = TestDataFactory.createCIMAParticipant(privateFund, 'B10', 2);
        CIMAParticipant__c participant13 = TestDataFactory.createCIMAParticipant(privateFund, 'B11', 1);
        CIMAParticipant__c participant3 = TestDataFactory.createCIMAParticipant(privateFund, 'B26', 1);
        CIMAParticipant__c participant4 = TestDataFactory.createCIMAParticipant(privateFund, 'B26', 2);
        CIMAParticipant__c participant5 = TestDataFactory.createCIMAParticipant(privateFund, 'B27', 1);
        CIMAParticipant__c participant6 = TestDataFactory.createCIMAParticipant(privateFund, 'B28', 1);
        CIMAParticipant__c participant7 = TestDataFactory.createCIMAParticipant(privateFund, 'B29', 1);
        CIMAParticipant__c participant10 = TestDataFactory.createCIMAParticipant(privateFund, 'B34', 1);
        CIMAParticipant__c participant11 = TestDataFactory.createCIMAParticipant(privateFund, 'C12', 1);
        CIMAParticipant__c participant12 = TestDataFactory.createCIMAParticipant(privateFund, 'C12', 2);
        CIMAParticipant__c participant14 = TestDataFactory.createCIMAParticipant(privateFund, 'C07', 1);
        CIMAParticipant__c participant15 = TestDataFactory.createCIMAParticipant(privateFund, 'C07', 2);
        CIMAParticipant__c participant16 = TestDataFactory.createCIMAParticipant(privateFund, 'C07', 3);
        CIMAParticipant__c participant17 = TestDataFactory.createCIMAParticipant(privateFund, 'C01', 1);
        CIMAParticipant__c participant18 = TestDataFactory.createCIMAParticipant(privateFund, 'C02', 1);
        CIMAParticipant__c participant19 = TestDataFactory.createCIMAParticipant(privateFund, 'C02', 2);
        CIMAParticipant__c participant20 = TestDataFactory.createCIMAParticipant(privateFund, 'C03', 1);
        CIMAParticipant__c participant21 = TestDataFactory.createCIMAParticipant(privateFund, 'C03', 2);
        CIMAParticipant__c participant22 = TestDataFactory.createCIMAParticipant(privateFund, 'C03', 3);
        List<CIMAParticipant__c> participantList = new List<CIMAParticipant__c> {participant1, participant2, participant3, participant4, participant5, participant6, participant7, participant10, participant11, participant12, participant13, participant14, participant15, participant16, participant17, participant18, participant19, participant20, participant21, participant22};
        insert participantList;
            
        CIMAQualification__c qualification1 = TestDataFactory.createCIMAQualification(privateFund, 'D22', 1);
        CIMAQualification__c qualification2 = TestDataFactory.createCIMAQualification(privateFund, 'D22', 2);
        CIMAQualification__c qualification3 = TestDataFactory.createCIMAQualification(privateFund, 'D44', 1);
        CIMAQualification__c qualification4 = TestDataFactory.createCIMAQualification(privateFund, 'D44', 2);
        CIMAQualification__c qualification5 = TestDataFactory.createCIMAQualification(privateFund, 'D66', 1);
        CIMAQualification__c qualification6 = TestDataFactory.createCIMAQualification(privateFund, 'D88', 1);
        List<CIMAQualification__c> qualificationList = new List<CIMAQualification__c> {qualification1, qualification2, qualification3, qualification4, qualification5, qualification6};
        insert qualificationList;
        
        CIMAMultiFund__c multiFund1 = TestDataFactory.createCIMAMultiFund(privateFund, 'A31', 1);
        CIMAMultiFund__c multiFund2 = TestDataFactory.createCIMAMultiFund(privateFund, 'A31', 2);
        CIMAMultiFund__c multiFund3 = TestDataFactory.createCIMAMultiFund(privateFund, 'A31', 3);
        List<CIMAMultiFund__c> multiFundList = new List<CIMAMultiFund__c> {multiFund1, multiFund2, multiFund3};
        insert multiFundList;
        
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
    
}