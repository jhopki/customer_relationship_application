class Rolodex
  @contacts = []
  @id = 1000

  def self.add_contact(contact)
    contact.id = @id
    @contacts << contact
    @id += 1
  end

  def self.contacts
    @contacts
  end

  def self.display_all_contacts
    Rolodex.contacts.each do |x| 
      puts "First Name: #{x.first_name}"
      puts "Last Name: #{x.last_name}"
      puts "Email: #{x.email}"
      puts "Note: #{x.note}"
      end
  end

  def self.display_attribute   #for all contacts
    puts "Display what attribute for all contacts?"
    puts "[1] first name, [2] last name, [3] email or [4] note: "
    choice = gets.to_i
    case choice
    when 1
      @contacts.each {|x| puts x.first_name}
    when 2
      @contacts.each {|x| puts x.last_name}
    when 3
      Rolodex.contacts.each {|x| puts x.email}
    when 4
      Rolodex.contacts.each {|x| puts x.note}
    else
      puts "Enter a number."
      Rolodex.display_attribute
    end    
  end
end