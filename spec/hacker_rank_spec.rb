require 'spec_helper'
require './lib/functions'
describe "displayPathtoPrincess" do
  it "passes Hacker Rank Test" do
    n = 3
    grid = ["---","-m-","p--"]

    expected = "DOWN\nLEFT"

    expect { displayPathtoPrincess(n, grid) }.to output(expected).to_stdout
  end
end

describe "nextMove" do
  it "passes Hacker Rank Test" do
    n = 5
    r = 2; c = 3
    grid = [
      "-----",
      "-----",
      "p--m-",
      "-----",
      "-----"
    ]
    expected_output = "LEFT"

    # expected_state = [
    #   "-----",
    #   "-----",
    #   "p-m--",
    #   "-----",
    #   "-----"
    # ]

    expect { nextMove(n,r,c,grid) }.to output(expected_output).to_stdout
  end
end
