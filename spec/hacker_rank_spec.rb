require 'spec_helper'

describe "displayPathtoPrincess" do
  it "passes Hacker Rank Test" do
    n = 3
    grid = ["---","-m-","p--"]

    valid_outputs = ["DOWN\nLEFT", "LEFT\nDOWN"]
    actual = displayPathtoPrincess(n, grid)

    expect(valid_outputs).to include(actual)
  end
end
