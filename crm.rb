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
      puts "\e[H\e[2J"
      main_menu
    when 2
      puts "\e[H\e[2J"
      modify_existing_contact
      main_menu
    when 3
      delete_contact
      main_menu
    when 4
      puts "\e[H\e[2J"
      display_all_contacts
      main_menu
    when 5
      display_attribute  #particular attribute of all contacts
      main_menu
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

  def display_all_contacts
    Rolodex.contacts.each do |x| 
      puts "First Name: #{x.first_name}"
      puts "Last Name: #{x.last_name}"
      puts "Email: #{x.email}"
      puts "Note: #{x.note}"
      puts "---------------"
      end
  end

  def display_attribute   #for all contacts
    puts "Display what attribute for all contacts?"
    puts "[1] first name, [2] last name, [3] email or [4] note: "
    choice = gets.to_i
    case choice
    when 1
      Rolodex.contacts.each {|x| puts x.first_name}
    when 2
      Rolodex.contacts.each {|x| puts x.last_name}
    when 3
      Rolodex.contacts.each {|x| puts x.email}
    when 4
      Rolodex.contacts.each {|x| puts x.note}
    else
      puts "Enter a number."
      Rolodex.display_attribute
    end 
    puts
  end


  def display_particular_contact(id_num)
    Rolodex.contacts.each do |x|
      if x.id == id_num
        puts "First name: #{x.first_name}"
        puts "Last name: #{x.last_name}"
        puts "Email: #{x.email}"
        puts "Note: #{x.note}"
        puts
      end
    end
  end

  def edit_attribute(modify_what, id_num)
    display_particular_contact(id_num)
    puts "Enter new choices[modify_what]: "
    new_name = gets.chomp
  end

  def modify_existing_contact
    choices = {1 => "first name", 2 => "last name", 3 => "email", 4 => "note"}
    puts "Modify?: "
    puts "[1] first name, [2] last name, [3] email or [4] note?"
    puts "Enter number"
    modify_what = gets.to_i 
    puts "Please confirm, changing #{choices[modify_what]} (y/n)"
    confirm = gets.chomp.downcase
    if confirm == "y"
      puts "Enter the id number of the contact you want to change: "
      id_num = gets.to_i
      display_particular_contact(id_num)
      puts "Enter new #{choices[modify_what]}"
      new_value = gets.chomp
      case modify_what
      # search each contact in rolodex to look for match, start by assuming all unique
      when 1
        Rolodex.contacts.each {|x| x.first_name = new_value if x.id == id_num}
      when 2
        Rolodex.contacts.each {|x| x.last_name = new_value if x.id == id_num}
      when 3
        Rolodex.contacts.each {|x| x.email = new_value if x.id == id_num}  
      when 4
        Rolodex.contacts.each {|x| x.note = new_value if x.id == id_num}
      end
      puts "Updated contact: "
      display_particular_contact(id_num)
    elsif confirm == "n"
      main_menu
    else
      puts "please confirm, (y/n)"
    end
  end

  def delete_contact #try displaying a particular contact first
    puts "Which contact do you wish to delete? Enter id number: "
    id_number = gets.to_i
    display_particular_contact(id_number)
    puts "Do you want to delete this contact? (y/n)"
    confirm = gets.chomp.downcase
    if confirm == "y"
      Rolodex.contacts.delete_if {|x| x.id == id_number}
      puts "Contact deleted."
      display_all_contacts
    elsif confirm == "n"
      main_menu
    else
      main_menu
    end
  end
end

my_crm = CRM.new("firstCRM")
puts my_crm.name

my_crm.main_menu



#questions is the way I set it to loop a good way or horrible one
# what about searching by other attributes? other than id number 
# same way as I did for id number just requires a lot more asking the user for things
# how would I loop over my_crm.main_menu another way? 
# can i get the user_selected outside of the method? looks like no at the moment, but i don't know
