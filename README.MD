<div align="center">
   <img style="margin: 0 auto; padding-bottom: 15px; padding-top: 30px" width=40%" src="https://github.com/KravitzMC/MT5-stealth-mode/blob/main/banner.png">
</div>

# MT5-Stealth Mode

The Windows batch scripts convert MetaTrader 5 into background Windows Service. that best work only on EA, Python-MetaTrader etc. but dont't show anything UI process while running script. good for who want to running as slience mode and full performance on VPS/Server enviroment without [MT5 on VINE](https://github.com/gmag11/MetaTrader5-Docker) freezee docker.

## Feature

✅ Auto enabled allow algorithmic trading. </br>
✅ Auto enabled allow DLL import. </br>


## 👇 Quickstart

### 1. First clone repository:

🖥️  Open Command Prompt (Run as Administator) 

```bash
git clone https://github.com/KravitzMC/MT5-stealth-mode.git

cd MT5-stealth-mode
```

### 2. Basic Configuration:

Open the common.ini file, and set the Login, Password, Server values in Common section and set Symbol in StartUp section.

```bash
[Common]
Login=your_login_id
Password=your_password
Server=your_broker_server

[StartUp]
;--- please set Symbol chart only from your borker.
Symbol=XAUUSD.p           

[Experts]
AllowDllImport=1
Enabled=1
Account=0
Profile=0
Chart=0
Api=0
DisableOpenCL=
WebRequest=0
WebRequestUrl=
```

<b> Whould you like more option plese go to : [Metatrader5 Official](https://www.metatrader5.com/en/terminal/help/start_advanced/start) </b>

### 3. Install MT5-Stealth Service:

```bash
mt5_install.bat
```

on ``` services.msc ```  When you check services list you will see MT5Service (running) that install successfully.

<div align="center">
   <img style="margin: 0 auto; padding-bottom: 15px; padding-top: 30px" width=70%" src="https://github.com/KravitzMC/MT5-stealth-mode/blob/main/serv_screen.png">
</div>

for another command if you want:
* <b>Start Service :</b> ``` mt5_start.bat ```
* <b>Stop Service :</b>  ``` mt5_stop.bat ```
* <b>Uninstall Service :</b>  ``` mt5_remove.bat ```


### 4. Try running script [py-MetaTrader5](https://pypi.org/project/metatrader5/) :

Before running the script, please make sure to close all MT5 process instances.

```python
import MetaTrader5 as mt5

if not mt5.initialize():
   raise Exception("MT5 initialize failed")      

if not mt5.login(
            login=12345678,
            password="123400000",
            server="your_broker_server"):
            
    raise Exception("MT5 login failed")

print("MT5 connected")
account_info = mt5.account_info()
print("Account:", account_info.login)
print("Balance:", account_info.balance)
```

if output is : Connected to MT5 Account: 123456789 mean is service background process still working.

### 🔴 Note : 

Please test with your Demo account before trade with Live account.  and if you want to remove all order position you can remove by manually at Metatrader 5, App Broker, or by Python code.