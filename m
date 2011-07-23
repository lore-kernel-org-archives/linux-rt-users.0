From: Robin Gareus <robin@gareus.org>
Subject: Re: [PATCH] Various fixups from first bug reports
Date: Sat, 23 Jul 2011 11:57:44 +0200
Message-ID: <4E2A9B18.6030000@gareus.org>
References: <alpine.LFD.2.02.1107211932440.2702@ionos>	 <1311278277-8222-1-git-send-email-u.kleine-koenig@pengutronix.de>	 <1311313414.2940.8.camel@box> <20110722065711.GD16561@pengutronix.de>	 <87y5zqzick.fsf@rustcorp.com.au>  <20110722192051.GH16561@pengutronix.de> <1311391059.2343.8.camel@box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	devicetree-discuss@lists.ozlabs.org, lguest@lists.ozlabs.org
To: hermann <brummer-@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:56645 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449Ab1GWJ62 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jul 2011 05:58:28 -0400
In-Reply-To: <1311391059.2343.8.camel@box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/23/2011 05:17 AM, hermann wrote:
> Am Freitag, den 22.07.2011, 21:20 +0200 schrieb Uwe Kleine-K=C3=B6nig=
:
>> I don't understand that and didn't try to reproduce.=20
>> hermann, maybe you can follow up with your failing .config and try t=
o
>> reproduce on v3.0 (without rt)?
>>
>> Best regards
>> Uwe=20
>=20
> well, it also didn't build from the 3.0 mainline with that config. Af=
ter
> modules build stage 2, it comes to :
> . . . . .
> IHEX    firmware/yam/9600.bin
> make[1]: Leaving directory `/home/brummer/Projekte/Kernel/linux-3.0'
> /usr/bin/make    ARCH=3Di386 \
> 			     -C Documentation/lguest
> make: *** Documentation/lguest: Datei oder Verzeichnis nicht gefunden=
=2E
> Schluss.
> make: *** [debian/stamp/build/kernel] Fehler 2
>=20
Hello Herman,

Are you using make-kpkg?  You need to change the path to lguest
in /usr/share/kernel-package/ruleset/targets/doc.mk and two or three
other files there as Rusty outlined.

HTH,
robin
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
