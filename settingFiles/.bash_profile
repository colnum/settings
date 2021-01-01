# ---------------------------------------------------------------
# This setting file is read, when you have logined this computer.
# If you not use bash for login-shell, this file is not read.
# ---------------------------------------------------------------

# When .profile is existing, do it.
# Get the environment parameters.
if [ -f ~/.profile ]; then
	. ~/.profile
fi

# When .bashrc is existing, do it.
# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
