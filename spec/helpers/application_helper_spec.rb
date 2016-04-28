require 'rails_helper'
RSpec.describe ApplicationHelper, type: :helper do
  describe "active_class" do
    it "returns 'active' if the current url matches a given url" do
      allow(helper).to receive(:current_page?).and_return(true)
      expect(helper).to receive(:current_page?).with("first")
      expect(helper.active_class("first")).to eq("active")
    end

    it "returns '' if the current url does not match a given url" do
      allow(helper).to receive(:current_page?).and_return(false)
      expect(helper).to receive(:current_page?).with("second")
      expect(helper.active_class("second")).to eq("")
    end

    it "returns the specified class string if the current url matches a given url" do
      allow(helper).to receive(:current_page?).and_return(true)
      expect(helper).to receive(:current_page?).with("third")
      expect(helper.active_class("third", "foo")).to eq("foo")
    end
  end

  describe "link_to" do
    it "adds the active for the current url" do
      allow(helper).to receive(:current_page?).and_return(true)
      expect(helper.link_to("name", "path")).to have_tag("a", with: { class: "active" })
    end

    it "omits the active class for urls that are not current" do
      allow(helper).to receive(:current_page?).and_return(false)
      expect(helper.link_to("name", "path")).to have_tag("a", without: { class: "active" })
    end
  end

  describe "flash_tag" do
    it "adds alert-success for notice flash" do
      expect(helper.flash_tag(["notice", "message"])).to have_tag("div", with: { class: ["alert", "alert-success"] })
    end

    it "adds alert-danger for alert flash" do
      expect(helper.flash_tag(["alert", "message"])).to have_tag("div", with: { class: ["alert", "alert-danger"] })
    end

    it "adds alert-info for flash" do
      expect(helper.flash_tag(["flash", "message"])).to have_tag("div", with: { class: ["alert", "alert-info"] })
    end
  end
end
