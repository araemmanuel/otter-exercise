@isTest
private class PricebookEntrySelectorTest {
    @testSetup
    static void setupTestData() {        
        List<Product2> testProducts = new List<Product2>{
            new Product2(Name = 'First Product', ProductCode = 'PC1'),
            new Product2(Name = 'Second Product', ProductCode = 'PC2'),
            new Product2(Name = 'Third Product', ProductCode = 'PC3')
        };
        insert testProducts;

        List<PricebookEntry> testPricebookEntries = new List<PricebookEntry>();
        Decimal unitPrice = 100.00;
        for (Product2 p : testProducts) {
            PricebookEntry prodEntry = new PricebookEntry();
            prodEntry.Pricebook2Id = Test.getStandardPricebookId();
            prodEntry.Product2Id = p.Id;
            prodEntry.UnitPrice =  unitPrice;
            prodEntry.IsActive = true;
            testPricebookEntries.add(prodEntry);
            unitPrice+=10;
        }
        insert testPricebookEntries;
    }

    @isTest
    static void testSelectByProductCode() {
        List<String> productCodes = new List<String>{'PC1', 'PC3'};
        
        Test.startTest();
        List<PricebookEntry> selectedPricebookEntries = PricebookEntrySelector.selectByProductCode(productCodes);
        Test.stopTest();
        
        System.assertEquals(2, selectedPricebookEntries.size(), 'Must have 2 Pricebook Entries');
        System.assertEquals('PC1', selectedPricebookEntries[0].ProductCode, 'Expected the first selected PricebookEntry to have the ProductCode "P1"');
        System.assertEquals('PC3', selectedPricebookEntries[1].ProductCode, 'Expected the second selected PricebookEntry to have the ProductCode "P3"');
    }
}
