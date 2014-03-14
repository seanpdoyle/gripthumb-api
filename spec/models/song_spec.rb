require 'spec_helper'

describe Song do
  it { should have_many(:parts) }
end
