require "googleauth"
require "google_drive"

#
# Set up a service account at https://console.developers.google.com/project
# and download the credentials to a JSON file. This includes the service
# account's private key.
#
# Be sure to also enable the Drive API for your Google project.
#
# Share the Google spreadsheet with the service account email address.
#
# Set up the following environment variable:
#
# GOOGLE_APPLICATION_CREDENTIALS="/Users/david/play/drive-api-play/My Project-c6549ad64235.json"
#
# adjusted for your configuration. The "My Project....json" file is the service
# account credentials.
#
# If you get an error similar to the following
#
#   SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (Faraday::SSLError)
#
# this means the TLS/SSL certificate chain for the Google APIs could not be
# verified. This is most likely because your Ruby can't find the correct root
# certificates. One way to solve this is set the following environment variable:
#
# SSL_CERT_FILE=/Users/david/.rvm/gems/ruby-2.2.1@google-api/gems/google-api-client-0.8.6/lib/cacerts.pem
#
# You can do this in Ruby code with
#
# ENV["SSL_CERT_FILE"] = $LOAD_PATH.grep(/google-api-client/).first + "/cacerts.pem"
#
# If you are using RVM on Mac OS X, you can also solve the problem by re-
# installing Ruby as follows:
#
# % rvm reinstall VERSION --disable-binary
#

spreadsheet_name = "demo"

credentials = Google::Auth.get_application_default
credentials.scope = ["https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds/"]
credentials.fetch_access_token!
access_token = credentials.access_token

drive_session = GoogleDrive.login_with_oauth(access_token)
spreadsheet = drive_session.spreadsheet_by_title(spreadsheet_name)
raise "Spreadsheet #{spreadsheet_name} not found" unless spreadsheet

worksheet = spreadsheet.worksheets.first

worksheet.rows.each do |row|
  puts row.join(', ')
end
