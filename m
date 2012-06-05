From: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: RE: [PATCH][UPSTREAM]net,RT:Remove preemption disabling in
 netif_rx()
Date: Tue, 5 Jun 2012 09:04:38 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F1907A0C5EB@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1337227511-2271-1-git-send-email-Priyanka.Jain@freescale.com>
	 <AC83832D6324604BB08FAE5A33553F19079E17C8@039-SN2MPN1-011.039d.mgd.msft.net>
	 <1337865466.13348.175.camel@gandalf.stny.rr.com>
	 <alpine.LFD.2.02.1205260028480.3231@ionos>
	 <1337985836.13348.272.camel@gandalf.stny.rr.com>
 <1338278369.14636.12.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Srivastava Rajan-B34330 <B34330@freescale.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [65.55.88.15] ([65.55.88.15]:48095 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751326Ab2FEJFs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jun 2012 05:05:48 -0400
In-Reply-To: <1338278369.14636.12.camel@twins>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Peter Zijlstra
Sent: Tuesday, May 29, 2012 1:29 PM
To: Steven Rostedt
Cc: Thomas Gleixner; Jain Priyanka-B32167; linux-rt-users@vger.kernel.org; Srivastava Rajan-B34330
Subject: RE: [PATCH][UPSTREAM]net,RT:Remove preemption disabling in netif_rx()

On Fri, 2012-05-25 at 18:43 -0400, Steven Rostedt wrote:
> On Sat, 2012-05-26 at 00:31 +0200, Thomas Gleixner wrote:
> > On Thu, 24 May 2012, Steven Rostedt wrote:
> > 
> > > On Thu, 2012-05-24 at 04:28 +0000, Jain Priyanka-B32167 wrote:
> > > > Waiting for review comments on this.
> > > > 
> > > 
> > > > diff --git a/net/core/dev.c b/net/core/dev.c index 
> > > > 452db70..4017820 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -2940,7 +2940,7 @@ int netif_rx(struct sk_buff *skb)
> > > >  		struct rps_dev_flow voidflow, *rflow = &voidflow;
> > > >  		int cpu;
> > > >  
> > > > -		preempt_disable();
> > > > +		migrate_disable();
> > > 
> > > I really want to avoid placing open coded migrate_disable() around 
> > > the kernel. Perhaps we should use "get_cpu_light()" here too.
> > 
> > No. get_cpu_light() and migrate_disable() are different.
> > 
> > Following your argument we would have to replace preempt_disable() 
> > with get_cpu() all over the place.
> > 
> 
> I didn't like the get_cpu_light either, but I thought it was Peter 
> that was against a 'migrate-disable()' API leaking all over the kernel.
> 
> IIRC, he gave in when it was part of a locking internal infrastructure.
> Now it's coming to what he was against. Maybe he changed his mind. 
> I'll let him speak for himself.

Ah, right, so I've mapped migrate_disable() to preempt_disable() for !
PREEMPT_RT. This to make sure people don't do stupid things with it :-)

Then again, people do lots of stupid things with preempt_disable() too, but at least we don't grow actual migrate_disable() abuse.

I think I've done one or two migrate_disable() site like the proposed in -rt already.

The thing I really want to avoid is introducing a migrate_disable() that can schedule for !rt.
[Priyanka]: In this case migrate_disable do get scheduled in case of !rt but as it mapped to preempt_disable, no change in functionality in case of !rt.

This patch is required to make sure that preemption is not disabled in case of RT to prevent the possible crash issue.
Please suggest some other better approach if not migrate_disable.
 
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html


