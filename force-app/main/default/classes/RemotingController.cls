/*
* Written By: Naore Azenkut @ 5th Dec 2016
* Use: Performance tests only. this is not production code.
*/
public without sharing class RemotingController {
	
    @remoteAction
    @readOnly
    public static List<Account> get50kAccounts(){
        return [select name,Id from Account Limit 50000];
    }
    @remoteAction
    @readOnly
    public static List<Contact> get50kContacts(){
        return [select name,Id from Contact Limit 50000];
    }

    @remoteAction
    @readOnly
    public static List<Opportunity> get50kOpportunities(){
        return [select name,Id from Opportunity Limit 50000];
    }
    
    @remoteAction
    @readOnly
    public static Object search(String term){
        term= '*'+term+'*';
        return  
            [FIND :term IN ALL FIELDS RETURNING Customer__c (Id, Name), Contact(Id, Name), Opportunity(Id, Name), Lead(Id, Name)];

    }
    
  
}