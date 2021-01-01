# ---------------------------------------------------------------
# This setting file is read, when you have logined this computer.
# If you not use bash for login-shell, this file is not read.
# !COUTION! : .zshrc is road on login and interactive. 
# Don't have to wirte reading .zshrc file setting in this file.
# ---------------------------------------------------------------

# When .profile is existing, do it.
# Get the environment parameters.
if [ -f ~/.profile ]; then
	source ~/.profile
fi

