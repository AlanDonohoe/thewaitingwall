class Tenant < ActiveRecord::Base
  has_many :messages
  has_many :batches

  def self.default_tenant
    Tenant.first
  end

  def self.append_guest_url?(subdomain)
    !using_subdomain_for_tenants? && subdomain.present?
  end

  def self.using_subdomain_for_tenants?
    return true if Rails.env.test? # will need to look at making this a little more flexible
    false # amend if we do start using subdomains
  end

  def approved_messages
    messages.approved_messages
  end

  # - - - - - - - - - - -
  # Batch related methods
  def create_batch
    batches.create unless messages.empty?
  end

  def batch
    batches.last
  end
  
  def batch_count
    batches.count
  end

  def oldest_batch
    batches.first
  end
  # Batch related methods - end
  # - - - - - - - - - - -
end
