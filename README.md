### Prepare Informix Database
Execute the command below to start the informix docker:
```sh
docker run -itd -p 2021:2021 --name tc-informix appiriodevops/informix:1.2
```

Then add an entry to your hosts file like below:
```
192.168.99.100  env.topcoder.com
```

The `192.168.99.100` is the ip of my docker box hosting the tc-informix container, you need to replace it with yours.
And the `env.topcoder.com` is the hostname of the database server used in the tcs loader. 

Then connect to the database, and execute the `test_files/test-data.sql` to insert some test data. 
Note that for the `calendar` test data, you need to change it to use today's values. 

### Execute TCS Loader
Execute the following command to create the tcs-loader jar:
```sh
mvn clean package
```

The `env.sh` defines the following variable used in all scripts:
* BASE_DIR - the base directory of the submission, it needs to be the absolute path

Execute `source env.sh` to export this variable. 

The scripts directory contains the following shell scripts:
* scripts/loadtcsscript.sh - it will execute the `com.topcoder.utilities.dwload.TCLoadTCS` to load tcs data
* scripts/loadtcs.sh - it will simply execute `loadtcsscript.sh` as a background task

Then in the base directory, you can execute the scripts as below:
```
# execute loadtcs directly
sh scripts/loadtcsscript.sh

# execute loadtcs as a background task
# it will generate a tcs_load.log file
sh scripts/loadtcs.sh
```

I've also included a copy of `tcs_load.log` in the `test_files` directory generated from the loadtcs.sh script. 
