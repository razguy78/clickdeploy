global class NIT_Contact_Read_Batch implements Database.Batchable<sObject> {
	
	String query = 'SELECT Id, FirstName, LastName, Gender__c, Birthdate, Email, Phone, IDNumber__c FROM Contact';
	
	global NIT_Contact_Read_Batch() {
		
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		System.debug('SF: Start Contact Read Batch');
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<Contact> scope) {
   		for(Contact contact: scope){
   			System.debug('*************************************************');
			System.debug(contact);
			System.debug('+++++++++++++++++++++++++++++++++++++++++++++++++');
   		}
	}
	
	global void finish(Database.BatchableContext BC) {
		System.debug('SF: Finish Contact Read Batch');
	}
	
}