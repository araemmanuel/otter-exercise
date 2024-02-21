@RestResource(urlMapping='/otterapi/*')
global with sharing class OtterApi {
    @HttpPost
    global static String doPost() {
        String jsonString = RestContext.request.requestBody.toString();

        Map<String, Object> rawObj = (Map<String, Object>) JSON.deserializeUntyped(jsonString);
        
        OtterApiHelper.processSignUp(
            (String)rawObj.get('companyName'),
            (String)rawObj.get('email'),
            (String)rawObj.get('phone'),
            (String)rawObj.get('address'),
            (String)rawObj.get('firstName'),
            (String)rawObj.get('lastName'),
            (String)rawObj.get('productUuid'),
            (String)rawObj.get('productQuantity'));

        Map<String, Object> response = new Map<String, Object>();
        response.put('status', 'success');
        response.put('message', 'Data received and processed successfully');
        String responseJson = JSON.serialize(response);
        return responseJson;
    }
}