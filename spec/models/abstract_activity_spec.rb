require 'rails_helper'

RSpec.describe AbstractActivity, type: :model do
  it "provides a description for each subclass" do
    klass1 = Class.new(AbstractActivity) do
      description "description 1"
    end

    klass2 = Class.new(AbstractActivity) do
      description "description 2"
    end

    expect(klass1.description).to eq("description 1")
    expect(klass2.description).to eq("description 2")
  end
end
