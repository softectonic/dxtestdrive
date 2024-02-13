public without sharing class Foo {
    void foo() {
        //Error - hardcoded the record type id
        Account a = [SELECT Id, RecordTypeId FROM Account Limit 1];
        if (a.RecordTypeId == '012500000009WAr') {
            //do some logic here.....
        } else if (a.RecordTypeId == '0123000000095Km') {
            //do some logic here for a different record type...
        }
    }

    public void doSomething() {
        try {
            Account a = new Account();
            a.Name = 'ABC Limited';
            insert a;
        } catch (DmlException dmle) {
            // not good
        }
    }

    public void bar() {
        try {
          // empty try!
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
