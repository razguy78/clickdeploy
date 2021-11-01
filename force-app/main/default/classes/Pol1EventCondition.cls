global class Pol1EventCondition implements TxnSecurity.EventCondition {

    public boolean evaluate(SObject event) {
        return true;
    }

}