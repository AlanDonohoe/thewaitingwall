require 'rails_helper'

feature 'User posts and views messages via a multi tenant section of the site' do
  before do
    Tenant.create(name: '', subdomain: '') # default tenant...
    @meaning_conf_tenant = create(:tenant, :meaning_conf)
    @other_tenant = create(:tenant, subdomain: 'othertenant')
    @wall = create(:wall)
  end
  scenario 'they post a message to a subdomain section of the site' do
    @meaning_conf_tenant = create(:tenant, :meaning_conf)
    switch_to_subdomain('meaningconf')
    visit new_message_path
    fill_in 'message_message_text', with: 'this is my message for the meaningconf wall'
    click_on 'Post to the wall'
    expect(page).to have_content('Thank you')
    expect(@meaning_conf_tenant.messages.count).to eq 1
  end

  scenario 'they see correctly scoped messages based on what version of the site they are visiting' do
    Capybara.ignore_hidden_elements = false 
    @meaning_conf_msg = create(:message, :approved, message_text: 'meaning conf message', tenant_id: @meaning_conf_tenant.id)
    @other_tenant_msg = create(:message, :approved, message_text: 'other tenant message', tenant_id: @other_tenant.id)
    visit new_message_path
    fill_in 'message_message_text', with: 'this is a general message'
    click_on 'Post to the wall'
    @general_message = Message.unapproved_messages.first
    @general_message.update_columns(approved: true)
    # run the batch method
    Tenant.all.each { |tenant| tenant.create_batch }
    expect(Batch.count).to eq 3 # just to check default tenant has a batch made...
    # tenant 1:
    switch_to_subdomain('meaningconf')
    visit wall_path(@wall)
    within('#current_batch_of_messages') do
      expect(page).to have_content @meaning_conf_msg.message_text
      expect(page).to_not have_content @other_tenant_msg.message_text
      expect(page).to_not have_content @general_message.message_text
    end
    # tenant 2:
    switch_to_subdomain('othertenant')
    visit wall_path(@wall)
    within('#current_batch_of_messages') do
      expect(page).to have_content @other_tenant_msg.message_text
      expect(page).to_not have_content @meaning_conf_msg.message_text
      expect(page).to_not have_content @general_message.message_text
    end
    # default tenant:
    switch_to_subdomain('')
    visit wall_path(@wall)
    within('#current_batch_of_messages') do
      expect(page).to have_content @general_message.message_text
      expect(page).to_not have_content @meaning_conf_msg.message_text
      expect(page).to_not have_content @other_tenant_msg.message_text
    end
  end
end  
