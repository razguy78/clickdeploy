public class HttpApexProxy {
	
    public class CallOutParams{
        @InvocableVariable
        public String method;
	
        @InvocableVariable
        public String relativePath;

    	@InvocableVariable
        public String namedCredentialName;
   
        @InvocableVariable
        public list<String> headerNameList;

        @InvocableVariable
        public list<String> headerValueList;

        @InvocableVariable
        public String body;
		
        @InvocableVariable
        public list<String> URLParams;
    }
    
    @InvocableMethod(label='Perform Proxied Callout' description='Performs an https callout, based on name credential with custom params, headers & body')
    public static List<String> doCallout(List<CallOutParams> paramList){
        List<String> retList = new List<String>();
		
        // Security check that the action started from the UI.
        //system.assert(System.currentPageReference() !=Null, 'API Calls Are not allowed for this method');
        
        system.assert( paramList !=null && paramList.size() == 1, 'Method Accepts exactly 1 callout specification');

        CallOutParams callPar = paramList[0];
        system.debug('callPar: ' + callPar);
        
        // Instantiate a new http object
        HttpRequest req = new HttpRequest();
		req.setEndpoint('callout:'+callPar.namedCredentialName+'/'+callPar.relativePath);
		req.setMethod(callPar.method);
		
        //sets headers
        for (Integer i=0; callPar.headerNameList!= null && i<callPar.headerNameList.size() ; i++){
            req.setHeader(callPar.headerNameList[i],callPar.headerValueList[i]);
        }
        
        HTTPResponse res = (new Http()).send(req);
        
        // todo:
        // a. Input validation
        // b. Response Structuring
        // c. Error Handling
        retList.add(res.getBody());
        return retList;
    }
    
}