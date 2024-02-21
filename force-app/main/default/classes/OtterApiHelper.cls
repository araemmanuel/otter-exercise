public class OtterApiHelper {
    public OtterApiHelper() {

    }
    @future
    public static void processSignUp(String compName,String customEmail,String customPhone,String customAddress,String firstName,String lastName,String prodUuids,String prodQuantities) {

        Map<String, Object> parameters = new Map<String, Object>();
        parameters.put('CompanyName', compName);
        parameters.put('CustomEmail', customEmail);
        parameters.put('Phone', customPhone);
        parameters.put('Address', customAddress);
        parameters.put('FirstName', firstName);
        parameters.put('LastName', lastName);
        Flow.Interview.Otter_Sign_Up otterFlow = new Flow.Interview.Otter_Sign_Up(parameters);
        otterFlow.start();

        assignProducts(compName, prodUuids, prodQuantities);
    }
    
    public static Boolean assignProducts(String compName, String uuids, String quantities) {
        
        Opportunity selectedOpp = OpportunitySelector.selectOppByName(compName);
        if (selectedOpp != null) {
            List<String> selectedProductUuids = uuids.split(',');
            List<String> selectedProductQuant = quantities.split(',');
            List<PricebookEntry> pricebookProducts = PricebookEntrySelector.selectByProductCode(selectedProductUuids);

            Map<String, PricebookEntry> pricebookEntryMap = new Map<String, PricebookEntry>();
            for(PricebookEntry prod : pricebookProducts) {
                pricebookEntryMap.put(prod.ProductCode, prod);
            }
            
            List<OpportunityLineItem> productsToInsert = new List<OpportunityLineItem>();
            for (Integer key = 0; key < selectedProductUuids.size(); key++) {
                OpportunityLineItem item = new OpportunityLineItem();
                
                String prodCode = selectedProductUuids[key];
                Integer quanti = Integer.valueOf(selectedProductQuant[key]);
                PricebookEntry pEntry = pricebookEntryMap.get(prodCode);
                
                item.OpportunityId = selectedOpp.Id;
                item.Product2Id = pEntry.Product2Id;
                item.Quantity = quanti;
                item.TotalPrice = pEntry.UnitPrice*quanti;

                productsToInsert.add(item);
            }
            if (!productsToInsert.isEmpty()) {
                insert productsToInsert;
                selectedOpp.StageName = 'Closed Won';
                update selectedOpp;
                return true;
            }
            return false;
         }
         return false;
    }

}