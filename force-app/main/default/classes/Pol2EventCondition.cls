global class Pol2EventCondition implements TxnSecurity.EventCondition {

	public boolean evaluate(SObject event) {
		return true;
	}

}