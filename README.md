# ssl-sites-batch.sh
Bash script invoked by cron that uses acme.sh to generate ssl certs and create nginx conf snippet for a site list.

> Use ``` git --recursive clone https://github.com/artusrocha/ssl-sites-batch.sh.git ```
> to initialize acme.sh dependence


### NGINX location conf to acme-challenge
```
location ~ /\.well-known/acme-challenge/ {
  root <SSL-SITES-BATCH-DIR>/acme-challenge/;
}
```


### Cronjob setting example
```
0 0 * * * cat my-domain.list | <SSL-SITES-BATCH-DIR>/ssl-sites-batch.sh
```
 or
```
0 0 * * * <SSL-SITES-BATCH-DIR>/ssl-sites-batch.sh my-domain.list
```

