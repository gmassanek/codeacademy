# coding: utf-8
# seeds/development.rb
# ======================

require 'csv'

directory = "db/init_csv_data/"

#Loading nodes
file_name = "nodes.csv"
path_to_file = directory + file_name

puts 'Loading Node records...'
CSV.foreach(path_to_file) do |row|
  row.each { |e| e.strip! unless e.nil?}
  newNode = Node.new :title => row[1], :description => row[2], :created_at => row[3], :updated_at => row[4], :homepage => row[5], :created_by_id => row[9], :last_updated_by_id => row[10]
  if !newNode.save
    puts "Error adding:"
    puts row.inspect
  end
end
puts "Finished loading #{Node.count} Node records"

#Loading relationships
file_name = "relationships.csv"
path_to_file = directory + file_name

puts 'Loading Relationships records...'
CSV.foreach(path_to_file) do |row|
  row.each { |e| e.strip! unless e.nil?}
  newRel = Relationship.new :sentence1 => row[0], :sentence2 => row[1], :node1 => Node.find_by_title(row[2]), :node2 => Node.find_by_title(row[3]), :created_at => row[4], :updated_at => row[5]
  if !newRel.save
    puts "Error adding:"
    puts row.inspect
  end
end
puts "Finished loading #{Relationship.count} Relationship records"

#Loading links
file_name = "links.csv"
path_to_file = directory + file_name

puts 'Loading Link records...'
CSV.foreach(path_to_file) do |row|
  row.each { |e| e.strip! unless e.nil?}
  if row[1] or row[2]
    newLink = Link.new :url => row[0], :created_at => row[3], :updated_at => row[4]
    if row[1].blank?
      newLink.linkable = Relationship.find_by_sentence1(row[2])
    else
      newLink.linkable = Node.find_by_title(row[1])
    end

    if !newLink.save
      puts "Error adding:"
      puts row.inspect
    end
  end
end
puts "Finished loading #{Link.count} Link records"

#Loading tutorials
file_name = "tutorials.csv"
path_to_file = directory + file_name

puts 'Loading Tutorials records...'
CSV.foreach(path_to_file) do |row|
  row.each { |e| e.strip! unless e.nil?}
  if row[4]
    newTut = Tutorial.new :title => row[0], :description => row[1], :content => row[2], :answered => row[3], :created_at => row[5], :updated_at => row[6]
    newTut.item = Node.find_by_title(row[4])

    if !newTut.save
      puts "Error adding:"
      puts row.inspect
    end
  end
end
puts "Finished loading #{Tutorial.count} Tutorial records"
