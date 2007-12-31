From: Chirag Jog <chirag@linux.vnet.ibm.com>
Subject: Re: Fwd: -rt and PowerPC
Date: Mon, 31 Dec 2007 09:56:23 +0530
Message-ID: <20071231042623.GA8421@linux.vnet.ibm.com>
References: <200712241140.00738.sripathik@in.ibm.com> <562556514-1198501255-cardhu_decombobulator_blackberry.rim.net-1487612076-@bxe137.bisx.prod.on.blackberry> <20071226042325.GA23220@hells-kitchen.in.ibm.com> <1198859012.12074.0.camel@sven.thebigcorporation.com>
Reply-To: Chirag Jog <chirag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Sripathi Kodi <sripathik@in.ibm.com>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from E23SMTP06.au.ibm.com ([202.81.18.175]:36931 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbXLaE2I (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 30 Dec 2007 23:28:08 -0500
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id lBV4S0RW006777
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Dec 2007 15:28:00 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id lBV4QpKd2678918
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Dec 2007 15:26:51 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lBV4QYai019727
	for <linux-rt-users@vger.kernel.org>; Mon, 31 Dec 2007 15:26:35 +1100
Content-Disposition: inline
In-Reply-To: <1198859012.12074.0.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
* Sven-Thorsten Dietrich <sven@thebigcorporation.com> [2007-12-28 08:23:32]:

> On Wed, 2007-12-26 at 09:53 +0530, Chirag Jog wrote:
> > * sven@thebigcorporation.com <sven@thebigcorporation.com> [2007-12-24 13:00:30]:
> > 
> > Hi,
> 
> Sorry for top-posting the last email. Have not learned how to inline on
> the Blackberry.
> 
> Comments below.
> 
> > > Do you have DEBUG and LOCKDEP configured?
> > CONFIG_PREEMPT_DEBUG is enabled
> > but LOCKDEP is not.
> > > 
> > > -----Original Message-----
> > > From:	Sripathi Kodi <sripathik@in.ibm.com>
> > > 
> > >     We are trying to get a ppc64 box booted with the -rt kernel.
> > > 
> > >     Tried the latest 2.6.24-rc5-rt1 kernel.
> > > 
> > >     Everything goes well [ kernel boots up etc] until the services
> > >     start coming up.
> > >     It takes a lot of time at Starting udev.
> > >     After which either services take too long to start or we get
> > >     SEGFAULT.
> 
> I have seen this exact behavior with lockdep enabled on earlier x86-SMP
> Kernels. I saw the issue predominantly on larger SMP machines, but it
> behaved much like a race. This was observed on 2.6.21 Kernels, I will
> try and verify whether .23 has the same behavior.
> 
> We eventually bisected it down to CONFIG_PROVE_LOCKING, but I wasn't
> totally convinced whethere the root cause was in lockdep, or
> elsewhere.  
> 
> > > 
> > >     This is easily reproducible. Also if we get a chance to login;
> > >     simple commands like ls, vi etc take either too long or get
> > >     SEGFAULT.
> 
> > > 
> > >     Booting the kernel with maxcpus=1 or turning off SMP, doesn't
> > >     solve the problem.
> > >
> 
> Hmmm, so have you COMPILED-out SMP, or just booted with nosmp?
> 
> It might help narrowing this down to compile a UP Kernel.
We have tried both options, compiled out SMP and boot with maxcpus=1.
Similar results.
Sripathi also tried with turning off HIGH_RES_TIMERS but didn't seem
to help.
The system took forever to come up.
> 
> Thanks
> 
> Sven
 
<snip>
-- 
Cheers,
Chirag Jog
