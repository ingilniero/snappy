require 'spec_helper'

describe Answer do
  it "is valid with body" do
    expect(build(:answer)).to be_valid
  end

  it "is invalid without body" do
    expect(build(:answer, body: nil)).to have(2).errors_on(:body)
  end

  it "is invalid if the body's length is less than 2 characters" do
    expect(build(:answer, body: Faker::Lorem.characters(1))).to have(1).errors_on(:body)
  end

  it "is invalid if the body's length is greater than 255 characters" do
    expect(build(:answer, body: Faker::Lorem.characters(256))).to have(1).errors_on(:body)
  end
end
