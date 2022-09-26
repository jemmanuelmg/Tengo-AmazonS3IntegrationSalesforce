public class PrivateFundRegistrationService {
    
    public static void createDefaultData(List<SObject> newPrivateFundRegistrations) {
        
        List<InvestmentManagerCaymanOption__c> imco = [SELECT Name FROM InvestmentManagerCaymanOption__c WHERE Name = '(Not Reported)'];
        List<InvestmentManagerWorldOption__c> inwo = [SELECT Name FROM InvestmentManagerWorldOption__c WHERE Name = '(Not Reported)'];
        
        for (PrivateFundRegistration__c pfr : (List<PrivateFundRegistration__c>) newPrivateFundRegistrations) {

            if (!imco.isEmpty() && !inwo.isEmpty()) {
                
                if (pfr.IfInCaymanSelectInvestmentManager__c == null) {
                    pfr.IfInCaymanSelectInvestmentManager__c = imco[0].Id;
                }
                if (pfr.NameOfRegulatorForNAVCalculationAgReg__c == null) {
                	pfr.NameOfRegulatorForNAVCalculationAgReg__c = inwo[0].Id;
                }
                if (pfr.IfNotInCaymanSelectNameOfRegulat__c == null) {
                	pfr.IfNotInCaymanSelectNameOfRegulat__c = inwo[0].Id;
                }
                if (pfr.NameOfRegulatorForAdministratorContB15__c == null) {
                    pfr.NameOfRegulatorForAdministratorContB15__c = inwo[0].Id;
                }
                if (pfr.NameOfRegulatorForRegistrarAndTran__c == null) {
                    pfr.NameOfRegulatorForRegistrarAndTran__c = inwo[0].Id;
                }
            }
        }
    }

    public static void uploadRecordToAmazonS3(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        
        for (Id currentId : newItems.keySet()) {
            
            PrivateFundRegistration__c currentPFR = (PrivateFundRegistration__c) newItems.get(currentId);
            PrivateFundRegistration__c oldPFR = (PrivateFundRegistration__c) oldItems.get(currentId);
            if (currentPFR.Status__c == 'Submitted' && currentPFR.Status__c != oldPFR.Status__c ) {
				PrivateFundRegistrationsJSONBuilder.uploadAllToAmazonS3(currentId);
            }
            
        }
    }
    
    public static void addLookupToCorpServicesBU(List<PrivateFundRegistration__c> newItems,  Map<Id, PrivateFundRegistration__c> oldItems) {
        
        Map<Id, PrivateFundRegistration__c> pfrEngagementList = new Map<Id, PrivateFundRegistration__c>();
        List<CSV__c> corpServicesToUpdate = new List<CSV__c>();
        
        for (PrivateFundRegistration__c pfr : newItems) {
            if ((oldItems == null && pfr.Engagement__c != null) || (oldItems != null && pfr.Engagement__c != null && pfr.Engagement__c != oldItems.get(pfr.Id).Engagement__c)) {
                pfrEngagementList.put(pfr.Engagement__c, pfr);
            } else if (oldItems != null && pfr.Engagement__c == null && pfr.Engagement__c != oldItems.get(pfr.Id).Engagement__c) {
                pfrEngagementList.put(oldItems.get(pfr.Id).Engagement__c, null);
            }
        }     
        
        if (!pfrEngagementList.isEmpty()) {
            List<CSV__c> corpServBUList = [SELECT Engagement__c,
                                                  PrivateFundRegistration__c
                                 		   FROM CSV__c 
                                 		   WHERE Engagement__c = :pfrEngagementList.keySet()];
            for (CSV__c cs : corpServBUList) {
                PrivateFundRegistration__c relatedPFR = pfrEngagementList.get(cs.Engagement__c);
                
                if (relatedPFR != null && relatedPFR.Id != cs.PrivateFundRegistration__c) {
                	cs.PrivateFundRegistration__c = relatedPFR.Id;
                    corpServicesToUpdate.add(cs);
                } else if (relatedPFR == null && cs.PrivateFundRegistration__c != null) {
                    cs.PrivateFundRegistration__c = null;
                    corpServicesToUpdate.add(cs);
                }
                
            }          
        }    
        
        if (!corpServicesToUpdate.isEmpty()) {
            update corpServicesToUpdate;
        }

    }
    
    public static void validateAttachedFiles(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        
        for (Id currentId : newItems.keySet()) {
            
            PrivateFundRegistration__c currentPFR = (PrivateFundRegistration__c) newItems.get(currentId);
            PrivateFundRegistration__c oldPFR = (PrivateFundRegistration__c) oldItems.get(currentId);
            if (currentPFR.Status__c == 'Submitted' && currentPFR.Status__c != oldPFR.Status__c ) {
				
                List<ContentDocumentLink> documentLinks = [SELECT ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId = :currentId];
                List<Id> contentDocumentIds = new List<Id>();
                for (ContentDocumentLink documentLink : documentLinks) {
                    contentDocumentIds.add(documentLink.ContentDocumentId);
                }
                
                List<ContentVersion> contentVersionList = [SELECT Title, FileExtension, VersionData FROM ContentVersion WHERE ContentDocumentId IN :contentDocumentIds];
                List<String> fileTitlesList = new List<String>();
                for (ContentVersion record: contentVersionList) {
                    fileTitlesList.add(record.Title);
                }
                
                if (!String.isEmpty(currentPFR.AttachStructureChartTitles__c)) {
                    if (!fileTitlesList.contains(currentPFR.AttachStructureChartTitles__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.AttachStructureChartTitles__c + '\' was not found. Please review the file\'s name');
                    }
                } 
                
                if (!String.isEmpty(currentPFR.AttachCertOfIncorporationTitles__c)) {
                    if (!fileTitlesList.contains(currentPFR.AttachCertOfIncorporationTitles__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.AttachCertOfIncorporationTitles__c + '\' was not found. Please review the file\'s name');
                    }
                }
                
                if (!String.isEmpty(currentPFR.AttachTrustDeedDeclarationTitles__c)) {
                    if (!fileTitlesList.contains(currentPFR.AttachTrustDeedDeclarationTitles__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.AttachTrustDeedDeclarationTitles__c + '\' was not found. Please review the file\'s name');
                    }
                }
                
                if (!String.isEmpty(currentPFR.AttachOfferingDocSummaryTitles__c)) {
                    if (!fileTitlesList.contains(currentPFR.AttachOfferingDocSummaryTitles__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.AttachOfferingDocSummaryTitles__c + '\' was not found. Please review the file\'s name');
                    }
                }
                
                if (!String.isEmpty(currentPFR.AdministratorsConsentLetterTitle__c)) {
                    if (!fileTitlesList.contains(currentPFR.AdministratorsConsentLetterTitle__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.AdministratorsConsentLetterTitle__c + '\' was not found. Please review the file\'s name');
                    }
                }
                
                if (!String.isEmpty(currentPFR.AttachConsFromRegAndTransfTitle__c)) {
                    if (!fileTitlesList.contains(currentPFR.AttachConsFromRegAndTransfTitle__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.AttachConsFromRegAndTransfTitle__c + '\' was not found. Please review the file\'s name');
                    }
                }
                
                if (!String.isEmpty(currentPFR.AttachConsentFromNAVCalcAgenTitle__c)) {
                    if (!fileTitlesList.contains(currentPFR.AttachConsentFromNAVCalcAgenTitle__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.AttachConsentFromNAVCalcAgenTitle__c + '\' was not found. Please review the file\'s name');
                    }
                }
                
                if (!String.isEmpty(currentPFR.AttachAuditorsConsentLetter__c)) {
                    if (!fileTitlesList.contains(currentPFR.AttachAuditorsConsentLetter__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.AttachAuditorsConsentLetter__c + '\' was not found. Please review the file\'s name');
                    }
                }                
                
                if (!String.isEmpty(currentPFR.ALMCOCVResumeTitle__c)) {
                    if (!fileTitlesList.contains(currentPFR.ALMCOCVResumeTitle__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.ALMCOCVResumeTitle__c + '\' was not found. Please review the file\'s name');
                    }
                }
                
                if (!String.isEmpty(currentPFR.DAMLCOCVResumeTitle__c)) {
                    if (!fileTitlesList.contains(currentPFR.DAMLCOCVResumeTitle__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.DAMLCOCVResumeTitle__c + '\' was not found. Please review the file\'s name');
                    }
                }
                
                if (!String.isEmpty(currentPFR.MLROCVResumeTitle__c)) {
                    if (!fileTitlesList.contains(currentPFR.MLROCVResumeTitle__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.MLROCVResumeTitle__c + '\' was not found. Please review the file\'s name');
                    }
                }
                
                if (!String.isEmpty(currentPFR.DMLROCVResumeTitle__c)) {
                    if (!fileTitlesList.contains(currentPFR.DMLROCVResumeTitle__c)) {
                        newItems.get(currentId).addError('Attached file with name: \'' + currentPFR.DMLROCVResumeTitle__c + '\' was not found. Please review the file\'s name');
                    }
                }
                
            }
            
        }
        
    }
    
    public static void validateRelatedObjects(Map<Id, SObject> newItems, Map<Id, SObject> oldItems) {
        
        Set<String> a07Forc01c07 = new Set<String>(new String[] {'Ex-Unlimited Liability', 
            													 'Exempted Company', 'Exempted Company - By way of Continuation', 
                                                                 'Exempted Limited Duration Company',
            													 'Foreign Company', 
            													 'International Business Company', 
                                                                 'Limited Duration Company', 
            													 'Limited Liability Company', 
            													 'Open-Ended Investment Company', 
                                                                 'Ordinary Non-Resident', 
            													 'Ordinary Resident', 
            													 'Segregated Portfolio Company'});
        
        Set<String> a07Forc08 = new Set<String>(new String[] {'Exempt Trust', 
            												  'Unit Trust'});
        
        Set<String> a07Forc09c12 = new Set<String>(new String[] {'Exempt Limited Partnership', 
            													 'Limited Partnership', 
            													 'Open-Ended Limited Partnership', 
            													 'Partnership'});

        Set<Id> pfrIdSet = newItems.keySet();
        List<CIMAMultiFund__c> allMultifundRecords = [SELECT PrivateFundRegistration__c FROM CIMAMultiFund__c WHERE PrivateFundRegistration__c IN :pfrIdSet];
        List<CIMAParticipant__c> allParticipantRecords = [SELECT FormId__c, PrivateFundRegistration__c FROM CIMAParticipant__c WHERE PrivateFundRegistration__c IN :pfrIdSet];
        List<CIMAQualification__c> allQualificationRecords = [SELECT FormId__c, PrivateFundRegistration__c FROM CIMAQualification__c WHERE PrivateFundRegistration__c IN :pfrIdSet];
        
        List<CIMAMultiFund__c> multifunds = new List<CIMAMultiFund__c>();
        List<CIMAParticipant__c> participants = new List<CIMAParticipant__c>();
        List<CIMAQualification__c> qualifications = new List<CIMAQualification__c>();

        for (Id currentId : newItems.keySet()) {
            
            PrivateFundRegistration__c currentPFR = (PrivateFundRegistration__c) newItems.get(currentId);
            PrivateFundRegistration__c oldPFR = (PrivateFundRegistration__c) oldItems.get(currentId);
            if (currentPFR.Status__c == 'Submitted' && currentPFR.Status__c != oldPFR.Status__c ) {
                
                String errorRelatedObject = '';
                multifunds.clear();
                participants.clear();
                qualifications.clear();

                for (CIMAMultiFund__c multifund : allMultifundRecords) {
                    if (multifund.PrivateFundRegistration__c == currentId) {
                        multifunds.add(multifund);
                    }
                }

                for (CIMAParticipant__c participant : allParticipantRecords) {
                    if (participant.PrivateFundRegistration__c == currentId) {
                        participants.add(participant);
                    }
                }

                for (CIMAQualification__c qualification : allQualificationRecords) {
                    if (qualification.PrivateFundRegistration__c == currentId) {
                        qualifications.add(qualification);
                    }
                }

                
                if (currentPFR.SingleFundMultiFund__c == 'Multi Fund') {
                    if (multifunds.isEmpty()) {
                        errorRelatedObject += 'If field \'A30 Single Fund / Multi Fund\' is \'Multi Fund\', create a CIMA Multi Fund record related with this private fund registration';
                    }
                }
                
                Set<String> partSet = new Set<String>();
                for (CIMAParticipant__c p: participants) {
                    partSet.add(p.FormId__c);
                }
                for (CIMAQualification__c q: qualifications) {
                    partSet.add(q.FormId__c);
                }

                if (!partSet.contains('B10')) {
                    errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with B10 as Form Id. ';
                } 

                if (!partSet.contains('B11')) {
                    errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with B11 as Form Id. ';
                } 

                if (!partSet.contains('B26')) {
                    errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with B26 as Form Id. ';
                } 

                if (!partSet.contains('B27')) {
                    errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with B27 as Form Id. ';
                } 

                if (!partSet.contains('B28')) {
                    errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with B28 as Form Id. ';
                } 

                if (!partSet.contains('B29')) {
                    errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with B29 as Form Id. ';
                } 

                if (a07Forc01c07.contains(currentPFR.LegalStructure__c)) {
                    if (!partSet.contains('C01')) {
                        errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with C01 as Form Id. ';
                    } 

                    if (!partSet.contains('C02')) {
                        errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with C02 as Form Id. ';
                    } 

                    if (!partSet.contains('C03')) {
                        errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with C03 as Form Id. ';
                    } 

                    if (!partSet.contains('C07')) {
                        errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with C07 as Form Id. ';
                    }
                } 

                if (a07Forc09c12.contains(currentPFR.LegalStructure__c) && !partSet.contains('C12')) {
                    errorRelatedObject += 'Create a CIMA Participant record related with this private fund registration with C12 as Form Id. ';
                } 

                if (partSet.contains('C12')) {
                    List<CIMAParticipant__c> participantsC12 = [SELECT Id FROM CIMAParticipant__c 
                                                                WHERE FormId__c = 'C12' 
                                                                AND FirstName__c = '' AND PrivateFundRegistration__c = :currentId];
                    if (!participantsC12.isEmpty()) {
                        errorRelatedObject += 'One or more CIMA Participant with Form Id C12 does not have First Name filled. Please review them. ';
                    }
                } 

                if (!partSet.contains('D22')) {
                    errorRelatedObject += 'Create a CIMA Qualification record related with this private fund registration with D22 as Form Id. ';
                } 

                if (!partSet.contains('D44')) {
                    errorRelatedObject += 'Create a CIMA Qualification record related with this private fund registration with D44 as Form Id. ';
                } 

                if (!partSet.contains('D66')) {
                    errorRelatedObject += 'Create a CIMA Qualification record related with this private fund registration with D66 as Form Id. ';
                } 

                if (!partSet.contains('D88')) {
                    errorRelatedObject += 'Create a CIMA Qualification record related with this private fund registration with D88 as Form Id. ';
                } 

                if (partSet.contains('D88')) {
                    List<CIMAQualification__c> qualificationsD88 = [SELECT Id FROM CIMAQualification__c 
                                                                    WHERE FormId__c = 'D88' AND AccreditingBody__c = '' AND Type__c = '(Not Reported)' AND Date__c = null 
                                                                    AND PrivateFundRegistration__c = :currentId];
                    if (!qualificationsD88.isEmpty()) {
                        errorRelatedObject += 'One or more CIMA Qualification with Form Id D88 does not have Date, Accrediting Body or Type filled. Please review them. ';
                    }
                }

                if (errorRelatedObject != '') {
                    newItems.get(currentId).addError(errorRelatedObject);
                }
                
            }
        }
    }

    @AuraEnabled
    public static void saveA31Records(List<CIMAMultiFund__c> a31List) {
        upsert a31List;
    } 

    @AuraEnabled
    public static String createA31Record(Id pfrId) {
        CIMAMultiFund__c a31 = new CIMAMultiFund__c (PrivateFundRegistration__c = pfrId);
        insert a31;
        return a31.Id;
    } 

    @AuraEnabled
    public static void deleteA31Record(Id a31Id) {
        CIMAMultiFund__c cimaMulti = new CIMAMultiFund__c (Id = a31Id);
        delete cimaMulti;
    } 

    @AuraEnabled(cacheable=true)
    public static List<CIMAMultifund__c> getA31(Id pfrId, String refreshCacheWorkaround) {

        List<CIMAMultifund__c> a31List = [SELECT Id, Name__c, PrivateFundRegistration__c, AccountingPrinciples__c, ActualOrExpectedSizeOfInvestorBase__c, 
                                            AuditingPrinciples__c, BaseCurrencyOfOffering__c, CountryOfEstablishment__c, DetailsA31ix__c, DetailsA31xi__c, 
                                            DetailsSameAsAbovePrivateFund__c, FYEDay__c, FYEMonth__c, FrequencyOfValuations__c, InvestmentRestrictionsCategory__c, 
                                            InvestmentRestrictionsDetails__c, InvestmentVehicleType__c, MaximumAggregateOfOffering__c, MinimumAggregateOfOffering__c, 
                                            MinimumInitialInvestmentforInvestor__c, Name, PrimaryInvestmentStrategy__c, RiskFactors__c, SecondaryInvestmentStrategy__c, SequenceNo__c  
                                            FROM CIMAMultiFund__c 
                                            WHERE PrivateFundRegistration__c = :pfrId 
                                            ORDER BY SequenceNo__c];

        return a31List;
    } 

    @AuraEnabled(cacheable=true)
    public static List<CIMAQualification__c> getQualifications(Id pfrId, String formId, String refreshCacheWorkaround) {

        List<CIMAQualification__c> qualificationList = [SELECT Id, Name, PrivateFundRegistration__c, FormId__c, Description__c, 
                                                    Date__c, AccreditingBody__c, Type__c, SequenceNo__c  
                                                    FROM CIMAQualification__c 
                                                    WHERE PrivateFundRegistration__c = :pfrId AND FormId__c = :formId 
                                                    ORDER BY SequenceNo__c];

        return qualificationList;
    } 

    @AuraEnabled
    public static void saveQualificationRecords(List<CIMAQualification__c> qualificationList) {
        upsert qualificationList;

    } 

    @AuraEnabled
    public static String createQualificationRecord(Id pfrId) {
        CIMAQualification__c q = new CIMAQualification__c (PrivateFundRegistration__c = pfrId);
        insert q;
        return q.Id;
    } 

    @AuraEnabled
    public static void deleteQualificationRecord(Id qualificationId) {
        CIMAQualification__c qualificationList = new CIMAQualification__c (Id = qualificationId);
        delete qualificationList;
    }

    @AuraEnabled(cacheable=true)
    public static List<CIMAParticipant__c> getParticipants(Id pfrId, String formId, String refreshCacheWorkaround) {

        List<CIMAParticipant__c> participantList = [SELECT Id, Name, PrivateFundRegistration__c, CIMAID__c, Country__c, 
                                                    DateOfBirth__c, DirectorID__c, Director__c, EmailAddress__c, FirstName__c, 
                                                    FormId__c, LastName__c, MiddleName__c, NameOfAdvisor__c, SequenceNo__c 
                                                    FROM CIMAParticipant__c
                                                    WHERE PrivateFundRegistration__c = :pfrId AND FormId__c = :formId 
                                                    ORDER BY SequenceNo__c];
        return participantList;
    } 

    @AuraEnabled
    public static void saveParticipantRecords(List<CIMAParticipant__c> participantList) {
        upsert participantList;
    } 

    @AuraEnabled
    public static String createParticipantRecord(Id pfrId) {
        CIMAParticipant__c p = new CIMAParticipant__c (PrivateFundRegistration__c = pfrId);
        insert p;
        return p.Id;
    } 

    @AuraEnabled
    public static void deleteParticipantRecord(Id participantId) {
        CIMAParticipant__c participantList = new CIMAParticipant__c (Id = participantId);
        delete participantList;
    }

    @AuraEnabled(cacheable=true)
    public static List<sObject> getCustomPicklist(String objectApiName) {
        List<sObject> sobjList = Database.query('SELECT Name FROM '+ objectApiName + ' ORDER BY Name');
        return sobjList;
    }

    @AuraEnabled(cacheable=true)
    public static PrivateFundRegistration__c getCustomPicklistValue(String pfrId, String formId, String refreshCacheWorkaround) {

        PrivateFundRegistration__c pdf = null;
        PrivateFundRegistration__c prf;
        List<PrivateFundRegistration__c> pfr = [SELECT IfInCaymanSelectInvestmentManager__r.Id, IfInCaymanSelectInvestmentManager__r.Name,
                                                IfNotInCaymanSelectNameOfRegulat__r.Id,  IfNotInCaymanSelectNameOfRegulat__r.Name, 
                                                NameOfRegulatorForAdministratorContB15__r.Id, NameOfRegulatorForAdministratorContB15__r.Name, 
                                                NameOfRegulatorForRegistrarAndTran__r.Id, NameOfRegulatorForRegistrarAndTran__r.Name, 
                                                NameOfRegulatorForNAVCalculationAgReg__r.Id, NameOfRegulatorForNAVCalculationAgReg__r.Name
                                                FROM PrivateFundRegistration__c WHERE Id = :pfrId];

        if (formId.equals('B08a')) {
            prf = pfr[0];
        } else if (formId.equals('B09')) {
            prf = pfr[0];
        } else if (formId.equals('B15')) {
            prf = pfr[0];
        } else if (formId.equals('B19')) {
            prf = pfr[0];
        } else if (formId.equals('B24')) {
            prf = pfr[0];
        }
        return prf;
    }
    
}