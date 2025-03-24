# db/seeds.rb
User.create!(
  email: 'admin@email.com',
  password: 'iamadmin',
  password_confirmation: 'iamadmin',
  role: :admin
)
