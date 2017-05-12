require "spec_helper"

describe Shoe do
  it { should have_many :stores }
  it { should_not allow_value("blahblah" * 20).for(:name) }
  it { is_expected.to callback(:capitalize_title).before(:save) }
end

describe Store do
  it { should have_many :shoes }
  it { should_not allow_value("blahblah" * 20).for(:name) }
  it { is_expected.to callback(:capitalize_title).before(:save) }
end

describe StoreShoe do
  it { should belong_to :store }
  it { should belong_to :shoe }
end