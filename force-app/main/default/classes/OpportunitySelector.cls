public class OpportunitySelector {
    public static Opportunity selectOppByName(String oppName) {
        return [SELECT Id, Name, Pricebook2Id FROM Opportunity WHERE Name = :oppName];
    }
}