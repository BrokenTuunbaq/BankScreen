BankScreen
Test App for Bank

Bank Screen application shows the list of banks loaded from the offline json stored in JsonBank.swift file (struct JsonBank).

According to a selection of user a list of stocks for this bank loaded from server using https://www.alphavantage API. The list is sorted by time in early->later order.

By default the time interval is one minute. There are buttons on top of the table to change the interval. Every pressing button sends a new request and reloads the table after a response received.

The third screen shows the graph of the open positions of the stock from the previous table.

- branch develop
