require "googleauth"
require "google/api_client"
require "google_drive"

#
# Set up a service account at https://console.developers.google.com/project
# and download the credentials to a JSON file. This includes the service account's
# private key.
#
# Share the Google spreadsheet with the service account email address.
#
# Set up the following environment variables
#
# GOOGLE_APPLICATION_CREDENTIALS="/Users/david/play/drive-api-play/My Project-c6549ad64235.json"
# SSL_CERT_FILE=/Users/david/.rvm/gems/ruby-2.2.1@google-api/gems/google-api-client-0.8.6/lib/cacerts.pem
#
# adjusted for your configuration. The "My Project....json" file is the service account credentials.
#

credentials = Google::Auth.get_application_default
credentials.scope = ["https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds/"]
credentials.fetch_access_token!
access_token = credentials.access_token

drive_session = GoogleDrive.login_with_oauth(access_token)
spreadsheet = drive_session.spreadsheet_by_title("my-google-spreadsheet")
worksheet = spreadsheet.worksheets.first

worksheet.rows.each do |row|
  puts row.join(', ')
end
