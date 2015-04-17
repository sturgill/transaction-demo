class TransactionLock < ActiveRecord::Base
  def self.perform(name)
    return false unless block_given?
    return false if self.connection.open_transactions > 0

    name = Digest::MD5.hexdigest(name)
    ensure_exists name

    self.transaction do
      transaction_lock = self.where(name: name).first(lock: true)
      yield
    end
  end

  protected

  def self.ensure_exists(name)
    query = "INSERT IGNORE INTO #{table_name} (name) VALUES (#{sanitize name})"
    connection.execute query
  end
end
