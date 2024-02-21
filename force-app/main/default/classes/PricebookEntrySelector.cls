public class PricebookEntrySelector {
    public static List<PricebookEntry> selectByProductCode(List<String> productCodes) {
        return [SELECT Id, UnitPrice, Product2Id, ProductCode FROM PricebookEntry WHERE ProductCode IN :productCodes AND IsActive = true];
    }
}