FactoryGirl.define do
  factory :tenant do
    name "Tenant One"
    subdomain "tenantone"
    trait :default_tenant do
      name ""
      subdomain ""
    end
    trait :meaning_conf do
      name 'Meaning Conference'
      subdomain "meaningconf"
      info_text 'welcome to the meaning conference'
    end
  end
end
