/**

 */
@isTest
private class HttpResponseMockCallOutInsert implements HttpCalloutMock 
{
   public HTTPResponse respond(HTTPRequest req) 
    {
        HttpResponse httpResponse = new HttpResponse();
        httpResponse .setHeader('Content-Type', 'application/json');
        httpResponse.setStatusCode(200);
        httpResponse.setBody('{"status":"Success"}');
        return httpResponse;
    } 
}