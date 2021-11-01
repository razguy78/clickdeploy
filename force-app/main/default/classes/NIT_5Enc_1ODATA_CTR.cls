public with sharing class NIT_5Enc_1ODATA_CTR {
    /**
     * Class Variables
     */
    
    /**
     * Public variables
     */
    public Customer__c  customer            {get; set;}
    public Contact      contact             {get; set;}
    public Contact__x   contactExternal     {get; set;}

    
    /**
     * Class contructor
     */
    public NIT_5Enc_1ODATA_CTR() {
        init();
    }

    /**
     * Initialize page variables
     */
    private void init(){
        this.customer = new Customer__c();
        this.contact = new Contact();
        this.contactExternal = new Contact__x();

        String customerId = apexpages.currentpage().getparameters().get('customerId');
        String contactId = apexpages.currentpage().getparameters().get('contactId');
        try{
            this.customer = [SELECT Id, Name, JoinedDate__c, Description__c, NumberOfEmployees__c, Phone__c, FullName__c, CompanyStartedDate__c,
                                    Industry__c FROM Customer__c LIMIT 1];
            this.contact = [SELECT Id, FirstName, LastName, Gender__c, GUID__c FROM Contact LIMIT 1];

        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No records to display'));
        }

        try{

                this.contactExternal = [SELECT BankingType__c, Age__c, CountryOfResidency__c, EnglishFirstName__c, EnglishLastName__c FROM Contact__x LIMIT 1];
        }
        catch(Exception c){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'External system error'));
        }
    }
}