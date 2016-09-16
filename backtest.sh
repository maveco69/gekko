#!/usr/bin/env bash
#BURST,BBR,CGA,HUC,DIEM,BITS,NOBL,QORA,GRC,C2,NSR,EMC2,VTC,XST,QBK,FLO,MYR,QTL,BELA,SDC,PINK,CURE,DGB,RIC,VIA,SBD,OMNI,XCN,VRC,
export COINS="LSK,VOX,1CR,XCP,BTM,NOTE,POT,SYNC,XVC,AMP,XDN,LBC,NBT,ETH,NXT,MAID,PPC,SJCX,LTC,BLK,XEM,STR,DOGE,SYS,BTS,XMR,ETC,IOC,MMNXT,XRP,DCR,NMC,BTCD,DASH,RADS,XPM,GAME,FCT,BITCNY,SC,NAUT,LTBC,NAV,GEO,STEEM,XBC,UNITY,CLAM,BCN,HZ,NEOS,EXP,BLOCK,RBY,XMG,RDD,FLDC,BCY"

for coin in $(echo $COINS | sed "s/,/ /g")
do
    for day in {01..01}
    do
        declare day_end=$(printf "%02d" $((day+1)))
        echo "$coin - $day - %coin - %day_start - %day_end" | sed -e "s/%coin/$coin/g; s/%year/2016/g; s/%month/09/g; s/%day_start/$day/g; s/%day_end/$day_end/g"

        cat cp-config.js | sed -e "s/%coin/$coin/g; s/%year/2016/g; s/%month/09/g; s/%day_start/$day/g; s/%day_end/15/g" > configs/$coin.config.js

        node gekko.js --import --config configs/$coin.config.js
        #node gekko.js --backtest --config configs/$coin.config.js > logs/$coin.$day.log
        #echo "2016-06-11 08:53:22 (INFO): (PROFIT REPORT) simulated yearly profit:   -435.53244 USD (-70.68152%)" > $i.log
        #egrep 'simulated profit' logs/$coin.$day.log >> profit.csv
    done
done