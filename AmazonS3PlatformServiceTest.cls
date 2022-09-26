@isTest
public class AmazonS3PlatformServiceTest {

    @testSetup 
    static void setup() {
        
        AWSSettings__c awsSetting = new AWSSettings__c();
        awsSetting.AWSS3BucketName__c = 'test-bucket-name';
        awsSetting.AWSS3Key__c = 'ABCDEFG1234567';
        awsSetting.AWSS3Secret__c = 'DZngp9RJqWx6WovchjHY78FVKO3c4yVLa8EgVV80';
        awsSetting.AWSS3Region__c = 'us-east-1';
        insert awsSetting;
        
    }
    
    @isTest
    static void testPositiveUploadFileToAmazonS3() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        
        Test.startTest();
        	HTTPResponse response = AmazonS3PlatformService.uploadFileToAmazonS3(Blob.valueOf('test content'), 'Test File 01', 'text/plain');
        Test.stopTest();
        
        System.assertEquals(200, response.getStatusCode(), 'Expected to have a response with status code of 200');
        
    }
    
    @isTest
    static void testNegativeUploadFileToAmazonS3() {
        
        Test.setMock(HttpCalloutMock.class, new AmazonS3PlatformMockImpl());
        
        Test.startTest();
        	HTTPResponse response = AmazonS3PlatformService.uploadFileToAmazonS3(Blob.valueOf('test content'), 'Test~File~01', 'text/plain');
        Test.stopTest();
        
        System.assertEquals(400, response.getStatusCode(), 'Expected to have a response with status code of 400');
        
    }
    
    @isTest
    static void testPositiveGetContentType() {
        
        List<String> fileExtensionList = new List<String>{'pdf', 'ppt', 'doc', 'xls', 'csv', 'png', 'jpeg', 'gif', 'mp3', 'mp4', 'zip', 'rar', 'xml', 'json', 'txt'};
        String contentType = '';
        Test.startTest();
            for (String extension : fileExtensionList) {
                contentType = AmazonS3PlatformService.getContentType(extension);
            }
        Test.stopTest();
        
        System.assertEquals('text/plain', contentType, 'Expected to have \'text/plain\' as the last returned content type');
        
    }
    
    @isTest
    static void testNegativeGetContentType(){
        
       	String extension = 'xyz';
        Test.startTest();
        	String contentType = AmazonS3PlatformService.getContentType(extension);
        Test.stopTest();
        
        System.assertEquals('', contentType, 'Expected to have an empty sting as the returned content type');
        
    }
    
}