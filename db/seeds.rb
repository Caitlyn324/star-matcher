require 'phantomjs'
require 'capybara/dsl'
require 'capybara/poltergeist'
include Capybara::DSL

backstage_page = "https://www.backstage.com/casting/?exclude_nationwide=true&gender=B&geo=-75.16378900000001%2C39.952335&location=Philadelphia%2C+PA&max_age=100&min_age=0&page=1&pt=60&pt=69&pt=70&radius=10&sort_by=newest"

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false, phantomjs: Phantomjs.path})
end

browser = Capybara::Session.new(:poltergeist)
browser.visit(backstage_page)
union = browser.all("a.tag.union")
links = []
browser.all('h3.prod__title').each do |div_title|
  links << div_title.text
end

links.each_with_index do |link, index|
  browser.click_link link

  equity = true
  if !union[index] || !union[index].text.downcase.include?("UNION")
    equity = false
  end

  details = browser.all("div.prod-listing__details.undefined")
  while details.empty?
    details = browser.all("div.prod-listing__details.undefined")
  end
  deets = []
  details.each do |detail|
    deets << detail.find("p")
  end

  date_string = browser.find("span.expires-text--date").text
  date = Date.parse(date_string)

  current_audition = Audition.create!(
    show: link,
    equity: equity,
    date: date,
    company: deets[0].text,
    description: "#{deets[1].text}\n#{deets[3].text}",
    created_at: Time.now,
    updated_at: Time.now
  )

  # create each Role
  browser.find("a", text: "Collapse").click
  browser.find("a", text: "Expand").click

  role_divs = browser.all("div.role-group")
  while role_divs.empty?
    role_divs = browser.all("div.role-group")
  end


  role_divs.each do |role_div|
    title = role_div.find("span.name").text
    title.slice! ":"

    gender_and_age = role_div.find("span.details")
    gender = gender_and_age.text.split(",").first
    if gender.downcase != 'female' &&  gender.downcase != 'male'
      gender = 'All Genders'
    end

    age_string = gender_and_age.text.split(",").last
    age_string.slice! " "
    if age_string.include?("+")
      age_string.slice! "+"
      age_min = age_string.to_i
      age_max = 100
    elsif age_string.include?("-")
      age_array = age_string.split("-")
      age_min = age_array.first.to_i
      age_max = age_array.last.to_i
    else
      age_min = age_string.to_i
      age_max = age_string.to_i
    end

    ethnicity_and_media_div = role_div.all("p.ethnicities-info")
    while ethnicity_and_media_div.empty?
      binding.pry
      ethnicity_and_media_div = role_div.all("p.ethnicities-info")
    end

    ethnicity = ethnicity_and_media_div.first.text
    ethnicity.slice! "Ethnicity: "

    required_media = ethnicity_and_media_div.last.text
    required_media.slice! "Required Media: "

    description = role_div.find("div.role__desc").text
    Role.create!(
      audition: current_audition,
      title: title,
      gender: gender,
      age_min: age_min,
      age_max: age_max,
      ethnicity: ethnicity,
      required_media: required_media,
      description: description
    )
  end

  2.times do browser.go_back end
end

Actor.destroy_all
actor = Actor.create!(
  name: 'Chris Donohue',
  phone_number: '2679871412',
  email: 'chris.donohue0628@gmail.com',
  password: 'tbatst4892',
  gender: 'Male',
  age: '21',
  ethnicity: 'Caucasian'
)
actor.confirm
