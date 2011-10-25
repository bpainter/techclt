# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# [
# ["A"],["B"],["C"],["D"],["E"],["F"],["G"],["H"],["I"],["J"],["K"],["L"],["M"],["N"],["O"],["P"],["Q"],["R"],["S"],["T"],["U"],["V"],["W"],["X"],["Y"],["Z"],
# ["AA"],["BB"],["CC"],["DD"],["EE"],["FF"],["GG"],["HH"],["II"],["JJ"],["KK"],["LL"],["MM"],["NN"],["OO"],["PP"],["QQ"],["RR"],["SS"],["TT"],["UU"],["VV"],["WW"],["XX"],["YY"],["ZZ"]
# ].each do |h|
#  Letter.create!(:letter_text => h[0])
# end

[
  ["Hacker"],["Founder"],["Hustler"],["Developer"],["Designer"],["Business Development"],["CEO"],["CTO"],
  ["Maker"],["Javascript"],["Ruby"],["Python"],["PHP"],["Evangelist"],["UX"],["Mobile"],
  ["Marketing"],["Community Manager"],["VC"],["Angel Investor"]
].each do |h|
  Tag.create!(:name => h[0])
end