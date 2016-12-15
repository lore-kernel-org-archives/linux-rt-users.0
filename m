From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: question about rcuc/X tasks
Date: Thu, 15 Dec 2016 15:34:30 -0800
Message-ID: <20161215233430.GF3924@linux.vnet.ibm.com>
References: <584F27B8.2090406@windriver.com>
 <518a5f66-76d0-e356-b08b-bde2a7a17bb2@bristot.me>
 <20161215090714.0b62cc03@gandalf.local.home>
 <5852B4B8.1090600@windriver.com>
 <20161215190405.GZ3924@linux.vnet.ibm.com>
 <585317DF.7080502@windriver.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <daniel@bristot.me>,
        linux-rt-users@vger.kernel.org
To: Chris Friesen <chris.friesen@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46591 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754171AbcLOXeg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Dec 2016 18:34:36 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFNXkcg048078
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Dec 2016 18:34:31 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27bwsmgs50-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Dec 2016 18:34:30 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 15 Dec 2016 16:34:29 -0700
Content-Disposition: inline
In-Reply-To: <585317DF.7080502@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Dec 15, 2016 at 04:23:27PM -0600, Chris Friesen wrote:
> On 12/15/2016 01:04 PM, Paul E. McKenney wrote:
> >On Thu, Dec 15, 2016 at 09:20:24AM -0600, Chris Friesen wrote:
> 
> >>On a related note, I found an old email from Paul suggesting that
> >>the various rcuc/X threads could be affined to the management CPUs
> >>to free up the "realtime" cores, but when I try that it doesn't let
> >>me change affinity.  Was that disallowed for technical reasons?
> >>(It's also possible it's something local, in which case I need to go
> >>digging.)
> >
> >The rcuo/X kthreads can be affined, but the rcuc/X kthreads must run on
> >the corresponding CPU for correctness reasons -- they communicate with
> >RCU core using protocols that are only single-CPU-safe.  But if you are
> >running NO_HZ_FULL, these kthreads should never run unless your user
> >threads are doing syscalls.
> >
> >So, are they actually running in your setup?
> 
> Yes, but I wasn't setting nohz_full.  With "rcu_nocb_poll
> isolcpus=1-15 rcu_nocbs=1-15 nohz_full=1-15" I'm not seeing the
> rcuc/X kthreads running.
> 
> So in the non-nohz_full case, what are they waking up to do?
> Something timer-related?

Interesting.  I need to look into this a bit.  I would not expect
that rcuc/X kthreads corresponding to NOCB CPUs to ever wake up.
(They are created by a per-CPU facility that creates a kthread per
CPU no matter what.)

							Thanx, Paul

