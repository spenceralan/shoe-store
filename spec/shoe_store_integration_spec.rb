require "spec_helper"

describe("the shoe path", {:type => :feature}) do

  let(:new_shoe) {Shoe.create({name: "Fancy Shoe", price: 100})
}

  it("adds a new shoe") do
    visit("/")
    click_link("add shoe")
    fill_in("shoe-name", :with => "Fancy Shoes")
    fill_in("shoe-price", :with => "90")
    click_button("add shoes")
    expect(page).to have_content("Fancy Shoes")
    expect(page).to have_content("$90.00")
  end

  it("returns an error if shoe name is blank") do
    visit("/")
    click_link("add shoe")
    fill_in("shoe-price", :with => "90")
    click_button("add shoes")
    expect(page).to have_content("Name can't be blank")
  end

  it("returns an error if price is not a number") do
    visit("/")
    click_link("add shoe")
    fill_in("shoe-name", :with => "Fancy Shoes")
    fill_in("shoe-price", :with => "forty")
    click_button("add shoes")
    expect(page).to have_content("Price is not a number")
  end

  it("updates the price of a shoe") do
    new_shoe
    visit("/")
    click_link("Fancy Shoe")
    click_link("edit shoes")
    fill_in("shoe-price", :with => "80")
    click_button("update shoes")
    expect(page).to have_content("$80.00")
  end

  it("updates the name of a shoe") do
    new_shoe
    visit("/")
    click_link("Fancy Shoe")
    click_link("edit shoes")
    fill_in("shoe-name", :with => "Super Fancy Shoe")
    click_button("update shoes")
    expect(page).to have_content("Super Fancy Shoe")
  end

  it("deletes a shoe") do
    new_shoe
    visit("/")
    click_link("Fancy Shoe")
    click_link("edit shoes")
    click_button("delete shoes")
    expect(page).not_to have_content("Fancy Shoe")
  end

end

describe("the store path", {:type => :feature}) do

  let(:new_store) {Store.create({name: "Fancy Store"})}
  let(:new_shoe1) {Shoe.create({name: "Crazy Fancy Shoe", price: 100})}
  let(:new_shoe2) {Shoe.create({name: "Super Fancy Shoe", price: 100})}


  it("adds a new store") do
    visit("/")
    click_link("add store")
    fill_in("store-name", :with => "Fancy Store")
    click_button("add store")
    expect(page).to have_content("Fancy Store")
  end

  it("returns an error if store name is blank") do
    visit("/")
    click_link("add store")
    click_button("add store")
    expect(page).to have_content("Name can't be blank")
  end

  it("updates the name of a store") do
    new_store
    visit("/")
    click_link("Fancy Store")
    click_link("edit store")
    fill_in("store-name", with: "Super Fancy Store")
    click_button("update store")
    expect(page).to have_content("Super Fancy Store")
  end

  it("deteles a store") do
    new_store
    visit("/")
    click_link("Fancy Store")
    click_link("edit store")
    click_button("delete store")
    expect(page).not_to have_content("Fancy Store")
  end

  it("adds shoes to a store") do
    new_store
    new_shoe1
    new_shoe2
    visit("/")
    click_link("Fancy Store")
    click_link("edit store")
    check("Crazy Fancy Shoe")
    check("Super Fancy Shoe")
    click_button("update store")
    expect(page).to have_content("Crazy Fancy Shoe")
    expect(page).to have_content("Super Fancy Shoe")
  end

  it("removes shoes from a store") do
    new_store.shoes.push(new_shoe1)
    new_store.shoes.push(new_shoe2)
    visit("/")
    click_link("Fancy Store")
    click_link("edit store")
    uncheck("Crazy Fancy Shoe")
    uncheck("Super Fancy Shoe")
    click_button("update store")
    expect(page).not_to have_content("Crazy Fancy Shoe")
    expect(page).not_to have_content("Super Fancy Shoe")
  end

end