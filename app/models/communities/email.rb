class Communities::Email < Communities::Base
  set_community_type :email

  def add_members!(emails)
    visitors.where(revoked: true, email: emails).update_all(revoked: false)
    (emails - visitors.pluck(:email)).map { |email| visitors.create!(email: email) }
  end

  def includes?(member)
    visitors.where(revoked: false).pluck(:email).include?(member.email)
  end

  def members
    @members ||= visitors.where(revoked: false)
  end

  def notify!(event)
    # send an email about the event if appropriate
  end
end