shell_dir = ${HOME}/.config/shell
awesome_dir = ${HOME}/.config/awesome
alacritty_dir = ${HOME}/.config/alacritty

nvim_dir = ${HOME}/.config/nvim
nvim_lua_dir = ${nvim_dir}/lua
packer = ${HOME}/.local/share/nvim/site/pack/packer/start/packer.nvim

gtk3_dir = ${HOME}/.config/gtk-3.0

awesome_default_theme_dir = ${awesome_dir}/themes/default
wallpapers_dir = ${HOME}/wallpapers
statusbar_dir = ${HOME}/.local/bin/statusbar

share_icons_dir = ${HOME}/.local/share/icons
cursor_theme = ArcMidnight-cursors

ttf_fonts_dir = ${HOME}/.local/share/fonts/ttf
fira_code_fonts = ${ttf_fonts_dir}/FiraCode-Bold.ttf \
		  ${ttf_fonts_dir}/FiraCode-Light.ttf \
		  ${ttf_fonts_dir}/FiraCode-Medium.ttf \
		  ${ttf_fonts_dir}/FiraCode-Regular.ttf \
		  ${ttf_fonts_dir}/FiraCode-Retina.ttf \
		  ${ttf_fonts_dir}/FiraCode-SemiBold.ttf

statusbar = ${statusbar_dir}/accuweather \
			${statusbar_dir}/backlight \
			${statusbar_dir}/battery \
			${statusbar_dir}/cpu \
			${statusbar_dir}/cpu_temp \
			${statusbar_dir}/datetime \
			${statusbar_dir}/disk \
			${statusbar_dir}/internet \
			${statusbar_dir}/kernel \
			${statusbar_dir}/keyboard \
			${statusbar_dir}/mailbox \
			${statusbar_dir}/nettraf \
			${statusbar_dir}/ram \
			${statusbar_dir}/rate \
			${statusbar_dir}/rate.py \
			${statusbar_dir}/upt \
			${statusbar_dir}/volume \
			${statusbar_dir}/weather

install: \
	${shell_dir} \
	${shell_dir}/aliases \
	${shell_dir}/utils \
	${HOME}/.bashrc \
	${HOME}/.bash_profile \
	${HOME}/.xinitrc \
	${HOME}/.Xresources \
	${awesome_dir} \
	${awesome_dir}/rc.lua \
	${awesome_dir}/osmiumrc.lua \
	${awesome_dir}/wibar.lua \
	${awesome_dir}/osmium \
	${awesome_default_theme_dir} \
	${awesome_default_theme_dir}/theme.lua \
	${wallpapers_dir} \
	${wallpapers_dir}/0002.jpg \
	${statusbar_dir} \
	${statusbar} \
	${alacritty_dir} \
	${alacritty_dir}/alacritty.yml \
	${nvim_dir} \
	${nvim_dir}/init.lua \
	${nvim_lua_dir} \
	${nvim_lua_dir}/keymappings.lua \
	${nvim_lua_dir}/plugins.lua \
	${packer} \
	${gtk3_dir} \
	${gtk3_dir}/settings.ini \
	${share_icons_dir}/${cursor_theme} \
	${ttf_fonts_dir} \
	${fira_code_fonts} \
	${ttf_fonts_dir}/Symbola.ttf

# Shell
${shell_dir}:
	mkdir -p $@

${shell_dir}/aliases: .config/shell/aliases
	cp $< $@

${shell_dir}/utils: .config/shell/utils
	cp $< $@

# Bash
${HOME}/.bash_profile: .bash_profile
	cp $< $@

${HOME}/.bashrc: .bashrc
	cp $< $@

# X11
${HOME}/.xinitrc: .xinitrc
	cp $< $@

${HOME}/.Xresources: .Xresources
	cp $< $@

bash: \
	${shell_dir} \
	${shell_dir}/aliases \
	${shell_dir}/utils
	${HOME}/.bashrc \
	${HOME}/.bash_profile \
	${HOME}/.xinirc \
	${HOME}/.Xresources

# AwesomeWM
${awesome_dir}:
	mkdir -p $@

${awesome_dir}/rc.lua: .config/awesome/rc.lua
	cp $< $@

${awesome_dir}/wibar.lua: .config/awesome/wibar.lua
	cp $< $@

${awesome_dir}/osmiumrc.lua: .config/awesome/osmiumrc.lua
	cp $< $@

${awesome_dir}/osmium:
	test ! -e $@ && ln -s -r .config/awesome/osmium $@ || true

${awesome_default_theme_dir}:
	mkdir -p $@

${awesome_default_theme_dir}/theme.lua: .config/awesome/themes/default/theme.lua
	cp $< $@

${wallpapers_dir}:
	mkdir -p $@

${wallpapers_dir}/0002.jpg:
	wget -q --show-progress -P ${@D} \
		https://ewr1.vultrobjects.com/wallpapers/0002.jpg

${statusbar_dir}:
	mkdir -p $@

${statusbar_dir}/%: .local/bin/statusbar/%
	cp $< $@

awesome: \
	${awesome_dir} \
	${awesome_dir}/rc.lua \
	${awesome_dir}/wibar.lua \
	${awesome_dir}/osmium \
	${awesome_default_theme_dir} \
	${awesome_default_theme_dir}/theme.lua \
	${wallpapers_dir} \
	${wallpapers_dir}/0002.jpg \
	${statusbar_dir} \
	${statusbar}

# Alacritty
${alacritty_dir}:
	mkdir -p $@

${alacritty_dir}/alacritty.yml: .config/alacritty/alacritty.yml
	cp $< $@

# Neovim
${nvim_dir}:
	mkdir -p $@

${nvim_dir}/init.lua: .config/nvim/init.lua
	cp $< $@

${nvim_lua_dir}:
	mkdir -p $@

${nvim_lua_dir}/%: .config/nvim/lua/%
	cp $< $@

${packer}:
	git clone --depth 1 https://github.com/wbthomason/packer.nvim $@
	nvim --headless \
		-c 'autocmd User PackerComplete quitall' \
		-c 'PackerSync' \
		> /dev/null 2>&1

${share_icons_dir}/${cursor_theme}:
	./change-cursor-theme ${cursor_theme}

# Gtk-3
${gtk3_dir}:
	mkdir -p $@

${gtk3_dir}/settings.ini: .config/gtk-3.0/settings.ini
	cp $< $@

# Fonts
${ttf_fonts_dir}:
	mkdir -p $@

define install-font
	wget -q --show-progress -P /tmp \
		https://ewr1.vultrobjects.com/fonts/${1}.tar.gz
	tar xf /tmp/${1}.tar.gz -C ${ttf_fonts_dir}
	rm /tmp/${1}.tar.gz
	fc-cache -f
endef

${fira_code_fonts}:
	${call install-font,Fira-Code}

${ttf_fonts_dir}/Symbola.ttf:
	${call install-font,Symbola}
