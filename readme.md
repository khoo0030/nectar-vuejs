## Table of Contents
- [About this project](#about-this-project)
    - [What does it do?](#what-does-it-do?)
- [Instructions to run in local environment in Windows](#instructions-to-run-in-local-environment-in-windows)
- [Relevant files that might be of interest to you](#relevant-files-that-might-be-of-interest-to-you)
    - [Edit these files for your use case](#edit-these-files-for-your-use-case)
    - [Files to transfer to any VueJS project](#files-to-transfer-to-any-vuejs-project)

## About this project
This project serves as an example to how to deploy a VueJS app on [Nectar](https://www.tech.gov.sg/media/technews/getting-to-know-nectar-and-apex).

### What does it do?
- Nectar will git clone from the specified repository and will proceed to run specified Dockerfile to build image.

- The Dockerfile does the following:
    - Setup Nginx
        - Make Nginx compatible with Nectar OpenShift. Refer to this [Blog](https://torstenwalter.de/openshift/nginx/2017/08/04/nginx-on-openshift.html#run_nginx_in_openshift)
        - Make access and error logs directory and assign global permissions
        - Copy nginx .conf
    - Expose port 8080
    - Setup Node (for npm)
        - Copy JS files
        - Run npm install 
        - Run npm run build-(environment) (depending on which Dockerfile is run)
        
- Deployment environment Dockerfile

Environment | Dockerfile
------------ | -------------
local | Dockerfile.local
staging | Dockerfile.staging
production | Dockerfile.production

## Instructions to run in local environment in Windows
Configure Windows host file
```
1. Windows host file location:

C:\Windows\System32\drivers\etc\host

2. Add these 3 lines below into host file:

127.0.0.1 local.example.com
127.0.0.1 staging.example.com
127.0.0.1 production.example.com
```

Build docker image
```
docker build -t nectar-vuejs . -f ./Dockerfile.staging
```

Run docker container
```
docker run --name nectar-vuejs-container -p 80:8080 -d nectar-vuejs
```

Access website via browser
```
http://local.example.com
```

And you are done!

Alternatively - you can run start.sh for easy setup
```
./start.sh
```

## Relevant files that might be of interest to you

### Edit these files for your use case

```
/nginxconf/local.conf line 3:
server_name local.example.com; *edit FQDN
```

```
/nginxconf/staging.conf line 3:
server_name staging.example.com; *edit FQDN
```

```
/nginxconf/production.conf line 3:
server_name production.example.com; *edit FQDN
```

### Files to transfer to any VueJS project

```
- /nginxconf
- .dockerignore
- Dockerfile.local
- Dockerfile.staging
- Dockerfile.production
- start.sh
```
