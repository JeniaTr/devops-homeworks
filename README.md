# DevOps - Home Works

## Home Work 1

---

### Folder hw1p1 -- Scripting assignments
To run the script, give it the appropriate permission. From project folder:
- **$sudo chmod u+x ./hw1p1/bash.sh**

Then you can run the script. 
There are several options for launching: 
1) Just start and select the process and whois field from menu 

2) Run the script with the tags. The tag can be the __$app__ - name of the process or its PID and __$parr__ - number of parameter from whois __1-Organization 2-City 3-Country__, and also __$tailIPs__ - number of last IPs to check
 - **$./bash.sh $app $parr $tailIPs**

----

 ### Folder hw1p2 -- Become financial guru

To run the script, you need to run this command to get data for processing.

- **curl -s https://yandex.ru/news/quotes/graph_2000.json > ./quotes.json**

Not included in the script, as access to Yandex is blocked in different countries.

To run the script, you must also grant launch permission. As in the previous assignment.

- **$sudo chmod u+x ./hw1p1/h1p2**

And then run the script itself by executing the line:

- **$./h1p2.sh**

After that, the result of the script execution will be shown in the terminal. Namely, the year and the value of the minimum volatility will be shown - starting from the year specified in the script (provided that there is data from this year, if there is no data, the data will be processed starting from the first available one) and for the month specified in the script.

Year and month values are specified in the assignment (starting from 2005 and referring to the 03th month)

----
 ### Folder hw1p3 -- GitHub
 
You need to install python. Here is the installation link:

- **https://linuxize.com/post/how-to-install-python-3-8-on-ubuntu-18-04/**

And before running the script, you need to install an additional module.

- **pip install PyGithub**

Grant launch rights:

- **$sudo chmod u+x p3.sh**

After that, you can start running the script itself and performing the necessary actions. which are indicated in the __menu__.

- **./p3.sh**


Or you can run the script specifying the parameter - repository for analysis. For example:
- **./p3.sh https://github.com/PyGithub/PyGithub**

----

 ### Folder hw1p4 -- Ansible/Flask

To check the availability and the first launch to create a user for ansible, the root user is used, therefore the base user variable in __"group_vars"__ is used:

- ansible_user: root

And the key to it:

- ansible_ssh_private_key_file: /home/jenia/.ssh/admins_andersen.id_rsa

To start the process of creating our new user, we need to check for the presence of these fields (which were mentioned above) and execute this line from the ansible directory(launching the playbook):

- __ansible-playbook playbooks/02userAdd.yml__

After that we need to comment out the lines __ "group_vars" __ related to the user root. Since all further actions will be performed with an ansible sub-user. And the entrance of the rest will be blocked. Lines to be uncommented:

- ansible_user: anscfg
- ansible_ssh_private_key_file: /home/jenia/.ssh/id_rsa

After that, you can start the rest of the playbooks:

Will change the rules for entering the SSH:
- __ansible-playbook playbooks/03secure_ssh.yml__

Creates directories, loads the environment, creates services, brings up the web:

- __ansible-playbook playbooks/04flaskAppDeploy.yml__

After that, you can send requests to our site, and receive responses from it, as well as view some web pages:

flask.jeniatr.space/myIp

flask.jeniatr.space/user/id (1-3)

flask.jeniatr.space/404

flask.jeniatr.space/about

----
## Telegram bot
Change the token in the code to the one you will receive when registering the bot.

- **https://marketplace.creatio.com/sites/marketplace/files/app-guide/Instructions._Telegram_bot_1.pdf**

Put as arguments __$chat__ - chat id __$subject__ - topic  __$message__ - body of message

- **./telegram.sh $chat $subject $message**

And the message will be sent to the selected chat

---