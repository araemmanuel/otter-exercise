@isTest
private class LeadSelectorTest {

    @testSetup
    static void setupTestData() {
        List<Lead> testLeads = new List<Lead>{
            new Lead(Company = 'Lead Company Name 1', LastName = 'testName1'),
            new Lead(Company = 'Lead Company Name 2', LastName = 'testName2'),
            new Lead(Company = 'Lead Company Name 3', LastName = 'testName3')
        };
        insert testLeads;
    }

    @isTest
    static void testselectLeadsByCompanyNames() {
        List<String> compNames = new List<String>{'Lead Company Name 1', 'Lead Company Name 2'};
        
        Test.startTest();
        List<Lead> selectedLeads = LeadSelector.selectLeadsByCompanyNames(compNames);
        Test.stopTest();
        
        System.assertEquals(2, selectedLeads.size(), 'Lead List should have 2 results.');
        System.assertEquals('Lead Company Name 1', selectedLeads[0].Company, 'First lead must have the name "Lead Company Name 1"');
        System.assertEquals('Lead Company Name 2', selectedLeads[1].Company, 'Second lead must have the name "Lead Company Name 2"');

        try{
            Lead negativeTest = selectedLeads[2];
        } catch (ListException e){
            System.assert(e.getMessage().contains('out of bounds'), 'Expecting List index out of bounds');
        }
    }
}