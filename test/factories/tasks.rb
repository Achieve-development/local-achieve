FactoryGirl.define do
  factory :task do
    user nil
    title "MyString"
    content "MyText"
    deadline "2016-08-08 10:36:32"
    charge_id 1
    done false
    status 1
  end
end
