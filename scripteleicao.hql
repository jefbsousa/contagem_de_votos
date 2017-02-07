--since the file is delimited with ';' we use OpenCSVSerde to create the table

create external table tb_eleicao (dt_geracao date, hora_geracao timestamp, ano_eleicao int, no_turno int, 
descricao string, UF string, UE string, cd_municipio int, nm_municipio string, no_zona int, 
no_secao int, cd_cargo int, desc_cargo string, no_votavel int, votos int)
 
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'

WITH SERDEPROPERTIES (
   "separatorChar" = "\;",
   "quoteChar"     = "\""
)
STORED AS TEXTFILE;

--insert the data into the table
load data inpath '/user/hadoop/eleicao/votacao_secao_2014_BR.txt' into table tb_eleicao;

--Here we count the number of votes in 1st and 2nd rounds
create external table tb_resultados (turno string, qt_votos int); 
insert into tb_resultados select 'primeiro turno', count(*) from tb_eleicao where no_turno=1;
insert into tb_resultados select 'segundo turno', count(*) from tb_eleicao where no_turno=2;

--put the your bucket name inside in [s3_bucket] below:
--create an external table stored in amazon s3

create table tb_export (turno string, qt_votos int) row format delimited fields terminated by '\:' 
lines terminated by '\n' STORED AS TEXTFILE LOCATION 's3n://[s3_bucket]/output/';

--export the results into amazon s3 table
INSERT OVERWRITE TABLE tb_export select * from tb_resultados;
