#!/usr/bin/env bash
export coin=$1
export day=$2

declare profit=0.0
declare day_end=$(printf "%02d" $((day+1)))
echo "$coin - $day - %coin - %day_start - %day_end" | sed -e "s/%coin/$coin/g; s/%year/2016/g; s/%month/09/g; s/%day_start/$day/g; s/%day_end/$day_end/g"

cat cp-config.js | sed -e "s/%coin/$coin/g; s/%year/2016/g; s/%month/08/g; s/%day_start/$day/g; s/%day_end/02/g" > configs/$coin.config.js

node gekko.js --import --config configs/$coin.config.js
node gekko.js --backtest --config configs/$coin.config.js &> logs/$coin.$day.log
#echo "2016-06-11 08:53:22 (INFO): (PROFIT REPORT) simulated yearly profit:   -435.53244 USD (-70.68152%)" > $i.log
profit=$(egrep 'simulated profit' logs/$coin.$day.log | sed "s/.*:.*:.*BTC (//g; s/%)//g; s/[[:blank:]]//g;")
coin_profit=$(awk '{print $1+$2}' <<<"$profit $coin_profit")
egrep 'simulated profit' logs/$coin.$day.log | sed "s/.*:.*:/$coin;$day;/g; s/BTC//g; s/(/;/g; s/)//g; s/[[:blank:]]//g;" >> profit.csv
echo "$coin - $profit %"