From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Mon, 5 Dec 2011 17:56:01 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112051740510.2735@ionos>
References: <4ECCE979.5080109@cedwards.geek.nz>  <1322056363.20742.45.camel@frodo>  <4ECD7DCC.3000505@ripples.dyndns.org> <1322691017.24563.9.camel@frodo> <4ED9EEB2.6070401@ripples.dyndns.org> <alpine.LFD.2.02.1112031726370.2735@ionos> <4EDAAEFD.9060209@ripples.dyndns.org>
 <alpine.LFD.2.02.1112041428560.2735@ionos> <4EDCC978.3060401@cedwards.geek.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Borislav Petkov <borislav.petkov@amd.com>
To: Chris Edwards <cedwards.linux@cedwards.geek.nz>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56341 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932436Ab1LEQ4G (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Dec 2011 11:56:06 -0500
In-Reply-To: <4EDCC978.3060401@cedwards.geek.nz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 6 Dec 2011, Chris Edwards wrote:

> On 05/12/11 02:32, Thomas Gleixner wrote:
> > On Sun, 4 Dec 2011, Chris Edwards wrote:
> > > On 04/12/11 05:29, Thomas Gleixner wrote:
> > > > Ok, that tells us something. So there is something unhappy in your
> > > > system about the way how the threaded irq handling works. Can you
> > > > please provide the output of lspci -vvv and a full boot log (any
> > > > 3.0/3.2 kernel you have handy)?
> > > Attached. :)
> > Could you disable the e1000 for a test? Just boot up and bring the
> > interface down.
> > 
> > Does that change the situation?
> 
> Yes - I tested with 3.2.0-rc4-rt5 (and it actually is an RT kernel this time -
> see below!) and with the Ethernet interface down, it seems to be working
> properly.  Even Pure Data didn't cause any crackling or stuttering (other than
> when starting up).
> 
> [    0.000000] Linux version 3.2.0-rc4-rt5 (root@babelfish) (gcc version 4.4.3
> (Ubuntu 4.4.3-4ubuntu5) ) #1 SMP PREEMPT RT Tue Dec 6 01:22:11 NZDT 2011
> [    0.000000] Command line: BOOT_IMAGE=/vmlinuz-3.2.0-rc4-rt5
> root=UUID=ca21e0bf-b7f8-45c3-8fc9-066c4dd6052e ro quiet splash
> 
> What next?  Should I try moving the Ethernet card to other slots and see if
> anything changes?

That card hangs on the AMD bridge and that bridge has nasty interrupt
related erratas. Your "feature" is undocumented so far. It looks like
it sends interrupts which are masked, but pending over and over to a
different interrupt line :( We've seen this before. It's a legacy mode
feature, but your chip is excluded from the fixup.

Boris, any idea ?

You could try the following patch. Be aware that it might not work at
all, but I don't expect that you need a fire extinguisher :)

Thanks,

	tglx
---
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1791,8 +1791,7 @@ static void quirk_disable_amd_813x_boot_interrupt(struct pci_dev *dev)
 
 	if (noioapicquirk)
 		return;
-	if ((dev->revision == AMD_813X_REV_B1) ||
-	    (dev->revision == AMD_813X_REV_B2))
+	if (dev->revision == AMD_813X_REV_B2)
 		return;
 
 	pci_read_config_dword(dev, AMD_813X_MISC, &pci_config_dword);

