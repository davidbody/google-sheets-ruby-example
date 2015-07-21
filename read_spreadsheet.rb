require "googleauth"
require "google/api_client"
require "google_drive"

# Requires the following environment variables
#
# GOOGLE_APPLICATION_CREDENTIALS="/Users/david/play/drive-api-play/My Project-c6549ad64235.json"
# SSL_CERT_FILE=/Users/david/.rvm/gems/ruby-2.2.1@google-api/gems/google-api-client-0.8.6/lib/cacerts.pem
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
