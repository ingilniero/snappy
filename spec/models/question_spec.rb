require 'spec_helper'

describe Question do
  it "is valid with a body" do
    expect(build(:question)).to be_valid  
  end

  it "is invalid without a body" do
    expect(build(:question, body: nil)).to have(2).errors_on(:body)
  end

  it "is invalid if body's length is less than 10 characters" do
    expect(build(:question, body: Faker::Lorem.characters(9))).to have(1).errors_on(:body)
  end

  it "is invalid if body's length is greater than 255 characters" do
    expect(build(:question, body: Faker::Lorem.characters(256))).to have(1).errors_on(:body)
  end

  it "is invalid if solved if not false" do
    expect(build(:question, solved: nil)).to have(1).errors_on(:solved)
  end

  it "is invalid if solved if not true" do
    expect(build(:question, solved: "")).to have(1).errors_on(:solved)
  end
end
