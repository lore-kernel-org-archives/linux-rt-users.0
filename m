From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: loadavg problem with 2.6.26.8-rt16 on Atmel AT91SAM9260
Date: Fri, 20 Feb 2009 14:07:26 -0500 (EST)
Message-ID: <alpine.DEB.2.00.0902201407001.26438@gandalf.stny.rr.com>
References: <Pine.LNX.4.64.0902191110060.22561@lxtpfaff.pcs.ditec.de> <7d1d9c250902201012r4a01ca2w2d4a4ef7ba4f9883@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Pfaff <tpfaff@pcs.com>, linux-rt-users@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:54576 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbZBTTH3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Feb 2009 14:07:29 -0500
In-Reply-To: <7d1d9c250902201012r4a01ca2w2d4a4ef7ba4f9883@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Fri, 20 Feb 2009, Paul Gortmaker wrote:

> On Thu, Feb 19, 2009 at 7:11 AM, Thomas Pfaff <tpfaff@pcs.com> wrote:
> > While testing the 2.6.26.8-rt16 kernel on an AT91SAM9260-EK Arm9 board i noticed
> > a small regression to 2.6.24.7-rt27.
> >
> > The kernel compiles and boots fine but the average load when the cpu is idle
> > tends to be 1, it starts at 0 when the system boots and goes to 1 or above after
> > some time.
> >
> > All kernels have the at91 patches from http://maxim.org.za/sam9.html
> >
> > Following kernels are ok:
> >
> > 2.6.24.7-rt27
> > 2.6.26.8 without rt
> >
> > With the rt patch i have tested several combinations of the PREEMPT options:
> >
> > Without CONFIG_PREEMPT_HARDIRQ i get an oops on boot (see next mail).
> >
> > All other CONFIG_PREEMPT_[NONE|VOLUNTARY|DESKTOP|RT] options are working but
> > with the wrong average load.
> 
> Please test the following patch.  I think you should find it fixes the problem.

Thanks,

I've queued this up for 26-rt as well as added it to my rt git tree.

-- Steve

