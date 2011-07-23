From: hermann <brummer-@web.de>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Sat, 23 Jul 2011 17:21:23 +0200
Message-ID: <1311434484.2223.12.camel@box>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>
	 <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>
	 <1311313414.2940.8.camel@box> <20110722065711.GD16561@pengutronix.de>
	 <87y5zqzick.fsf@rustcorp.com.au>  <20110722192051.GH16561@pengutronix.de>
	 <1311391059.2343.8.camel@box>  <4E2A9B18.6030000@gareus.org>
	 <1311430753.2223.5.camel@box>  <4E2ADBB6.20604@gareus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org, lguest@lists.ozlabs.org
To: Robin Gareus <robin@gareus.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:54514 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752779Ab1GWPV1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 11:21:27 -0400
In-Reply-To: <4E2ADBB6.20604@gareus.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Am Samstag, den 23.07.2011, 16:33 +0200 schrieb Robin Gareus:
> On 07/23/2011 04:19 PM, hermann wrote:
> > Am Samstag, den 23.07.2011, 11:57 +0200 schrieb Robin Gareus:
> >> Hello Herman,
> >>
> >> Are you using make-kpkg?  You need to change the path to lguest
> >> in /usr/share/kernel-package/ruleset/targets/doc.mk and two or three
> >> other files there as Rusty outlined.
> >>
> >> HTH,
> >> robin 
> > 
> > Hi Robin
> > 
> > Yes, using make-kpkg. I changed line 61 from 
> > [..]
> > but it didn't help, the result is still the same.
> > /usr/bin/make    ARCH=i386 \
> > 			     -C Documentation/lguest
> 
> That's the one in /usr/share/kernel-package/ruleset/targets/image.mk
> 
> I don't remember all locations, there were around a dozen, also
> including some $CONFIG_* checks. It was pretty straight forward and -
> alas - I did not keep a diff.
> 
> `grep -rli lguest /usr/share/kernel-package/` should get you going.
> 
> If you're really stuck I can `apt-get --reinstall` and create a diff.
> Let me know. If it is Debian, be aware that there are also various other
> scripts in need of patching (e.g. /etc/init.d/udev supported_kernel()
> does not match the 3.X series, yet),..
> 
> 
> > Schluss.
> ende, aus :)
> 
> robin

Thanks robin, get it working now. Have changed the locations in 
/usr/share/kernel-package/ruleset/targets/common.mk
/usr/share/kernel-package/ruleset/targets/doc.mk
/usr/share/kernel-package/ruleset/targets/image.mk

It would be cool if you could remember witch other scripts need to be
patched to support the 3.X series.

I mean I run already the Kernel 3.0.0-rc7-rt0 i686 here on debian/sid
without hazel, but be interested to set up all in a matching manner.  

regards
hermann

