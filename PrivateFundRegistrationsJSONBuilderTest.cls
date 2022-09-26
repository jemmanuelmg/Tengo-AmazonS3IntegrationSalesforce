@isTest
public class PrivateFundRegistrationsJSONBuilderTest {
	
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
    static void testConvertToJSON1() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        PrivateFundRegistration__c privateFund = [SELECT
                                                  Id,
                                                  Account__r.Name,
                                                  IsDeleted,
                                                  Name,
                                                  Status__c,
                                                  CurrencyIsoCode,
                                                  CreatedDate,
                                                  CreatedById,
                                                  LastModifiedDate,
                                                  LastModifiedById,
                                                  SystemModstamp,
                                                  Account__c,
                                                  ALMCOCVResumeTitle__c,
                                                  ALMCOCVResume__c,
                                                  ALMCOCity__c,
                                                  ALMCOCountryOfBirth__c,
                                                  ALMCOCountry__c,
                                                  ALMCODateOfBirth__c,
                                                  ALMCOEmailAddress__c,
                                                  ALMCOEmployer__c,
                                                  ALMCOFacsimileNumber__c,
                                                  ALMCOFirstName__c,
                                                  ALMCOGender__c,
                                                  ALMCOLastName__c,
                                                  ALMCOMiddleName__c,
                                                  ALMCOOccupationTitle__c,
                                                  ALMCOOtherNames__c,
                                                  ALMCOPOBox__c,
                                                  ALMCOPhoneNumber__c,
                                                  ALMCOPrefix__c,
                                                  ALMCOStateProvince__c,
                                                  ALMCOStreetAddress__c,
                                                  ALMCOZipPostalCode__c,
                                                  AMLCFTServiceProviderCountry__c,
                                                  AMLCFTServiceProviderEmail__c,
                                                  AMLCFTServiceProviderName__c,
                                                  AccountingPrinciples__c,
                                                  ActualOrExpectedSizeOfInvestorBase__c,
                                                  AdministratorsConsentLetterTitle__c,
                                                  AttachAuditorsConsentLetter__c,
                                                  AttachCertOfIncorporationTitles__c,
                                                  AttachCertificateOfIncorporation_Re__c,
                                                  AttachConsFromRegAndTransfTitle__c,
                                                  AttachConsentFromNAVCalcAgenTitle__c,
                                                  AttachOfferingDocSummaryTitles__c,
                                                  AttachStructureChartTitles__c,
                                                  AttachStructureChart__c,
                                                  AttachTrustDeedDeclarationTitles__c,
                                                  AuditingPrinciples__c,
                                                  AuditorsConsentLetter__c,
                                                  BaseCurrencyOfOffering__c,
                                                  BuildingFloorSuiteB03a__c,
                                                  BuildingFloorSuiteB05a__c,
                                                  CIMAIDC06__c,
                                                  CIMAID__c,
                                                  CaymanAuditorLocalAuditSignOff__c,
                                                  CityB03d__c,
                                                  CityB05d__c,
                                                  CompaniesRegistrationCORISNumber__c,
                                                  CountryB03g__c,
                                                  CountryB05g__c,
                                                  CountryOfAdministrator__c,
                                                  CountryOfDepositary__c,
                                                  CountryOfFormation__c,
                                                  CountryOfInvestmentManager__c,
                                                  CountryOfNAVCalculationAgent__c,
                                                  CountryOfOverseasAuditor__c,
                                                  CountryOfPromoterSponsor__c,
                                                  CountryOfRegistrarAndTransferAgent__c,
                                                  DAMLCOCIMAID__c,
                                                  DAMLCOCVResumeTitle__c,
                                                  DAMLCOCVResume__c,
                                                  DAMLCOCity__c,
                                                  DAMLCOCountryOfBirth__c,
                                                  DAMLCOCountry__c,
                                                  DAMLCODateOfBirth__c,
                                                  DAMLCOEmailAddress__c,
                                                  DAMLCOEmployer__c,
                                                  DAMLCOFacsimileNumber__c,
                                                  DAMLCOFirstName__c,
                                                  DAMLCOGender__c,
                                                  DAMLCOLastName__c,
                                                  DAMLCOMiddleName__c,
                                                  DAMLCOOccupationTitle__c,
                                                  DAMLCOOtherNamesAliases__c,
                                                  DAMLCOPOBox__c,
                                                  DAMLCOPhoneNumber__c,
                                                  DAMLCOPrefix__c,
                                                  DAMLCOStateProvince__c,
                                                  DAMLCOStreetAddress__c,
                                                  DAMLCOZipPostalCode__c,
                                                  DMLROCIMAID__c,
                                                  DMLROCVResumeTitle__c,
                                                  DMLROCVResume__c,
                                                  DMLROCity__c,
                                                  DMLROCountryOfBirth__c,
                                                  DMLROCountry__c,
                                                  DMLRODateOfBirth__c,
                                                  DMLROEmailAddress__c,
                                                  DMLROEmployer__c,
                                                  DMLROFacsimileNumber__c,
                                                  DMLROFirstName__c,
                                                  DMLROGender__c,
                                                  DMLROLastName__c,
                                                  DMLROMiddleName__c,
                                                  DMLROOccupationTitle__c,
                                                  DMLROOtherNamesAliases__c,
                                                  DMLROPOBox__c,
                                                  DMLROPhoneNumber__c,
                                                  DMLROPrefix__c,
                                                  DMLROStateProvince__c,
                                                  DMLROStreetAddress__c,
                                                  DMLROZipPostalCode__c,
                                                  DateOfFormationIncorporation__c,
                                                  EmailAddressB03i__c,
                                                  EmailAddressB05i__c,
                                                  EmailAddress__c,
                                                  FYEDay__c,
                                                  FYEMonth__c,
                                                  FeePaymentsRegisteredOff__c,
                                                  FirstName__c,
                                                  FrequencyOfValuations__c,
                                                  FundProvideItsAdministrationServices__c,
                                                  GPCountry__c,
                                                  GPLegalEntityIdentifierLEI__c,
                                                  GeneralPartnerGP__c,
                                                  HasNomineeInvestors__c,
                                                  IfInCaymanNotRegisteredProvideIM__c,
                                                  IfInCaymanSelectAdministratorName__c,
                                                  IfNoProvideFreePayments__c,
                                                  IfNoProvideNameOfNAVCalcAgent__c,
                                                  IfNoProvideNameOfRegistrarAndTra__c,
                                                  IfNoProvideOngoingQueries__c,
                                                  IfNotInCaymanProvideAdministrator__c,
                                                  IfNotInCaymanProvideIM__c,
                                                  IfRegulatorIsNotOnTheListInB19__c,
                                                  IfRegulatorIsNotOnTheListInB24__c,
                                                  IfRegulatorisNotOnTheListInB09__c,
                                                  IndustryReference__c,
                                                  InitialTermDurationOfFundInYears__c,
                                                  InvestmentManagerIndependent__c,
                                                  InvestmentRestrictionsCategory__c,
                                                  InvestmentRestrictionsDetails__c,
                                                  IsTheAMLFunctionOutsourced__c,
                                                  IsTheNAVCalculationAgentIndependent__c,
                                                  IsTheRegistrarAndTransferAgent__c,
                                                  LastName__c,
                                                  LegalCounselInCayman__c,
                                                  LegalEntityIdentifierLEI__c,
                                                  LegalStructure__c,
                                                  MLROCIMAID__c,
                                                  MLROCVResumeTitle__c,
                                                  MLROCVResume__c,
                                                  MLROCity__c,
                                                  MLROCountryOfBirth__c,
                                                  MLROCountry__c,
                                                  MLRODateOfBirth__c,
                                                  MLROEmailAddress__c,
                                                  MLROEmployer__c,
                                                  MLROFacsimileNumber__c,
                                                  MLROFirstName__c,
                                                  MLROGender__c,
                                                  MLROLastName__c,
                                                  MLROMiddleName__c,
                                                  MLROOccupationTitle__c,
                                                  MLROOtherNamesAliases__c,
                                                  MLROPOBox__c,
                                                  MLROPhoneNumber__c,
                                                  MLROPrefix__c,
                                                  MLROStateProvince__c,
                                                  MLROStreetAddress__c,
                                                  MLROZipPostalCode__c,
                                                  MaximumTermDurationOfFundInYears__c,
                                                  MinimumInitialInvestmentForInvestor__c,
                                                  NAVCalculationAgentSameAdmin__c,
                                                  NameC04__c,
                                                  NameOfDepositary__c,
                                                  NameOfDistributorIfApplicable__c,
                                                  NameOfFund__c,
                                                  NameOfOverseasAuditor__c,
                                                  NameOfPromoterSponsor__c,
                                                  NameOfRegisteredOffice__c,
                                                  NameOfRegulatorForAdministratorCont__c,
                                                  NewInvestmentManagerApplicationRef__c,
                                                  OfferingDocTermsSummaryMarketingMat__c,
                                                  OngoingQueriesRegisteredOff__c,
                                                  POBoxB03c__c,
                                                  POBoxB05c__c,
                                                  PrimaryInvestmentStrategy__c,
                                                  PrimaryStockExchangeOfFund__c,
                                                  ProvinceStateB03e__c,
                                                  ProvinceStateB05e__c,
                                                  RegisterAndTransferAgentSameAdmin__c,
                                                  RequestedDateOfRegistration__c,
                                                  RiskFactors__c,
                                                  SecondaryInvestmentStrategy__c,
                                                  SingleFundMultiFund__c,
                                                  StreetNameAndNumberB03b__c,
                                                  StreetNameAndNumberB05b__c,
                                                  TelephoneNumberB03h__c,
                                                  TelephoneNumberB05h__c,
                                                  TrustDeedPartnDeclMemAndAssArt__c,
                                                  Trustee__c,
                                                  ZIPPostalCodeB03f__c,
                                                  ZIPPostalCodeB05f__c,
                                                  IfInCaymanSelectInvestmentManager__c,
                                                  IfNotInCaymanSelectNameOfRegulat__c,
                                                  NameOfRegulatorForAdministratorContB15__c,
                                                  NameOfRegulatorForNAVCalculationAg__c,
                                                  NameOfRegulatorForRegistrarAndTran__c,
                                                  PrimaryInvestmentStrategyOther__c,
                                                  SecondaryInvestmentStrategyOther__c,
                                                  IfInCaymanSelectInvestmentManager__r.Name,
                                                  IfNotInCaymanSelectNameOfRegulat__r.Name,
                                                  NameOfRegulatorForAdministratorContB15__r.Name,
                                                  NameOfRegulatorForRegistrarAndTran__r.Name,
                                                  NameOfRegulatorForNAVCalculationAg__r.Name
                                                  FROM
                                                  PrivateFundRegistration__c];
        
        Test.startTest();
        	String jsonContent = PrivateFundRegistrationsJSONBuilder.convertToJSON(privateFund);
        Test.stopTest();
        
        System.assertEquals(true, jsonContent.contains('{') && jsonContent.contains('}') && jsonContent.contains('[') && jsonContent.contains(']') && jsonContent.contains(':'), 'Expected to have a valid json string with array values');
        
    }
    
        
    @isTest
    static void testUploadAllToAmazonS3() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        PrivateFundRegistration__c privateFund = [SELECT Id, Status__c FROM PrivateFundRegistration__c LIMIT 1];
        
        Test.startTest();
        	PrivateFundRegistrationsJSONBuilder.uploadAllToAmazonS3(privateFund.Id);
        Test.stopTest();
        
        System.assertEquals('In Review', privateFund.Status__c, 'Expected to an estatus of \'In Review\'');
        
    }
    
    
    @isTest
    static void testGetListOfAttachments() {
        
        PrivateFundRegistration__c privateFund = [SELECT Id FROM PrivateFundRegistration__c LIMIT 1];
        Test.startTest();
        	List<ContentVersion> contentVersionList = PrivateFundRegistrationsJSONBuilder.getListOfAttachments(privateFund.Id);
        Test.stopTest();
        
        System.assertEquals(2, contentVersionList.size(), 'Expected to have a list with 2 Content Version objects');
        
    }
    
}