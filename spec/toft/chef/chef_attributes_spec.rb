require 'spec_helper'
require 'cucumber/ast/table'

describe "ChefAttributes" do
  it "should parse chef dot connected attributes" do
    ca = Toft::ChefAttributes.new(Cucumber::Ast::Table.new([[]]))
    ca.add_attribute "one.two.three", "some"
    ca.add_attribute "one.four", "another"
    ca.attributes["one"]["two"]["three"].should == "some"
    ca.attributes["one"]["four"].should == "another"
  end
  
  it "should parse cucumber chef attributes ast table" do
    table = Cucumber::Ast::Table.new([
              ["key", "value"],
              ["one.four", "one"],
              ["one.two.three", "some"]
            ])
    ca = Toft::ChefAttributes.new(table)
    ca.attributes["one"]["four"].should == "one"
    ca.attributes["one"]["two"]["three"].should == "some"
  end
  
  it "should return json" do
    table = Cucumber::Ast::Table.new([
              ["key", "value"],
              ["one.four", "one"],
              ["one.two.three", "some"]
            ])
    ca = Toft::ChefAttributes.new(table)
    ca.to_json.should == "{\"one\":{\"two\":{\"three\":\"some\"},\"four\":\"one\"}}"
  end
  
  it "should initialize with 0 parameter" do
    ca =  Toft::ChefAttributes.new
    ca.add_attribute "one.four", "one"
    ca.attributes["one"]["four"].should == "one"
  end
end