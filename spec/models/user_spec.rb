require 'spec_helper'

describe User do
  it "is valid with a username, password and password confirmation" do
    expect(build(:user)).to be_valid  
  end

  it "is invalid without username" do
    expect(build(:user, username: nil)).to have(3).errors_on(:username)
  end

  it "is invalid if the username has less than 4 characters" do
    expect(build(:user, username: "gil")).to have(1).errors_on(:username)
  end

  it "is invalid if the username has more than 12 characters" do
    expect(build(:user, username: "josegilbertovilla")).to have(1).errors_on(:username)
  end

  it "is invalid if the username does not have the correct format" do
    expect(build(:user, username: "1_2@~/,-")).to have(1).errors_on(:username)
  end

  it "is invalid without password" do
    expect(build(:user, password: nil)).to have(2).errors_on(:password)
  end

  it "is invalid without password confirmation" do
    expect(build(:user, password_confirmation: nil)).to have(1).errors_on(:password_confirmation) 
  end

  it "is invalid if the passwords do not match" do
    expect(build(:user, password_confirmation: "passwd")).not_to be_valid
  end

  it "is invalid with a duplicate username" do
    create(:user, username:"gilberto")
    user = build(:user, username: "gilberto")
    expect(user).to have(1).errors_on(:username)

  end
  it "is invalid if the password's length is less than 4 characters" do
    expect(build(:user,  password:"pas")).to have(1).errors_on(:password)
  end

  it "is invalid if the password's length is more than 8 characters" do
    expect(build(:user, password_confirmation: "pass")).to have(1).errors_on(:password_confirmation)
  end
end
