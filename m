From: Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [PATCH][UPSTREAM]net,RT:Remove preemption disabling in
 netif_rx()
Date: Fri, 25 May 2012 18:43:56 -0400
Message-ID: <1337985836.13348.272.camel@gandalf.stny.rr.com>
References: <1337227511-2271-1-git-send-email-Priyanka.Jain@freescale.com>
	  <AC83832D6324604BB08FAE5A33553F19079E17C8@039-SN2MPN1-011.039d.mgd.msft.net>
	 <1337865466.13348.175.camel@gandalf.stny.rr.com>
	 <alpine.LFD.2.02.1205260028480.3231@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Jain Priyanka-B32167 <B32167@freescale.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Srivastava Rajan-B34330 <B34330@freescale.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:21692 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753164Ab2EYWn6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 25 May 2012 18:43:58 -0400
In-Reply-To: <alpine.LFD.2.02.1205260028480.3231@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2012-05-26 at 00:31 +0200, Thomas Gleixner wrote:
> On Thu, 24 May 2012, Steven Rostedt wrote:
> 
> > On Thu, 2012-05-24 at 04:28 +0000, Jain Priyanka-B32167 wrote:
> > > Waiting for review comments on this.
> > > 
> > 
> > > diff --git a/net/core/dev.c b/net/core/dev.c index 452db70..4017820 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -2940,7 +2940,7 @@ int netif_rx(struct sk_buff *skb)
> > >  		struct rps_dev_flow voidflow, *rflow = &voidflow;
> > >  		int cpu;
> > >  
> > > -		preempt_disable();
> > > +		migrate_disable();
> > 
> > I really want to avoid placing open coded migrate_disable() around the
> > kernel. Perhaps we should use "get_cpu_light()" here too.
> 
> No. get_cpu_light() and migrate_disable() are different.
> 
> Following your argument we would have to replace preempt_disable()
> with get_cpu() all over the place.
> 

I didn't like the get_cpu_light either, but I thought it was Peter that
was against a 'migrate-disable()' API leaking all over the kernel.

IIRC, he gave in when it was part of a locking internal infrastructure.
Now it's coming to what he was against. Maybe he changed his mind. I'll
let him speak for himself.

-- Steve


