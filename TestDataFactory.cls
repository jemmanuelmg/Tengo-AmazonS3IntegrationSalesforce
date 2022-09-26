public class TestDataFactory {
    
    public static Account createAccount(String name) {        
        Account acc = new Account();
        acc.Name = name;
        acc.Email__c = name + 'test@dmsgovernance.com';
        acc.Phone = '(+1)(+23)2458963';
        acc.Region__c = 'Europe';
        acc.Category__c = 'Administrator';
        acc.Regulator__c = '(FSCA) Financial Sector Conduct Authority';
        acc.BillingCountry = 'Denmark';        
        return acc;
    }
        
    public static Contact createContact(String lastName, Account relatedAcc) {
        String orgId = UserInfo.getOrganizationId();
        String dateString = String.valueOf(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer randomId = Integer.valueOf(Math.rint(Math.random()*1000000));         
        String uniqueName = orgId + dateString + randomId;                  
        Contact contact = new Contact();
        contact.AccountId = relatedAcc.Id;
        contact.LastName = lastName;
        contact.Category__c = 'Administrator';
        contact.Email = uniqueName + '@test' + orgId + '.org';
        return contact;
    }

    public static User createUser(String lastName, String profileName, Boolean isSalesRep) {        
        Profile pf = [SELECT Id FROM Profile WHERE Name = :profileName];         
        String orgId = UserInfo.getOrganizationId(); 
        String dateString = String.valueOf(Datetime.now()).replace(' ','').replace(':','').replace('-','') ;
        Integer randomId = Integer.valueOf(Math.rint(Math.random()*1000000)); 
        String uniqueName = orgId + dateString + randomId; 
        User us = new User(); 
        us.LastName = lastName; 
        us.Email = uniqueName + '@test' + orgId + '.org';
        us.Username = uniqueName + '@test' + orgId + '.org'; 
        us.EmailEncodingKey = 'ISO-8859-1';
        us.Alias = uniqueName.substring(18, 23); 
        us.TimeZoneSidKey = 'America/Los_Angeles'; 
        us.LocaleSidKey = 'en_US'; 
        us.LanguageLocaleKey = 'en_US'; 
        us.ProfileId = pf.Id;
        us.BDSalesRep__c = isSalesRep;                 
        return us;
    }

    public static Opportunity createOpportunity(String name, Account relatedAcc) {        
        Id recordTypeId = Schema.SObjectType.Opportunity.getRecordTypeInfosByName().get('Active').getRecordTypeId();    
        Opportunity opp = new Opportunity();
        opp.Name = name;
        opp.AccountId = relatedAcc.Id;
        opp.StageName = 'Initial Lead';
        opp.DMS_Product__c = 'AIFMD (holder)';
        opp.CloseDate = Date.today() + 60;
        opp.LeadSource = 'Internal Referral';
        opp.RecordTypeId = recordTypeId;        
        if (Test.isRunningTest()) {
            opp.Pricebook2Id = Test.getStandardPricebookId();        
        }
        return opp;
    }

    public static Contract createContract(String status, Account relatedAcc) {
        Contract contract = new Contract();
        contract.AccountId = relatedAcc.Id;
        contract.Status = status;
        contract.StartDate = Date.today();
        contract.ContractTerm = 4;        
        return contract;
    }

    //The related user MUST be have checked the BD Sales Rep field
    public static OpportunityTeamMember createOpportunityTeamMember(String role, User relatedUser, Opportunity relatedOpp) {        
        OpportunityTeamMember otm = new OpportunityTeamMember();
        otm.TeamMemberRole = role;
        otm.UserId = relatedUser.Id;
        otm.OpportunityId = relatedOpp.Id;
        return otm;
    }

    public static Product2 createProduct(String name, String family) {
        Product2 product = new Product2();
        product.Name = name;
        product.Family = family;        
        return product;
    }
    
    public static PriceBookEntry createPriceBookEntry(Id relatedPBId, Product2 relatedProd) {
        PriceBookEntry pbe = new PriceBookEntry();
        pbe.PriceBook2Id = relatedPBId;
        pbe.Product2Id = relatedProd.Id;
        pbe.UnitPrice = 5.00;
        pbe.IsActive = true;
        return pbe;
    }
           
    public static OpportunityLineItem createOppLineItem(Opportunity relatedOpp, PriceBookEntry relatedPBE) {
        OpportunityLineItem oli = new OpportunityLineItem();
        oli.OpportunityId = relatedOpp.Id; 
        oli.PricebookEntryId = relatedPBE.Id;
        oli.Quantity = 1;
        oli.TotalPrice = 1;
        return oli;
    }
    
    public static Order createOrder(String status, Account relatedAcc, Id relatedPBId, Opportunity relatedOpp) {                                
        Order order = new Order();
        order.AccountId = relatedAcc.Id;
        order.EffectiveDate = Date.today();
        order.Status = status;
        order.Pricebook2Id = relatedPBId;
        order.OpportunityId = relatedOpp.Id;        
        return order;
    }

    public static OrderItem createOrderProduct(Order relatedOrder, PriceBookEntry relatedPBE, Product2 relatedProd) {
        OrderItem oit = new OrderItem();
        oit.OrderId = relatedOrder.Id;
        oit.UnitPrice = 1;
        oit.PricebookEntryId = relatedPBE.Id; 
        oit.Quantity = 1;
        oit.Product2Id = relatedProd.Id;        
        return oit;
    }

    public static Onboarding_Engagement__c createOnboardingEng(Engagement__c relatedEng, Opportunity relatedOpp) {
        Onboarding_Engagement__c onEng = new Onboarding_Engagement__c();
        onEng.Engagement__c = relatedEng.Id;
        onEng.Opportunity__c = relatedOpp.Id;
        return onEng;
    }
    
    public static ContentDocumentLink createContentDocumentLink(Id contentDocumentId, Id linkedEntityId) {          
        ContentDocumentLink cdl = new ContentDocumentLink();
        cdl.LinkedEntityId = linkedEntityId;
        cdl.ContentDocumentId = contentDocumentId;              
        return cdl;
    }     

    public static DocumentExecution__c createDocumentExecution(Engagement__c relatedEng, Business_Unit__c relatedBU) {            
        DocumentExecution__c docEx = new DocumentExecution__c();
        docEx.Engagement__c = relatedEng.Id;
        docEx.Business_Unit__c = relatedBU.Id;        
        return docEx;
    }
    
    public static ContentVersion createContentVersionAndContentDocument(String title, String body) {
        String name1 = 'Jeremy';
        String name2 = 'David';
        String name3 = 'Richard';
        String lastName1 = 'Peterson';
        String lastName2 = 'Anderson';
        String lastName3 = 'Baker';        
        String category1 = 'AR/Proposals';
        String category2 = 'Breaches (ManCo)';
        String category3 = 'Declarations & Deeds';        
        ContentVersion cVer = new Contentversion();
        cVer.Title = title;
        cVer.Description = body;
        cVer.VersionData = Blob.valueOf(body);
        cVer.PathOnClient ='only_for_the_eml_extension.eml';
        cVer.RecordTypeId = Schema.SObjectType.ContentVersion.getRecordTypeInfosByName().get('Email').getRecordTypeId(); 
        cVer.IsMajorVersion = true;
        cVer.Recipients_From__c = name1 + ' ' + lastName1 + '|' + 'DMS Governance!' + name1 + lastName1 + '@dmsinternal.test.com';
        cVer.Recipients_To__c = lastName3 + ', ' + name3 + '!' + name3 + lastName3 + '@dmsinternal.test.com';
        cVer.Recipients_Cc__c = name2 + ' ' + lastName2 + '|' + 'DMS Governance!' + name2 + lastName2 + '@dmsinternal.test.com';
        cVer.Comments__c = 'A test comment for the current email';
        cVer.Categories__c = category1 + ';' + category2 + ';' + category3;        
        return cVer;
    }

    public static Business_Unit__c createBusinessUnit(Engagement__c relatedEng, String name, String status) {        
        Business_Unit__c bUnit = new Business_Unit__c();
        bUnit.Status__c = status;
        bUnit.Name = name;
        bUnit.Engagement__c = relatedEng.Id;        
        return bUnit;
    }

    public static Engagement__c createEngagement(String name, Account relatedAcc) {        
        Engagement__c eng = new Engagement__c();
        eng.Name__c = name;
        eng.Account__c = relatedAcc.Id;
        return eng;
    }
    
    public static Bank__c createBank(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		Bank__c bank = new Bank__c();
        bank.Engagement__c = relatedEng.Id;
        bank.Business_unit__c = relatedBU.Id; 
        return bank;
    }
    
    public static CSV__c createCorporateServices(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		CSV__c corpServ = new CSV__c();
        corpServ.Engagement__c = relatedEng.Id;
        corpServ.Business_unit__c = relatedBU.Id; 
        return corpServ;
    }
    
	public static Distribution__c createDistribution(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		Distribution__c dist = new Distribution__c();
        dist.Engagement__c = relatedEng.Id;
        dist.Business_unit__c = relatedBU.Id; 
        return dist;
    }
    
    public static EUCS__c createEUComplianceServices(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		EUCS__c eucs = new EUCS__c();
        eucs.Engagement__c = relatedEng.Id;
        eucs.Business_unit__c = relatedBU.Id; 
        return eucs;
    }
    
    public static EUCoRS__c createEUCorporateServices(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		EUCoRS__c eucors = new EUCoRS__c();
        eucors.Engagement__c = relatedEng.Id;
        eucors.Business_unit__c = relatedBU.Id; 
        return eucors;
    }
    
    public static ESF__c createEUStructuredFinance(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		ESF__c eusf = new ESF__c();
        eusf.Engagement__c = relatedEng.Id;
        eusf.Business_unit__c = relatedBU.Id;         
        return eusf;
    }

    public static GOV__c createFundGovernance(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
        GOV__c gov = new GOV__c();
        gov.Crs_p_p__c = false;
        gov.Engagement__c = relatedEng.Id; 
        gov.Business_unit__c = relatedBU.Id; 
        gov.Aeoi_completed__c = false;
        gov.Alternates_available__c = false;        
        return gov;
    }
    
    public static CCS__c createCaymanComplianceServices(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
        CCS__c ccs = new CCS__c();
        ccs.Engagement__c = relatedEng.Id; 
        ccs.Business_unit__c = relatedBU.Id;        
        return ccs;
    }
    
    public static ITC__c createInternationalTaxCompliance(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
        ITC__c itc = new ITC__c();
        itc.Engagement__c = relatedEng.Id;
        itc.Business_unit__c = relatedBU.Id;       
        return itc;
    }
    
    public static Liquidation__c createLiquidation(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		Liquidation__c liq = new Liquidation__c();
        liq.Engagement__c = relatedEng.Id;
        liq.Business_unit__c = relatedBU.Id;
        return liq;
    }

    public static MAN__c createManco(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		MAN__c manco = new MAN__c();
        manco.Engagement__c = relatedEng.Id;
        manco.Business_unit__c = relatedBU.Id;
        return manco;
    }
    
    public static MA__c createMarketAccess(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		MA__c ma = new MA__c();
        ma.Engagement__c = relatedEng.Id;
        ma.Business_unit__c = relatedBU.Id;
        return ma;
    }
    
    public static RMS__c createRiskManagement(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		RMS__c rm = new RMS__c();
        rm.Engagement__c = relatedEng.Id;
        rm.Business_unit__c = relatedBU.Id;
        return rm;
    }
    
    public static STF__c createStructuredFinance(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		STF__c sf = new STF__c();
        sf.Engagement__c = relatedEng.Id;
        sf.Business_unit__c = relatedBU.Id;
        return sf;
    }
    
    public static TRU__c createTrust(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		TRU__c trust = new TRU__c();
        trust.Engagement__c = relatedEng.Id;
        trust.Business_unit__c = relatedBU.Id;
        return trust;
    }
    
    public static ACD__c createUKACD(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		ACD__c acd = new ACD__c();
        acd.Engagement__c = relatedEng.Id;
        acd.Business_unit__c = relatedBU.Id;
        return acd;
    }
    
    public static USCS__c createUSComplianceServices(Engagement__c relatedEng, Business_Unit__c relatedBU) {        
		USCS__c uscs = new USCS__c();
        uscs.Engagement__c = relatedEng.Id;
        uscs.Business_unit__c = relatedBU.Id;
        return uscs;
    }

    public static Participant__c createParticipant(Account relatedAcc, Contact relatedCont, Engagement__c relatedEng, String role) {        
        Participant__c part = new Participant__c();
        part.Engagement__c = relatedEng.Id;
        part.Account__c = (relatedAcc != null ? relatedAcc.Id : null);
        part.Contact__c = (relatedCont != null ? relatedCont.Id : null);                 
        part.Role__c = role;
        return part;
    }

    public static Order_Engagement__c createOrderEngagement(String name, Order relatedOrd) {
        Order_Engagement__c ordEng = new Order_Engagement__c();
        ordEng.Order__c = relatedOrd.Id;
        ordEng.Name__c = name;
        return ordEng;
    }

    public static FATCA_Reportable_Jurisdiction__c createFATCAReportableJurisdiction() {         
        FATCA_Reportable_Jurisdiction__c frj = new FATCA_Reportable_Jurisdiction__c();
        frj.Jurisdiction__c = 'Bermuda'; 
        frj.Due_Date__c = Date.today();
        frj.Reportable_Type__c = 'CRS';        
        return frj;
    }    
    
    public static FATCA_Reportable_Jurisdiction_Status__c createFATCAReportableJurisdictionStatus(FATCA_Reportable_Jurisdiction__c relatedFrj, Engagement__c relatedEng) {        
        FATCA_Reportable_Jurisdiction_Status__c frjs = new FATCA_Reportable_Jurisdiction_Status__c();
        frjs.Engagement__c = relatedEng.Id;
        frjs.FATCA_Reportable_Jurisdiction__c = relatedFrj.Id;
        return frjs;
    }

    public static FATCA_Reportable_Form__c createFATCAReportableForm(FATCA_Reportable_Jurisdiction_Status__c frjs) {                
        FATCA_Reportable_Form__c frf = new FATCA_Reportable_Form__c();
        frf.FATCA_Reportable_Jurisdiction_Status__c = frjs.Id;        
        return frf;
    }
    
    public static PrivateFundRegistration__c createPrivateFundRegistration(Account account, InvestmentManagerCaymanOption__c option1, InvestmentManagerWorldOption__c option2) {
        PrivateFundRegistration__c fund = new PrivateFundRegistration__c();
        fund.Account__c = account.Id;
        fund.NameOfFund__c = account.Name + ' Fund Registration';
        fund.Status__c = 'In Review';
        fund.IndustryReference__c = 'Banking sevices';
        fund.RequestedDateOfRegistration__c = Date.valueOf(Datetime.now().addDays(20));
        fund.DateOfFormationIncorporation__c = Date.valueOf(Datetime.now().addDays(10));
        fund.CompaniesRegistrationCORISNumber__c = '237498ADDF78F6786S';
        fund.LegalEntityIdentifierLEI__c = 'AB76S7F6C77S6F6D';
        fund.LegalStructure__c = 'Exempt Trust';
        fund.AttachStructureChartTitles__c = 'Structure chart.pdf';
        fund.AttachCertOfIncorporationTitles__c = 'Certificate of incorporation.pdf';
        fund.AttachTrustDeedDeclarationTitles__c = 'Trust Declaration Document.pdf';
        fund.AttachOfferingDocSummaryTitles__c = 'Offering Document.pdf';
        fund.BaseCurrencyOfOffering__c = 'USD US Dollars';
        fund.PrimaryInvestmentStrategy__c = 'Arbitrage';
        fund.PrimaryInvestmentStrategyOther__c = 'Test investment strategy other';
        fund.SecondaryInvestmentStrategy__c = 'Aggressive Growth';
        fund.SecondaryInvestmentStrategyOther__c = 'Test investment strategy other';
        fund.InvestmentRestrictionsCategory__c = 'Instrument';
        fund.InvestmentRestrictionsDetails__c = 'Investment restricted to the 20% of utilities';
        fund.RiskFactors__c = 'Activities of other banking competitors in the area';
        fund.MinimumInitialInvestmentForInvestor__c = 45000;
        fund.InitialTermDurationOfFundInYears__c = 3;
        fund.MaximumTermDurationOfFundInYears__c =5;
        fund.ActualOrExpectedSizeOfInvestorBase__c = '1 - 15 investors';
        //fund.HasNomineeInvestors__c = true;
        fund.FrequencyOfValuations__c = 'Daily';
        fund.FYEMonth__c = 'JAN';
        fund.FYEDay__c = '(Not Reported)';
        fund.AccountingPrinciples__c = 'AAOIFI (Islamic Financial Institutions)';
        fund.AuditingPrinciples__c = 'Australia';
        fund.SingleFundMultiFund__c = 'Multi Fund';
        fund.NameOfRegisteredOffice__c= 'A.R.C. Directors Ltd';
        fund.OngoingQueriesRegisteredOff__c = 'Yes';
        fund.IfNoProvideOngoingQueries__c = 'Bauer Financial Services for Ongoing Queries';
        fund.BuildingFloorSuiteB03a__c = 'Phoenix Building, Floor 4, Suite 518';
        fund.StreetNameAndNumberB03b__c = '4053 Morgan St';
        fund.POBoxB03c__c = '2456';
        fund.CityB03d__c = 'Denver';
        fund.ProvinceStateB03e__c = 'Colorado';
        fund.ZIPPostalCodeB03f__c = '23165';
        fund.CountryB03g__c= 'United States of America';
        fund.TelephoneNumberB03h__c = '(1)(321)656468';
        fund.EmailAddressB03i__c = 'contact@bauerfinancialservices.com';
        fund.FeePaymentsRegisteredOff__c = 'Yes';
        fund.IfNoProvideFreePayments__c = 'Financial Fee Payments and Associates';
        fund.BuildingFloorSuiteB05a__c = 'Phoenix Building, Floor 4, Suite 518';
        fund.StreetNameAndNumberB05b__c = '4053 Morgan St';
        fund.POBoxB05c__c = '2456';
        fund.CityB05d__c = 'Denver';
        fund.ProvinceStateB05e__c = 'Colorado';
        fund.ZIPPostalCodeB05f__c = '23165';
        fund.CountryB05g__c= 'United States of America';
        fund.TelephoneNumberB05h__c = '(1)(321)656468';
        fund.EmailAddressB05i__c = 'contact@bauerfinancialservices.com';
        fund.NameOfDistributorIfApplicable__c = 'Carl Andersen';
        fund.InvestmentManagerIndependent__c = 'Yes';
        fund.CountryOfInvestmentManager__c = 'United States of America';
        fund.IfInCaymanNotRegisteredProvideIM__c = 'Mr. Andrew Hopkins';
        fund.NewInvestmentManagerApplicationRef__c = '654987922255';
        fund.IfNotInCaymanProvideIM__c = 'Mrs. Sarah McAllister';
        fund.IfRegulatorisNotOnTheListInB09__c = 'United States';
        fund.FirstName__c = 'Jennifer';
        fund.LastName__c = 'Flores';
        fund.EmailAddress__c = 'jenniferflores@bauerfinancialservices.com';
        fund.FundProvideItsAdministrationServices__c = 'Yes';
        fund.CountryOfAdministrator__c = 'United States of America'; 
        fund.IfInCaymanSelectAdministratorName__c = 'ALPS Alternative Investment Services, Ltd.';
        fund.IfNotInCaymanProvideAdministrator__c = 'Jessica Harris';
        fund.AdministratorsConsentLetterTitle__c = 'Consent Letter.pdf';
        fund.NameOfRegulatorForAdministratorCont__c = 'Richard Adams';
        fund.RegisterAndTransferAgentSameAdmin__c = 'Yes';
        fund.IfNoProvideNameOfRegistrarAndTra__c = 'Matthew Murphy';
        fund.CountryOfRegistrarAndTransferAgent__c = 'United States of America';
        fund.AttachConsFromRegAndTransfTitle__c = 'Consent.pdf';
        fund.IfRegulatorIsNotOnTheListInB19__c = 'Tuvalu';
        fund.IsTheRegistrarAndTransferAgent__c = 'Yes';
        fund.NAVCalculationAgentSameAdmin__c = 'Yes';
        fund.IfNoProvideNameOfNAVCalcAgent__c = 'Thomas Rogers';
        fund.CountryOfNAVCalculationAgent__c = 'Costa Rica';
        fund.AttachConsentFromNAVCalcAgenTitle__c= 'Consent from NACV agent.pdf';
        fund.IfRegulatorIsNotOnTheListInB24__c = 'Paul Bell';
        fund.IsTheNAVCalculationAgentIndependent__c = 'Yes';
        fund.NameOfDepositary__c = 'Catherine Howard';
        fund.CountryOfDepositary__c = 'Costa Rica';
        fund.PrimaryStockExchangeOfFund__c = ':AIA: Anguilla Ministry of Finance';
        fund.LegalCounselInCayman__c = 'AFA Legal Resources (Cayman) Ltd.';
        fund.CaymanAuditorLocalAuditSignOff__c = 'Baker Tilly (Cayman) Ltd.';
        fund.AttachAuditorsConsentLetter__c = 'Auditor Consent Letter.pdf';
        fund.NameOfOverseasAuditor__c = 'Samuel Gray';
        fund.CountryOfOverseasAuditor__c = 'Costa Rica';
        fund.NameOfPromoterSponsor__c = 'Helen Coleman';
        fund.CountryOfPromoterSponsor__c = 'Canada';
        fund.NameC04__c = 'Jacob Walker';
        fund.CountryOfFormation__c = 'Canada';
        fund.CIMAIDC06__c = '1254796';
        fund.Trustee__c= 'Cainvest Bank and Trust Limited';
        fund.GeneralPartnerGP__c = 'Mary Jane West';
        fund.GPCountry__c ='Canada';
        fund.GPLegalEntityIdentifierLEI__c = '1458742';
        fund.IsTheAMLFunctionOutsourced__c = 'Yes';
        fund.AMLCFTServiceProviderName__c = 'Bejamin Crawford';
        fund.AMLCFTServiceProviderCountry__c = 'United States of America'; 
        fund.AMLCFTServiceProviderEmail__c = 'benjamincrawford@bauerfinancialservices.com';
        fund.CIMAID__c = 'ASK7D585RFS887';
        fund.ALMCOPrefix__c = 'Mrs';
        fund.ALMCOFirstName__c = 'Pamela';
        fund.ALMCOMiddleName__c = '';
        fund.ALMCOLastName__c = 'Sullivan';
        fund.ALMCODateOfBirth__c = Date.valueOf(Datetime.now().addYears(-34));
        fund.ALMCOCountryOfBirth__c = 'United States of America';
        fund.ALMCOGender__c = 'Female';
        fund.ALMCOOtherNames__c = 'Pamela Sullivan Legal Services';
        fund.ALMCOOccupationTitle__c = 'Director Legal Serv. Depart.';
        fund.ALMCOEmployer__c = 'Bauer Financial Services LLC';
        fund.ALMCOPOBox__c = '2456';
        fund.ALMCOStreetAddress__c = 'Stark Avenue No. 5458';
        fund.ALMCOCity__c = 'Seattle';
        fund.ALMCOStateProvince__c = 'King County, Washington';
        fund.ALMCOCountry__c = 'United States of America';
        fund.ALMCOZipPostalCode__c = '254981';
        fund.ALMCOPhoneNumber__c = '(1)(321)476468';
        fund.ALMCOFacsimileNumber__c = '(1)(321)486468';
        fund.ALMCOEmailAddress__c = 'pamelasullivan@bauerfinancialservices.com';
        fund.ALMCOCVResumeTitle__c = 'ALMCO resume.pdf';
        fund.DAMLCOCIMAID__c = '4584362';
        fund.DAMLCOPrefix__c = 'Mr';
        fund.DAMLCOFirstName__c = 'Matt';
        fund.DAMLCOMiddleName__c = '';
        fund.DAMLCOLastName__c = 'Cunningham';
        fund.DAMLCODateOfBirth__c = Date.valueOf(Datetime.now().addYears(-34));
        fund.DAMLCOCountryOfBirth__c = 'United States of America';
        fund.DAMLCOGender__c = 'Male';
        fund.DAMLCOOtherNamesAliases__c = 'Matt Anti-Money Laundering';
        fund.DAMLCOOccupationTitle__c = 'Anti-Money Laundering Officer';
        fund.DAMLCOEmployer__c = 'Bauer Financial Services LLC';
        fund.DAMLCOPOBox__c = '2456';
        fund.DAMLCOStreetAddress__c = 'Glenwood Avenue';
        fund.DAMLCOCity__c = 'Charlotte';
        fund.DAMLCOStateProvince__c = 'Mecklenburg, North Carolina';
        fund.DAMLCOCountry__c = 'United States of America';
        fund.DAMLCOZipPostalCode__c = '458326';
        fund.DAMLCOPhoneNumber__c = '(1)(321)476468';
        fund.DAMLCOFacsimileNumber__c = '(1)(321)47758';
        fund.DAMLCOEmailAddress__c = 'mattcunningham@bauerfinancialservices.com';
        fund.DAMLCOCVResumeTitle__c = 'DAMLCO Resume.pdf';
        fund.MLROCIMAID__c = '9874525';
        fund.MLROPrefix__c = 'Ms';
        fund.MLROFirstName__c = 'Caroline';
        fund.MLROMiddleName__c = '';
        fund.MLROLastName__c = 'Konstar';
        fund.MLRODateOfBirth__c = Date.valueOf(Datetime.now().addYears(-34));
        fund.MLROCountryOfBirth__c = 'United States of America';
        fund.MLROGender__c = 'Female';
        fund.MLROOtherNamesAliases__c = 'Caroline Money Laundering';
        fund.MLROOccupationTitle__c = 'Money Laundering Officer';
        fund.MLROEmployer__c = 'Bauer Financial Services LLC';
        fund.MLROPOBox__c = '2456';
        fund.MLROStreetAddress__c = 'Glenwood Avenue';
        fund.MLROCity__c = 'Charlotte';
        fund.MLROStateProvince__c = 'Mecklenburg, North Carolina';
        fund.MLROCountry__c = 'United States of America';
        fund.MLROZipPostalCode__c = '458326';
        fund.MLROPhoneNumber__c = '(1)(321)476468';
        fund.MLROFacsimileNumber__c = '(1)(321)47758';
        fund.MLROEmailAddress__c = 'carolinekonstar@bauerfinancialservices.com';
        fund.MLROCVResumeTitle__c = 'MLRO Resume.pdf';
        fund.DMLROCIMAID__c = '9874525';
        fund.DMLROPrefix__c = 'Ms';
        fund.DMLROFirstName__c = 'Samantha';
        fund.DMLROMiddleName__c = '';
        fund.DMLROLastName__c = 'Foster';
        fund.DMLRODateOfBirth__c = Date.valueOf(Datetime.now().addYears(-34));
        fund.DMLROCountryOfBirth__c = 'United States of America';
        fund.DMLROGender__c = 'Female';
        fund.DMLROOtherNamesAliases__c = 'Samantha Money Laundering';
        fund.DMLROOccupationTitle__c = 'Money Laundering Officer';
        fund.DMLROEmployer__c = 'Bauer Financial Services LLC';
        fund.DMLROPOBox__c = '2456';
        fund.DMLROStreetAddress__c = 'Glenwood Avenue';
        fund.DMLROCity__c = 'Charlotte';
        fund.DMLROStateProvince__c = 'Mecklenburg, North Carolina';
        fund.DMLROCountry__c = 'United States of America';
        fund.DMLROZipPostalCode__c = '458326';
        fund.DMLROPhoneNumber__c = '(1)(321)476468';
        fund.DMLROFacsimileNumber__c = '(1)(321)47758';
        fund.DMLROEmailAddress__c = 'samanthafoster@bauerfinancialservices.com';
        fund.DMLROCVResumeTitle__c = 'DMLRO Resume.pdf';
        fund.ALMCOMiddleName__c = 'No Middlename';
        fund.DAMLCOMiddleName__c = 'No Middlename';
        fund.DMLROMiddleName__c = 'No Middlename';
        fund.DAMLCOMiddleName__c = 'No Middlename';
        fund.DMLROMiddleName__c = 'No Middlename';
        fund.MLROMiddleName__c = 'No Middlename';
        fund.AttachCertificateOfIncorporation_Re__c = 'Certificate of incorporation.pdf';
        fund.TrustDeedPartnDeclMemAndAssArt__c = 'Trust Declaration Document.pdf';
        fund.OfferingDocTermsSummaryMarketingMat__c = 'Offering Document.pdf';
        fund.IfInCaymanSelectInvestmentManager__c = option1.Id;
        fund.IfNotInCaymanSelectNameOfRegulat__c = option2.Id;
        fund.NameOfRegulatorForAdministratorContB15__c = option2.Id;
        fund.NameOfRegulatorForNAVCalculationAg__c = option1.Id;
        fund.NameOfRegulatorForRegistrarAndTran__c = option2.Id;
        return fund;
    }
    
    public static CIMAParticipant__c createCIMAParticipant(PrivateFundRegistration__c privateFund, String formId, Integer sequenceNumber) {
        CIMAParticipant__c participant = new CIMAParticipant__c();
        participant.FormId__c = formId;
        participant.PrivateFundRegistration__c = privateFund.Id;
        participant.FirstName__c = 'Jon';
        participant.MiddleName__c = 'Andrew';
        participant.LastName__c = 'Gilligan';
        participant.EmailAddress__c = 'jon' + String.valueOf(System.now().getTime()) + '@test.emdev.com';
        participant.CurrencyIsoCode = '	GBP';
        participant.Country__c = 'United States of America';
        participant.NameOfAdvisor__c = 'Robert Clark';
        participant.SequenceNo__c = sequenceNumber;
        participant.DateOfBirth__c = Date.today();
        participant.Director__c = 'Berman Fisher Limited';
        participant.DirectorID__c = '1587469';
        return participant;
    }
    
    public static CIMAQualification__c createCIMAQualification(PrivateFundRegistration__c privateFund, String formId, Integer sequenceNumber) {
        CIMAQualification__c qualification = new CIMAQualification__c();
        qualification.FormId__c = formId;
        qualification.PrivateFundRegistration__c = privateFund.Id;
        qualification.CurrencyIsoCode = 'GBP';
        qualification.AccreditingBody__c = 'British Accreditation Council (BAC)';
        qualification.Type__c = 'Professional';
        qualification.Description__c = 'Pellentesque at tincidunt mi. Aliquam et enim in orci posuere semper id dignissim eros.';
        qualification.Date__c = Date.valueOf(Datetime.now());
        qualification.SequenceNo__c = sequenceNumber;
        return qualification;
    }
    
    public static CIMAMultiFund__c createCIMAMultiFund(PrivateFundRegistration__c privateFund, String formId, Integer sequenceNumber) {
        CIMAMultiFund__c multiFund = new CIMAMultiFund__c();
        multiFund.PrivateFundRegistration__c = privateFund.Id;
        multiFund.CurrencyIsoCode = 'GBP';
        multiFund.InvestmentVehicleType__c = 'Alternative Investment Vehicle';
        multiFund.Name__c = 'New Multi Fund ' + Datetime.now().getTime();
        multiFund.CountryOfEstablishment__c = 'Australia';
        multiFund.AccountingPrinciples__c = 'Canadian GAAP';
        multiFund.ActualOrExpectedSizeOfInvestorBase__c = '1 - 15 investors';
        multiFund.DetailsSameAsAbovePrivateFund__c = 'Yes';
        multiFund.BaseCurrencyOfOffering__c = 'USD US Dollars';
        multiFund.AuditingPrinciples__c = 'Canada';
        multiFund.DetailsA31ix__c = 'Test details for this multi fund record';
        multifund.DetailsA31xi__c = 'Test details for this multi fund record';
		multiFund.MinimumAggregateOfOffering__c = 'Sample Minimun Aggregate';  
        multiFund.FYEDay__c = '(Not Reported)';
        multiFund.InvestmentRestrictionsDetails__c = 'Reduction of income by contributors';
        multiFund.SequeceNo__c = sequenceNumber;
        multiFund.MaximumAggregateOfOffering__c = '5';
        multiFund.PrimaryInvestmentStrategy__c = 'Dedicated Short';
        multiFund.SecondaryInvestmentStrategy__c = 'Other...';
        multiFund.InvestmentRestrictionsCategory__c = 'Instrument';
        multiFund.RiskFactors__c = 'Interest rate, index of customers, value of the properties, proven financial security of clients.';
        multiFund.MinimumInitialInvestmentforInvestor__c = 50000;
        multiFund.FrequencyOfValuations__c = 'Monthly';
        multiFund.FYEMonth__c = 'APR';

        return multiFund;
    }
    
    public static InvestmentManagerCaymanOption__c createInvestmentManagerCaymanOption() {
        InvestmentManagerCaymanOption__c option = new InvestmentManagerCaymanOption__c();
        option.Name = '3W Partners Capital Limited';
        return option;
    }
    
    public static InvestmentManagerWorldOption__c createInvestmentManagerWorldOption() {
        InvestmentManagerWorldOption__c option = new InvestmentManagerWorldOption__c();
        option.Name = ':ARE: Dubai Financial Services Authority';
        return option;
    }
    
}