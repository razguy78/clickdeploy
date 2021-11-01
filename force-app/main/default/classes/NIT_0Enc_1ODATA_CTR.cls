public with sharing class NIT_0Enc_1ODATA_CTR {
    /**
     * Class Variables
     */
    
    /**
     * Public variables
     */
    public Customer__c          customer            {get; set;}
    public Customer_External__x customerExternal    {get; set;}

    /**
     * Private variables
     */
    private String customerId;

    
    /**
     * Class contructor
     */
    public NIT_0Enc_1ODATA_CTR() {
        init();
    }

    /**
     * Initialize page variables
     */
    private void init(){
        try{
            this.customer = new Customer__c();
            this.customerExternal = new Customer_External__x();
    
            this.customer = [SELECT Id, Name, JoinedDate__c, Description__c, NumberOfEmployees__c, Phone__c, GUID__c FROM Customer__c LIMIT 1];        
            this.customerExternal = [SELECT TargetSector__c, Slice__c, ManagingCustomerNumber__c, BusinessSector__c FROM Customer_External__x LIMIT 1];
        }catch(Exception c){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'External system error'));
        }
    }

}