public class LeadTriggerHandler {
    public LeadTriggerHandler() {

    }

    public void checkExistingAccounts(List<Lead> leads) {
        List<String> companyNames = new List<String>();
        for (Lead cLead : leads) {
            companyNames.add(cLead.Company);
        }

        List<Account> existingAccs = AccountSelector.selectAccountsByNames(companyNames);
        List<String> existingAccounts = new List<String>();
        for (Account acc : existingAccs) {
            existingAccounts.add(acc.Name);
        }

        for (Lead l : leads) {
            if (existingAccounts.contains(l.Company)) {     
                l.Company.addError('An Account with this name already exists.');
            }
        }


    }
}