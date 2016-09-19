#!/usr/bin/env bash
export COINS="BURST,BBR,CGA,HUC,DIEM,BITS,NOBL,QORA,GRC,C2,NSR,EMC2,VTC,XST,QBK,FLO,MYR,QTL,BELA,SDC,PINK,CURE,DGB,RIC,VIA,SBD,OMNI,XCN,VRC,LSK,VOX,1CR,XCP,BTM,NOTE,POT,SYNC,XVC,AMP,XDN,LBC,NBT,ETH,NXT,MAID,PPC,SJCX,LTC,BLK,XEM,STR,DOGE,SYS,BTS,XMR,ETC,IOC,MMNXT,XRP,DCR,NMC,BTCD,DASH,RADS,XPM,GAME,FCT,BITCNY,SC,NAUT,LTBC,NAV,GEO,STEEM,XBC,UNITY,CLAM,BCN,HZ,NEOS,EXP,BLOCK,RBY,XMG,RDD,FLDC,BCY"

declare full_profit=0.0
for coin in $(echo $COINS | sed "s/,/ /g")
do
    declare coin_profit=0.0
    for day in {01..15}
    do
        declare day_end=$(printf "%02d" $((day+1)))
        echo "$coin - $day - %coin - %day_start - %day_end" | sed -e "s/%coin/$coin/g; s/%year/2016/g; s/%month/09/g; s/%day_start/$day/g; s/%day_end/$day_end/g"

        cat cp-config.js | sed -e "s/%coin/$coin/g; s/%year/2016/g; s/%month/09/g; s/%day_start/$day/g; s/%day_end/$day_end/g" > configs/$coin.config.js

        #node gekko.js --import --config configs/$coin.config.js
        node gekko.js --backtest --config configs/$coin.config.js > logs/$coin.$day.log
        #echo "2016-06-11 08:53:22 (INFO): (PROFIT REPORT) simulated yearly profit:   -435.53244 USD (-70.68152%)" > $i.log
        profit=$(egrep 'simulated profit' logs/$coin.$day.log | sed "s/.*:.*:.*BTC (//g; s/%)//g; s/[[:blank:]]//g;")
        coin_profit=$(awk '{print $1+$2}' <<<"$profit $coin_profit")
        egrep 'simulated profit' logs/$coin.$day.log | sed "s/.*:.*:/$coin;$day;/g; s/BTC//g; s/(/;/g; s/)//g; s/[[:blank:]]//g;" >> profit.csv
        echo "$coin - $profit %"
    done
    #echo "$coin;$coin_profit%" >> profit.csv
    full_profit=$(awk '{print $1+$2}' <<<"$coin_profit $full_profit")
done
echo $full_profit
echo "TOTAL;$full_profit%" >> profit.csv