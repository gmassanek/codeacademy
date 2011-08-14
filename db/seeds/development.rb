#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

rspec = Fabricate(:node, :title => "Rspec", :homepage)
twitter = Fabricate(:node, :title => "Twitter")
