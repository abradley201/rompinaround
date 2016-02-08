class InfoStat < ActiveRecord::Base
	validates :account, :passcode, presence: true
  	validates :account, length: { maximum: 14 }
  	validates :account, uniqueness: true
  	validates_format_of :account, :with => /^[A-Za-z0-9]+$/, :multiline => true
  	validates :passcode, length: { maximum: 40 }
	
	
end