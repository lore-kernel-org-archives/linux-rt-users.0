From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: [RFC patch] genirq threading (v2) for ehci, ohci and uhci USB
	hosts and ohci1394
Date: Tue, 21 Oct 2008 03:29:26 -0700
Message-ID: <1224584966.20800.19.camel@sven.thebigcorporation.com>
References: <200810210207.m9L275nQ031086@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Arjan van de Veen <arjan@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jon Masters <jonathan@jonmasters.org>,
	slert-devel <slert-devel@suse.de>,
	Daniel Walker <dwalker@soe.ucsc.edu>,
	RT Users List <linux-rt-users@vger.kernel.org>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.173]:30617 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbYJUK3c (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 21 Oct 2008 06:29:32 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2445735wfd.4
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Oct 2008 03:29:31 -0700 (PDT)
In-Reply-To: <200810210207.m9L275nQ031086@turbo.physics.adelaide.edu.au>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2008-10-21 at 11:37 +0930, Jonathan Woithe wrote:
> Hi
> 
> > > This patch series implements support for threaded irq handlers for the
> > > generic IRQ layer.
> >
> > Subject: genirq threading for ehci, ohci and uhci USB hosts.
> > 
> > This is a functional POC for partitioning of the USB interrupt handlers into
> > a quickcheck function and a threaded main-handler function.
> > :
> > The ieee1394/ohci1394.c is a bit more problematic, since it does not use
> > struct usb_hcd, and therefore another place for the status cache must be found,
> > in struct ti_ohci presumably. 
> > I will send a separate patch for ieee1394/ohci1394.c after looking at it more.
> 
> Thanks for sending this through; I will endeavour to test it over the coming
> days.  I'll also see if I can test it for the case where USB and ieee1394
> share IRQs.  Even though ieee1394 isn't done yet these changes should
> prevent the USB-related problems we've seen in FFADO when USB shares the
> firewire IRQ.
> 
> Having said that, the forthcoming ohci1394.c patch will also be interesting
> since that is the other area which will greatly benefit FFADO.
> 

Hi, 

I have re-released the patch set with support for ohci1394. 

I have not tested, for lack of hardware :: it compiles.

The location of status_cache is now within the ti_ohci struct.

That organization not entirely consistent with the USB side, predicated
by other variation between the drivers.

The updated patch queue is available here.

http://www.thebigcorporation.com/Sven/genirq-usb/genirq-usb-v2.tar.bz2

Bug fix:
The declaration of status_cache has been made consistent u32. 
The former declaration of unsigned short (copied from uhci-hcd.c) it was
probably too ambiguous for some architectures.

Thanks,

Sven


> Regards
>   jonathan

