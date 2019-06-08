------------------------shell Scripting----------------------------

#!/bin/bash
#
# This script creates a new user on the local system.
# You will be prompted to enter the username (login), the person name, and a password.
# The username, password, and host for the account will be displayed.

# Make sure the script is being executed with superuser privileges.
if [[ "${UID}" -ne 0 ]] #Root has 0 UID
then
   echo 'Please run with sudo or as root.'
   exit 1 
fi

# Get the username (login).
read -p 'Enter the username to create: ' USER_NAME  #To read username from terminal and it will save in USER_NAME

# Get the real name (contents for the description field).
read -p 'Enter the name of the person or application that will be using this account: ' COMMENT  #To enter comment and it will save in COMMENT

# Get the password.
read -p 'Enter the password to use for the account: ' PASSWORD  #To take password and it will save it in PASSWORD

# Create the account.
useradd -c "${COMMENT}" -m ${USER_NAME}  #To add the user

# Check to see if the useradd command succeeded.
# We don't want to tell the user that an account was created when it hasn't been.
if [[ "${?}" -ne 0 ]]  #if the user creation not successful then print the below mentioned message
then
  echo 'The account could not be created.'
  exit 1
fi

# Set the password.
echo ${PASSWORD} | passwd --stdin ${USER_NAME}  #To set the password for username

# Check to see if the passwd command succeeded.
if [[ "${?}" -ne 0 ]]  # To check if the set password command is succeeded or failed
then
  echo 'The password for the account could not be set.'
  exit 1
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo
echo 'username:'
echo "${USER_NAME}"
echo
echo 'password:'
echo "${PASSWORD}"
echo
echo 'host:'
echo "${HOSTNAME}"
exit 0

