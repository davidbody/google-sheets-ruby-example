require "googleauth"
require "google_drive"

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
