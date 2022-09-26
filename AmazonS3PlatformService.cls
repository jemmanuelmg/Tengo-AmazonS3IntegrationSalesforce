public class AmazonS3PlatformService {
    
    public static HTTPResponse uploadFileToAmazonS3(Blob blobFileToUpload, String fileName, String contentType) {
        
        AWSSettings__c awsSettings = AWSSettings__c.getInstance(UserInfo.getUserId());
        String attachmentBody = EncodingUtil.base64Encode(blobFileToUpload);
        String formattedDateString = Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z');
        String key = awsSettings.AWSS3Key__c; 
        String secret = awsSettings.AWSS3Secret__c; 
        String bucketname = awsSettings.AWSS3BucketName__c;
        String region = awsSettings.AWSS3Region__c;
        String host = 's3.' + region + '.amazonaws.com';
        String method = 'PUT';
        
        HttpRequest req = new HttpRequest();
        req.setMethod(method);
        req.setEndpoint('callout:AmazonS3Credential1' + '/' + fileName);
        System.debug('The endpoint configured');
        System.debug(req.getEndpoint());
        req.setHeader('Host', bucketname + '.' + host);
        req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
        req.setHeader('Content-Encoding', 'UTF-8');
        req.setHeader('Content-type', contentType);
        req.setHeader('Connection', 'keep-alive');
        req.setHeader('Date', formattedDateString);
        req.setHeader('ACL', 'public-read-write');
        req.setBodyAsBlob(EncodingUtil.base64Decode(attachmentBody));
        
        Http http = new Http();
        HTTPResponse response = http.send(req);
        System.debug('The response status code is');
        System.debug(response.getStatusCode());
        System.debug('The response body is');
        System.debug(response.getBody());
        return response;
        
    }
        
    public static String getContentType(String fileExtension) {
        
        String contentType = '';
        switch on fileExtension {
            when 'pdf' {		
                contentType = 'application/pdf';
            }	
            when 'ppt', 'pptx' {		
                contentType = 'application/vnd.ms-powerpoint';
            }
            when 'doc', 'docx' {		
                contentType = 'application/msword';
            }
            when 'xls', 'xlsx' {		
                contentType = 'application/vnd.ms-excel';
            }
            when 'csv' {		
                contentType = 'text/csv';
            }
            when 'png' {		
                contentType = 'image/png';
            }
            when 'jpeg', 'jpg' {		
                contentType = 'image/jpeg';
            }
            when 'gif' {		
                contentType = 'image/gif';
            }
            when 'mp3' {		
                contentType = 'audio/mpeg';
            }
            when 'mp4' {		
                contentType = 'video/mp4';
            }
            when 'zip' {		
                contentType = 'application/zip';
            }
            when 'rar' {		
                contentType = 'application/x-rar-compressed';
            }
            when 'xml' {		
                contentType = 'application/xml';
            }
            when 'json' {		
                contentType = 'application/json';
            }
            when 'txt', 'eml' {		
                contentType = 'text/plain';
            }
            
                
        }
        return contentType;
        
    }
    
}