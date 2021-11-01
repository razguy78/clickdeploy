public with sharing class NIT_5Enc_CTR {
    /**
     * Class Variables
     */
    
    /**
     * Public variables
     */
    public Customer__c  customer        {get; set;}
    public Contact      contact         {get; set;}

    
    /**
     * Class contructor
     */
    public NIT_5Enc_CTR() {
        init();
    }

    /**
     * Initialize page variables
     */
    private void init(){
        this.customer = new Customer__c();
        this.contact = new Contact();

        String customerId = apexpages.currentpage().getparameters().get('customerId');
        String contactId = apexpages.currentpage().getparameters().get('contactId');

        try {
                this.customer = [SELECT Id, Name, JoinedDate__c, Description__c, NumberOfEmployees__c, Phone__c, FullName__c, CompanyStartedDate__c,
                                    Industry__c FROM Customer__c LIMIT 1];
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No records to display'));
        }

        try {
                this.contact = [SELECT Id, FirstName, LastName, Gender__c FROM Contact LIMIT 1];
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'External system error'));
        }
    }
}