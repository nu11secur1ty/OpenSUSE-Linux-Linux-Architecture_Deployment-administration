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

A module can hook into any of these processing phases, including filters.
Filters  would deserve a more detailed discussion but it would require  more time and cannot be addressed here, where, at least for the moment, purposes are different. Just know that  the Data Axis has been introduced with Apache2. With input filters the request data can be processed before the content generation and the response can be processed by output filters before being returned to the caller. When working with filters, keep always in mind that their execution order is not deterministic.

So, coming back to our purposes, what does request handling mean?
Well, in Apache HTTP Server 2.4 it means hooking module handlers into the server.

Apache2 official documentation reports “A hook is essentially a message telling the server that you are willing to either serve or at least take a glance at certain requests given by clients. All handlers, whether it's mod_rewrite, mod_authn_*, mod_proxy and so on, are hooked into specific parts of the request process. As you are probably aware, modules serve different purposes.... Thus, the server itself does not presume to know which module is responsible for handling a specific request, and will ask each module whether they have an interest in a given request or not. It is then up to each module to either gently decline serving a request, accept serving it or flat out deny the request from being served, as authentication/authorization modules do”.


- Getting started

In order to create a new httpd module project you can use APache eXtenSion tool (apx).

By giving the following instruction you can create a template for your new module.

```bash
apxs -g -n my_apache2_module
```

This command will create a directory with the given name my_apache2.

Into the newly create folder you will find a Makefile and your getting started module implementation mod_my_apache2.c.

Now, chose your preferred IDE, open the C file just created and implement your requirements.

Your starting point is the “Dispatch list for API hooks” where you have to specify the function delegated to register hooks.

```c
/* Dispatch list for API hooks */
module AP_MODULE_DECLARE_DATA my_apache2_module = {
  STANDARD20_MODULE_STUFF,
  NULL, /* create per-dir config structures */
  NULL, /* merge per-dir config structures */
  NULL, /* create per-server config structures */
  NULL, /* merge per-server config structures */
  NULL, /* table of config file commands */
  my_apache2_register_hooks /* register hooks */
};
```

Into the function my_apache2_register_hooks you will hook your action. For instance .


```c
static void my_apache2_register_hooks(apr_pool_t *pool) {
    ap_hook_handler(my_apache2_handler, NULL, NULL, APR_HOOK_LAST);
}
```
The function my_apache2_handler will implement the real handler then the actions to be taken when … specified by the used hook (in this example ap_hook_handler) and the given priority (in this case APR_HOOK_LAST). Please refer to API for more details.

As reported by the official documentation, please see below some other useful hooks.

   - ap_hook_child_init: Place a hook that executes when a child process is spawned (commonly used for initializing modules after the server has forked).
   - ap_hook_pre_config: Place a hook that executes before any configuration data has been read (very early hook).
   - ap_hook_post_config: Place a hook that executes after configuration has been parsed, but before the server has forked.
   - ap_hook_translate_name: Place a hook that executes when a URI needs to be translated into a filename on the server (think mod_rewrite).
   - ap_hook_quick_handler: Similar to ap_hook_handler, except it is run before any other request hooks (translation, auth, fixups etc).
   - ap_hook_log_transaction: Place a hook that executes when the server is about to add a log entry of the current request.

**A concrete example**

The following example has been derived from a specific need we had on a IAM project.
The main problem was to provide some information as environment variable to the mod_jk (1.2) proxying request towards a JEE application in the back-end. Unfortunately, for certain reasons, some information weren’t available in env space but just as HTTP Header parameter. Furthermore, we were not authorized to change mod_jk configuration  on the Apache2 Server (2.4) serving requests in front-end.

The solution at this problem has been the development of a custom Apache2 module delegated to set some environment variable taking information from HTTP Header.
The implementation

As already said above, the starting point is the dispatcher.


```c
module AP_MODULE_DECLARE_DATA header2env_module = {
    STANDARD20_MODULE_STUFF, NULL, /* create per-dir    config structures */
    NULL,                          /* merge  per-dir    config structures */
    NULL,                          /* create per-server config structures */
    NULL,                          /* merge  per-server config structures */
    NULL,                          /* table of config file commands       */
    header2env_register_hooks      /* register hooks                      */
};
```
That refers to the static method delegated to register hooks.

```c
static void header2env_register_hooks(apr_pool_t* p) {
    // Fixups: last chance to look at the request before content generation.
    ap_hook_fixups(header2env_module_fixups_handler, NULL, NULL, APR_HOOK_REALLY_FIRST);
}
```
Request handler implementation is provided into header2env_module_fixups_handler as specified by the hook register.

```c
static int header2env_module_fixups_handler(request_rec* r) {
    ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r, "Copying headers to environment ...");
    ...
    return OK;
}
```

See below the complete code provided for our specific purposes.


```c
#include "httpd.h"
#include "http_log.h"
#include "http_request.h"

static int header2env_module_fixups_handler(request_rec* r) {
    ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r, "Copying headers to environment ...");

    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
    const apr_array_header_t* fields;
    int i;
    apr_table_entry_t* e = 0;
    /*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

    fields = apr_table_elts(r->headers_in);
    e = (apr_table_entry_t*)fields->elts;

    // define the prefix of the name of headers to be processed
    const char* prefix = "CAS_";

    for(i = 0; i < fields->nelts; i++) {
        ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r, "[HDR] - %s: %s", e[i].key, e[i].val);
        if(strncmp(e[i].key, prefix, strlen(prefix)) == 0) {
            ap_log_rerror(APLOG_MARK, APLOG_DEBUG, 0, r, "[ENV] - %s: %s", &(e[i].key[strlen(prefix)]), e[i].val);
            // set env variable by removing the given prefix from the name
            apr_table_setn(r->subprocess_env, &(e[i].key[strlen(prefix)]), e[i].val);
        }
    }

    return OK;
}

static void header2env_register_hooks(apr_pool_t* p) {
    // Fixups: last chance to look at the request before content generation.
    ap_hook_fixups(header2env_module_fixups_handler, NULL, NULL, APR_HOOK_REALLY_FIRST);
}

/* Dispatch list for API hooks */
module AP_MODULE_DECLARE_DATA header2env_module = {
    STANDARD20_MODULE_STUFF, NULL, /* create per-dir    config structures */
    NULL,                          /* merge  per-dir    config structures */
    NULL,                          /* create per-server config structures */
    NULL,                          /* merge  per-server config structures */
    NULL,                          /* table of config file commands       */
    header2env_register_hooks      /* register hooks                      */
};
```



