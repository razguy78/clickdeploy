//public with sharing class NadavTestingClass 
//{
//	public NadavTestingClass() 
//	{
//		contact_t con = (contact_t)JSON.deserialize('test', contact_t.class);
//	}

//	public void myJSONFunc()
//	{
//		contact_t con = (contact_t)JSON.deserialize('test', contact_t.class);
//	}
//}

global with sharing class NadavTestingClass {

	/**
	 * Public variables
	 */
	public customer__c 	customer_t 		{get; set;}
	public contact 		contact_t 		{get; set;}
	public String 		dataToUpdate 	{get; set;}

	public NadavTestingClass() {
		init();
	}

	/**
	 * Initialize page variables
	 */
	private void init(){
		this.customer_t = new customer__c();
		this.contact_t = new contact();
		this.dataToUpdate = '' ; //add inline comment

		String customer_tId = apexpages.currentpage().getparameters().get('customer_tId');
		String contact_tId = apexpages.currentpage().getparameters().get('contact_tId');

		if(!String.isEmpty(customer_tId)){
			this.customer_t = [SELECT Id, Name, JoinedDate__c, Description__c, NumberOfEmployees__c, Phone__c, FullName__c, AnnualRevenue__c,
						Industry__c, disable_WF__c FROM customer__c WHERE Id =: customer_tId LIMIT 1];
		}
		else{
			this.customer_t = [SELECT Id, Name, JoinedDate__c, Description__c, NumberOfEmployees__c, Phone__c, FullName__c, AnnualRevenue__c,
								Industry__c, disable_WF__c FROM customer__c LIMIT 1];
		}

		if(!String.isEmpty(contact_tId)){
			this.contact_t = [SELECT Id, FirstName, LastName, Gender__c, GUID__c ,disable_WF__c FROM contact WHERE Id =: contact_tId LIMIT 1];
		}
		else{
			this.contact_t = [SELECT Id, FirstName, LastName, Gender__c, GUID__c ,disable_WF__c FROM contact LIMIT 1];
		}
	}

	/**
	 * runReadBatch call read batch operation
	 */
	public void runReadBatch(){
		NIT_contact_Read_Batch bat = new NIT_contact_Read_Batch();
		Database.executeBatch(bat);
	}

	/**
	 * runWriteBatch call write batch operation
	 */
	public void runWriteBatch(){
		NIT_contact_Write_Batch bat = new NIT_contact_Write_Batch();
		Database.executeBatch(bat);
	}

	/**
	 * updatecustomer_t update customer_t information
	 */
	public void updatecustomer_t(){
		System.debug('SFDC this.dataToUpdate: ' + this.dataToUpdate);
		//customer_t__c customer_t = (customer_t__c)JSON.deserialize(this.dataToUpdate, customer_t__c.class);
		//contact_t contact_ttre = (contact_t)JSON.deserialize('test', contact_t.class);
		//customer_t.Id = this.customer_t.Id;
		//System.debug('SFDC customer_t: ' + customer_t);
		//update customer_t;
	}

	public void updatecustomer_t1()
	{
		SObject con = (Contact)JSON.deserialize('test', Contact.class);
	}

	
	/**
	 * updatecontact_t update contact_t information
	 */
	@RemoteAction
	global static void updatecontact(contact contact_tToUpdate){
		System.debug('SFDC objectToUpdate: ' + contact_tToUpdate);
		//contact_t customer_t = (contact_t)JSON.deserialize('test', contact_t.class);
		//update contact_t;
	}

}