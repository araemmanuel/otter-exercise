public class LeadSelector {
    public static List<Lead> selectLeadsByCompanyNames(List<String> compNames) {
        return [SELECT Id, Company FROM Lead WHERE Company IN :compNames AND Converted_To_Account__c = false];
    }
}