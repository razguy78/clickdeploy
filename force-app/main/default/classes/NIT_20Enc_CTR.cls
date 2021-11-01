public with sharing class NIT_20Enc_CTR {
    /**
     * Class Variables
     */
    
    /**
     * Public variables
     */
    public Customer__c  customer            {get; set;}
    public Contact      contact             {get; set;}
    public Address__c   address             {get; set;}
    public FinancialAccount__c financial    {get; set;}

    
    /**
     * Class contructor
     */
    public NIT_20Enc_CTR(){
        init();
    }

    /**
     * Initialize page variables
     */
    private void init(){
        this.customer = new Customer__c();
        this.contact = new Contact();
        this.address = new Address__c();
        this.financial = new FinancialAccount__c();

        String customerId = apexpages.currentpage().getparameters().get('customerId');
        String contactId = apexpages.currentpage().getparameters().get('contactId');
        String financialId = apexpages.currentpage().getparameters().get('financialId');

        try {
                this.customer = [SELECT Id, Name, JoinedDate__c, Description__c, NumberOfEmployees__c, Phone__c, FullName__c, CompanyStartedDate__c,
                                    Industry__c, GUID__c, AnnualRevenue__c FROM Customer__c LIMIT 1];
                this.contact = [SELECT Id, FirstName, LastName, Gender__c, Birthdate, IDNumber__c, Phone, Description, GUID__c 
                                    FROM Contact LIMIT 1];
                this.address = [SELECT Id, Name, Street__c, City__c, PostalCode__c, Country__c, Type__c, PrimaryContact__c, Customer__c, GUID__c 
                                    FROM Address__c LIMIT 1];
                this.financial = [SELECT Id, Name, CeaseActivityDate__c, AccountType__c, AccountOpenedOn__c, SignatureComponents__c,
                                    AccountNumber__c, Branch__c, FullBranchNumber__c, SignatureComponentCode__c, Status__c 
                                    FROM FinancialAccount__c LIMIT 1];
        } catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'No records to display'));
        }

    }
}