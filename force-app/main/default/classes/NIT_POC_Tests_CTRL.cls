global with sharing class NIT_POC_Tests_CTRL {
	
	public String strToFind {get;set;}
	public Customer__c custToUpdate {get;set;}
	public List<List<Customer__c>> searchList {get;set;}
	public String inputMail {get;set;}
	public Address__c customerLookupSupplier {get;set;}
	public Customer__c customer {get; set;}
	public Contact contact {get; set;}
	public String dataToUpdate {get; set;}
	public String restApiReadBody {get; set;}
	public String restApiReadResultsBody {get; set;}
	public String endpointForWebService {get; set;}
	private Map<String, EndpointInfo__c> endpointInfoCSbyNameMap;

	public NIT_POC_Tests_CTRL() {
		this.customerLookupSupplier = new Address__c();
		this.custToUpdate = new Customer__c();
		init();
		endpointInfoCSbyNameMap = EndpointInfo__c.getall();
		system.debug('endpointInfoCSbyNameMap: '+endpointInfoCSbyNameMap);
	}

	public List<SelectOption> getItems() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('Lab','Lab endpoint')); 
        options.add(new SelectOption('RestPoc','Rest poc endpoint')); return options; 
    }

	public void getSoslResults(){
		this.searchList = null;
		if(String.isNotBlank(this.strToFind)){
			try{
				this.searchList = [FIND :strToFind IN ALL FIELDS 
                                      RETURNING Customer__c(Name, Description__c, Industry__c, FullName__c)];
            }
            catch(Exception x){
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Search failed, try to add more characters..'));
            }
            if(this.searchList == null || this.searchList.size() == 0 || (this.searchList.size() == 1 && this.searchList[0].size() == 0)){
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Info,'No customers were found for the keyword '+'"'+this.strToFind+'"'));
            }	
		}
		else{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please enter a value to search for'));
		}
	}

	public void popCustomerValues(){
		try{
			this.restApiReadBody = '';
			List<Customer__c> customerList = [SELECT Id, disable_WF__c , FullName__c, JoinedDate__c, CompanyStartedDate__c, CompanyRegistrationNumber__c, NumberOfEmployees__c, Name, Industry__c, Description__c FROM Customer__c WHERE Id =: this.customerLookupSupplier.Customer__c];
			if(customerList != null && customerList.size() > 0){
				this.custToUpdate = customerList[0];
			}
			this.restApiReadBody = '{'+
				+'"FullName":"'+this.custToUpdate.FullName__c+'"'
				+'"JoinedDate":"'+this.custToUpdate.JoinedDate__c+'"'
				+'"CompanyStartedDate":"'+this.custToUpdate.CompanyStartedDate__c+'"'
				+'"CompanyRegistrationNumber":"'+this.custToUpdate.CompanyRegistrationNumber__c+'"'
				+'"NumberOfEmployees":"'+this.custToUpdate.NumberOfEmployees__c+'"'
			+'}';
			system.debug('TEST BODY: '+this.restApiReadBody);
		}
		catch(Exception x){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please select a valid customer!'));
		}
	}

	public void sendEmailWithDecryptedFields(){
		//List<Customer__c> custList = [SELECT FullName__c, Name, Industry__c, Description__c FROM Customer__c WHERE Id =: this.customerLookupSupplier.Customer__c];
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddresses = new String[] {};
		toAddresses.add(inputMail);
		mail.setToAddresses(toAddresses);
		mail.setSubject('Test mail');
		mail.setSenderDisplayName('Salesforce Support');
		if(String.isNotBlank(String.valueOf(this.customerLookupSupplier.Customer__c))){
			mail.setHtmlBody('The customer info: name: '+custToUpdate.Name+', full name: '+custToUpdate.FullName__c+', industry: '+custToUpdate.Industry__c+', description: '+custToUpdate.Description__c);
			try{
				Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Email sent to '+inputMail+' !'));
			}
			catch(Exception x){
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please enter a valid Email!'));
			}
		}
		else{
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please select a valid customer!'));
		}
	}

	public void updateCustomer(){
		try{
			this.custToUpdate.Id = this.customerLookupSupplier.Customer__c;
			system.debug('this.custToUpdate.Id: '+this.custToUpdate.Id);
			update this.custToUpdate;
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Customer has been updated!'));
		}
		catch(Exception x){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Could not update the customer!'));
		}
	}

	/**
	 * Initialize page variables
	 */
	private void init(){
		this.customer = new Customer__c();
		this.contact = new Contact();
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
			this.contact = [SELECT Id, FirstName, LastName, Gender__c, GUID__c ,disable_WF__c FROM Contact WHERE Id =: contactId LIMIT 1];
		}
		else{
			this.contact = [SELECT Id, FirstName, LastName, Gender__c, GUID__c ,disable_WF__c FROM Contact LIMIT 1];
		}
	}

	/**
	 * runReadBatch call read batch operation
	 */
	public void runReadBatch(){
		NIT_Contact_Read_Batch bat = new NIT_Contact_Read_Batch();
		Database.executeBatch(bat, 5);
	}

	/**
	 * runWriteBatch call write batch operation
	 */
	public void runWriteBatch(){
		NIT_Contact_Write_Batch bat = new NIT_Contact_Write_Batch();
		Database.executeBatch(bat, 5);
	}

	/**
	 * updateCustomer update customer information
	 */
	public void updateCustomer2(){
		System.debug('SFDC this.dataToUpdate: ' + this.dataToUpdate);
		Customer__c customer = (Customer__c)JSON.deserialize(this.dataToUpdate, Customer__c.class);
		customer.Id = this.customer.Id;
		System.debug('SFDC customer: ' + customer);
		update customer;
	}

	/**
	 * updateContact update contact information
	 */
	@RemoteAction
	global static void updateContact(Contact contactToUpdate){
		System.debug('SFDC objectToUpdate: ' + contactToUpdate);
		//update contact;
	}

	/**
	 * rest_API_Read_Method makes a callout using rest API to receive decrypted values
	 */
	public void rest_API_Read_Method(){
		String endpoint = '';
		try{
			endpoint = this.endpointInfoCSbyNameMap.get(this.endpointForWebService).Url__c;
		}
		catch(Exception x){
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please select a valid endpoint!'));
		}
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('POST');
        if(String.isNotBlank(String.valueOf(this.customerLookupSupplier.Customer__c))){
	        request.setBody(this.restApiReadBody);
	        HttpResponse response = http.send(request);
	        system.debug('ISRAEL TEST RESPONSE = '+response);
	        system.debug('ISRAEL TEST RESPONSE Body= '+response.getBody());
	        this.restApiReadResultsBody = response.getBody();
	        if (response.getStatusCode() == 200) {
	        	this.restApiReadResultsBody = response.getBody();
	        }
	        else{
	        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error code not equal to 200 received'));
	        }
	    }
	    else{
	    	this.restApiReadResultsBody = '';
	    	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Please select a valid customer!'));
	    }
	}

	/**
	 * soap_API_Read_Method makes a callout using soap API to receive decrypted values
	 */
	public void soap_API_Read_Method(){

	}

	/**
	 * rest_API_Write_Method
	 */
	public void rest_API_Write_Method(){

	}
}