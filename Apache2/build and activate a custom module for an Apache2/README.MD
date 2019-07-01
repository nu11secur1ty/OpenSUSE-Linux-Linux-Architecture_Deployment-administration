# Build and activate a custom module for an Apache2
- Introduction

This post describes how to create, build and activate a custom module for an Apache2 HTTP Server deployed on Linux.
Please consider that all the steps and examples reported below have been executed on a Linux Ubuntu 16.04 with Apache 2.4 installed via ATP. Nonetheless it is quite simple to rearrange them by googling specific keywords that you will find later in the reading.

According to these premises, I going to start introducing some specific details about the main aspects related to the request processing in Apache2 Server.

Just after this introduction, you will find a sort of “getting started” guide to be used to create your really first httpd module.

This very short guide will finish by exploring a simplified module that has been used in a real project to provide specific information to a JEE application deployed on Apache Tomcat 8 but proxied via mod_jk 1.2.

# Prerequisites

   - basic knowledge of C programming language
   - basic understanding of how modules are loaded and configured in the Apache HTTP Server

- Apache Server request handling overview

Request processing  in Apache HTTP Server 2.4 can be well described by the following image 
![](https://github.com/nu11secur1ty/OpenSUSE-Linux-Linux-Architecture_Deployment-administration/blob/master/Apache2/build%20and%20activate%20a%20custom%20module%20for%20an%20Apache2/image/filter_arch.png)
