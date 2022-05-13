import pandas as pd
import yfinance as yf

companies = ['NAVYA.PA']
all = []
boite=['NAVYA.PA']

for i in range(len(companies)):
    data = yf.download(companies[i], start="2021-10-01", end="2022-03-17")
    name = []
    for k in range(data.shape[0]): #數據保存形式 0 =列 1=行
        name.append(boite[i])
    data.insert(loc=0, column='yuyu_name', value=name)
    #data.to_csv(rf"C:\Users\yuyup\Downloads\{c}.csv", sep=';')
    all.append(data)

all_data = pd.concat(all)
all_data.to_csv(r"C:\Users\yuyup\Downloads\sources.csv", sep=';')

print(all_data)

import pandas as pd
import matplotlib.pyplot as plt
import datetime

data = pd.read_csv(r'C:\Users\yuyup\Downloads\sources.csv', sep=';')

for c in companies:
    sub_data = data[data['yuyu_name']==c] 
    dates = sub_data['Date']
    open_price = sub_data['Open']

    x_values = [datetime.datetime.strptime(d,"%Y-%m-%d").date() for d in dates]

    plt.xlabel('Date')
    plt.ylabel('Openning price')
    plt.plot(x_values,open_price,label=c)
    plt.legend()
    plt.title('The historical opening price of the stock 2019/2021')

plt.show()
plt.savefig(r"C:\Users\yuyup\Downloads\The historical opening price of the stock 20192021.png")

for c in companies:
    sub_data = data[data['yuyu_name']==c]
    dates = sub_data['Date']
    open_price = sub_data['Volume']

    x_values = [datetime.datetime.strptime(d,"%Y-%m-%d").date() for d in dates]

    plt.plot(x_values,open_price,label=c)
    plt.legend()
    plt.title('The historical Volume of the stock 20192021')
    
plt.show()
plt.savefig(r"C:\Users\yuyup\Downloads\The historical Volume of the stock 20192021.png")
