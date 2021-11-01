global with sharing class NIT_NADAVFLOWS_CTR {

	/**
	 * Public variables
	 */
	public Customer__c 		customer 			{get; set;}
	public Contact 			currentContact 		{get; set;}
	public String 			dataToUpdate 		{get; set;}

	public NIT_NADAVFLOWS_CTR() {
		init();
	}

	/**
	 * Initialize page variables
	 */
	private void init(){
		this.customer = new Customer__c();
		this.currentContact = new Contact();
		this.dataToUpdate = '';

		String customerId = apexpages.currentpage().getparameters().get('customerId');
		String contactId = apexpages.currentpage().getparameters().get('contactId');

		if(!String.isEmpty(customerId)){
			this.customer = [SELECT Id, Name, JoinedDate__c, Description__c, NumberOfEmployees__c, Phone__c, FullName__c, AnnualRevenue__c,
						Industry__c, disable_WF__c FROM Customer__c WHERE Id =: customerId LIMIT 1];
		}
		else{
			this.customer = [SELECT Id, Name, JoinedDate__c, Description__c, NumberOfEmployees__c, Phone__c, FullName__c, AnnualRevenue__c,
								Industry__c, disable_WF__c FROM Customer__c LIMIT 1];
		}

		if(!String.isEmpty(contactId)){
			this.currentContact = [SELECT Id, FirstName, LastName, Gender__c, GUID__c ,disable_WF__c FROM Contact WHERE Id =: contactId LIMIT 1];
		}
		else{
			this.currentContact = [SELECT Id, FirstName, LastName, Gender__c, GUID__c ,disable_WF__c FROM Contact LIMIT 1];
		}
	}

	/**
	 * runReadBatch call read batch operation
	 */
	public void runReadBatch(){
		NIT_Contact_Read_Batch bat = new NIT_Contact_Read_Batch();
		Database.executeBatch(bat);
	}

	/**
	 * runWriteBatch call write batch operation
	 */
	public void runWriteBatch(){
		NIT_Contact_Write_Batch bat = new NIT_Contact_Write_Batch();
		Database.executeBatch(bat);
	}

	/**
	 * updateCustomer update customer information
	 */
	public void updateCustomer(){
		System.debug('SFDC this.dataToUpdate: ' + this.dataToUpdate);
		Customer__c customer = (Customer__c)JSON.deserialize(this.dataToUpdate, Customer__c.class);
		Contact contacttre = (Contact)JSON.deserialize('test', Contact.class);
		customer.Id = this.customer.Id;
		System.debug('SFDC customer: ' + customer);
		update customer;
	}

	
	/**
	 * updateContact update currentContact information
	 */
	@RemoteAction
	global static void updateContact(Contact contactToUpdate){
		System.debug('SFDC objectToUpdate: ' + contactToUpdate);
		//update currentContact;
	}

}