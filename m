From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Mon, 5 Dec 2011 22:02:27 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112052200190.2735@ionos>
References: <4ECCE979.5080109@cedwards.geek.nz> <1322056363.20742.45.camel@frodo> <4ECD7DCC.3000505@ripples.dyndns.org> <1322691017.24563.9.camel@frodo> <4ED9EEB2.6070401@ripples.dyndns.org> <alpine.LFD.2.02.1112031726370.2735@ionos> <4EDAAEFD.9060209@ripples.dyndns.org>
 <alpine.LFD.2.02.1112041428560.2735@ionos> <4EDCC978.3060401@cedwards.geek.nz> <alpine.LFD.2.02.1112051740510.2735@ionos> <20111205181450.GK7834@aftab>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chris Edwards <cedwards.linux@cedwards.geek.nz>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Borislav Petkov <borislav.petkov@amd.com>
To: Borislav Petkov <bp@amd64.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57426 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004Ab1LEVCh (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Dec 2011 16:02:37 -0500
In-Reply-To: <20111205181450.GK7834@aftab>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 5 Dec 2011, Borislav Petkov wrote:
> On Mon, Dec 05, 2011 at 05:56:01PM +0100, Thomas Gleixner wrote:
> > That card hangs on the AMD bridge and that bridge has nasty interrupt
> > related erratas. Your "feature" is undocumented so far. It looks like
> > it sends interrupts which are masked, but pending over and over to a
> > different interrupt line :( We've seen this before. It's a legacy mode
> > feature, but your chip is excluded from the fixup.
> > 
> > Boris, any idea ?
> 
> Hmm, that's the old 8131 chipset, correct?
> 
> > You could try the following patch. Be aware that it might not work at
> > all, but I don't expect that you need a fire extinguisher :)
> > 
> > Thanks,
> > 
> > 	tglx
> > ---
> > --- a/drivers/pci/quirks.c
> > +++ b/drivers/pci/quirks.c
> > @@ -1791,8 +1791,7 @@ static void quirk_disable_amd_813x_boot_interrupt(struct pci_dev *dev)
> >  
> >  	if (noioapicquirk)
> >  		return;
> > -	if ((dev->revision == AMD_813X_REV_B1) ||
> > -	    (dev->revision == AMD_813X_REV_B2))
> > +	if (dev->revision == AMD_813X_REV_B2)
> >  		return;
> 
> Ok, according to my docs, this erratum you're addressing here is
> supposed to be fixed in revision B1 of the chipset but your test patch
> enables the quirk for B1 too.
> 
> What is dev->revision on that board, 0x12?

Yep:

[    0.716126] pci 0000:03:01.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC
[    0.716138] pci 0000:03:02.0: AMD8131 rev 12 detected; disabling PCI-X MMRBC

But that interrupt behaviour is exaclty the same which we saw with the
other pre rev 12 versions. So I just wanted Edward to try that quirk
and see whether it solves his issues.

Thanks,

	tglx
