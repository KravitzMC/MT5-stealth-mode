# MT5-Stealth Mode

The Windows batch scripts convert MetaTrader 4 or 5 into background Windows Services. that best work only on EA, Python-MetaTrader etc. but dont't show anything while running script, it will hide all window of MT5. 

## 👇 Quickstart

### 1. First clone repository:

```bash
git clone https://github.com/KravitzMC/MT5-stealth-mode.git

cd MT5-stealth-mode
```

### 2. Open Command Prompt (Run Admin):

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

### 4. Test running script 

Before running the script, please close all MT5 process instances.

```python
import MetaTrader5 as mt5

if not mt5.initialize():
    print("initialize() failed")
    mt5.shutdown()

print("Connected to MT5")
account_info = mt5.account_info()
print("Account:", account_info.login)
```

