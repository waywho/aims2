FactoryGirl.define do  

  factory :staff do
    name "MyString"
    biography "MyText"
    role "MyString"
    photo "MyString"
    slug "MyString"
    published_at "2015-12-24 08:53:20"
    workflow_state "MyString"
  end

  factory :admin, class: Casein::AdminUser do
  	login "admin"
  	name "admin person"
    email "admin@example.com"
    password "password"
    password_confirmation "password"
    password_salt "<%= salt = Authlogic::Random.hex_token %>"
    crypted_password "<%= Authlogic::CryptoProviders::SCrypt.encrypt('password' + salt) %>"
    persistence_token "<%= Authlogic::Random.hex_token %>"
    single_access_token "<%= Authlogic::Random.friendly_token %>"
    perishable_token "<%= Authlogic::Random.friendly_token %>"
  end

  factory :format do
    title "Mini-Aims" 
    description "MyText" 
    whats_new "2016 is very new" 
    when_from "2016-04-09 08:53:20" 
    when_to "2016-04-10 21:53:20" 
    venue "St Gabriel's Halls" 
    address1 "Pimlico" 
    city "London" 
    county "Greater London" 
    post_code "SW1V 2TC"
  end
end