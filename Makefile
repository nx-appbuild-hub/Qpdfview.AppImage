# Copyright 2020 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
PWD:=$(shell pwd)

all: clean
	mkdir --parents $(PWD)/build/Boilerplate.AppDir
	apprepo --destination=$(PWD)/build appdir boilerplate qpdfview qpdfview-djvu-plugin qpdfview-ps-plugin qpdfview-translations

	cp $(PWD)/build/Boilerplate.AppDir/lib64/qpdfview/* $(PWD)/build/Boilerplate.AppDir/bin
	echo "exec \$${APPDIR}/bin/qpdfview \"\$${@}\"" >> $(PWD)/build/Boilerplate.AppDir/AppRun

	rm -f $(PWD)/build/Boilerplate.AppDir/*.desktop | true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.png | true
	rm -f $(PWD)/build/Boilerplate.AppDir/*.svg | true	

	cp --force $(PWD)/AppDir/*.svg $(PWD)/build/Boilerplate.AppDir 			| true	
	cp --force $(PWD)/AppDir/*.png $(PWD)/build/Boilerplate.AppDir 			| true	
	cp --force $(PWD)/AppDir/*.desktop $(PWD)/build/Boilerplate.AppDir 		| true	
	
	export ARCH=x86_64 && bin/appimagetool.AppImage $(PWD)/build/Boilerplate.AppDir $(PWD)/Qpdfview.AppImage
	chmod +x $(PWD)/Qpdfview.AppImage

clean:
	rm -rf $(PWD)/build
