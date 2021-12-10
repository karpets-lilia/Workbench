public class WorkbenchSOQL {
    
    public static void getResultQuery() {
        
        // 1. Написать SOQL запрос для получения таблицы из объекта Contact c полями Id, Name,
        //    а также полеName связанного с ним Аккаунта где LastName ‘Stark’
        
        List<Contact> contacts1 = [
            SELECT Id, Name, Account.Name
            FROM Contact
            WHERE LastName = 'Stark'
            LIMIT 50000
        ];
        
        System.debug(contacts1);
        
        //2. Написать SOQL запрос для получения таблицы из объекта Contact c полями Id, Name,
        // а также полеName связанного с ним Аккаунта где LastName будет начинаться с G’
        
        List<Contact> contacts2 = [
            SELECT Id, Name, Account.Name
            FROM Contact
            WHERE LastName LIKE 'G%'
            LIMIT 50000
        ];
        
        System.debug(contacts2);
        
        //3.Написать SOQL запрос для получения таблицы из объекта Contact c полями Id, Name,
        // а также полеName связанного с ним Аккаунта и отсортировать по дате создания(возрастание)
        List<Contact> contacts3 = [
            SELECT Id, Name, Account.Name
            FROM Contact
            ORDER BY CreatedDate DESC
            LIMIT 50000
        ];
        
        System.debug(contacts3);
        
        //4.Написать SOQL запрос для получения таблицы из объекта Contact c полями Id, Name,
        // а также полеName связанного с ним Аккаунта с 8 по 10 записи
        
        List<Contact> contacts4 = [
            SELECT Id, Name, Account.Name
            FROM Contact
            LIMIT 2 OFFSET 4
        ];
        
        System.debug(contacts4);
        //5.Написать SOQL запрос для получения таблицы из объекта Contact c полями Id, Name,
        // а также поле Name связанного с ним Аккаунта где FirstName John или LastName Snow
        
        List<Contact> contacts5 = [
            SELECT Id, Name, Account.Name
            FROM Contact
            WHERE FirstName = 'John' OR LastName = 'Snow'
            LIMIT 50000
        ];
        
        System.debug(contacts5);
        
        //6. Написать SOQL запрос для получения таблицы из объекта Lead у которой есть сотрудники
        
        List<Lead> leads = [
            SELECT Id
            FROM Lead
            WHERE NumberOfEmployees != null
            LIMIT 50000
        ];
        
        System.debug(leads);
        
        //7. Написать SOSL запрос для получения accounts, contacts, opportunities, и leads имя которыхначинается с 'ber'
        List<List<SObject>> objects = [
            FIND 'ber%' IN Name FIELDS
            RETURNING Account(Name), Contact(Name), Opportunity(Name), Lead(Name)
        ];
        
        System.debug(objects);
    }
    
}