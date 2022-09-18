shell_dir = ${HOME}/.config/shell
awesome_dir = ${HOME}/.config/awesome
alacritty_dir = ${HOME}/.config/alacritty

nvim_dir = ${HOME}/.config/nvim
nvim_lua_dir = ${nvim_dir}/lua

gtk3_dir = ${HOME}/.config/gtk-3.0

awesome_default_theme_dir = ${awesome_dir}/themes/default
wallpapers_dir = ${HOME}/wallpapers
statusbar_dir = ${HOME}/.local/bin/statusbar

icons_default_dir = ${HOME}/.icons/default
share_icons_dir = ${HOME}/.local/share/icons
cursor_theme = ArcMidnight-cursors

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
			${statusbar_dir}/weather \

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
	${icons_default_dir} \
	${icons_default_dir}/index.theme \
	${share_icons_dir} \
	${share_icons_dir}/${cursor_theme} \
	${gtk3_dir} \
	${gtk3_dir}/settings.ini

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

# Cursor theme
${icons_default_dir}:
	mkdir -p $@

${icons_default_dir}/index.theme: .icons/default/index.theme
	cp $< $@

${share_icons_dir}:
	mkdir -p $@

${share_icons_dir}/${cursor_theme}:
	wget -q --show-progress -P /tmp \
		https://ewr1.vultrobjects.com/cursors/${cursor_theme}.tar.gz
	tar xf /tmp/${cursor_theme}.tar.gz -C ${share_icons_dir}
	rm /tmp/${cursor_theme}.tar.gz
	ln -s ${share_icons_dir}/${cursor_theme}/cursors \
		${icons_default_dir}/cursors

# Gtk-3
${gtk3_dir}:
	mkdir -p $@

${gtk3_dir}/settings.ini: .config/gtk-3.0/settings.ini
	cp $< $@

