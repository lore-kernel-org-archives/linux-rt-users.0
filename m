From: Joakim Hernberg <jbh@alchemy.lu>
Subject: Re: WAS: linux-rt fails to boot on > 3.12.5.-rt7 ... NOW IS:
 linux-rt-3.14 boots by reverting patches + nvidia uses __rt_mutex_init
 [which in 3.14 has been changed to EXPORT_SYMBOL_GPL]
Date: Mon, 19 May 2014 17:16:03 +0200
Message-ID: <20140519171603.6c0c2ec2@tor.valhalla.alchemy.lu>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Kimmo Taskinen <kimmo.taskinen@me.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	jordan <triplesquarednine@gmail.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailsafe.webbplatsen.se ([94.247.172.109]:39900 "EHLO
	mailsafe.webbplatsen.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbaESPQM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 May 2014 11:16:12 -0400
In-Reply-To: <1400505358.3482.6.camel@archlinux>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 19 May 2014 15:15:58 +0200
Ralf Mardorf <ralf.mardorf@alice-dsl.net> wrote:

> On Mon, 2014-05-19 at 15:14 +0200, Ralf Mardorf wrote:
> > On Wed, 2014-05-14 at 03:38 +0300, Kimmo Taskinen wrote:
> > > I had not been able to boot my Phenom II X4 910e PC with any of
> > > the latest RT kernels (3.12 after 3.12.5-rt7 or 3.14 or not even
> > > the latest 3.10 versions)
> > 
> > For my AMD Athlon X2 BE-2350 CPU on an ASUS M2A-VM HDMI <= 3.8.x-rt
> > kernels work, >= 3.10-rt kernels don't work.
> 
> PS: Without the RT patch, the new kernels do work.

If you are still on archlinux, try the new 3.14.3-rt5 kernel that I've
uploaded to the AUR and to the binary archaudio-production repo.  This
one has 3 patches reverted, and all of NO_HZ disabled. Apparently this
makes it work on some AMD cpus that have had problem booting recent -rt
kernels.

-- 

   Joakim
