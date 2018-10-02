/**
 * Created by t.shkoda on 23.08.18.
 */

trigger AdHocRevenueTrigger on Ad_hoc_Revenue__c (before insert, before update) {
    new AdHocRevenueTriggerHandler().run();

}