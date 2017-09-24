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
- Enter shipping code:
> Matkahuolto code is: 373325381117900560  
> DB Schenker code is: 888001103126
- Press Save

- ### Result

- Unique url is defined with provider and code query string
- On left side you will see results for that particular shipment  
 Shipment status  
 All events for that shipment
- Beneath you will see 'Enter email address to be informed when shipping status change!'  
 Enter your email address in input field - email is saved  
 You will see your email on right side  
- After that you will see 'Do you wish to send additional email to someone close?'  
 Type another email address if you wish - additional email is saved  
- When you refresh page after first or second email you will see notification that you not longer be informed about this shipment because is 'Delivered'  
- Email are sent immediately after you submit the form with ajax  
- With command rake shipment:schedule you can check all shipments and notify all users if shipment status is not 'Delivered'
- With this command is also possible to manage cron job to check info ex. every 5 min.
- Just in terminal type: 
~~~bash
crontab -e
~~~
- And add this line: 
~~~bash
*/5 * * * * cd /vagrant/ && /usr/local/bin/rake shipment:schedule
~~~