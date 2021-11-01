public with sharing class NIT_0Enc_CTR {

    /**
     * Class Variables
     */
    
    /**
     * Public variables
     */
    public Customer__c customer         {get; set;}

    /**
     * Class contructor
     */
    public NIT_0Enc_CTR() {
        init();
    }

    /**
     * Initialize page variables
     */
    private void init(){
        this.customer = new Customer__c();

        String customerId = apexpages.currentpage().getparameters().get('customerId');

        try {
            this.customer = [SELECT Id, Name, JoinedDate__c, Description__c, NumberOfEmployees__c, Phone__c FROM Customer__c LIMIT 1];
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No records to display'));
        }

    }


}