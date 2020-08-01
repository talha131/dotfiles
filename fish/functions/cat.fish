function cat
  which bat > /dev/null
  and begin
	command bat $argv;
  end
  or begin
	command cat $argv;
  end
end

