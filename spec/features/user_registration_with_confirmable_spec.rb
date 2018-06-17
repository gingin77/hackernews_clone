require 'rails_helper'

describe "user registration flow with confirmable" do
  describe "with qualifying credentials" do
    before {
      visit new_user_registration_path

      fill_in "Name",                        with: "Jessica Jones"
      fill_in "Email",                       with: "jjones@email.com"
      fill_in "user[password]",              with: "password!@"
      fill_in "user[password_confirmation]", with: "password!@"

      click_on "Sign up"
    }

    let!(:user)  { User.last }
    let!(:email) { Devise.mailer.deliveries.last }
    let!(:host)  { "http://localhost:3000" }

    it "provides an informative alert message" do
      expect(page).to have_css("div", text: "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.", class: "alert-notice")
    end

    it "does not display any content besides the message and nav bar" do
      expect(page).to have_link("Sign In", href: "/users/sign_in" )

      expect(page).to_not have_content "Email"
      expect(page).to_not have_content "Password"
    end

    it "sends an instructional email to the submitted address" do
      expect(email.to[0]).to   eq("jjones@email.com")
      expect(email.from[0]).to eq("no-reply@myhackernewslite.com")
      expect(email.subject).to eq("Confirmation instructions")

      expect(email.body.to_s).to have_content("You can confirm your account email through the link below:")
    end

    it "email has confirmation link based on the users unique token" do
      expect(email.body.to_s).to have_link(
        "Confirm my account",
        href: "#{host}/users/confirmation?confirmation_token=#{user.confirmation_token}" )
    end

    describe "user clicks on confirmation link" do
      before {
        visit "#{host}/users/confirmation?confirmation_token=#{user.confirmation_token}"
      }

      describe "visitor is taken to the sign in page" do
        it { expect(page).to have_field("user[email]") }
        it { expect(page).to have_field("user[password]") }

        it { expect(page).to_not have_field("user[name]") }
        it { expect(page).to_not have_field("user[password_confirmation]") }

        it "displays an informative alert message" do
          expect(page).to have_css(
            "div",
            class: "alert-notice",
              text: "Your email address has been successfully confirmed. You can now sign in using the password you just created."
          )
        end
      end
    end
  end
end