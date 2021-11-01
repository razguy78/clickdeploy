trigger NIT_CustomerTrigger on Customer__c (before update) {
	for(Customer__c cust : Trigger.new){
		cust.QAFullNamePlainText__c = cust.FullName__c;
		if(cust.NameFieldTriggerOverride__c == true){
			cust.FullName__c = 'זהו ערך אוטומטי שנוסף על ידי טריגר';
		}
	}
}