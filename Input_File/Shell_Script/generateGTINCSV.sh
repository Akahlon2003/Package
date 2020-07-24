dateStamp=`date "+%Y%m%d"`
#dateStamp='20160425'


#if [ -s /ccdq/archive/gtin_table_$dateStamp.sql.gz ]
#then
echo "Connecting to Database....."
mysql -h localhost -P 3306 -u root -p"!ccdqmysql123$" DB_PRD_CCDQ --execute="select cast(TIME_STAMP AS DATE) as Date1 , count(*) from DB_PRD_CCDQ.gtinXML group by 1 order by 1;"

echo "Start time - " `date "+%Y-%m-%d %H:%M:%S" `
mysql -h localhost -P 3306 -u root -p"!ccdqmysql123$" DB_PRD_CCDQ < /home/ec2-user/GTIN/Extract_Query_GTin.sql
echo "End time - " `date "+%Y-%m-%d %H:%M:%S" `

echo "Renaming and moving the csv file "
sudo mv "/var/lib/mysql/DB_PRD_CCDQ/Lansa_Extr.csv" "/ccdq/outbound/GTIN/Lansa_Extract_$dateStamp.csv"

#else 
#echo "Back-up file not found !! "
#fi

if [ -s /ccdq/outbound/GTIN/Lansa_Extract_$dateStamp.csv ] 
then
	echo "File Successfully generated!! " 
fi

echo "Existing Program !!"

