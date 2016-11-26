### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Shortcut for the ghc HEAD's compiler
export head="/Volumes/GHC/build/ghc-build/inplace/bin/ghc-stage2"

# Env vars
export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"
export PATH=/Users/kvelicka/.local/bin:$PATH
export PATH=/Users/kvelicka/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/Qt-5.3.2/bin:$PATH

# Add GHC 7.10.3 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.3.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${PATH}:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin"
fi

# start f.lux on linux
xflux -l 51 -g 0 # approx London coordinates
dropbox start

