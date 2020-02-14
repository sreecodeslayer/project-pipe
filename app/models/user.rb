class User < ApplicationRecord
  validates_presence_of :provider, :gid, :email, :fullname, :handle, :picture

  def self.find_or_create_from_auth_hash(auth)

    where(provider: auth.provider, gid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.gid = auth.uid
      user.bio = auth.extra.raw_info.bio
      user.email = auth.info.email
      user.fullname = auth.info.name
      user.handle = auth.info.nickname
      user.picture = auth.info.image

      user.save!
    end
  end
end
