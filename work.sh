#!/usr/bin/env bash
export COINS="BURST,BBR,CGA,HUC,DIEM,BITS,NOBL,QORA,GRC,C2,NSR,EMC2,VTC,XST,QBK,FLO,MYR,QTL,BELA,SDC,PINK,CURE,DGB,RIC,VIA,SBD,OMNI,XCN,VRC,LSK,VOX,1CR,XCP,BTM,NOTE,POT,SYNC,XVC,AMP,XDN,LBC,NBT,ETH,NXT,MAID,PPC,SJCX,LTC,BLK,XEM,STR,DOGE,SYS,BTS,XMR,ETC,IOC,MMNXT,XRP,DCR,NMC,BTCD,DASH,RADS,XPM,GAME,FCT,BITCNY,SC,NAUT,LTBC,NAV,GEO,STEEM,XBC,UNITY,CLAM,BCN,HZ,NEOS,EXP,BLOCK,RBY,XMG,RDD,FLDC,BCY"
for coin in $(echo $COINS | sed "s/,/ /g")
do  
    cat cp-config.js | sed -e "s/%coin/$coin/g; s/%year/2016/g; s/%month/08/g; s/%day_start/01/g; s/%day_end/02/g" > configs/$coin.config.js
    screen -d -m bash work-coin.sh $coin
done