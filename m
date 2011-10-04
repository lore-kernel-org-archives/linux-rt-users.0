From: Mike Galbraith <efault@gmx.de>
Subject: Re: 3.0.4-rt14 "shutdown -h now" hangs on x86 32b
Date: Tue, 04 Oct 2011 11:28:09 +0200
Message-ID: <1317720489.6260.9.camel@marge.simson.net>
References: <4E89FBDE.7080406@linux.intel.com>
	 <4E8ABB4B.6000204@iis.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Darren Hart <dvhart@linux.intel.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Simon Sudler <Simon.Sudler@iis.fraunhofer.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:34221 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755215Ab1JDJ2N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Oct 2011 05:28:13 -0400
In-Reply-To: <4E8ABB4B.6000204@iis.fraunhofer.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2011-10-04 at 09:52 +0200, Simon Sudler wrote: 
> Hi Darren,
> 
> i had the same problem on a Z530 with all RT kernels 3.0. I didn't 
> search for the reason, however the problem went away when i used the 
> "Intel Atom" at the "Processor family" option.

I see something similar at least on my Q6600 and E5620 boxen.

'poweroff' or shutting down from KDE doesn't always do so, sometimes
leaving boxen with a message saying it'll be halted immediately or such
on the screen, but requiring press/hold of power button to get box
really powered down.  I just tried Q6600 again to get exact quote, but
of course the little bugger powered down properly.

> On 03.10.2011 20:15, Darren Hart wrote:
> > I have a couple of platforms (including the n450 dev board from kernel
> > summit) where an x86 32b build of 3.0.4-rt14 fails to shutdown with
> > "shutdown -h now". reboot works properly, and shutdown works with
> > maxcpus=1 (otherwise the n450 has 2 hardware threads).
> >
> > The last messages to hit the console are:
> >
> > e1000e 0000:04:00.0: PCI INT A disabled
> > ehci_hcd 0000:00:1d.7: PCI INT A disabled
> > ehci_hcd 0000:00:1a.7: PCI INT C disabled
> >
> > I am booting from a USB stick. If I install to a SATA connected SSD, the
> > shutdown still fails, but I don't see the "INT X disabled" messages.
> >
> > Has anyone run into this with a known workaround? Any thoughts on where
> > to start digging?
> >
> > .config attached.
> 



