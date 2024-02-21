public class AccountSelector {
    public static List<Account> selectAccountsByNames(List<String> compNames) {
        return [SELECT Id, Name FROM Account WHERE Name IN :compNames];
    }
}