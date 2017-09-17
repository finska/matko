# README

## Install

Run:
~~~bash
rake db:create
~~~
- Will create DB with credentials listed in config/db file 
- I've setup these credentials based on requirements of linux virtual machine  
- You may have your credentials of course  

Run:
~~~bash
- rake db:migrate
~~~

Will migrate database with all tables required for app  

Run:

~~~bash
- rake db:seed
~~~

Will populate table providers with info needed for app to work properly  

Run:

~~~bash
- rails s
~~~

To start up rails server and go to [http://localhost:3000]()
## Use case

- Choose provider from dropdown list (for now it's only have two providers to choose from)  
- Type your email address in email field
- Enter shipping code:
> Matkahuolto code is: 373325381117900560  
> DB Schenker code is: 888001103126
- Press Save

- ### Result

- On right side you will see results for that particular shipment  
 Shipment status  
 All events for that shipment
- Beneath Save button you will see question  
 "Send additional email with this info to someone?"  
 When you click this you will see form to insert additional email address to be notified
 