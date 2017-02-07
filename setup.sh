#! /bin/bash
#create two directories
hadoop fs -mkdir eleicao
hadoop fs -mkdir script

# put your amazon bucket name in [](remember to rip out the square brackets)
#copy HQL script and the file to be analyzed
hadoop distcp s3://[s3_bucket]/data/votacao_secao_2014_BR.txt.gz  /user/hadoop/eleicao/votacao_secao_2014_BR.txt.gz
hadoop distcp s3://[s3_bucket]/scripts/scripteleicao.hql  /user/hadoop/script/scripteleicao.hql

#since the file is compressed, this command decompress the file using gzip
hadoop fs -cat eleicao/votacao_secao_2014_BR.txt.gz | gzip -d | hadoop fs -put - eleicao/votacao_secao_2014_BR.txt
