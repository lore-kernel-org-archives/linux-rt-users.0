From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init
 [which in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Mon, 19 May 2014 21:02:09 +0200
Message-ID: <1400526129.839.10.camel@archlinux>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
	 <CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com>
	 <CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
	 <CAOcfFMy_Ui94baWzuAMKOnUpcjYpnNsubdDCNTZx52XokVyN6g@mail.gmail.com>
	 <535A7474.2090701@windriver.com>
	 <CAOcfFMyjup8OAkxHj-hbb5rMzrPjNPpw_9Jdx-iXPi09ce-Zuw@mail.gmail.com>
	 <535A9DDC.4070801@windriver.com> <5372BB0C.8030303@me.com>
	 <1400505275.3482.5.camel@archlinux> <1400505358.3482.6.camel@archlinux>
	 <20140519171603.6c0c2ec2@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Joakim Hernberg <jbh@alchemy.lu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail153c50.megamailservers.eu ([91.136.10.163]:41032 "EHLO
	mail50c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751254AbaESTCV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2014 15:02:21 -0400
In-Reply-To: <20140519171603.6c0c2ec2@tor.valhalla.alchemy.lu>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2014-05-19 at 17:16 +0200, Joakim Hernberg wrote:
> If you are still on archlinux, try the new 3.14.3-rt5 kernel that I've
> uploaded to the AUR and to the binary archaudio-production repo.  This
> one has 3 patches reverted, and all of NO_HZ disabled. Apparently this
> makes it work on some AMD cpus that have had problem booting recent -rt
> kernels.

I tried both rt-lts and rt from the repo, not from AUR, for a x86_64
install.

$ pacman -Q linux-rt-lts
linux-rt-lts 3.10.39_rt40-1

I only tried to boot it one time.
Startup finished with a black screen, the display manager wasn't
visible.

$ pacman -Q linux-rt
linux-rt 3.14.3_rt5-1

The first time I booted it, a restart happened during startup.
The second time I booted it, startup hung.

