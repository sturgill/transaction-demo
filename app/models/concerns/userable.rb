module Userable
  extend ActiveSupport::Concern

  included do
    validates :username, presence: true, uniqueness: true
    before_save :delay_me_maybe
  end

  def delay_me
    @delay_me = true
  end

  def dont_delay_me
    @delay_me = false
  end

  protected

  def delay_me_maybe
    sleep(5) if @delay_me
  end
end