require 'rspec'
require 'nokogiri'
require_relative '../lib/formfinder'

html=File.read(File.join(File.dirname(__FILE__),"test.html"))
document=Nokogiri::HTML html
describe FormFinder, '#_findLoginFormsByActions' do
	it "finds forms based on action" do
		f=FormFinder.new
		res=f._findLoginFormsByActions document
		res.count.should be 1
		expect(res[0]['action']).to eq "/obviouslogin"
	end
end
describe FormFinder, '#_findLoginFormsByInputs' do
	it "finds forms based input names" do
		f=FormFinder.new
		res=f._findLoginFormsByInputs document
		res.count.should be 2			
		expect(res[0]['action']).to eq "/obviouslogin"
		expect(res[1]['action']).to eq "/jack_in"
	end
end
describe FormFinder, '#findAllForms' do
	it "finds all forms" do
		f=FormFinder.new
		res=f.findAllForms document
		res.count.should be 2			
		expect(res[0]['action']).to eq "/obviouslogin"
		expect(res[1]['action']).to eq "/jack_in"
	end
end
