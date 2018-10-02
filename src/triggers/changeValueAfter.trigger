trigger changeValueAfter on Account (after insert) {

    //list of new instance of object to update. 
    Account[] accounts = new Account[]{};

    for (Account a: Trigger.new) {
        //here the magic by creating a new instance using the same id
        Account aux  = new Account(Id = a.Id);
        aux.Name =  a.Id + 'Value forced to be set after by an extrange req';
        accounts.add(aux);
    }
    //then update the new instance list. 
    update accounts;
}