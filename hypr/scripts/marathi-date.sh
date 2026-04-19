#!/usr/bin/env bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
python3 -c "
from datetime import datetime
days = {'Monday':'सोमवार','Tuesday':'मंगळवार','Wednesday':'बुधवार','Thursday':'गुरुवार','Friday':'शुक्रवार','Saturday':'शनिवार','Sunday':'रविवार'}
months = {'January':'जानेवारी','February':'फेब्रुवारी','March':'मार्च','April':'एप्रिल','May':'मे','June':'जून','July':'जुलै','August':'ऑगस्ट','September':'सप्टेंबर','October':'ऑक्टोबर','November':'नोव्हेंबर','December':'डिसेंबर'}
digits = str.maketrans('0123456789', '०१२३४५६७८९')
now = datetime.now()
day = days[now.strftime('%A')]
dd = now.strftime('%d').translate(digits)
month = months[now.strftime('%B')]
year = now.strftime('%Y').translate(digits)
print(f'{day}, {dd} {month} {year}')
"
