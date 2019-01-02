class Message < ApplicationRecord
  acts_as_paranoid
  default_scope { order('times_shown ASC') }
  scope :approved_messages, -> { where(approved: true) }
  scope :unapproved_messages, -> { where(approved: false) }
  belongs_to :batch, optional: true
  belongs_to :tenant, optional: true
  after_create :assign_default_tenant_if_unowned
  validates :message_text, presence: true
  paginates_per 50

  def assign_default_tenant_if_unowned
    return if tenant.present?
    update_columns(tenant_id: Tenant.default_tenant.id)
  end

  def self.add_initial_messages
    # from: http://www.confessions.net/
    return unless Message.first.nil?
    Message.create(approved: true, message_text: "Every time I start to date a new person, I always consider whether or not I could marry them, what marriage would be like, raising kids, the whole mess. It doesn't matter how long we haven't been together--I can't stop my brain from running through scenarios. I've only been dating my current boyfriend for two months and already I picture us blissfully wed. It's just neurotic and more than a little creepy.")
    Message.create(approved: true, message_text: "I don't know why but I can't stop myself from telling a lie.. it can be about the stupidest things too. I tell lies to make stories sound better, to make people laugh, to get attention. I want to stop but I am afraid that people wont' like me as much. I am known as the funny laid back kinda person and I really don't want to be known as a liar to.")
    Message.create(approved: true, message_text: "Once I knew a girl that I liked. She liked me back, we were both texting eachother alot. Then she did something with out my knowledge, deleted all her sent messages and saved certain messages from me. Then she went around my class showing people and saying stuff like I was stalking her.. She proceded to mess with my head. Its amazing what a girl can do. She nearly made me take my life, thats how much it messed me up..")
    Message.create(approved: true, message_text: "I met a girl who I have almost everything in common with - which is strange. Its like destiny brought us together, just a few twists of pure fate collided our fates together in some strange pattern.  I'm sure i've never, ever felt this way about someone else before; and I think she likes me too - from what I've read. This is just so strangely fantastic.")
    Message.create(approved: true, message_text: "my friend has been dating this girl for a couple months now, and i can't stop thinking about her. i go out of my way to see her, make up excuses to talk to her. i know that there is no way she will ever see me the same way she sees him, and it kills me because even though i know he appreciates her, he doesnt treat her nearly as well as he should. there is almost nothing i can do without thinking about this girl, and every time i think about her the pain inside get's worse.")
    Message.create(approved: true, message_text: "i have been smoking for the past two and a half years n my parents still havent come to know of it.")
    Message.create(approved: true, message_text: "I lied to my mother and invited my boyfriend into my bedroom. But nothing happened!!")
    Message.create(approved: true, message_text: "I am a 23 year old female, I am a professional, and I really want to fight. Not with anyone in particular, I just have frequent urges to just get in a fight with someone... I mean like a serious fight. I have not told anyone about this as I know no one would understand. Heck I don't understand either. But I am really close to just go out to a random bar and just pick a fight with another woman.")
  end
end
