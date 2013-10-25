require_relative "contact"
require_relative "rolodex"

class CRM
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def print_main_menu  #should there be another for 'display particular contact'?
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Display an attribute" 
    puts "[6] Exit"
    puts "Enter a number: "
  end

  def main_menu
    print_main_menu
    user_selected = gets.to_i
    call_option(user_selected)
  end

  def call_option(user_selected)
    case user_selected
    when 1
      add_new_contact
    when 2
      modify_existing_contact
    when 3
      delete_contact
    when 4
      Rolodex.display_all_contacts
    when 5
      Rolodex.display_attribute  #particular attribute of all contacts
    when 6
      puts "Goodbye"
      exit 
    else
      puts "\e[H\e[2J"
      puts "Enter a number."
      main_menu      
    end
  end

  def add_new_contact
    print "Enter First Name: "
    first_name = gets.chomp
    print "Enter Last Name: "
    last_name = gets.chomp
    print "Enter Email Address: "
    email = gets.chomp
    print "Enter a Note: "
    note = gets.chomp
    contact = Contact.new(first_name, last_name, email, note)
    Rolodex.add_contact(contact)
  end

  def modify_existing_contact
    puts which contact and modify what
    # which contact, find contact, modify what, then actually modify it 
    puts "Modify?: "
    puts "[1] first name, [2] last name, [3] email or [4] note?"
    puts "Enter number"
    modify_what = gets.to_i #use numbers
    case modify_what
    when 1
      puts "Please enter new first name: "
      now what = gets.chomp
    when 2 
      then what 
    end
      
  end

  def delete_contact #try displaying a particular contact first
    puts "Which contact do you wish to delete?"
    puts "Enter the name, email, note or id number: " #why would delete by note? both names?
    # choice = gets.chomp (or to_i if use numbers?)
    #display contact and ask if sure, maybe write method for display one
    #contact.  maybe should search for contact using whatever and return id num
    #if first wrong how to not keep finding same one. or assume all contacts are unique
    # in each way
  end
end

my_crm = CRM.new("firstCRM")
puts my_crm.name
my_crm.main_menu
my_crm.main_menu
# will need final loop for until 6 then end
