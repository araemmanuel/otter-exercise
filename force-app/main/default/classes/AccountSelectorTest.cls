@isTest
private class AccountSelectorTest {

    @testSetup
    static void setupTestData() {
        List<Account> testAccounts = new List<Account>{
            new Account(Name = 'Company 1'),
            new Account(Name = 'Company 2'),
            new Account(Name = 'Company 3')
        };
        insert testAccounts;
    }

    @isTest
    static void testSelectAccountsByNames() {
        List<String> compNames = new List<String>{'Company 1', 'Company 2'};
        
        Test.startTest();
        List<Account> selectedAccounts = AccountSelector.selectAccountsByNames(compNames);
        Test.stopTest();
        
        System.assertEquals(2, selectedAccounts.size(), 'Account List should have 2 results.');
        System.assertEquals('Company 1', selectedAccounts[0].Name, 'First record should have the name "Company 1"');
        System.assertEquals('Company 2', selectedAccounts[1].Name, 'Second record should have the name "Company 2"');

        try{
            Account negativeTest = selectedAccounts[2];
        } catch (ListException e){
            System.assert(e.getMessage().contains('out of bounds'), 'Expecting List index out of bounds');
        }
    }
}