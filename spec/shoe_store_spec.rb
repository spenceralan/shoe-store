require "spec_helper"

describe Shoe do
  it { should have_many :stores }
  it { should_not allow_value("").for(:name) }
  it { should_not allow_value("   ").for(:name) }
  it { should_not allow_value("blahblah" * 20).for(:name) }
  it { is_expected.to callback(:capitalize_title).before(:validation) }
  it { should_not allow_value("h").for(:price) }
  it { should allow_value(9.0).for(:price) }
  it { should allow_value("1000").for(:price) }
  it { should_not allow_value("").for(:price) }
  it { should allow_value("0").for(:price) }
  it { should_not allow_value("  ").for(:price) }
end

describe Store do
  it { should have_many :shoes }
  it { should_not allow_value("").for(:name) }
  it { should_not allow_value("   ").for(:name) }
  it { should_not allow_value("blahblah" * 20).for(:name) }
  it { is_expected.to callback(:capitalize_title).before(:validation) }
end

describe StoreShoe do
  it { should belong_to :store }
  it { should belong_to :shoe }
end