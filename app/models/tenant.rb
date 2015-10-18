class Tenant < ActiveRecord::Base
  has_many :messages
  has_many :batches

  def self.default_tenant
    Tenant.first
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
    batches.fist
  end
  # Batch related methods - end
  # - - - - - - - - - - -
end
