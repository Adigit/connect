require 'spreadsheet'
require 'json'
class JsonParse
	def initialize
		@data_file = File.open "../shell-scripts/trip_advisor_data_for_indian_cities", 'r'
		@excel_file = Spreadsheet::Workbook.new
		@sheet = @excel_file.create_worksheet :name => 'sheet1'
	end

	def read_file_line_by_line
		index = 1
		@data_file.each do |line|
			parsed_data = parse_json line
			unless parsed_data.nil?
				save_data_in_excel_file parsed_data, index
				index = index + 1
			end
		end
		@excel_file.write '../excel-files/tripadvisor_data.xlsx'
	end

	def parse_json line
		line && line.length >= 2 ? JSON.parse(line) : nil
	end

	def save_data_in_excel_file parsed_data, index
		return nil if parsed_data.nil?
		_urls = []
		name = ""
		parent_name = ""
		grandparent_name = ""
		coords = ""
		if parsed_data['results'] && parsed_data['results'][0]
			_urls = []
			results = parsed_data['results'][0]
			results['urls'].each do |urls|
				_urls << urls['url']
			end
			name = results['name']
			if results['details']
				parent_name = results['details']['parent_name']
				grandparent_name = results['details']['grandparent_name']
			end
			coords = results['coords']
			_urls << results['url']
		end
		@sheet.row(index).push parsed_data['normalized']['query'], name, parent_name, grandparent_name, coords, _urls.join(',')
	end
end
obj = JsonParse.new
obj.read_file_line_by_line
