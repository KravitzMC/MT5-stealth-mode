<div align="center">
   <img style="margin: 0 auto; padding-bottom: 15px; padding-top: 30px" width=40%" src="https://github.com/KravitzMC/MT5-stealth-mode/blob/main/banner.png">
</div>

# MT5-Stealth Mode

The Windows batch scripts convert MetaTrader 5 into background Windows Services. that best work only on EA, Python-MetaTrader etc. but dont't show anything UI process while running script.

## Feature

✅ Auto allow algorithmic trading. </br>
✅ Auto allow DLL import. </br>


## 👇 Quickstart

### 1. First clone repository:

```bash
git clone https://github.com/KravitzMC/MT5-stealth-mode.git

cd MT5-stealth-mode
```


### 2. Install MT5-Stealth Service:

🖥️  Open Command Prompt (Run as Administator) 

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


### 3. Try running script [py-MetaTrader5](https://pypi.org/project/metatrader5/) :

Before running the script, please make sure to close all MT5 process instances.

```python
import MetaTrader5 as mt5

if not mt5.initialize():
   raise Exception("MT5 initialize failed")      

if not mt5.login(
            login=12345678,
            password=123456,
            server=your_broker_server)
      ):
      raise Exception("MT5 login failed")   

print("MT5 connected")
account_info = mt5.account_info()
print("Account:", account_info.login)
```

if output is : Connected to MT5 Account: 123456789 mean is service background process still working.