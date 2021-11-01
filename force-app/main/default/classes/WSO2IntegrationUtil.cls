/*
    Client Credential oAuth Salesforce.com Flow
    POC class designed to showcase best practice approach for token management and HTTP call wrapper for BNHP Implementation
    Error Correction is not currently implemented, all exception bubble right up.
 */

public with sharing class WSO2IntegrationUtil {
    public class AuthenticationException extends Exception{}

    private static final string WSO2_NAMED_CRED = 'WSO2_ClientCred';
    private static final string WSO2_CS_RECORD_NAME = 'WSO2ClientCredCust';
    private static final Integer MAX_AUTH_TRY = 2;
    private static final WSO2ClientCredentialsLogin2__c AUTH_CONFIG_DATA = WSO2ClientCredentialsLogin2__c.getValues(WSO2_CS_RECORD_NAME);

    private static Integer authRetryCount = 0;
    private static String accessToken {get{
                                        if (accessToken == null) {
                                            return AUTH_CONFIG_DATA.Access_Token__c;
                                        }else{
                                            return accessToken;
                                        }
                                    } private set;}

    public static String getDataFromCommonESBService(String relativeURL,String body, Map<String,String> headerMap, Boolean allowDML){
        relativeURL = relativeURL.startsWith('/')? relativeURL : ('/'+relativeURL);

        headerMap = headerMap != null ? headerMap : new Map<String,String>();
        headerMap.put('Authorization', 'Bearer ' + accessToken);

        HttpResponse res = doCalloutByParams('callout:'+ WSO2_NAMED_CRED + relativeURL, 'POST',body,headerMap);

        if (res.getStatusCode() == 401){
            accessToken = getNewAccessToken();
            return getDataFromCommonESBService(relativeURL,body,headerMap,allowDML);
        }

        if (authRetryCount >  0 && allowDML != null && allowDML){
            updateCustomSettingWithFreshAccessToken (accessToken);
        }

        return res.getBody();
    }


    private static HTTPResponse doCalloutByParams(String url, String method,String body,Map <String,String> headerMap){
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod(method);
        req.setBody(body);

        for (String key: headerMap.keySet())
            req.setHeader(key, headerMap.get(key));

        Http http = new Http();
        HTTPResponse res = http.send(req);

        return res;
    }

    private static String getNewAccessToken() {
        authRetryCount++;
        if (authRetryCount > MAX_AUTH_TRY ){
            throw new AuthenticationException('Unable to recieve Access Token for auth params WSO2ClientCredentialsLogin2__c.getValues(' + WSO2_CS_RECORD_NAME +')');
        }

        Map<String,String> authHeaderMap = new map <String,String> {
                'Authorization'=>
                        ('Basic ' + EncodingUtil.base64Encode(Blob.valueOf(AUTH_CONFIG_DATA.Consumer_Key__c + ':' + AUTH_CONFIG_DATA.Consumer_Secret__c )) )
        };

        HttpResponse authRes = doCalloutByParams(AUTH_CONFIG_DATA.Token_Endpoint_URL__c, 'POST','grant_type=client_credentials', authHeaderMap);

        if (authRes.getStatusCode() != 200){
            return getNewAccessToken();
        }

        return ((Map<string,string>) JSON.deserialize(authRes.getBody(), Map<string,string>.class)).get('access_token');
    }

    private static void updateCustomSettingWithFreshAccessToken(String newAccessTokenVal){
        update new WSO2ClientCredentialsLogin2__c(Id= AUTH_CONFIG_DATA.Id, Access_Token__c=newAccessTokenVal);
    }
}