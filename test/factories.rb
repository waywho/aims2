FactoryGirl.define do  factory :document do
    caption "MyString"
description "MyText"
file "MyString"
  end
  factory :user do
    provider "MyString"
uid "MyString"
name "MyString"
oauth_token "MyString"
refresh_token "MyString"
instance_url "MyString"
  end
  factory :news_item do
    title "MyString"
description "MyText"
workflow_state "MyString"
slug "MyString"
user_id 1
published_at "2016-01-12 11:25:05"
  end
  factory :courseformat do
    
  end
  factory :highlight do
    title "MyString"
description "MyString"
course_format_id nil
  end
  factory :recordfy do
    page_id 1
entry ""
row_order 1
  end
  factory :menu do
    name "MyString"
ancestry "MyString"
  end
  factory :quote do
    author "MyString"
saying "MyString"
workflow_state "MyString"
  end
  factory :fee do
    fee_type "MyString"
category "MyString"
description "MyString"
amount 1
eventable_id 1
eventable_type "MyString"
  end
  factory :event do
    title "MyString"
    description "MyText"
    programme "MyText"
    performers "MyText"
    date "2015-12-24 08:53:20"
    slug "MyString"
  end
  factory :course_format do
    title "MyString"
    description "MyText"
    slug "MyString"
    workflow_state "MyString"
    whats_new "MyText"
    when_from "2015-12-30 10:54:46"
    when_to "2015-12-30 10:54:46"
    venue "MyString"
    address1 "MyString"
    address2 "MyString"
    city "MyString"
    county "MyString"
    country "MyString"
    post_code "MyString"
  end
  

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

  factory :klass do
    title "MyString"
    description "Mytext"
    repertoire "Mytext"
    number_of_sessions "6"
    session_of_day "Session 2"
    course_id "21"
  end

  factory :photo do
    caption "MyText"
    image "image1.jpg"
    imageable_id "1"
    imageable_type "course"
  end

  factory :course do
    title "Solo"
    description "MyText"
    slug "solo"
    format_id "1"
  end



end