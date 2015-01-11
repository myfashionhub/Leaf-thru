require "#{Rails.root}/lib/pocket"

class Session < ActiveRecord::Base
  def self.create_new(reader)
    if reader == nil
      status = 'error'
      if Reader.find_by(email: params[:email]) == nil
        msg = 'There\'s no record of this email.'
      else
        msg = 'Password is incorrect.'
      end
    else
      current_reader = reader
      msg    = ''
      status = 'success'
    end
    { msg: msg, status: status }
  end
end
