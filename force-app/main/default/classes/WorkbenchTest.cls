public class WorkbenchTest {
    
    public static void contactCount() {
        List<Contact> contactsWOAccounts = [SELECT Id, AccountId FROM Contact WHERE AccountId = null LIMIT 10000];
        List<Account> accounts = [SELECT Id, Name, (SELECT Id FROM Contacts) FROM Account LIMIT 10000];
        
        //count how many contacts have the accountId field filled
        Decimal numberContactsWithAccounts = 0;
        for (Account account : accounts) {
            numberContactsWithAccounts += account.contacts.size();
        }
        
        //find the average value of contacts
        Decimal averageValueDecimal = 
            ((contactsWOAccounts.size() + numberContactsWithAccounts)/accounts.size()).round(System.RoundingMode.CEILING);
        
        Integer averageValue = Integer.valueOf(averageValueDecimal);

        
        List<Contact> contactsForAccounts = new List<Contact>();
        contactsForAccounts.addAll(contactsWOAccounts);
        
        //we find accounts in which the number of contacts is more than average and 
        //add "extra" contacts to the list of contacts for accounts
        //
        for (Account account : accounts) {
            for (Integer i = averageValue; i < account.contacts.size(); i++) {
                contactsForAccounts.add(new Contact(Id = account.contacts[i].Id));
            }
        }
        
        //we fill out accounts for which the number of contacts is less than the average number and 
        //if there are no contacts, then we create new ones
        
        List<Contact> contactsForAccountsUpsert = new List<Contact>();
        
        for (Account acc : accounts) {
            Integer contactsSize = acc.Contacts.size();
            
            while (contactsSize < averageValue) {
                if (contactsForAccounts.size() > 0) {
                    contactsForAccounts[0].AccountId = acc.Id;
                    contactsForAccountsUpsert.add(contactsForAccounts.remove(0));
                    contactsSize++;
                    
                } else {
                    Integer nextNum = contactsSize + 1;                  
                    contactsForAccountsUpsert.add(new Contact(LastName = acc.Name + nextNum, AccountId = acc.Id));
                    contactsSize++;                   
                }
            }            
        }
        System.debug(contactsForAccountsUpsert);
        upsert contactsForAccountsUpsert;
    }
}