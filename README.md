# contagem de votos
<h2>number of votes using Hadoop ecosystem(2014 Brazilian election)</h2>

the steps are straighforward:
<ul>
  <li>Create an AWS EMR Cluster. </li>
  <li>upload the file and scripts on Amazon S3</li>
  <li>Execute a HiveQL script</li>
  <li>Export the results to AWS S3 Bucket</li>
</ul>
<h3> Setup </h3>
Create a Bucket in S3 and inside the bucket create 3 folders:
<ul>
  <li>data (where you will upload the file to be analyzed by Hadoop)</li>
  <li>scripts (bash and HiveQL scripts)</li>
  <li>Output (results will be written here)</li>
</ul>

<h3> Scripts </h3>

There are two scripts: one in bash and another in HiveQL.
<br>Bash script is intended to prepare the HDFS and copy the HQL script into the HDFS;
while the HQL script count the number of votes.</br>

<h3> Usage </h3>
<ol>
  <li>Log in in AWS, and go to the EMR dashboard.
  Create a cluster with five or six instances (one is the master and the rest are slaves).</li>
  <li>Upload the text file in data folder(S3 bucket). HQL and Bash scripts will be uploaded into scripts folder</li>
  <li>after that, ssh into master node using your pem key (refer to AWS documentation on Pem Keys) 
    <br><i> ssh -i [path]/[pem_key_name].pem hadoop@[Master_public_DNS] </i></br>
  </li>
  <li>Copy the bash script into HDFS(hadoop distributed file system) and execute it using the folowing commands
  (Note the dot at the end of the first command):
      <br><i>hadoop distcp s3://[bucket_name]/scripts/setup.sh . <i></br>
      <i>hadoop fs -cat setup.sh | exec sh</i>
  </li>
  <li>Execute the HiveQL script:
    <br><i>hive -f s3://[s3_bucket]/scripts/scripteleicao.hql</i></br>
  </li>
  <li>The result will then be copied to the output folder in your s3 bucket(something like "000000_0").
  You can download it and see the results.</li>

</ol>



