FactoryGirl.define do
  factory :user, :class => 'User' do
    name 'Foo'
    email 'foo@bar.com'
    password '0123456789'
    confirmed_at Time.now
  end
end
