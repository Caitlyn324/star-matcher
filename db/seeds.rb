Audition.create!(
  roles: ["Pierre", "Natasha", "Sonya"],
  show: "Natasha, Pierre, And the Great Comet of 1812",
  theater: "Walnut Street Theater",
  address: "825 Walnut St, Philadelphia, PA 19107",
  company: "THE theater troupe",
  description: "You should be just really damn talented",
  equity: true,
  time: Faker::Time.between(Date.today, 3.days.from_now, :afternoon)
)

Audition.create!(
  roles: ["Phantom", "Christine", "The Other Guy"],
  show: "Phantom",
  address: "240 S Broad St, Philadelphia, PA 19102",
  theater: "Academy of Music",
  equity: true,
  time: Faker::Time.between(Date.today, 3.days.from_now, :afternoon)
)

User.create!(
  name: 'Chris Donohue',
  phone_number: '2679871412',
  email: 'chris.donohue0628@gmail.com',
  password: 'tbatst4892'
)
