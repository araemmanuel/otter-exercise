public class AccountTriggerHandler {
    public AccountTriggerHandler() {

    }

    public void checkExistingLeads(List<Account> accs) {
        List<String> accountNames = new List<String>();
        for (Account currentAccount : accs) {
            accountNames.add(currentAccount.Name);
        }

        List<Lead> existingLeads = LeadSelector.selectLeadsByCompanyNames(accountNames);
        List<String> existingLeadCompanies = new List<String>();
        for (Lead l : existingLeads) {
            existingLeadCompanies.add(l.Company);
        }

        for (Account a : accs) {
            if (existingLeadCompanies.contains(a.Name)) {     
                a.Name.addError('A Lead with this Company Name already exists.');
            }
        }


    }
}