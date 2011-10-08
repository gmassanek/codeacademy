#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

rspec = Fabricate(:node, :title => "Rspec")
twitter = Fabricate(:node, :title => "Twitter")
rel1 = Fabricate(:relationship, :node1 => rspec, :node2 => twitter) 
rel2 = Fabricate(:relationship)
rel3 = Fabricate(:relationship)
rel4 = Fabricate(:relationship)
