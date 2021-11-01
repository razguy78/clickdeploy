@RestResource(urlMapping='/V1/ServiceCenters/*')
global with sharing class ServiceCenterRequest {

   //@HttpGet
    @HTTPPost
    global static List<Opportunity> getOpenOpps(id CompanyId,String UserId)//,List<Link__c>links)
    {
        Case SrvCtrReq = new case();
        Account Acc = [select id from account where id =:CompanyId ];
        SrvCtrReq.Account = Acc;
        List<Opportunity> retval = new List<Opportunity>();
        
        List<Opportunity> retval1 = new List<Opportunity>();
        system.debug('Begin getOpenOpps');
        RestRequest request = RestContext.request;
        if(request != null)
        {
        system.debug(request.requestBody);
        }
        else
        {
            system.debug('Request is null');
        }
        Opportunity oppy = new Opportunity(name = 'My new Opp',
        CloseDate = system.today() +10,
        StageName = 'Prospecting');
     insert oppy;
       /* List<Link__c> linklist = new List<Link__c>();
        for(Link__c mylink : links)
        {
           mylink.Opportunity__c = oppy.Id;
           linklist.add(mylink);
        }
  
        insert linklist;
*/
        /*JSON2Apex pyld =  JSON2Apex.parse(request.requestBody.toString());
        if(pyld != null )
        {
        Decimal Opp = 1;//decimal.valueof(request.requestURI.substring(
          //request.requestURI.lastIndexOf('/')+1));
        system.debug('The value of the account is: ' + pyld.CompanyId);
        system.debug('The value of the User is: ' + pyld.UserId);
            User usr = [Select ID from User where myusrlookup__c = :pyld.UserId];
         retval = [Select id,name,Account.name from Opportunity where isClosed!=true and (Account.Hp__c = :Opp or Account.PHp__C = :Opp)];//new List<Opportunity>();
              Map<ID,Opportunity> data = new Map<Id,Opportunity>(retval);

            List<Id> ids = new List<Id>();
            for (Opportunity myopp : retval)
            {
                ids.add(myopp.id);
            }
            
            List<UserRecordAccess> uAccess = [SELECT RecordId, HasReadAccess,HasEditAccess FROM UserRecordAccess WHERE UserId =:usr.Id  AND RecordId in :ids];
            for (UserRecordAccess acc :uAccess )
            {
                if( acc.HasReadAccess)
                {
                    retval1.add(data.get(acc.RecordId));
                }
         
            }
            return retval1;
        }
        else
        {
            system.debug('Json Parse failed with null');
        }
*/
            System.debug('End getOpenOpps');
         return retval1;

        
    }
    

}