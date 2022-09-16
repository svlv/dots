shell_dir = ${HOME}/.config/shell

install: \
	${shell_dir}/aliases \
	${shell_dir}/utils \
	${HOME}/.bashrc \
	${HOME}/.bash_profile \
	${HOME}/.xinitrc

${shell_dir}:
	mkdir -p $@

${shell_dir}/aliases: .config/shell/aliases ${shell_dir} 
	cp $< $@

${shell_dir}/utils: .config/shell/utils ${shell_dir} 
	cp $< $@

${HOME}/.bashrc: .bashrc
	cp $< $@

${HOME}/.xinitrc: .xinitrc
	cp $< $@

${HOME}/.bash_profile: .bash_profile
	cp $< $@

bash: ${HOME}/.bashrc ${HOME}/.bash_profile

