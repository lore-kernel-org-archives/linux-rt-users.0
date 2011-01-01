From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: Tweaking pengutronix' debian packages for rt kernels
Date: Sat, 1 Jan 2011 18:25:23 +0100
Message-ID: <20110101172523.GA29870@opentech.at>
References: <20110101161000.GY32493@bzzt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Arnout Engelen <arnouten@bzzt.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:45896 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923Ab1AARcH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 1 Jan 2011 12:32:07 -0500
Content-Disposition: inline
In-Reply-To: <20110101161000.GY32493@bzzt.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 01 Jan 2011, Arnout Engelen wrote:

> Hi,
> 
> http://www.pengutronix.de/software/linux-rt/debian_en.html mentions this 
> would be the right place to discuss the Pengutronix Debian packages containing
> RT-patched kernels.
> 
> Is there any guide that documents how to build tweaked versions of these 
> packages? Pengutronix seems to be doing a great job, but for example the 
> package for the 2.6.33.7.2-rt30 kernel doesn't contain the 'nouveau' graphics
> driver, which I happen to use. 
>

roughly:
* apt-get install build-essential libncurses5-dev kernel-package
* grab sources: http://debian.pengutronix.de/debian/pool/non-free/l/linux-2.6/linux-2.6_2.6.33.7.2-rt30.orig.tar.gz
 Note that you can't verify the sources as no signature file is provided (bad)
 ...or simply grab a verified kernel from kernel.org and the appropriate patch
* unpack sources
* copy the config file to .config in the kernel source tree.
* make menuconfig and add the driver you need
* adjust /etc/kernel-pkg.conf (atleast maintainer and email - so you get blamed if you screwed up ;)
* compile and sign package: CONCURRENCY_LEVEL=4 make-kpkg --pgpsign YOURNAME --initrd --append-to-version=-nouveau --revision=2.6.33.7 kernel-image kernel-source

Notes:
* Note that you get a build failure on lenny as it does not find the utsreleas version in the right location for newer kernels (newer than 2.6.26 that is) so you have to manually cp include/generated/utsrelease.h include/linux/utsrelease.h and rerun the make-kpkg command
* provide package AND sginature to the users of this package.
* CONCURRENCY_LEVEL is just like -j4 here - so adjust to what is suitable for your compile box
* the "--append-to-version=" is the string that will be added to the kenrle package so that you have a kernel package at the end called linux-image-2.6.33.7.2-rt30-nouveau_2.6.33.7_ARCH.deb
* the name that you pass with --pgpsign must be the same as you get when you use gpg --list-keys 

> Some pointers on how to create a version of the packages including the
> 'nouveau' modules would be very helpful.
>

man make-kpkg
man kernel-pkg.conf

further details about debian packages at http://www.debian.org/doc/maint-guide/

hofrat 
