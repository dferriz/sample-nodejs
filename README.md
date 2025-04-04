### What's is it?

Its an example of how to optimize a node app just avoiding not necessary node builts.



### How it works?

The trick is done using a volume and a checksum validation over the .lock file (this file tells us exactly which version is being used for each vendor package).

In this scenario we just use a named volume attached to the container but it can be replicated in the same way for Cloud Services like EC2 instances and EBS volumes or similar.



### Ok, I want to try

Just follow these steps:

- Clone the repo and execute
- `make -C docker build-dev`
- `make -C docker bring-up`
- At this point you will have the app running so if you execute `docker logs -f app` you will see something like:
  ![img.png](img.png)
- Now just stop containers with `make -C docker bring-down`
- Finally start containers again with `make -C docker bring-up` and show logs `docker logs -f app` you will see something like:
  ![img_1.png](img_1.png)

As you could see, the container ignored node_modules recreation.



You can also try deleting node_modules and repeating the steps above, the result will be the same.

As a final step you can add a new node package like dotenv:

- `docker exec -it app npm install dotenv`
- restart dockers and will show node_modules is rebuilt
- restart dockers and will show node_modules is not rebuilt
