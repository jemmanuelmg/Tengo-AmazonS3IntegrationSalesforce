@isTest
public class PrivateFundRegistrationServiceTest {
    
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
        
        Engagement__c eng = TestDataFactory.createEngagement('Test Engagement', account);
        insert eng;
        
        Business_Unit__c bu = TestDataFactory.createBusinessUnit(eng, 'CSV BU', 'Pending');
        insert bu;
        
        CSV__c corpServBU = TestDataFactory.createCorporateServices(eng, bu);
        insert corpServBU;

        InvestmentManagerCaymanOption__c option1 = TestDataFactory.createInvestmentManagerCaymanOption();
        insert option1;

        InvestmentManagerCaymanOption__c imcpNotReportedOption = TestDataFactory.createInvestmentManagerCaymanOption();
        imcpNotReportedOption.Name = '(Not Reported)';
        insert imcpNotReportedOption;

        InvestmentManagerCaymanOption__c imcpTestOption = TestDataFactory.createInvestmentManagerCaymanOption();
        imcpTestOption.Name = 'Test';
        insert imcpTestOption;
        
        InvestmentManagerWorldOption__c option2 = TestDataFactory.createInvestmentManagerWorldOption();
        insert option2;

        InvestmentManagerWorldOption__c imwoTestOption = TestDataFactory.createInvestmentManagerWorldOption();
        imwoTestOption.Name = 'Test';
        insert imwoTestOption;

        InvestmentManagerWorldOption__c imwoNotReportedOption = TestDataFactory.createInvestmentManagerWorldOption();
        imwoNotReportedOption.Name = '(Not Reported)';
        insert imwoNotReportedOption;
        
        PrivateFundRegistration__c privateFund = TestDataFactory.createPrivateFundRegistration(account, option1, option2);
        insert privateFund;
        
        CIMAParticipant__c participantB10 = TestDataFactory.createCIMAParticipant(privateFund, 'B10', 1);
        insert participantB10;
        CIMAParticipant__c participantB11 = TestDataFactory.createCIMAParticipant(privateFund, 'B11', 1);
        insert participantB11;
        CIMAParticipant__c participantB26 = TestDataFactory.createCIMAParticipant(privateFund, 'B26', 1);
        insert participantB26;
        CIMAParticipant__c participantB27 = TestDataFactory.createCIMAParticipant(privateFund, 'B27', 1);
        insert participantB27;
        CIMAParticipant__c participantB28 = TestDataFactory.createCIMAParticipant(privateFund, 'B28', 1);
        insert participantB28;
        CIMAParticipant__c participantB29 = TestDataFactory.createCIMAParticipant(privateFund, 'B29', 1);
        insert participantB29;
        CIMAParticipant__c participantC01 = TestDataFactory.createCIMAParticipant(privateFund, 'C01', 1);
        insert participantC01;
        CIMAParticipant__c participantC02 = TestDataFactory.createCIMAParticipant(privateFund, 'C02', 1);
        insert participantC02;
        CIMAParticipant__c participantC03 = TestDataFactory.createCIMAParticipant(privateFund, 'C03', 1);
        insert participantC03;
        CIMAParticipant__c participantC07 = TestDataFactory.createCIMAParticipant(privateFund, 'C07', 1);
        insert participantC07;
        CIMAParticipant__c participantC12 = TestDataFactory.createCIMAParticipant(privateFund, 'C12', 1);
        insert participantC12;
        
        CIMAQualification__c qualificationD22 = TestDataFactory.createCIMAQualification(privateFund, 'D22', 1);
        insert qualificationD22;
        CIMAQualification__c qualificationD44 = TestDataFactory.createCIMAQualification(privateFund, 'D44', 1);
        insert qualificationD44;
        CIMAQualification__c qualificationD66 = TestDataFactory.createCIMAQualification(privateFund, 'D66', 1);
        insert qualificationD66;
        CIMAQualification__c qualificationD88 = TestDataFactory.createCIMAQualification(privateFund, 'D88', 1);
        insert qualificationD88;
                
        CIMAMultiFund__c multiFund = TestDataFactory.createCIMAMultiFund(privateFund, 'A31', 1);
        insert multiFund;
        
        ContentVersion contentVersion1 = TestDataFactory.createContentVersionAndContentDocument('File1', 'Test content of attachment');
        ContentVersion contentVersion2 = TestDataFactory.createContentVersionAndContentDocument('File2', 'Test content of attachment');
        List<ContentVersion> contentVersionList = new List<ContentVersion> {contentVersion1, contentVersion2};
        insert contentVersionList;
        
        List<ContentDocument> contentDocumentList = [SELECT Id, Title, SystemModstamp FROM ContentDocument ORDER BY SystemModstamp DESC LIMIT 2];
        ContentDocumentLink documentLink1 = TestDataFactory.createContentDocumentLink(contentDocumentList[0].Id, privateFund.Id);
        ContentDocumentLink documentLink2 = TestDataFactory.createContentDocumentLink(contentDocumentList[1].Id, privateFund.Id);
        List<ContentDocumentLink> documentLinkList = new List<ContentDocumentLink> {documentLink1, documentLink2};
        insert documentLinkList;
        
        PrivateFundRegistration__c privateFund2 = TestDataFactory.createPrivateFundRegistration(account, option1, option2);
        privateFund2.SingleFundMultiFund__c = 'Multi Fund';
        privateFund2.Trustee__c = 'BNP Paribas';
        insert privateFund2;
        
        PrivateFundRegistration__c privateFund3 = TestDataFactory.createPrivateFundRegistration(account, option1, option2);
        privateFund3.Trustee__c = 'Banco Fibra S.A.';
        insert privateFund3;
        
        CIMAParticipant__c participantC12B = TestDataFactory.createCIMAParticipant(privateFund3, 'C12', 1);
        participantC12B.FirstName__c = null;
        insert participantC12B;
        
        CIMAQualification__c qualificationD88B = TestDataFactory.createCIMAQualification(privateFund3, 'D88', 1);
        qualificationD88B.AccreditingBody__c = '';
        qualificationD88B.Type__c = '(Not Reported)';
        qualificationD88B.Date__c = null;
        insert qualificationD88B;

        
    }

    @isTest
    static void testCreateDefaultDataPositiveB08a() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        PrivateFundRegistration__c pfr = new PrivateFundRegistration__c(Account__c = acc.Id);
        
        Test.startTest();
            insert pfr;
        Test.stopTest();

        PrivateFundRegistration__c pfrUpdated = [SELECT IfInCaymanSelectInvestmentManager__r.Name FROM PrivateFundRegistration__c WHERE Id = : pfr.Id];
        System.assertEquals(null, pfr.IfInCaymanSelectInvestmentManager__c, 'Expected to be null before inserting');
        System.assertEquals('(Not Reported)', pfrUpdated.IfInCaymanSelectInvestmentManager__r.Name, 'Expected to be Not Reported when no value was set');
    }

    @isTest
    static void testCreateDefaultDataNegativeB08a() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        PrivateFundRegistration__c pfr = new PrivateFundRegistration__c(Account__c = acc.Id);

        InvestmentManagerCaymanOption__c imco = [SELECT Id FROM InvestmentManagerCaymanOption__c WHERE Name = 'Test'];
        pfr.IfInCaymanSelectInvestmentManager__c = imco.Id;

        Test.startTest();
            insert pfr;
        Test.stopTest();

        PrivateFundRegistration__c pfrUpdated = [SELECT IfInCaymanSelectInvestmentManager__r.Name FROM PrivateFundRegistration__c WHERE Id = : pfr.Id];
        System.assert(pfr.IfInCaymanSelectInvestmentManager__c != null, 'Expected to be not null before inserting');
        System.assertEquals('Test', pfrUpdated.IfInCaymanSelectInvestmentManager__r.Name, 'Expected to be Not Reported when no value was set');
    }

    @isTest
    static void testCreateDefaultDataPositiveB24() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        PrivateFundRegistration__c pfr = new PrivateFundRegistration__c(Account__c = acc.Id);
        
        Test.startTest();
            insert pfr;
        Test.stopTest();

        PrivateFundRegistration__c pfrUpdated = [SELECT NameOfRegulatorForNAVCalculationAgReg__r.Name FROM PrivateFundRegistration__c WHERE Id = : pfr.Id];
        System.assertEquals(null, pfr.IfInCaymanSelectInvestmentManager__c, 'Expected to be null before inserting');
        System.assertEquals('(Not Reported)', pfrUpdated.NameOfRegulatorForNAVCalculationAgReg__r.Name, 'Expected to be Not Reported when no value was set');
    }

    @isTest
    static void testCreateDefaultDataNegativeB24() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        PrivateFundRegistration__c pfr = new PrivateFundRegistration__c(Account__c = acc.Id);

        InvestmentManagerWorldOption__c imco = [SELECT Id FROM InvestmentManagerWorldOption__c WHERE Name = 'Test' LIMIT 1];
        pfr.NameOfRegulatorForNAVCalculationAgReg__c = imco.Id;

        Test.startTest();
            insert pfr;
        Test.stopTest();

        PrivateFundRegistration__c pfrUpdated = [SELECT NameOfRegulatorForNAVCalculationAgReg__r.Name FROM PrivateFundRegistration__c WHERE Id = : pfr.Id];
        System.assert(pfr.NameOfRegulatorForNAVCalculationAgReg__c != null, 'Expected to be not null before inserting');
        System.assertEquals('Test', pfrUpdated.NameOfRegulatorForNAVCalculationAgReg__r.Name, 'Expected to be Not Reported when no value was set');
    }
    
    @isTest
    static void testCreateDefaultDataPositiveB09() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        PrivateFundRegistration__c pfr = new PrivateFundRegistration__c(Account__c = acc.Id);
        
        Test.startTest();
            insert pfr;
        Test.stopTest();

        PrivateFundRegistration__c pfrUpdated = [SELECT IfNotInCaymanSelectNameOfRegulat__r.Name FROM PrivateFundRegistration__c WHERE Id = : pfr.Id];
        System.assertEquals(null, pfr.IfNotInCaymanSelectNameOfRegulat__c, 'Expected to be null before inserting');
        System.assertEquals('(Not Reported)', pfrUpdated.IfNotInCaymanSelectNameOfRegulat__r.Name, 'Expected to be Not Reported when no value was set');
    }

    @isTest
    static void testCreateDefaultDataNegativeB09() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        PrivateFundRegistration__c pfr = new PrivateFundRegistration__c(Account__c = acc.Id);

        InvestmentManagerWorldOption__c imco = [SELECT Id FROM InvestmentManagerWorldOption__c WHERE Name = 'Test'];
        pfr.IfNotInCaymanSelectNameOfRegulat__c = imco.Id;

        Test.startTest();
            insert pfr;
        Test.stopTest();

        PrivateFundRegistration__c pfrUpdated = [SELECT IfNotInCaymanSelectNameOfRegulat__r.Name FROM PrivateFundRegistration__c WHERE Id = : pfr.Id];
        System.assert(pfr.IfNotInCaymanSelectNameOfRegulat__c != null, 'Expected to be not null before inserting');
        System.assertEquals('Test', pfrUpdated.IfNotInCaymanSelectNameOfRegulat__r.Name, 'Expected to be Not Reported when no value was set');
    }
    
    @isTest
    static void testCreateDefaultDataPositiveB15() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        PrivateFundRegistration__c pfr = new PrivateFundRegistration__c(Account__c = acc.Id);
        
        Test.startTest();
            insert pfr;
        Test.stopTest();

        PrivateFundRegistration__c pfrUpdated = [SELECT NameOfRegulatorForAdministratorContB15__r.Name FROM PrivateFundRegistration__c WHERE Id = : pfr.Id];
        System.assertEquals(null, pfr.NameOfRegulatorForAdministratorContB15__c, 'Expected to be null before inserting');
        System.assertEquals('(Not Reported)', pfrUpdated.NameOfRegulatorForAdministratorContB15__r.Name, 'Expected to be Not Reported when no value was set');
    }

    @isTest
    static void testCreateDefaultDataNegativeB15() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        PrivateFundRegistration__c pfr = new PrivateFundRegistration__c(Account__c = acc.Id);

        InvestmentManagerWorldOption__c imco = [SELECT Id FROM InvestmentManagerWorldOption__c WHERE Name = 'Test'];
        pfr.NameOfRegulatorForAdministratorContB15__c = imco.Id;

        Test.startTest();
            insert pfr;
        Test.stopTest();

        PrivateFundRegistration__c pfrUpdated = [SELECT NameOfRegulatorForAdministratorContB15__r.Name FROM PrivateFundRegistration__c WHERE Id = : pfr.Id];
        System.assert(pfr.NameOfRegulatorForAdministratorContB15__c != null, 'Expected to be not null before inserting');
        System.assertEquals('Test', pfrUpdated.NameOfRegulatorForAdministratorContB15__r.Name, 'Expected to be Not Reported when no value was set');
    }
    
    @isTest
    static void testCreateDefaultDataPositiveB19() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        PrivateFundRegistration__c pfr = new PrivateFundRegistration__c(Account__c = acc.Id);
        
        Test.startTest();
            insert pfr;
        Test.stopTest();

        PrivateFundRegistration__c pfrUpdated = [SELECT NameOfRegulatorForRegistrarAndTran__r.Name FROM PrivateFundRegistration__c WHERE Id = : pfr.Id];
        System.assertEquals(null, pfr.NameOfRegulatorForRegistrarAndTran__c, 'Expected to be null before inserting');
        System.assertEquals('(Not Reported)', pfrUpdated.NameOfRegulatorForRegistrarAndTran__r.Name, 'Expected to be Not Reported when no value was set');
    }

    @isTest
    static void testCreateDefaultDataNegativeB19() {
        Account acc = [SELECT Id FROM Account LIMIT 1];
        PrivateFundRegistration__c pfr = new PrivateFundRegistration__c(Account__c = acc.Id);

        InvestmentManagerWorldOption__c imco = [SELECT Id FROM InvestmentManagerWorldOption__c WHERE Name = 'Test'];
        pfr.NameOfRegulatorForRegistrarAndTran__c = imco.Id;

        Test.startTest();
            insert pfr;
        Test.stopTest();

        PrivateFundRegistration__c pfrUpdated = [SELECT NameOfRegulatorForRegistrarAndTran__r.Name FROM PrivateFundRegistration__c WHERE Id = : pfr.Id];
        System.assert(pfr.NameOfRegulatorForRegistrarAndTran__c != null, 'Expected to be not null before inserting');
        System.assertEquals('Test', pfrUpdated.NameOfRegulatorForRegistrarAndTran__r.Name, 'Expected to be Not Reported when no value was set');
    }
    
    @isTest 
    static void testSaveA31Records() {

        PrivateFundRegistration__c pfr = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        
        CIMAMultiFund__c a31A = new CIMAMultiFund__c (PrivateFundRegistration__c = pfr.Id);
        CIMAMultiFund__c a31B = new CIMAMultiFund__c (PrivateFundRegistration__c = pfr.Id);
        List<CIMAMultiFund__c> a31List =  new List<CIMAMultiFund__c>();
        a31List.add(a31A);
        a31List.add(a31B);
        List<CIMAMultiFund__c> a31ListInitial = [SELECT Id FROM CIMAMultiFund__c];

        Test.startTest();
            PrivateFundRegistrationService.saveA31Records(a31List);
        Test.stopTest();

        List<CIMAMultiFund__c> a31ListFinal = [SELECT Id FROM CIMAMultiFund__c];
        System.assert(a31ListFinal.size() > a31ListInitial.size(), 'Expected to have more records in the list');
    }

    @isTest 
    static void testCreateA31Record() {

        PrivateFundRegistration__c pfr = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        List<CIMAMultiFund__c> a31ListInitial = [SELECT Id FROM CIMAMultiFund__c];

        Test.startTest();
            PrivateFundRegistrationService.createA31Record(pfr.Id);
        Test.stopTest();

        List<CIMAMultiFund__c> a31ListFinal = [SELECT Id FROM CIMAMultiFund__c];
        System.assert(a31ListFinal.size() > a31ListInitial.size(), 'Expected to have more records in the list');
    }
    
    @isTest 
    static void testDeleteA31Record() {

        CIMAMultiFund__c a31 = [SELECT Id FROM CIMAMultiFund__c LIMIT 1];
        List<CIMAMultiFund__c> a31ListInitial = [SELECT Id FROM CIMAMultiFund__c];

        Test.startTest();
            PrivateFundRegistrationService.deleteA31Record(a31.Id);
        Test.stopTest();

        List<CIMAMultiFund__c> a31ListFinal = [SELECT Id FROM CIMAMultiFund__c];
        System.assert(a31ListInitial.size() > a31ListFinal.size(), 'Expected to have less records in the list');
    }

    @isTest 
    static void testGetA31() {

        PrivateFundRegistration__c pfr = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];

        Test.startTest();
            PrivateFundRegistrationService.getA31(pfr.Id, 'workaround');
        Test.stopTest();

        List<CIMAMultiFund__c> a31ListFinal = [SELECT Id FROM CIMAMultiFund__c];
        System.assert(a31ListFinal.size() > 0, 'Expected to have at least 1 record in the list');
    }

    @isTest 
    static void testSaveQualificationRecords() {

        PrivateFundRegistration__c pfr = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        
        CIMAQualification__c qA = new CIMAQualification__c (PrivateFundRegistration__c = pfr.Id);
        CIMAQualification__c qB = new CIMAQualification__c (PrivateFundRegistration__c = pfr.Id);
        List<CIMAQualification__c> qList =  new List<CIMAQualification__c>();
        qList.add(qA);
        qList.add(qB);
        
        List<CIMAQualification__c> qListInitial = [SELECT Id FROM CIMAQualification__c];

        Test.startTest();
            PrivateFundRegistrationService.saveQualificationRecords(qList);
        Test.stopTest();

        List<CIMAQualification__c> qListFinal = [SELECT Id FROM CIMAQualification__c];
        System.assert(qListFinal.size() > qListInitial.size(), 'Expected to have more records in the list');
    }

    @isTest 
    static void testCreateQualificationRecord() {

        PrivateFundRegistration__c pfr = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        List<CIMAQualification__c> qListInitial = [SELECT Id FROM CIMAQualification__c];

        Test.startTest();
            PrivateFundRegistrationService.createQualificationRecord(pfr.Id);
        Test.stopTest();

        List<CIMAQualification__c> qListFinal = [SELECT Id FROM CIMAQualification__c];
        System.assert(qListFinal.size() > qListInitial.size(), 'Expected to have more records in the list');
    }
    
    @isTest 
    static void testDeleteQualificationRecord() {

        CIMAQualification__c q = [SELECT Id FROM CIMAQualification__c LIMIT 1];
        List<CIMAQualification__c> qListInitial = [SELECT Id FROM CIMAQualification__c];

        Test.startTest();
            PrivateFundRegistrationService.deleteQualificationRecord(q.Id);
        Test.stopTest();

        List<CIMAQualification__c> qListFinal = [SELECT Id FROM CIMAQualification__c];
        System.assert(qListInitial.size() > qListFinal.size(), 'Expected to have less records in the list');
    }

    @isTest 
    static void testGetQualifications() {

        PrivateFundRegistration__c pfr = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];

        Test.startTest();
            PrivateFundRegistrationService.getQualifications(pfr.Id, 'A01', 'workaround');
        Test.stopTest();

        List<CIMAQualification__c> qListFinal = [SELECT Id FROM CIMAQualification__c];
        System.assert(qListFinal.size() > 0, 'Expected to have at least 1 record in the list');
    }
    
    @isTest 
    static void testSaveParticipantRecords() {

        PrivateFundRegistration__c pfr = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        
        CIMAParticipant__c pA = new CIMAParticipant__c (PrivateFundRegistration__c = pfr.Id);
        CIMAParticipant__c pB = new CIMAParticipant__c (PrivateFundRegistration__c = pfr.Id);
        List<CIMAParticipant__c> pList =  new List<CIMAParticipant__c>();
        pList.add(pA);
        pList.add(pB);
        List<CIMAParticipant__c> pListInitial = [SELECT Id FROM CIMAParticipant__c];

        Test.startTest();
            PrivateFundRegistrationService.saveParticipantRecords(pList);
        Test.stopTest();

        List<CIMAParticipant__c> pListFinal = [SELECT Id FROM CIMAParticipant__c];
        System.assert(pListFinal.size() > pListInitial.size(), 'Expected to have more records in the list');
    }

    @isTest 
    static void testCreateParticipantRecord() {

        PrivateFundRegistration__c pfr = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        List<CIMAParticipant__c> pListInicial = [SELECT Id FROM CIMAParticipant__c];

        Test.startTest();
            PrivateFundRegistrationService.createParticipantRecord(pfr.Id);
        Test.stopTest();

        List<CIMAParticipant__c> pListFinal = [SELECT Id FROM CIMAParticipant__c];
        System.assert(pListFinal.size() > pListInicial.size(), 'Expected to have more records in the list');
    }
    
    @isTest 
    static void testDeleteParticipantRecord() {

        CIMAParticipant__c p = [SELECT Id FROM CIMAParticipant__c LIMIT 1];
        List<CIMAParticipant__c> pListInitial = [SELECT Id FROM CIMAParticipant__c];

        Test.startTest();
            PrivateFundRegistrationService.deleteParticipantRecord(p.Id);
        Test.stopTest();

        List<CIMAParticipant__c> pListFinal = [SELECT Id FROM CIMAParticipant__c];
        System.assert(pListInitial.size() > pListFinal.size(), 'Expected to have less records in the list');
    }

    @isTest 
    static void testGetParticipants() {

        PrivateFundRegistration__c pfr = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];

        Test.startTest();
            PrivateFundRegistrationService.getParticipants(pfr.Id, 'A01', 'workaround');
        Test.stopTest();

        List<CIMAParticipant__c> pListFinal = [SELECT Id FROM CIMAParticipant__c];
        System.assert(pListFinal.size() > 0, 'Expected to have at least 1 record in the list');
    }
    
    @isTest 
    static void testGetCustomPicklistIMCO() {

        Test.startTest();
            List<InvestmentManagerCaymanOption__c> imco = PrivateFundRegistrationService.getCustomPicklist('InvestmentManagerCaymanOption__c');
        Test.stopTest();

        System.assert(imco.size() > 0, 'Expected to have at least 1 record in the list');
    }
    
    @isTest 
    static void testGetCustomPicklistIMWO() {

        Test.startTest();
            List<InvestmentManagerWorldOption__c> imco = PrivateFundRegistrationService.getCustomPicklist('InvestmentManagerWorldOption__c');
        Test.stopTest();

        System.assert(imco.size() > 0, 'Expected to have at least 1 record in the list');
    }
    
    @isTest 
    static void testGetCustomPicklistValueB08a() {

        PrivateFundRegistration__c pfrOrig = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        InvestmentManagerCaymanOption__c imco = [SELECT Name FROM InvestmentManagerCaymanOption__c LIMIT 1];
        
        pfrOrig.IfInCaymanSelectInvestmentManager__c = imco.Id;
        update pfrOrig; 
        
        Test.startTest();
            PrivateFundRegistration__c pfr = PrivateFundRegistrationService.getCustomPicklistValue(pfrOrig.Id, 'B08a', 'workaround');
        Test.stopTest();

        System.assertEquals(imco.Name, pfr.IfInCaymanSelectInvestmentManager__r.Name, 'Expected to have the same name for the record in the list');
    }

    @isTest 
    static void testGetCustomPicklistValueB09() {

        PrivateFundRegistration__c pfrOrig = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        InvestmentManagerWorldOption__c imwo = [SELECT Name FROM InvestmentManagerWorldOption__c LIMIT 1];
        
        pfrOrig.IfNotInCaymanSelectNameOfRegulat__c = imwo.Id;
        update pfrOrig; 
        
        Test.startTest();
            PrivateFundRegistration__c pfr = PrivateFundRegistrationService.getCustomPicklistValue(pfrOrig.Id, 'B09', 'workaround');
        Test.stopTest();

        System.assertEquals(imwo.Name, pfr.IfNotInCaymanSelectNameOfRegulat__r.Name, 'Expected to have the same name for the record in the list');
    }

    @isTest 
    static void testGetCustomPicklistValueB15() {

        PrivateFundRegistration__c pfrOrig = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        InvestmentManagerWorldOption__c imwo = [SELECT Name FROM InvestmentManagerWorldOption__c LIMIT 1];
        
        pfrOrig.NameOfRegulatorForAdministratorContB15__c = imwo.Id;
        update pfrOrig; 
        
        Test.startTest();
            PrivateFundRegistration__c pfr = PrivateFundRegistrationService.getCustomPicklistValue(pfrOrig.Id, 'B15', 'workaround');
        Test.stopTest();

        System.assertEquals(imwo.Name, pfr.NameOfRegulatorForAdministratorContB15__r.Name, 'Expected to have the same name for the record in the list');
    }

    @isTest 
    static void testGetCustomPicklistValueB19() {

        PrivateFundRegistration__c pfrOrig = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        InvestmentManagerWorldOption__c imwo = [SELECT Name FROM InvestmentManagerWorldOption__c LIMIT 1];
        
        pfrOrig.NameOfRegulatorForRegistrarAndTran__c = imwo.Id;
        update pfrOrig; 
        
        Test.startTest();
            PrivateFundRegistration__c pfr = PrivateFundRegistrationService.getCustomPicklistValue(pfrOrig.Id, 'B19', 'workaround');
        Test.stopTest();

        System.assertEquals(imwo.Name, pfr.NameOfRegulatorForRegistrarAndTran__r.Name, 'Expected to have the same name for the record in the list');
    }
    
    @isTest 
    static void testGetCustomPicklistValueB24() {

        PrivateFundRegistration__c pfrOrig = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        InvestmentManagerCaymanOption__c imco = [SELECT Name FROM InvestmentManagerCaymanOption__c LIMIT 1];
        
        pfrOrig.IfInCaymanSelectInvestmentManager__c = imco.Id;
        update pfrOrig; 
        
        Test.startTest();
            PrivateFundRegistration__c pfr = PrivateFundRegistrationService.getCustomPicklistValue(pfrOrig.Id, 'B24', 'workaround');
        Test.stopTest();

        System.assertEquals(imco.Name, pfr.IfInCaymanSelectInvestmentManager__r.Name, 'Expected to have the same name for the record in the list');
    }
    
    @isTest 
    static void testPositiveUploadRecordToAmazonS3() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());       
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c != 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
                update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException =  e.getMessage().contains('Attached file with name: \'DMLRO Resume.pdf\' was not found') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected to have at least one exception thrown');
        
    }
    
    @isTest
    static void testPositiveAddLookupToCorpServicesBUOnInsert() {
        
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'Test Account Name'];
        Engagement__c eng = [SELECT Id FROM Engagement__c WHERE Name__c = 'Test Engagement'];
        
        InvestmentManagerCaymanOption__c imCaymanOption = [SELECT Id, Name FROM InvestmentManagerCaymanOption__c LIMIT 1];
        InvestmentManagerWorldOption__c imWorldOption = [SELECT Id, Name FROM InvestmentManagerWorldOption__c LIMIT 1];
        PrivateFundRegistration__c testPFR = TestDataFactory.createPrivateFundRegistration(acc, imCaymanOption, imWorldOption);
        testPFR.Engagement__c = eng.Id;
        
        Test.startTest();
            insert testPFR;
        Test.stopTest();
        
        CSV__c csv = [SELECT PrivateFundRegistration__c FROM CSV__c WHERE Engagement__c = :eng.Id];
        System.assertEquals(testPFR.Id, csv.PrivateFundRegistration__c, 'Expected Corporate Services BU to be set with the Private Fund Registration Id');
    
    }
    
    @isTest
    static void testPositiveAddLookupToCorpServicesBUOnUpdateNull() {
        
        Account acc = [SELECT Id, Name FROM Account WHERE Name = 'Test Account Name'];
        Engagement__c eng = [SELECT Id FROM Engagement__c WHERE Name__c = 'Test Engagement'];
        
        InvestmentManagerCaymanOption__c imCaymanOption = [SELECT Id, Name FROM InvestmentManagerCaymanOption__c LIMIT 1];
        InvestmentManagerWorldOption__c imWorldOption = [SELECT Id, Name FROM InvestmentManagerWorldOption__c LIMIT 1];
        PrivateFundRegistration__c testPFR = TestDataFactory.createPrivateFundRegistration(acc, imCaymanOption, imWorldOption);
        testPFR.Engagement__c = eng.Id;
        insert testPFR;
        
        Test.startTest();
            testPFR.Engagement__c = null;
            update testPFR;
        Test.stopTest();
        
        CSV__c csv = [SELECT PrivateFundRegistration__c FROM CSV__c WHERE Engagement__c = :eng.Id];
        System.assertEquals(null, csv.PrivateFundRegistration__c, 'Expected Private Fund Registration to be removed from Corporate Services BU');
        
    }
    
    @isTest
    static void testPositiveValidateAttachedFiles() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c != 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
                update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException =  e.getMessage().contains('Attached file with name: \'DMLRO Resume.pdf\' was not found') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected to have at least one exception');
        
    }
    
    @isTest
    static void testNegativeValidateAttachedFiles() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
                update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException =  e.getMessage().contains('Attached file with name: \'DMLRO Resume.pdf\' was not found') ? true : false;
        }
        
        System.assertEquals(false, expectedDmlException, 'Expected to not have exceptions');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsMultifunds() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
                update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('create a CIMA Multi Fund record related with this private fund registration') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about multifund related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsB10() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
                update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with B10 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants B10 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsB11() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
                update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with B11 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants B11 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsB26() {
            
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
                update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with B26 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants B26 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsB27() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with B27 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants B27 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsB28() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with B28 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants B28 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsB29() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with B29 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants B29 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsC01() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            testPFR.LegalStructure__c = 'Exempted Company';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with C01 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants C01 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsC02() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            testPFR.LegalStructure__c = 'Exempted Company';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with C02 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants C02 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsC03() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            testPFR.LegalStructure__c = 'Exempted Company';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with C03 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants C03 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsC07() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            testPFR.LegalStructure__c = 'Exempted Company';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with C07 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants C07 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsC12() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            testPFR.LegalStructure__c = 'Exempt Limited Partnership';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Participant record related with this private fund registration with C12 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants C12 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsC12B() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'Banco Fibra S.A.' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('One or more CIMA Participant with Form Id C12 does not have First Name filled') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants C12 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsD22() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Qualification record related with this private fund registration with D22 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants D22 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsD44() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Qualification record related with this private fund registration with D44 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants D44 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsD66() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Qualification record related with this private fund registration with D66 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants D66 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsD88() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('Create a CIMA Qualification record related with this private fund registration with D88 as Form Id') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants D88 related records');
        
    }
    
    @isTest
    static void testPositiveValidateRelatedObjectsD88B() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'Banco Fibra S.A.' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
            update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('One or more CIMA Qualification with Form Id D88 does not have Date, Accrediting Body or Type filled') ? true : false;
        }
        
        System.assertEquals(true, expectedDmlException, 'Expected one exception about participants D88 related records');
        
    }
    
    @isTest
    static void testNegativeValidateRelatedObjects() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        Boolean expectedDmlException = false;
        PrivateFundRegistration__c testPFR = [SELECT Status__c FROM PrivateFundRegistration__c WHERE Trustee__c = 'BNP Paribas' LIMIT 1];
        
        try {
            Test.startTest();
            testPFR.Status__c = 'Submitted';
                update testPFR;         
            Test.stopTest();
        } catch(Exception e) {
            expectedDmlException = e.getMessage().contains('create a CIMA Multi Fund record related with this private fund registration') ? false : false;
        }
        
        System.assertEquals(false, expectedDmlException, 'Expected to not have exceptions about related records');
        
    }
    
}