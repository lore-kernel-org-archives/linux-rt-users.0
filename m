From: Robin Gareus <robin@gareus.org>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Sat, 23 Jul 2011 16:33:26 +0200
Message-ID: <4E2ADBB6.20604@gareus.org>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>	 <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>	 <1311313414.2940.8.camel@box> <20110722065711.GD16561@pengutronix.de>	 <87y5zqzick.fsf@rustcorp.com.au>  <20110722192051.GH16561@pengutronix.de>	 <1311391059.2343.8.camel@box>  <4E2A9B18.6030000@gareus.org> <1311430753.2223.5.camel@box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org, lguest@lists.ozlabs.org
To: hermann <brummer-@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:48848 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752844Ab1GWOdn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 10:33:43 -0400
In-Reply-To: <1311430753.2223.5.camel@box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/23/2011 04:19 PM, hermann wrote:
> Am Samstag, den 23.07.2011, 11:57 +0200 schrieb Robin Gareus:
>> Hello Herman,
>>
>> Are you using make-kpkg?  You need to change the path to lguest
>> in /usr/share/kernel-package/ruleset/targets/doc.mk and two or three
>> other files there as Rusty outlined.
>>
>> HTH,
>> robin 
> 
> Hi Robin
> 
> Yes, using make-kpkg. I changed line 61 from 
> [..]
> but it didn't help, the result is still the same.
> /usr/bin/make    ARCH=i386 \
> 			     -C Documentation/lguest

That's the one in /usr/share/kernel-package/ruleset/targets/image.mk

I don't remember all locations, there were around a dozen, also
including some $CONFIG_* checks. It was pretty straight forward and -
alas - I did not keep a diff.

`grep -rli lguest /usr/share/kernel-package/` should get you going.

If you're really stuck I can `apt-get --reinstall` and create a diff.
Let me know. If it is Debian, be aware that there are also various other
scripts in need of patching (e.g. /etc/init.d/udev supported_kernel()
does not match the 3.X series, yet),..


> Schluss.
ende, aus :)

robin
