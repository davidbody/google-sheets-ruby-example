# Read a Google spreadsheet from Ruby

Example for [Iowa Ruby Brigade](http://www.iowaruby.org/) presentation, [October 20, 2015](http://www.iowaruby.org/meetings/2015/10/)

## Steps

1. Create a Google developer project at [https://console.developers.google.com/project](https://console.developers.google.com/project)

2. Enable the Drive API for this project.

3. Set up a service account for the project (under credentials) and download the credentials to a JSON file. This includes the service account's private key.

4. Share the Google spreadsheet with the service account email address.

5. Set up the following environment variable:

    `GOOGLE_APPLICATION_CREDENTIALS="google-sheets-ruby-example/My Project-xxxxxxxxxxxx.json"`

adjusted for your configuration. The "My Project....json" file is the service account credentials.

#### TLS/SSL Note

If you get an error similar to the following

    `SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (Faraday::SSLError)`

this means the TLS/SSL certificate chain for the Google APIs could not be verified. This is most likely because your Ruby can't find the correct root certificates. One way to solve this is set the following environment variable:

    `SSL_CERT_FILE=[path to your Ruby gems]/google-api-client-0.8.6/lib/cacerts.pem`

You can do this in Ruby code with

```ruby
ENV["SSL_CERT_FILE"] = $LOAD_PATH.grep(/google-api-client/).first + "/cacerts.pem"
```

If you are using RVM on Mac OS X, you can also solve the problem by re-installing Ruby as follows:

```
% rvm reinstall VERSION --disable-binary
```
