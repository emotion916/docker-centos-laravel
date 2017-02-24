Step 1: Pull docker

# docker pull luongle96/docker-centos-laravel

Step 2: Run container

# docker run -it --name <YOUR_CONTAINER_NAME> -v <YOUR_FOLDER_PROJECT_LARAVEL>:/usr/share/nginx/html/public_html -d luongle96/docker-centos-laravel

Step 3:

Run: 

# docker inspect <YOUR_CONTAINER_NAME> | grep -i ipaddr

Output:

 "SecondaryIPAddresses": null,
            "IPAddress": "your_container_ip",
                    "IPAddress": "your_container_ip",

Browser: http://your_container_ip -> run project laravel
Browser: http://your_container_ip:9999 -> run phpmyadmin

mysql_user : root
mysql_pass : root

OR

# docker exec -it <YOUR_CONTAINER_NAME> bash

