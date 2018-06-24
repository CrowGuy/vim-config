# vim-config
My vim custom IDE config.

## IDE support
- python3

## Set vim manageer 
Tap follow command to download the vim config file.
```
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
$ git clone https://github.com/CrowGuy/vim-config.git 
$ git mv vimrc ~/.vimrc
```
## Install Plugins
Exec the install command as follow in vim editor.
```
:PluginInstall
```

## Special plugin install case

### YouCompleteMe
When vim editor open file, there is an error message:
```
The ycmd server SHUT DOWN (restart with ':YcmRestartServer'). YCM core library not detected; you need to compile YCM before using it. Follow the instructions in the documentation.
```

Install development tools and CMake:
```
$ sudo apt-get install build-essential cmake
```
Compiling YCM with semantic support for C-family languages:
```
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
```
