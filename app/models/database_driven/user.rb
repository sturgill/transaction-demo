class DatabaseDriven::User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection
  include Userable

  # uniqueness constraint on :username enforced by database
end
