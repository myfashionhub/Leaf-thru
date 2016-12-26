class Session < ActiveRecord::Base
  def self.create_new(reader, params)
    if reader == nil
      status = 'error'
      if Reader.find_by(email: params[:email]) == nil
        msg = "There's no account with this email."
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

  def self.update_with_twitter(reader, data)
    reader.update({
      twitter_token: data.extra.access_token.params[:oauth_token],
      twitter_token_secret: data.extra.access_token.params[:oauth_token_secret],
      twitter_handle:data.info.nickname,
      name:          data.info.name,
      image:         data.info.image,
      location:      data.info.location,
      tagline:       data.info.description
    })
  end

  def self.update_with_facebook(reader, data)
    reader.update({
      facebook_token: data.credentials.token,
      facebook_uid:   data.uid,
      name:   data.info.name,
      #email: data.info.email,
      image:  data.info.image
    })
  end

  def self.update_with_pocket(reader, data)
    # reader.update(
    #   pocket_token: data[:access_token],
    #   pocket_username: data[:username]
    # )
  end
end
