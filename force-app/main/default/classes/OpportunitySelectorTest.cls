@isTest
private class OpportunitySelectorTest {

    @testSetup
    static void setupTestData() {
        List<Account> testAccounts = new List<Account>{
            new Account(Name = 'Test Account 1'),
            new Account(Name = 'Test Account 2')
        };
        insert testAccounts;

        Date defaultClose = System.today()+5;
        List<Opportunity> testOpps = new List<Opportunity>{
            new Opportunity(Name = 'Test Opp 1', CloseDate = defaultClose, StageName = 'Prospecting', AccountId = testAccounts[0].Id),
            new Opportunity(Name = 'Test Opp 2', CloseDate = defaultClose, StageName = 'Prospecting', AccountId = testAccounts[1].Id)
        };
        insert testOpps;
    }

    @isTest
    static void testSelectOppByName() {
        String oppName = 'Test Opp 1';

        Test.startTest();
        Opportunity selectedOpportunity = OpportunitySelector.selectOppByName(oppName);
        Test.stopTest();

        System.assertNotEquals(null, selectedOpportunity, 'Must have a selected opportunity');
        System.assertEquals('Test Opp 1', selectedOpportunity.Name, 'Opportunity selected must have the name "Test Opp 1"');
    }
}