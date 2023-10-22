# Digital Ocean Redirector
Used on Digital Ocean app platform to redirect domains. For instance you can use it to redirect your naked domain such as ```example.xyz``` to ```www.example.com``` as digital ocean app platform does not have ths ability natively.

Simply deploy this application to Digital ocean app platform and then use the environment variable feature to tell the application hot to redirect domains.

To configure the redirects you add an environment variable called REDIRECTS that contains a comma seperated list of the domains you want to redirect.

For example if you set the REDIRECTS environment variable to

```example.xyz>www.example.xyz,test.xyz>www.test.xyz```

It will redirect ```example.xyz``` to ```www.example.xyz``` and ```test.xyz``` to ```www.test.xyz```.

[![Deploy to DO](https://www.deploytodo.com/do-btn-blue.svg)](https://cloud.digitalocean.com/apps/new?repo=https://github.com/blafri/do_redirector/tree/main)

