# Project folder for the CD with Docker and Ansible course

This repository holds all the required files and folders to follow the
[Continuous Delivery Using Docker And Ansible](https://app.pluralsight.com/library/courses/docker-ansible-continuous-delivery/table-of-contents)
course on Pluralsight.

This course guides the follower through an extensive process of setting up a
Python application and following best practices to setup a proper CI/CD
pipeline on Jenkins and eventually deploying to AWS.

## How to run?

This section requires more details, but a special note is to run docker run with
the --env-file=.env tag.

## Some Extra Notes

This repository holds all the subfolders which the course have separate
repositories for. I brought all of it together, since I build a Vagrantfile and
bootstrap file for the VM I use to follow this course. Since the author of the
course uses a Mac and the course is a bit dated, I had to create this VM to
follow along properly. Plus the added benefit of having the ability to destroy
and easily recreate the machine if required :) It's a course on automation after
all!

I am aware that there's some hard coded privacy sensitive information inside some files; that's intentional. The VM created through Vagrant is unavailable via the internet and therefore the information is pretty useless. It's only for testing purposes and I couldn't be bothered to go out of my way to create special environment files for it :)

Do note that the bootstrap file isn't nessecarily required, since later on in the course you use Docker to do most of the heavy lifting. The current setup makes the VM that Vagrant creates very bloated.

For the jenkins pipeline, use [this](https://github.com/mixja/jenkins) GitHub repo for a proper Docker image.
