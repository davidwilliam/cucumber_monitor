module CucumberMonitor

	class FeatureRunner

		def self.command(feature)
			"bundle exec cucumber features/#{feature}.feature --format json --out tmp/cucumber.out"
		end

		def self.run(options={})
			`#{command(options[:name])}` if options.has_key?(:name) 
		end

		def self.json
			JSON.parse(File.open(CucumberMonitor::Base.cucumber_output_file).read)
		end

		def self.run_and_return_json(options={})
			run(options)
			json
			prepare
		end

		def self.elements
			json.first['elements'].map{|e| "#{e['keyword']}: #{e['name']}"}
		end

		def self.prepare
			prepared_json = json
			prepared_json.first['elements'].each do |element|
				element['steps'].each do |step|
					description = "#{step['keyword']}#{step['name']}"
					code_first_part = element['name'].blank? ?  element['keyword'].parameterize : element['name'].parameterize
					code_second_part = description.parameterize
					code = "#{code_first_part}-#{code_second_part}"
					step.merge!({
						            'description' => description,
						            'code' => code.parameterize
						          })
				end 
			end
			prepared_json
		end

	end

end