public class PrivateFundRegistrationsJSONBuilder {

    public static String convertToJSON(PrivateFundRegistration__c fundRegistration) {
        
        List<CIMAParticipant__c> cimaParticipants = [SELECT  SequenceNo__c, Director__c, DirectorID__c, FirstName__c, MiddleName__c, DateOfBirth__c, LastName__c, EmailAddress__c, FormId__c, Country__c, NameOfAdvisor__c, CurrencyIsoCode, CIMAID__c FROM CIMAParticipant__c WHERE PrivateFundRegistration__c = :fundRegistration.Id ORDER BY SequenceNo__c ASC];
        List<CIMAQualification__c> cimaQualifications = [SELECT  Description__c, SequenceNo__c, FormId__c, Date__c, AccreditingBody__c, Type__c, CurrencyIsoCode FROM CIMAQualification__c WHERE PrivateFundRegistration__c = :fundRegistration.Id ORDER BY SequenceNo__c ASC];
        List<CIMAMultiFund__c> cimaMultiFunds = [SELECT  Name, Name__c, SecondaryInvestmentStrategy__c, FYEDay__c, SequenceNo__c, currencyIsoCode, InvestmentVehicleType__c, CountryOfEstablishment__c, AccountingPrinciples__c, ActualOrExpectedSizeOfInvestorBase__c, MinimumAggregateOfOffering__c, DetailsSameAsAbovePrivateFund__c, MaximumAggregateOfOffering__c, BaseCurrencyOfOffering__c, AuditingPrinciples__c, DetailsA31ix__c, MinimumInitialInvestmentforInvestor__c, PrimaryInvestmentStrategy__c, RiskFactors__c, FrequencyOfValuations__c, FYEMonth__c, InvestmentRestrictionsCategory__c, InvestmentRestrictionsDetails__c, DetailsA31xi__c FROM CIMAMultiFund__c WHERE PrivateFundRegistration__c = :fundRegistration.Id ORDER BY SequenceNo__c ASC];
        
        JSONGenerator gen = JSON.createGenerator(true);
        gen.writeStartObject();
        gen.writeIdField('Id', fundRegistration.Id);
        JSONHelper.writeStringField(gen, 'Name', fundRegistration.Name);
        JSONHelper.writeStringField(gen, 'Account Name', fundRegistration.Account__r.Name);
        JSONHelper.writeStringField(gen, 'Status', fundRegistration.Status__c);
        gen.writeFieldName('Form Data');
        gen.writeStartObject();
        JSONHelper.writeStringField(gen, 'A01 Name of Fund', fundRegistration.NameOfFund__c);
        JSONHelper.writeStringField(gen, 'A02 Industry Reference', fundRegistration.IndustryReference__c);
        JSONHelper.writeStringField(gen, 'A03 Requested date of Registration', DateTime.newInstance(fundRegistration.RequestedDateOfRegistration__c.year(), fundRegistration.RequestedDateOfRegistration__c.month(), fundRegistration.RequestedDateOfRegistration__c.day()).format('yyyy-MM-dd'));
        JSONHelper.writeStringField(gen, 'A04 Date of Formation / incorporation', DateTime.newInstance(fundRegistration.RequestedDateOfRegistration__c.year(), fundRegistration.RequestedDateOfRegistration__c.month(), fundRegistration.RequestedDateOfRegistration__c.day()).format('yyyy-MM-dd'));
        JSONHelper.writeStringField(gen, 'A05 Registrar Registration (CORIS) Number', fundRegistration.CompaniesRegistrationCORISNumber__c);
        JSONHelper.writeStringField(gen, 'A06 Legal Entity Identifier (LEI)', fundRegistration.LegalEntityIdentifierLEI__c);
        JSONHelper.writeStringField(gen, 'A07 Legal Structure', fundRegistration.LegalStructure__c);
        JSONHelper.writeStringField(gen, 'A08 Structure Chart', 'A08 ' + fundRegistration.AttachStructureChartTitles__c + '.pdf');
        JSONHelper.writeStringField(gen, 'A09 Certificate of Incorporation / Registration', 'A09 ' + fundRegistration.AttachCertOfIncorporationTitles__c + '.pdf');
        JSONHelper.writeStringField(gen, 'A10 Attach Trust Deed / Declaration of Partnership / Memorandum and Articles of Association', 'A10 ' + fundRegistration.AttachTrustDeedDeclarationTitles__c + '.pdf');
        JSONHelper.writeStringField(gen, 'A11 Attach Offering Document / Summary of Terms / Marketing Material', 'A11 ' + fundRegistration.AttachOfferingDocSummaryTitles__c + '.pdf');
        JSONHelper.writeStringField(gen, 'A12 Base Currency of Offering', fundRegistration.BaseCurrencyOfOffering__c);
        JSONHelper.writeStringField(gen, 'A13 Primary Investment Strategy', fundRegistration.PrimaryInvestmentStrategy__c);
        JSONHelper.writeStringField(gen, 'A14 Primary Investment Strategy - Other', fundRegistration.PrimaryInvestmentStrategyOther__c);
        JSONHelper.writeStringField(gen, 'A15 Secondary Investment Strategy', fundRegistration.SecondaryInvestmentStrategy__c);
        JSONHelper.writeStringField(gen, 'A16 Secondary Investment Strategy - Other', fundRegistration.SecondaryInvestmentStrategyOther__c);
        JSONHelper.writeStringField(gen, 'A17 Investment restrictions Category', fundRegistration.InvestmentRestrictionsCategory__c);
        JSONHelper.writeStringField(gen, 'A18 Investment restrictions Details', fundRegistration.InvestmentRestrictionsDetails__c);
        JSONHelper.writeStringField(gen, 'A19 Risk factors', fundRegistration.RiskFactors__c);
        JSONHelper.writeNumberField(gen, 'A20 Minimum initial investment for investor in base currency', fundRegistration.MinimumInitialInvestmentForInvestor__c);
        JSONHelper.writeNumberField(gen, 'A21 Initial term/duration of fund (in years)', fundRegistration.InitialTermDurationOfFundInYears__c);
        JSONHelper.writeNumberField(gen, 'A22 Maximum term/duration of fund (in years)', fundRegistration.MaximumTermDurationOfFundInYears__c);
        JSONHelper.writeStringField(gen, 'A23 Actual or expected size of investor base', fundRegistration.ActualOrExpectedSizeOfInvestorBase__c);
        JSONHelper.writeStringField(gen, 'A24 Has Nominee Investors', fundRegistration.HasNomineeInvestors__c);
        JSONHelper.writeStringField(gen, 'A25 Frequency of Valuations', fundRegistration.FrequencyOfValuations__c);
        JSONHelper.writeStringField(gen, 'A26 FYE Day', fundRegistration.FYEDay__c);
        JSONHelper.writeStringField(gen, 'A27 FYE Month', fundRegistration.FYEMonth__c);
        JSONHelper.writeStringField(gen, 'A28 Accounting Principles', fundRegistration.AccountingPrinciples__c);
        JSONHelper.writeStringField(gen, 'A29 Auditing Principles', fundRegistration.AuditingPrinciples__c);
        JSONHelper.writeStringField(gen, 'A30 Single fund / Multi Fund', fundRegistration.SingleFundMultiFund__c); 
        gen.writeFieldName('A31 AIV / Co-Investment Vehicles / SPVs / Blockers / Holding Companies:');
        gen.writeStartArray();
        for (CIMAMultiFund__c multiFund : cimaMultiFunds) {
            gen.writeStartObject();
            JSONHelper.writeNumberField(gen, 'Sequence #', multiFund.SequenceNo__c);
            JSONHelper.writeStringField(gen, 'A31i Investment Vehicle Type', multiFund.InvestmentVehicleType__c);
            JSONHelper.writeStringField(gen, 'A31ii Entity Name', multiFund.Name__c);
            JSONHelper.writeStringField(gen, 'A31iii Country of Establishment', multiFund.CountryOfEstablishment__c);
            JSONHelper.writeStringField(gen, 'A31iv Details same as above private fund?', multiFund.DetailsSameAsAbovePrivateFund__c);
            JSONHelper.writeStringField(gen, 'A31v Base Currency of Offering', multiFund.BaseCurrencyOfOffering__c);
            JSONHelper.writeStringField(gen, 'A31vi Initial term/duration of fund (in years)', multiFund.MaximumAggregateOfOffering__c);
            JSONHelper.writeStringField(gen, 'A31vii Maximum term/duration of fund (in years)', multiFund.MinimumAggregateOfOffering__c);
            JSONHelper.writeStringField(gen, 'A31viii Primary Investment Strategy', multiFund.PrimaryInvestmentStrategy__c);
            JSONHelper.writeStringField(gen, 'A31ix Primary Investment Strategy Details', multiFund.DetailsA31ix__c);
            JSONHelper.writeStringField(gen, 'A31x Secondary Investment Strategy', multiFund.SecondaryInvestmentStrategy__c);
            JSONHelper.writeStringField(gen, 'A31xi Secondary Investment Strategy Details', multiFund.DetailsA31xi__c);
            JSONHelper.writeStringField(gen, 'A31xii Investment restrictions Category', multiFund.InvestmentRestrictionsCategory__c);
            JSONHelper.writeStringField(gen, 'A31xiii Investment restrictions Details', multiFund.InvestmentRestrictionsDetails__c);
            JSONHelper.writeStringField(gen, 'A31xiv Risk factors', multiFund.RiskFactors__c);
            JSONHelper.writeNumberField(gen, 'A31xv Minimum initial investment for investor in base currency', multiFund.MinimumInitialInvestmentforInvestor__c);
            JSONHelper.writeStringField(gen, 'A31xvi Actual or expected size of investor Base', multiFund.ActualOrExpectedSizeOfInvestorBase__c);
            JSONHelper.writeStringField(gen, 'A31xvii Frequency of Valuations', multiFund.FrequencyOfValuations__c);
            JSONHelper.writeStringField(gen, 'A31xviii FYE Month', multiFund.FYEMonth__c);
            JSONHelper.writeStringField(gen, 'A31xix FYE Day', multiFund.FYEDay__c);
            JSONHelper.writeStringField(gen, 'A31xx Accounting Principles', multiFund.AccountingPrinciples__c);
            JSONHelper.writeStringField(gen, 'A31xxi Auditing Principles', multiFund.AuditingPrinciples__c);
            gen.writeEndObject();
        }
        gen.writeEndArray();
        JSONHelper.writeStringField(gen, 'B01 Name of Registered Office', fundRegistration.NameOfRegisteredOffice__c);
        JSONHelper.writeStringField(gen, 'B02 Ongoing queries - same as Registered Office?', fundRegistration.OngoingQueriesRegisteredOff__c);
        JSONHelper.writeStringField(gen, 'B03 Ongoing Queries Entity Name', fundRegistration.IfNoProvideOngoingQueries__c);
        JSONHelper.writeStringField(gen, 'B03a Ongoing Queries Entity Building, Floor, Suite', fundRegistration.BuildingFloorSuiteB03a__c);
        JSONHelper.writeStringField(gen, 'B03b Ongoing Queries Entity Street Name and Number', fundRegistration.StreetNameAndNumberB03b__c);
        JSONHelper.writeStringField(gen, 'B03c Ongoing Queries Entity P.O. Box', fundRegistration.POBoxB03c__c);
        JSONHelper.writeStringField(gen, 'B03d Ongoing Queries Entity City', fundRegistration.CityB03d__c);
        JSONHelper.writeStringField(gen, 'B03e Ongoing Queries Entity Province / State', fundRegistration.ProvinceStateB03e__c);
        JSONHelper.writeStringField(gen, 'B03f Ongoing Queries Entity ZIP / Postal Code', fundRegistration.ZIPPostalCodeB03f__c );
        JSONHelper.writeStringField(gen, 'B03g Ongoing Queries Entity Country', fundRegistration.CountryB03g__c);
        JSONHelper.writeStringField(gen, 'B03h Ongoing Queries Entity Telephone Number', fundRegistration.TelephoneNumberB03h__c);
        JSONHelper.writeStringField(gen, 'B03i Ongoing Queries Entity Email Address', fundRegistration.EmailAddressB03i__c);
        JSONHelper.writeStringField(gen, 'B04 Fee Payments - Same as Registered Office?', fundRegistration.FeePaymentsRegisteredOff__c);
        JSONHelper.writeStringField(gen, 'B05 Fee Payments Entity Name', fundRegistration.IfNoProvideFreePayments__c);
        JSONHelper.writeStringField(gen, 'B05a Fee Payments Entity Building, Floor, Suite', fundRegistration.BuildingFloorSuiteB05a__c );
        JSONHelper.writeStringField(gen, 'B05b Fee Payments Entity Street Name and Number', fundRegistration.StreetNameAndNumberB05b__c);
        JSONHelper.writeStringField(gen, 'B05c Fee Payments Entity P.O. Box', fundRegistration.POBoxB05c__c);
        JSONHelper.writeStringField(gen, 'B05d Fee Payments Entity City', fundRegistration.CityB05d__c);
        JSONHelper.writeStringField(gen, 'B05e Fee Payments Entity Province / State', fundRegistration.ProvinceStateB05e__c);
        JSONHelper.writeStringField(gen, 'B05f Fee Payments Entity ZIP / Postal Code', fundRegistration.ZIPPostalCodeB05f__c);
        JSONHelper.writeStringField(gen, 'B05g Fee Payments Entity Country', fundRegistration.CountryB05g__c);
        JSONHelper.writeStringField(gen, 'B05h Fee Payments Entity Telephone Number', fundRegistration.TelephoneNumberB05h__c);
        JSONHelper.writeStringField(gen, 'B05i Fee Payments Entity Email Address', fundRegistration.EmailAddressB05i__c);
        JSONHelper.writeStringField(gen, 'B06 Name of Distributor', fundRegistration.NameOfDistributorIfApplicable__c);
        JSONHelper.writeStringField(gen, 'B07 Is the investment manager independent', fundRegistration.InvestmentManagerIndependent__c);
        JSONHelper.writeStringField(gen, 'B08 Country of Investment Manager', fundRegistration.CountryOfInvestmentManager__c);
        JSONHelper.writeStringField(gen, 'B08a If in Cayman, select Investment Manager name', fundRegistration.IfInCaymanSelectInvestmentManager__r.Name);
        JSONHelper.writeStringField(gen, 'B08b Investment Manager Name (Cayman)', fundRegistration.IfInCaymanNotRegisteredProvideIM__c);
        JSONHelper.writeStringField(gen, 'B08bb New Investment Manager Application Ref#', fundRegistration.NewInvestmentManagerApplicationRef__c);
        JSONHelper.writeStringField(gen, 'B08c Investment Manager Name (Non-Cayman)', fundRegistration.IfNotInCaymanProvideIM__c);
        JSONHelper.writeStringField(gen, 'B09 Investment Manager Regulator (Non-Cayman)', fundRegistration.IfNotInCaymanSelectNameOfRegulat__r.Name);
        JSONHelper.writeStringField(gen, 'B09o Investment Manager Other Regulator', fundRegistration.IfRegulatorisNotOnTheListInB09__c);
        gen.writeFieldName('B10 Principal of Investment Manager');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'B10') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', participant.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'B10i Principal of Investment Manager First Name', participant.FirstName__c);
                JSONHelper.writeStringField(gen, 'B10ii Principal of Investment Manager Last Name', participant.LastName__c);
                JSONHelper.writeStringField(gen, 'B10iii Principal of Investment Manager Email Address', participant.EmailAddress__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        gen.writeFieldName('B11 Investment Advisor(s)');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'B11') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', participant.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'B11i Investment Advisor Country', participant.Country__c);
                JSONHelper.writeStringField(gen, 'B11ii Name of Advisor', participant.NameOfAdvisor__c);
                JSONHelper.writeStringField(gen, 'B11iii Principal First Name', participant.FirstName__c);
                JSONHelper.writeStringField(gen, 'B11iv Principal Last Name', participant.LastName__c);
                JSONHelper.writeStringField(gen, 'B11v Principal Email Address', participant.EmailAddress__c);
                gen.writeEndObject();
            }
        }  
        gen.writeEndArray();
        JSONHelper.writeStringField(gen, 'B12 Does the fund provide its own administration services?', fundRegistration.FundProvideItsAdministrationServices__c);
        JSONHelper.writeStringField(gen, 'B13 Country of Administrator', fundRegistration.CountryOfAdministrator__c);
        JSONHelper.writeStringField(gen, 'B14a Administrator Name (Cayman)', fundRegistration.IfInCaymanSelectAdministratorName__c);
        JSONHelper.writeStringField(gen, 'B14b Administrator Name (Non-Cayman)', fundRegistration.IfNotInCaymanProvideAdministrator__c);
        JSONHelper.writeStringField(gen, 'B14c Administrator\'s Consent Letter', 'B14c ' + fundRegistration.AdministratorsConsentLetterTitle__c + '.pdf');
        JSONHelper.writeStringField(gen, 'B15 Name of Regulator for Administrator contracted', fundRegistration.NameOfRegulatorForAdministratorContB15__r.Name); 
        JSONHelper.writeStringField(gen, 'B15o Administrator Other Regulator', fundRegistration.NameOfRegulatorForAdministratorCont__c); 
        JSONHelper.writeStringField(gen, 'B16 Registrar and Transfer Agent - Same as Administrator?', fundRegistration.RegisterAndTransferAgentSameAdmin__c);
        JSONHelper.writeStringField(gen, 'B16a Registrar and Transfer Agent Name', fundRegistration.IfNoProvideNameOfRegistrarAndTra__c);
        JSONHelper.writeStringField(gen, 'B17 Country of Registrar and Transfer Agent', fundRegistration.CountryOfRegistrarAndTransferAgent__c);
        if (!String.isBlank(fundRegistration.AttachConsFromRegAndTransfTitle__c)) {
            JSONHelper.writeStringField(gen, 'B18 Attach consent from Registrar and Transfer Agent', 'B18 ' + fundRegistration.AttachConsFromRegAndTransfTitle__c + '.pdf');
        } else {
            JSONHelper.writeStringField(gen, 'B18 Attach consent from Registrar and Transfer Agent', fundRegistration.AttachConsFromRegAndTransfTitle__c);
        }
        JSONHelper.writeStringField(gen, 'B19 Name of Regulator for Registrar and Transfer Agent contracted', fundRegistration.NameOfRegulatorForRegistrarAndTran__r.Name); 
        JSONHelper.writeStringField(gen, 'B19o Registrar and Transfer Agent Other Regulator', fundRegistration.IfRegulatorIsNotOnTheListInB19__c);
        JSONHelper.writeStringField(gen, 'B20 Is the Registrar and Transfer Agent independent', fundRegistration.IsTheRegistrarAndTransferAgent__c);
        JSONHelper.writeStringField(gen, 'B21 NAV Calculation Agent - Same as Administrator?', fundRegistration.NAVCalculationAgentSameAdmin__c);
        JSONHelper.writeStringField(gen, 'B21a NAV Calculation Agent Name', fundRegistration.IfNoProvideNameOfNAVCalcAgent__c);
        JSONHelper.writeStringField(gen, 'B22 Country of NAV Calculation Agent', fundRegistration.CountryOfNAVCalculationAgent__c);
        if (!String.isBlank(fundRegistration.AttachConsentFromNAVCalcAgenTitle__c)) {
            JSONHelper.writeStringField(gen, 'B23 Attach consent from NAV Calculation Agent', 'B23 ' + fundRegistration.AttachConsentFromNAVCalcAgenTitle__c + '.pdf');
        } else {
            JSONHelper.writeStringField(gen, 'B23 Attach consent from NAV Calculation Agent', fundRegistration.AttachConsentFromNAVCalcAgenTitle__c);
        }        
        JSONHelper.writeStringField(gen, 'B24 Name of Regulator for NAV Calculation Agent contracted', fundRegistration.NameOfRegulatorForNAVCalculationAg__r.Name); 
        JSONHelper.writeStringField(gen, 'B24o NAV Calculation Agent Other Regulator', fundRegistration.IfRegulatorIsNotOnTheListInB24__c);
        JSONHelper.writeStringField(gen, 'B25 Is the NAV Calculations Agent independent', fundRegistration.IsTheNAVCalculationAgentIndependent__c );
        gen.writeFieldName('B26 Sub-Administrator(s)');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'B26') {
                gen.writeStartObject();
                JSONHelper.writeStringField(gen, 'B26i Sub-Administrator Name', participant.FirstName__c + ' ' + participant.LastName__c);
                JSONHelper.writeStringField(gen, 'B26ii Sub-Administrator Country', participant.Country__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        gen.writeFieldName('B27 Prime Broker(s)');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'B27') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', participant.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'B27i Prime Broker Name', participant.FirstName__c + ' ' + participant.LastName__c);
                JSONHelper.writeStringField(gen, 'B27ii Prime Broker Country', participant.Country__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        gen.writeFieldName('B28 Custodian(s)');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'B28') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', participant.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'B28i Custodian Name', participant.FirstName__c + ' ' + participant.LastName__c);
                JSONHelper.writeStringField(gen, 'B28ii Custodian Country', participant.Country__c);
                gen.writeEndObject();
            } 
        }
        gen.writeEndArray();
        gen.writeFieldName('B29 Sub-Custodian(s)');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'B29') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', participant.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'B29i Sub-Custodian Name', participant.FirstName__c + ' ' + participant.LastName__c);
                JSONHelper.writeStringField(gen, 'B29ii Sub-Custodian Country', participant.Country__c);
                gen.writeEndObject();
            } 
        }
        gen.writeEndArray(); 
        JSONHelper.writeStringField(gen, 'B30 Name of Depositary', fundRegistration.NameOfDepositary__c);
        JSONHelper.writeStringField(gen, 'B31 Country of Depositary', fundRegistration.CountryOfDepositary__c);
        JSONHelper.writeStringField(gen, 'B32 Primary Stock Exchange of Fund', fundRegistration.PrimaryStockExchangeOfFund__c);
        JSONHelper.writeStringField(gen, 'B33 Legal Counsel in Cayman', fundRegistration.LegalCounselInCayman__c); 
        gen.writeFieldName('B34 Other Legal Counsel');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'B34') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', participant.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'B34i Other Legal Counsel Name', participant.FirstName__c + ' ' + participant.LastName__c);
                JSONHelper.writeStringField(gen, 'B34ii Other Legal Counsel Country', participant.Country__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        JSONHelper.writeStringField(gen, 'B35 Cayman auditor', fundRegistration.CaymanAuditorLocalAuditSignOff__c);
        if (!String.isBlank(fundRegistration.AdministratorsConsentLetterTitle__c)) {
            JSONHelper.writeStringField(gen, 'B36 Attach Auditor\'s Consent Letter', 'B36 ' + fundRegistration.AttachAuditorsConsentLetter__c + '.pdf');
        } else {
            JSONHelper.writeStringField(gen, 'B36 Attach Auditor\'s Consent Letter', fundRegistration.AttachAuditorsConsentLetter__c);
        }
        JSONHelper.writeStringField(gen, 'B37 Name of overseas auditory', fundRegistration.NameOfOverseasAuditor__c);
        JSONHelper.writeStringField(gen, 'B38 Country of overseas auditor', fundRegistration.CountryOfOverseasAuditor__c);
        JSONHelper.writeStringField(gen, 'B39 Name of Promoter / Sponsor', fundRegistration.NameOfPromoterSponsor__c );
        JSONHelper.writeStringField(gen, 'B40 Country of Promoter / Sponsor', fundRegistration.CountryOfPromoterSponsor__c);
        gen.writeFieldName('C01 Director(s)');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'C01') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', participant.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'C01i Director Name And ID', participant.Director__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        gen.writeFieldName('C02 CIMA Director(s)');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'C02') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', participant.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'C02i Director First Name', participant.FirstName__c);
                JSONHelper.writeStringField(gen, 'C02ii Director Last Name', participant.LastName__c);
                JSONHelper.writeStringField(gen, 'C02iii Director ID', participant.DirectorID__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        gen.writeFieldName('C03 Other Director(s)');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'C03') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', participant.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'C03i First name', participant.FirstName__c);
                JSONHelper.writeStringField(gen, 'C03ii Middle Name', participant.MiddleName__c);
                JSONHelper.writeStringField(gen, 'C03iii Last name', participant.LastName__c);
                JSONHelper.writeDateField(gen, 'C03iv Date of Birth', participant.DateOfBirth__c);
                JSONHelper.writeStringField(gen, 'C03v Country of Birth', participant.Country__c);
                JSONHelper.writeStringField(gen, 'C03vi Email Address', participant.EmailAddress__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        JSONHelper.writeStringField(gen, 'C04 Corporate Director Name', fundRegistration.NameC04__c);
        JSONHelper.writeStringField(gen, 'C05 Corporate Director Country of Formation', fundRegistration.CountryOfFormation__c);
        JSONHelper.writeStringField(gen, 'C06 Corporate Director CIMA ID', fundRegistration.CIMAIDC06__c );
        gen.writeFieldName('C07 Details of Principals of Corporate Director');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'C07') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', participant.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'C07i Principal of Corporate Director First Name', participant.FirstName__c);
                JSONHelper.writeStringField(gen, 'C07ii Principal of Corporate Director Middle Name', participant.MiddleName__c);
                JSONHelper.writeStringField(gen, 'C07iii Principal of Corporate Director Last name', participant.LastName__c);
                JSONHelper.writeDateField(gen, 'C07iv Principal of Corporate Director Date of Birth', participant.DateOfBirth__c);
                JSONHelper.writeStringField(gen, 'C07v Principal of Corporate Director Country of Birth', participant.Country__c);
                JSONHelper.writeStringField(gen, 'C07vi Principal of Corporate Director Email Address', participant.EmailAddress__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        JSONHelper.writeStringField(gen, 'C08 Trustee', fundRegistration.Trustee__c);
        JSONHelper.writeStringField(gen, 'C09 GP Name', fundRegistration.GeneralPartnerGP__c);
        JSONHelper.writeStringField(gen, 'C10 GP Country', fundRegistration.GPCountry__c);              
        JSONHelper.writeStringField(gen, 'C11 GP LEI', fundRegistration.GPLegalEntityIdentifierLEI__c);
        gen.writeFieldName('C12 Principal(s) of the GP');
        gen.writeStartArray();
        for (CIMAParticipant__c participant : cimaParticipants) {
            if (participant.FormId__c == 'C12') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', 1);
                JSONHelper.writeStringField(gen, 'C12i Principal of the GP First name', participant.FirstName__c);
                JSONHelper.writeStringField(gen, 'C12ii Principal of the GP Middle Name', participant.MiddleName__c);
                JSONHelper.writeStringField(gen, 'C12iii Principal of the GP Last name', participant.LastName__c);
                JSONHelper.writeDateField(gen, 'C12iv Principal of the GP Date of Birth', participant.DateOfBirth__c);
                JSONHelper.writeStringField(gen, 'C12v Principal of the GP Country of Birth', participant.Country__c);
                JSONHelper.writeStringField(gen, 'C12vi Principal of the GP Email Address', participant.EmailAddress__c);
                JSONHelper.writeStringField(gen, 'C12vii Principal of the GP CIMA ID', participant.CIMAID__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        JSONHelper.writeStringField(gen, 'D00i Is the AML function outsourced?', fundRegistration.IsTheAMLFunctionOutsourced__c);
        JSONHelper.writeStringField(gen, 'D00ii AML/CFT service provider name', fundRegistration.AMLCFTServiceProviderName__c);
        JSONHelper.writeStringField(gen, 'D00iii AML/CFT service provider country', fundRegistration.AMLCFTServiceProviderCountry__c);
        JSONHelper.writeStringField(gen, 'D00iv AML/CFT service provider email', fundRegistration.AMLCFTServiceProviderEmail__c);
        JSONHelper.writeStringField(gen, 'D01 ALMCO CIMA ID (if known)', fundRegistration.CIMAID__c);
        JSONHelper.writeStringField(gen, 'D02 ALMCO Prefix', fundRegistration.ALMCOPrefix__c);
        JSONHelper.writeStringField(gen, 'D03 ALMCO First Name', fundRegistration.ALMCOFirstName__c);
        JSONHelper.writeStringField(gen, 'D04 ALMCO Middle Name', fundRegistration.ALMCOMiddleName__c);
        JSONHelper.writeStringField(gen, 'D05 ALMCO Last Name', fundRegistration.ALMCOLastName__c);
        JSONHelper.writeDateField(gen, 'D06 ALMCO Date of Birth', fundRegistration.ALMCODateOfBirth__c);
        JSONHelper.writeStringField(gen, 'D07 ALMCO Country of Birth', fundRegistration.ALMCOCountryOfBirth__c);
        JSONHelper.writeStringField(gen, 'D08 ALMCO Gender', fundRegistration.ALMCOGender__c);
        JSONHelper.writeStringField(gen, 'D09 ALMCO Other names (Aliases)', fundRegistration.ALMCOOtherNames__c);
        JSONHelper.writeStringField(gen, 'D10 ALMCO Occupation Title', fundRegistration.ALMCOOccupationTitle__c);
        JSONHelper.writeStringField(gen, 'D11 ALMCO Employer', fundRegistration.ALMCOEmployer__c);
        JSONHelper.writeStringField(gen, 'D12 ALMCO P.O. Box', fundRegistration.ALMCOPOBox__c);
        JSONHelper.writeStringField(gen, 'D13 ALMCO Street Address', fundRegistration.ALMCOStreetAddress__c);
        JSONHelper.writeStringField(gen, 'D14 ALMCO City', fundRegistration.ALMCOCity__c);
        JSONHelper.writeStringField(gen, 'D15 ALMCO State/ Province', fundRegistration.ALMCOStateProvince__c);
        JSONHelper.writeStringField(gen, 'D16 ALMCO Country', fundRegistration.ALMCOCountry__c);
        JSONHelper.writeStringField(gen, 'D17 ALMCO Zip / Postal Code', fundRegistration.ALMCOZipPostalCode__c);
        JSONHelper.writeStringField(gen, 'D18 ALMCO Phone Number', fundRegistration.ALMCOPhoneNumber__c);
        JSONHelper.writeStringField(gen, 'D19 ALMCO Facsimile Number', fundRegistration.ALMCOFacsimileNumber__c);
        JSONHelper.writeStringField(gen, 'D20 ALMCO Email Address', fundRegistration.ALMCOEmailAddress__c);
        if (!String.isBlank(fundRegistration.ALMCOCVResumeTitle__c)) {
            JSONHelper.writeStringField(gen, 'D21 ALMCO CV / Resume', 'D21 ' + fundRegistration.ALMCOCVResumeTitle__c + '.pdf');
        } else {
            JSONHelper.writeStringField(gen, 'D21 ALMCO CV / Resume', fundRegistration.ALMCOCVResumeTitle__c);
        }
        gen.writeFieldName('D22 AMLCO Qualifications');
        gen.writeStartArray();
        for (CIMAQualification__c qualification : cimaQualifications) {
            if (qualification.FormId__c == 'D22') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', qualification.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'D22i Qualification Description', qualification.Description__c);
                JSONHelper.writeDateField(gen, 'D22ii Qualification Date', qualification.Date__c);
                JSONHelper.writeStringField(gen, 'D22iii Qualification Accrediting Body', qualification.AccreditingBody__c);
                JSONHelper.writeStringField(gen, 'D22iv Qualification Type', qualification.Type__c);
                gen.writeEndObject();
            }
        } 
        gen.writeEndArray();
        JSONHelper.writeStringField(gen, 'D23 DAMLCO CIMA ID (if known)', fundRegistration.DAMLCOCIMAID__c );
        JSONHelper.writeStringField(gen, 'D24 DAMLCO Prefix', fundRegistration.DAMLCOPrefix__c);
        JSONHelper.writeStringField(gen, 'D25 DAMLCO First Name', fundRegistration.DAMLCOFirstName__c);
        JSONHelper.writeStringField(gen, 'D26 DAMLCO Middle Name', fundRegistration.DAMLCOMiddleName__c);
        JSONHelper.writeStringField(gen, 'D27 DAMLCO Last Name', fundRegistration.DAMLCOLastName__c);
        JSONHelper.writeDateField(gen, 'D28 DAMLCO Date of Birth', fundRegistration.DAMLCODateOfBirth__c);
        JSONHelper.writeStringField(gen, 'D29 DAMLCO Country of Birth', fundRegistration.DAMLCOCountryOfBirth__c);
        JSONHelper.writeStringField(gen, 'D30 DAMLCO Gender', fundRegistration.DAMLCOGender__c);
        JSONHelper.writeStringField(gen, 'D31 DAMLCO Other names (Aliases)', fundRegistration.DAMLCOOtherNamesAliases__c);
        JSONHelper.writeStringField(gen, 'D32 DAMLCO Occupation Title', fundRegistration.DAMLCOOccupationTitle__c);
        JSONHelper.writeStringField(gen, 'D33 DAMLCO Employer', fundRegistration.DAMLCOEmployer__c);
        JSONHelper.writeStringField(gen, 'D34 DAMLCO P.O. Box', fundRegistration.DAMLCOPOBox__c);
        JSONHelper.writeStringField(gen, 'D35 DAMLCO Street Address', fundRegistration.DAMLCOStreetAddress__c );
        JSONHelper.writeStringField(gen, 'D36 DAMLCO City', fundRegistration.DAMLCOCity__c);
        JSONHelper.writeStringField(gen, 'D37 DAMLCO State/ Province', fundRegistration.DAMLCOStateProvince__c);
        JSONHelper.writeStringField(gen, 'D38 DAMLCO Country', fundRegistration.DAMLCOCountry__c);
        JSONHelper.writeStringField(gen, 'D39 DAMLCO Zip / Postal Code', fundRegistration.DAMLCOZipPostalCode__c);
        JSONHelper.writeStringField(gen, 'D40 DAMLCO Phone Number', fundRegistration.DAMLCOPhoneNumber__c);
        JSONHelper.writeStringField(gen, 'D41 DAMLCO Facsimile Number', fundRegistration.DAMLCOFacsimileNumber__c);
        JSONHelper.writeStringField(gen, 'D42 DAMLCO Email Address', fundRegistration.DAMLCOEmailAddress__c);
        if (!String.isBlank(fundRegistration.DAMLCOCVResumeTitle__c)) {
            JSONHelper.writeStringField(gen, 'D43 DAMLCO CV / Resume', 'D43 ' + fundRegistration.DAMLCOCVResumeTitle__c + '.pdf');
        } else {
            JSONHelper.writeStringField(gen, 'D43 DAMLCO CV / Resume', fundRegistration.DAMLCOCVResumeTitle__c);
        }
        gen.writeFieldName('D44 DAMLCO Qualifications');
        gen.writeStartArray();
        for (CIMAQualification__c qualification : cimaQualifications) {
            if (qualification.FormId__c == 'D44') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', qualification.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'D44i Qualification Description', qualification.Description__c);
                JSONHelper.writeDateField(gen, 'D44ii Qualification Date', qualification.Date__c);
                JSONHelper.writeStringField(gen, 'D44iii Qualification Accrediting Body', qualification.AccreditingBody__c);
                JSONHelper.writeStringField(gen, 'D44iv Qualification Type', qualification.Type__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        JSONHelper.writeStringField(gen, 'D45 MLRO CIMA ID (if known)', fundRegistration.MLROCIMAID__c);
        JSONHelper.writeStringField(gen, 'D46 MLRO Prefix', fundRegistration.MLROPrefix__c);
        JSONHelper.writeStringField(gen, 'D47 MLRO First Name', fundRegistration.MLROFirstName__c);
        JSONHelper.writeStringField(gen, 'D48 MLRO Middle Name', fundRegistration.MLROMiddleName__c);
        JSONHelper.writeStringField(gen, 'D49 MLRO Last Name', fundRegistration.MLROLastName__c);
        JSONHelper.writeDateField(gen, 'D50 MLRO Date of Birth', fundRegistration.MLRODateOfBirth__c);
        JSONHelper.writeStringField(gen, 'D51 MLRO Country of Birth', fundRegistration.MLROCountryOfBirth__c);
        JSONHelper.writeStringField(gen, 'D52 MLRO Gender', fundRegistration.MLROGender__c);
        JSONHelper.writeStringField(gen, 'D53 MLRO Other names (Aliases)', fundRegistration.MLROOtherNamesAliases__c);
        JSONHelper.writeStringField(gen, 'D54 MLRO Occupation Title', fundRegistration.MLROOccupationTitle__c);
        JSONHelper.writeStringField(gen, 'D55 MLRO Employer', fundRegistration.MLROEmployer__c);
        JSONHelper.writeStringField(gen, 'D56 MLRO P.O. Box', fundRegistration.MLROPOBox__c);
        JSONHelper.writeStringField(gen, 'D57 MLRO Street Address', fundRegistration.MLROStreetAddress__c);
        JSONHelper.writeStringField(gen, 'D58 MLRO City', fundRegistration.MLROCity__c);
        JSONHelper.writeStringField(gen, 'D59 MLRO State/ Province', fundRegistration.MLROStateProvince__c);
        JSONHelper.writeStringField(gen, 'D60 MLRO Country', fundRegistration.MLROCountry__c);
        JSONHelper.writeStringField(gen, 'D61 MLRO Zip / Postal Code', fundRegistration.MLROZipPostalCode__c);
        JSONHelper.writeStringField(gen, 'D62 MLRO Phone Number', fundRegistration.MLROPhoneNumber__c);
        JSONHelper.writeStringField(gen, 'D63 MLRO Facsimile Number', fundRegistration.MLROFacsimileNumber__c);
        JSONHelper.writeStringField(gen, 'D64 MLRO Email Address', fundRegistration.MLROEmailAddress__c);
        if (!String.isBlank(fundRegistration.MLROCVResumeTitle__c)) {
            JSONHelper.writeStringField(gen, 'D65 MLRO CV / Resume', 'D65 ' + fundRegistration.MLROCVResumeTitle__c + '.pdf');
        } else {
            JSONHelper.writeStringField(gen, 'D65 MLRO CV / Resume', fundRegistration.MLROCVResumeTitle__c);
        }
        gen.writeFieldName('D66 MLRO Qualifications');
        gen.writeStartArray();
        for (CIMAQualification__c qualification : cimaQualifications) {
            if (qualification.FormId__c == 'D66') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', qualification.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'D66i Qualification Description', qualification.Description__c);
                JSONHelper.writeDateField(gen, 'D66ii Qualification Date', qualification.Date__c);
                JSONHelper.writeStringField(gen, 'D66iii Qualification Accrediting Body', qualification.AccreditingBody__c);
                JSONHelper.writeStringField(gen, 'D66iv Qualification Type', qualification.Type__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        JSONHelper.writeStringField(gen, 'D67 DMLRO CIMA ID (if known)', fundRegistration.DMLROCIMAID__c);
        JSONHelper.writeStringField(gen, 'D68 DMLRO Prefix', fundRegistration.DMLROPrefix__c);
        JSONHelper.writeStringField(gen, 'D69 DMLRO First Name', fundRegistration.DMLROFirstName__c);
        JSONHelper.writeStringField(gen, 'D70 DMLRO Middle Name', fundRegistration.DMLROMiddleName__c);
        JSONHelper.writeStringField(gen, 'D71 DMLRO Last Name', fundRegistration.DMLROLastName__c);
        JSONHelper.writeDateField(gen, 'D72 DMLRO Date of Birth', fundRegistration.DMLRODateOfBirth__c);
        JSONHelper.writeStringField(gen, 'D73 DMLRO Country of Birth', fundRegistration.DMLROCountryOfBirth__c);
        JSONHelper.writeStringField(gen, 'D74 DMLRO Gender', fundRegistration.DMLROGender__c);
        JSONHelper.writeStringField(gen, 'D75 DMLRO Other names (Aliases)', fundRegistration.DMLROOtherNamesAliases__c);
        JSONHelper.writeStringField(gen, 'D76 DMLRO Occupation Title', fundRegistration.DMLROOccupationTitle__c);
        JSONHelper.writeStringField(gen, 'D77 DMLRO Employer', fundRegistration.DMLROEmployer__c);
        JSONHelper.writeStringField(gen, 'D78 DMLRO P.O. Box', fundRegistration.DMLROPOBox__c);
        JSONHelper.writeStringField(gen, 'D79 DMLRO Street Address', fundRegistration.DMLROStreetAddress__c);
        JSONHelper.writeStringField(gen, 'D80 DMLRO City', fundRegistration.DMLROCity__c);
        JSONHelper.writeStringField(gen, 'D81 DMLRO State/ Province', fundRegistration.DMLROStateProvince__c);
        JSONHelper.writeStringField(gen, 'D82 DMLRO Country', fundRegistration.DMLROCountry__c);
        JSONHelper.writeStringField(gen, 'D83 DMLRO Zip / Postal Code', fundRegistration.DMLROZipPostalCode__c);
        JSONHelper.writeStringField(gen, 'D84 DMLRO Phone Number', fundRegistration.DMLROPhoneNumber__c);
        JSONHelper.writeStringField(gen, 'D85 DMLRO Facsimile Number', fundRegistration.DMLROFacsimileNumber__c);
        JSONHelper.writeStringField(gen, 'D86 DMLRO Email Address', fundRegistration.DMLROEmailAddress__c );
		if (!String.isBlank(fundRegistration.DMLROCVResumeTitle__c)) {
            JSONHelper.writeStringField(gen, 'D87 DMLRO CV / Resume', 'D87 ' + fundRegistration.DMLROCVResumeTitle__c + '.pdf');
        } else {
            JSONHelper.writeStringField(gen, 'D87 DMLRO CV / Resume', fundRegistration.DMLROCVResumeTitle__c);
        }        
        gen.writeFieldName('D88 DMLRO Qualifications');
        gen.writeStartArray();
        for (CIMAQualification__c qualification : cimaQualifications) {
            if (qualification.FormId__c == 'D88') {
                gen.writeStartObject();
                JSONHelper.writeNumberField(gen, 'Sequence #', qualification.SequenceNo__c);
                JSONHelper.writeStringField(gen, 'D88i Qualification Description', qualification.Description__c);
                JSONHelper.writeDateField(gen, 'D88ii Qualification Date', qualification.Date__c);
                JSONHelper.writeStringField(gen, 'D88iii Qualification Accrediting Body', qualification.AccreditingBody__c);
                JSONHelper.writeStringField(gen, 'D88iv Qualification Type', qualification.Type__c);
                gen.writeEndObject();
            }
        }
        gen.writeEndArray();
        gen.writeEndObject();
        gen.writeEndObject();
        String jsonContent = gen.getAsString();
        return jsonContent;
        
    }
    
    @future(callout=true)
    public static void uploadAllToAmazonS3(Id privateFundRegistrationId){
        
        PrivateFundRegistration__c fundRegistration = [SELECT
													Id,
													Name,
													Account__r.Name,
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
													CIMAApplicationNumber__c,
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
													Engagement__c,
													FYEDay__c,
													FYEMonth__c,
													FirstName__c,
													FrequencyOfValuations__c,
													GPCountry__c,
													GPLegalEntityIdentifierLEI__c,
													GeneralPartnerGP__c,
													IfInCaymanNotRegisteredProvideIM__c,
													IfInCaymanSelectAdministratorName__c,
													IfInCaymanSelectInvestmentManager__c,
													IfNoProvideFreePayments__c,
													IfNoProvideNameOfNAVCalcAgent__c,
													IfNoProvideNameOfRegistrarAndTra__c,
													IfNoProvideOngoingQueries__c,
													IfNotInCaymanProvideAdministrator__c,
													IfNotInCaymanProvideIM__c,
													IfNotInCaymanSelectNameOfRegulat__c,
													IfRegulatorIsNotOnTheListInB19__c,
													IfRegulatorIsNotOnTheListInB24__c,
													IfRegulatorisNotOnTheListInB09__c,
													IndustryReference__c,
													InitialTermDurationOfFundInYears__c,
													InvestmentRestrictionsCategory__c,
													InvestmentRestrictionsDetails__c,
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
													NameC04__c,
													NameOfDepositary__c,
													NameOfDistributorIfApplicable__c,
													NameOfFund__c,
													NameOfOverseasAuditor__c,
													NameOfPromoterSponsor__c,
													NameOfRegisteredOffice__c,
													NameOfRegulatorForAdministratorContB15__c,
													NameOfRegulatorForAdministratorCont__c,
													NameOfRegulatorForNAVCalculationAg__c,
													NameOfRegulatorForRegistrarAndTran__c,
													NewInvestmentManagerApplicationRef__c,
													OfferingDocTermsSummaryMarketingMat__c,
													POBoxB03c__c,
													POBoxB05c__c,
													PrimaryInvestmentStrategyOther__c,
													PrimaryInvestmentStrategy__c,
													PrimaryStockExchangeOfFund__c,
													ProvinceStateB03e__c,
													ProvinceStateB05e__c,
													RequestedDateOfRegistration__c,
													RiskFactors__c,
													SecondaryInvestmentStrategyOther__c,
													SecondaryInvestmentStrategy__c,
													SingleFundMultiFund__c,
													Status__c,
													StreetNameAndNumberB03b__c,
													StreetNameAndNumberB05b__c,
													TelephoneNumberB03h__c,
													TelephoneNumberB05h__c,
													TrustDeedPartnDeclMemAndAssArt__c,
													Trustee__c,
													ZIPPostalCodeB03f__c,
													ZIPPostalCodeB05f__c,
													FeePaymentsRegisteredOff__c,
													FundProvideItsAdministrationServices__c,
													HasNomineeInvestors__c,
													InvestmentManagerIndependent__c,
													IsTheAMLFunctionOutsourced__c,
													IsTheNAVCalculationAgentIndependent__c,
													IsTheRegistrarAndTransferAgent__c,
													NAVCalculationAgentSameAdmin__c,
													OngoingQueriesRegisteredOff__c,
													RegisterAndTransferAgentSameAdmin__c,
                                                    IfInCaymanSelectInvestmentManager__r.Name, 
                                                    IfNotInCaymanSelectNameOfRegulat__r.Name, 
                                                    NameOfRegulatorForAdministratorContB15__r.Name,
                                                    NameOfRegulatorForRegistrarAndTran__r.Name, 
                                                    NameOfRegulatorForNAVCalculationAg__r.Name
													FROM
	                                                PrivateFundRegistration__c
	                                                WHERE Id = :privateFundRegistrationId];
        
        AWSSettings__c awsSettings = AWSSettings__c.getInstance(UserInfo.getUserId());
        String fundAsJson = PrivateFundRegistrationsJSONBuilder.convertToJSON(fundRegistration);
        
        Timezone tz = Timezone.getTimeZone('America/Bogota');
        Datetime now = Datetime.now();
        Integer offset = tz.getOffset(now);
        Datetime local = now.addSeconds(offset/1000); 
        
        String baseName = fundRegistration.Name + '_' + now.yearGmt() + now.monthGmt() + now.dayGmt() + '_' + String.valueOf(local.hourGmt()) + String.valueOf(local.minuteGmt()) + String.valueOf(local.secondGmt());
        String folderName = awsSettings.AWSS3Path__c + '/files/' + baseName + '/';
        String jsonFileName = awsSettings.AWSS3Path__c + '/pending/' + baseName + '.json';
        AmazonS3PlatformService.uploadFileToAmazonS3(Blob.valueOf(fundAsJson), jsonFileName, 'application/json');        
        
        List<ContentVersion> attachments = PrivateFundRegistrationsJSONBuilder.getListOfAttachments(privateFundRegistrationId);
        if (!attachments.isEmpty()) {
            for (ContentVersion contentVersion : attachments) {
                String contentType = AmazonS3PlatformService.getContentType(contentVersion.FileExtension);
                String rawFileName = contentVersion.Title + '.pdf';
                
                if (contentVersion.Title == fundRegistration.AttachStructureChartTitles__c) {
                    
                    rawFileName =  'A08 ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.AttachCertOfIncorporationTitles__c) {
                    
                    rawFileName =  'A09 ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.AttachTrustDeedDeclarationTitles__c) {
                    
                    rawFileName =  'A10 ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.AttachOfferingDocSummaryTitles__c) {
                    
                    rawFileName =  'A11 ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.AdministratorsConsentLetterTitle__c) {
                    
                    rawFileName =  'B14c ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.AttachConsFromRegAndTransfTitle__c) {
                    
                    rawFileName =  'B18 ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.AttachConsentFromNAVCalcAgenTitle__c) {
                    
                    rawFileName =  'B23 ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.AttachAuditorsConsentLetter__c) {
                    
                    rawFileName =  'B36 ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.ALMCOCVResumeTitle__c) {
                    
                    rawFileName =  'D21 ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.DAMLCOCVResumeTitle__c) {
                    
                    rawFileName =  'D43 ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.MLROCVResumeTitle__c) {
                    
                    rawFileName =  'D65 ' + contentVersion.Title + '.pdf';
                    
                } else if (contentVersion.Title == fundRegistration.DMLROCVResumeTitle__c) {
                    
                    rawFileName =  'D87 ' + contentVersion.Title + '.pdf';
                    
                } 
                
                String normalizedFileName = rawFileName.replace(' ', '%20');
                String fileName = folderName + normalizedFileName;
                AmazonS3PlatformService.uploadFileToAmazonS3(contentVersion.VersionData, fileName, contentType);
                
            }
        }
                
    }
    
    public static List<ContentVersion> getListOfAttachments(Id privateFundRegistrationId) {
        
        List<ContentDocumentLink> documentLinks = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :privateFundRegistrationId];
        List<Id> contentDocumentIds = new List<Id>();
        for (ContentDocumentLink documentLink : documentLinks) {
            contentDocumentIds.add(documentLink.ContentDocumentId);
        }
        List<ContentVersion> contentVersionList = [SELECT Title, FileExtension, VersionData FROM ContentVersion WHERE ContentDocumentId IN :contentDocumentIds];
        return contentVersionList;
        
    }
}