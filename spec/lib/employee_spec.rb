require "spec_helper"

describe Employee do
	it { should embed_many :juice_requests }
end