FactoryGirl.define do
  factory :tenant do
    name "Tenant No. One"
    subdomain "tenantnoone"
    trait :meaning_conf do
      name 'Meaning Conference'
      subdomain "meaningconf"
      info_text 'welcome to the meaning conference'
    end
  end
end
