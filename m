From: Joakim Hernberg <jbh@alchemy.lu>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init
 [which in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Tue, 20 May 2014 20:36:55 +0200
Message-ID: <20140520203655.307d2e38@tor.valhalla.alchemy.lu>
References: <CAOcfFMxc=Ldp_bvvz228_8C9SxqbCbfgzaAjBrf4n2oigG7_wg@mail.gmail.com>
	<CAOcfFMynnyHL_G6Gez_AZYFky=hLYeoyY8WVHF572RZq1g_aBw@mail.gmail.com>
	<CAP=VYLrHC3TPAixV8m0u9g8ooyiE0jvS=7bFLHDdCwt3wsA1iA@mail.gmail.com>
	<CAOcfFMy_Ui94baWzuAMKOnUpcjYpnNsubdDCNTZx52XokVyN6g@mail.gmail.com>
	<535A7474.2090701@windriver.com>
	<CAOcfFMyjup8OAkxHj-hbb5rMzrPjNPpw_9Jdx-iXPi09ce-Zuw@mail.gmail.com>
	<535A9DDC.4070801@windriver.com>
	<5372BB0C.8030303@me.com>
	<1400505275.3482.5.camel@archlinux>
	<1400505358.3482.6.camel@archlinux>
	<20140519171603.6c0c2ec2@tor.valhalla.alchemy.lu>
	<1400526129.839.10.camel@archlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	jordan <triplesquarednine@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:37304 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750957AbaETShC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 20 May 2014 14:37:02 -0400
In-Reply-To: <1400526129.839.10.camel@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 19 May 2014 21:02:09 +0200
Ralf Mardorf <ralf.mardorf@alice-dsl.net> wrote:

> On Mon, 2014-05-19 at 17:16 +0200, Joakim Hernberg wrote:
> > If you are still on archlinux, try the new 3.14.3-rt5 kernel that
> > I've uploaded to the AUR and to the binary archaudio-production
> > repo.  This one has 3 patches reverted, and all of NO_HZ disabled.
> > Apparently this makes it work on some AMD cpus that have had
> > problem booting recent -rt kernels.
> 
> I tried both rt-lts and rt from the repo, not from AUR, for a x86_64
> install.
> 
> $ pacman -Q linux-rt-lts
> linux-rt-lts 3.10.39_rt40-1
> 
> I only tried to boot it one time.
> Startup finished with a black screen, the display manager wasn't
> visible.
> 
> $ pacman -Q linux-rt
> linux-rt 3.14.3_rt5-1
> 
> The first time I booted it, a restart happened during startup.
> The second time I booted it, startup hung.
> 

If so I have no idea...  Maybe ask Jordan, as he has been having a
similar problem with AMD.  Maybe try his linux-l-pa kernel from the AUR.

-- 

   Joakim
