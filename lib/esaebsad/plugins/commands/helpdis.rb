class HelpDis < ESAEBSADCommand
    include Cinch::Plugin
    include ESAEBSAD::Utility
    extend ESAEBSAD::Utility

    match /helpdis (.+); (.+)/
    def execute(msg, page, new_mod)
        if is_op? msg.user.authname, "ftb"
            text = get_client.get_text(page)

            if text.include? "{{Disambiguation"
                last_mod = nil
                text_length = 0

                text.each_line do |line|
                    text_length += line.length
                    match = line.match /\* (\[\[|{{L|)(.+) \((.+)\)(\]\]|}})\n/
                    next if match.nil?
                    mod = match[3]
                    puts "Mod: #{mod}; Last mod: #{last_mod}; Length: #{text_length}"

                    if last_mod.nil?
                        last_mod = mod
                        next
                    end

                    break if last_mod > new_mod
                end

                new_line = ""

                if text.include? "{{L"
                    new_line = "* {{L|#{page} (#{new_mod})}}\n"
                else
                    new_line = "* [[#{page} (#{new_mod})]]\n"
                end

                get_client.edit(page, text.insert(text_length, new_line), summary: "Testing dis stuff")
            end
        end
    end
end
