require 'rails_helper'

RSpec.describe User do
  describe "validations" do
    it {should validate_presence_of(:name)}
    it {should validate_presence_of(:address)}
    it {should validate_presence_of(:city)}
    it {should validate_presence_of(:state)}
    it {should validate_presence_of(:zip)}
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:password)}
    it {should validate_presence_of(:password_confirmation)}

    it {should validate_uniqueness_of(:email)}
  end
  describe "roles" do
    it "can be created as a default user" do
        josh = User.create!(name: "Josh Tukman",
                              address: "756 Main St",
                              city: "Denver",
                              state: "Colorado",
                              zip: "80209",
                              email: "josh.t@gmail.com",
                              password: "secret_password",
                              password_confirmation: "secret_password")

        expect(josh.role).to eq("user")
        expect(josh.user?).to be_truthy
    end

    it "can be created as an employee" do
        josh = User.create!(name: "Josh Tukman",
                        address: "756 Main St",
                        city: "Denver",
                        state: "Colorado",
                        zip: "80209",
                        email: "josh.t@gmail.com",
                        password: "secret_password",
                        password_confirmation: "secret_password",
                        role: 1)

        expect(josh.role).to eq("employee")
        expect(josh.employee?).to be_truthy
    end
    
    it "can be created as an admin" do
        josh = User.create!(name: "Josh Tukman",
                        address: "756 Main St",
                        city: "Denver",
                        state: "Colorado",
                        zip: "80209",
                        email: "josh.t@gmail.com",
                        password: "secret_password",
                        password_confirmation: "secret_password",
                        role: 2)

        expect(josh.role).to eq("admin")
        expect(josh.admin?).to be_truthy
    end
  end


end
