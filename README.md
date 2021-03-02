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
## Telegram bot
Change the token in the code to the one you will receive when registering the bot.

- **https://marketplace.creatio.com/sites/marketplace/files/app-guide/Instructions._Telegram_bot_1.pdf**

Put as arguments __$chat__ - chat id __$subject__ - topic  __$message__ - body of message

- **./telegram.sh $chat $subject $message**

And the message will be sent to the selected chat