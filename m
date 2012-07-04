From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: cpu stall and hyperthread
Date: Tue, 3 Jul 2012 18:13:00 -0700
Message-ID: <20120704011300.GA2522@linux.vnet.ibm.com>
References: <4FEBCDDE.60503@gmail.com>
 <4FF351C6.3000100@gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Dong Liu <dliu.cn@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:42993 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab2GDBTp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Jul 2012 21:19:45 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 3 Jul 2012 19:19:44 -0600
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id D3D8B3E40048
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Jul 2012 01:19:12 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id q641JCg9302066
	for <linux-rt-users@vger.kernel.org>; Tue, 3 Jul 2012 19:19:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id q641JCK6019244
	for <linux-rt-users@vger.kernel.org>; Tue, 3 Jul 2012 19:19:12 -0600
Content-Disposition: inline
In-Reply-To: <4FF351C6.3000100@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Jul 03, 2012 at 04:10:46PM -0400, Dong Liu wrote:
> Hi,
> 
> After reading the RCU cpu stall doc. I thought that CONFIG_NO_HZ
> might have something to do with this problem. And I think the NO_HZ
> config is not good for RT performance, so I made a new kernel
> without NO_HZ. It lasted longer but eventually cpu stalls happened
> again.
> 
> I then disable the cpu stall checking by set
> 
> /sys/module/rcutree/parameters/rcu_cpu_stall_suppress
> 
> to "1", but it did not solve the problem. Instead of cpu stall I had
> 
> BUG: soft lockup - CPU#0 stuck for 279s! [swapper/0:0]
> 
> And even I disabled Hyper-Threading, I also got cpu stall now.
> 
> CPU stalls also occurred in KVM guest OS as well.
> 
> But I never get cpu stall when I'm running the normal kernel without
> -rt patch.
> 
> Is the cpu stall a known issue with the rt patch?
> 
> Thanks,
> 
> Dong
> 
> On 6/27/12 11:22 PM, Dong Liu wrote:
> >Hi,
> >
> >I'm running 3.4.3-rt11 and 3.2.18-rt29 on a system with Intel I7 860, I
> >noticed that with hyperthread enabled, I'm getting kernel error
> >
> >rcu_preempt detected stalls on CPUs/tasks: { 3} (detected by 5, t=60002
> >jiffies)

Did you get stack traces with this error?  And did you get repeated
stall messages if you waited a few minutes after the first one?

If so, the stack traces can help track down the problem.

							Thanx, Paul

> >But with hyperthread disabled, no such error.
> >
> >Is preempt_rt not supposed to be used with hyperthread?
> >
> >Thanks,
> >
> >Dong
> >
> >P.S.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

