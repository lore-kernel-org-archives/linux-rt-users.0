From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: infinite spin in RT when booting with DHCP on
Date: Fri, 03 Feb 2012 09:26:11 -0500
Message-ID: <1328279171.5882.155.camel@gandalf.stny.rr.com>
References: <4F292FE0.7090302@digi.com>
		 <201202021338.44950.tim.sander@hbm.com> <4F2A8850.4080201@digi.com>
		 <201202021525.05606.tim.sander@hbm.com>
	 <1328206245.5882.113.camel@gandalf.stny.rr.com> <4F2BB25E.7090708@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Tim Sander <tim.sander@hbm.com>, linux-rt-users@vger.kernel.org,
	lclaudio@uudg.org, efault@gmx.de,
	Thomas Gleixner <tglx@linutronix.de>
To: Hector Palacios <hector.palacios@digi.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:54896 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419Ab2BCO0Q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Feb 2012 09:26:16 -0500
In-Reply-To: <4F2BB25E.7090708@digi.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2012-02-03 at 11:09 +0100, Hector Palacios wrote:
> Hi Steve,
> 
> On 02/02/2012 07:10 PM, Steven Rostedt wrote:
> > That said, as I think I know the problem, can you try this patch to see
> > if it fixes things. This patch is a TOTAL HACK! Not for inclusion. It's
> > racy and buggy. I didn't even compile it because I couldn't get the
> > configs to enable FEC, and I was too lazy to set up my cross compiler to
> > test it. ;-)
> 
> Yes, this hack fixes things as long as I boot with the Ethernet cable plugged in. In 
> this case the autonegotiation is launched and fec_enet_start_xmit() waits until it 
> completes. From then on, the hack never triggers again (comp_set is 0) and 
> disconnecting-reconnecting the cable or asking for a new DHCP address seems to work 
> normally.
> 
> If I boot with the cable disconnected the driver seems to be trapped at the 
> wait_for_completion() and connecting the cable later simply doesn't allow the 
> autonegotiation to complete.

I said it was buggy ;-)


Well the good news is that we know where the problem is. The bad news
is, I have no idea how to fix it, as it seems specific to this driver.
And this bug may be a bug in mainline. If we can prove that, then we can
push the driver writers to fix it.

If you can add the patch that Uwe sent you and see if you can cause
mainline to lock up with it, then we can show that this is a mainline
bug.

Basically, if you have CONFIG_PREEMPT enabled, and set ksoftirqd to an
RT task, then it may exhibit the same behavior.

Oh! What happens if you boot the board with a mainline kernel without
connecting the cable? Can you see if ksoftirqd is running 100% of CPU?
If you say that when the cable is out, it can not complete the
autonegotiate, which means that it should go into the loop I shown
before. But as ksoftirqd is a normal task (non RT) you may not have
noticed the issue.

-- Steve



