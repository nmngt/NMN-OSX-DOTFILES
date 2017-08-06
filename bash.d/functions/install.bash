# ----------------------------------------------------------------------------
#  BASH: Functions - Installation
#  $Id$
# ----------------------------------------------------------------------------
# ::::::::::::::::::::::::::::::: vim: set noai noet ru nu ml ts=4 sw=4 tw=0:
# ----------------------------------------------------------------------------
nbe_msg "${icon[child]} Install Helper" ${BASH_SOURCE}

#
# IF first start or fresh install
#
run_list() {
cat <<EOT

Additional software to install

Browsers:
  Opera
  Google Chrome
  Google Chrome Canary

Development:
  iTerms 2
  Atom
  JetBrains ToolBox
  Wireshark
  Charles

Other:
  1Password
  Dropbox
  Airmail 3
  Boom 2
  Spotify
  Divvy

EOT
}