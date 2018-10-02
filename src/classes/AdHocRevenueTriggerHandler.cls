public with sharing class AdHocRevenueTriggerHandler extends TriggerHandler {

    Set<Ad_hoc_Revenue__c> q;
    private Map<Ad_hoc_Revenue__c, Set<Ad_hoc_Revenue__c>> a = new Map<Ad_hoc_Revenue__c,  Set<Ad_hoc_Revenue__c>>();
    public class PropertyClass{
        public String ObjectName { get; private set; }

        PropertyClass (String ObjectName){
            this.ObjectName = ObjectName;
        }
    }

    PropertyClass property = new PropertyClass('Property__c');
    PropertyClass account = new PropertyClass('Account');
    PropertyClass product = new PropertyClass('Product2');


    protected override void beforeInsert() {
        UpdateField();
    }
    protected override void beforeUpdate() {
        UpdateField();
    }

    private void UpdateField(){

        for (Ad_hoc_Revenue__c adHocRevenue: (List<Ad_hoc_Revenue__c>)Trigger.new) {

            SyncProductFields(product, adHocRevenue.Product_Name__c, adHocRevenue.Product__c,adHocRevenue,'Product_Name__c','Product__c');
            SyncProductFields(account, adHocRevenue.Customer_Account_Name__c, adHocRevenue.Customer_Account__c, adHocRevenue, 'Customer_Account_Name__c','Customer_Account__c');
            SyncProductFields(property, adHocRevenue.Property_Name__c, adHocRevenue.Property__c, adHocRevenue, 'Property_Name__c', 'Property__c');
        }
    }

    private Ad_hoc_Revenue__c SyncProductFields( PropertyClass propertyClassObject, String FieldDataName, String FieldDataId, Ad_hoc_Revenue__c adHoc, String FieldNameString, String FieldIdString){

        List<SObject> fieldId = Database.query('SELECT Name, Id From ' + propertyClassObject.ObjectName + ' Where Id =: Id' );
        List<SObject> fieldName = Database.query('SELECT Name, Id From ' + propertyClassObject.ObjectName + ' Where Name =: Name');

        if(FieldDataName == null || fieldName.isEmpty()){

            if(fieldId.isEmpty()){
                return adHoc;
            }

            FieldDataName = (String) fieldId[0].get('FieldDataName');
            adHoc.put(FieldNameString,FieldDataName);
            return adHoc;
        }

        FieldDataId = fieldName[0].Id;
        adHoc.put(FieldIdString, FieldDataId);
        return adHoc;

    }
}