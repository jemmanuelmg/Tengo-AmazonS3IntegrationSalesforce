@isTest
public class AmazonS3PlatformMockImpl implements HttpCalloutMock {
    
    public HTTPResponse respond(HTTPRequest req) {
        
        if (req.getEndpoint().contains('~')){
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"result":"Error"}');
            res.setStatusCode(400);
            return res;
            
        } else {
            
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"result":"Success"}');
            res.setStatusCode(200);
            return res;
            
        }
        
    }
    
}