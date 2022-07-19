[![Coverage Status](https://coveralls.io/repos/github/EevanR/trading-calc-api/badge.svg?branch=development)](https://coveralls.io/github/EevanR/trading-calc-api?branch=development)

# TradeLogs

TradeLogs is web service that breaks down a user's broker statement into insightful visual statistics. The data is presented through various graphs and stats, hoping to highlight overall performance, strengths, and weaknesses within the users trading habits. Other tools are available on the web application that aim to provide aid to an equities trader. Such tools are, the position calculator, the ability to save and edit strategies, and the Stock History Gap Scanner, which allows users to scan the history of a stock whose price has increased 20% or more overnight, presenting probablities for the days outcome based on what the stock has done in previous similar scenarios.  

## Deployed Site
https://www.trade-logs.com

## Dependencies
- Ruby 2.5.1
- Rails 6.0.5
- Rack-Cors
- Devise Token Auth
- Rest-Client
- Pundit
- Active Model Serializers
- Stripe Rails 1.8.11
- Coveralls_Reborn

## To test locally
#### Clone repository
```
$ git clone https://github.com/EevanR/trading-calc-api.git
$ cd trading-calc-api
```

#### Install dependencies
Install Rspec and dependencies
```
$ bundle
```

## Run testing frameworks
In console:
Run Rspec 
```
$ rspec
```

## Actions available to the user

Head to the deployed address listed above and have a look around.

#### User can:
- Login
- Upload data and review stats
- Calculate safe position sizes
- Save and review custom strategies
- Switch graphs between Net and Gross data sources
- Manage active subsciptions for access to more functionality
- change risk settings, used in position size calculation 
- Search stock history to determine End Of Day probabilities as trading tool

#### Demo account login:
Email: fake@fake.com
Password: 123456

## Updates/Improvement plans
- "How To" instructional page
- Automatic language translation
- Further breakdown and presentation of user metrics 

## License
Created under the <a href="https://en.wikipedia.org/wiki/MIT_License">MIT License</a>.
