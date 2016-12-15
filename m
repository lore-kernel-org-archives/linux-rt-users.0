From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: question about rcuc/X tasks
Date: Thu, 15 Dec 2016 11:04:05 -0800
Message-ID: <20161215190405.GZ3924@linux.vnet.ibm.com>
References: <584F27B8.2090406@windriver.com>
 <518a5f66-76d0-e356-b08b-bde2a7a17bb2@bristot.me>
 <20161215090714.0b62cc03@gandalf.local.home>
 <5852B4B8.1090600@windriver.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <daniel@bristot.me>,
        linux-rt-users@vger.kernel.org
To: Chris Friesen <chris.friesen@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43410 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752332AbcLOTEu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Dec 2016 14:04:50 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id uBFIxJ3l072052
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Dec 2016 14:04:07 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0b-001b2d01.pphosted.com with ESMTP id 27bdmg4ujn-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 15 Dec 2016 14:04:07 -0500
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 15 Dec 2016 12:04:05 -0700
Content-Disposition: inline
In-Reply-To: <5852B4B8.1090600@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Dec 15, 2016 at 09:20:24AM -0600, Chris Friesen wrote:
> On 12/15/2016 08:07 AM, Steven Rostedt wrote:
> >On Thu, 15 Dec 2016 14:47:37 +0100
> >Daniel Bristot de Oliveira <daniel@bristot.me> wrote:
> >
> >>Hi Chris,
> >>
> >>On 12/12/2016 11:42 PM, Chris Friesen wrote:
> >>>Based on the fact that Documentation/kernel-per-CPU-kthreads.txt
> >>>describes CONFIG_RCU_NOCB_CPU_ALL=y as a solution by preventing the
> >>>rcuc/%u kthreads from having any work to do, I had expected that the
> >>>"rcu_nocbs=1-15" kernel parameter would have a similar effect.
> >
> >Paul, would rcu_nocbs=1-15 work? Or should ALL be used ? I'm assuming
> >this is on a 16 CPUs box, in which case I don't see much of a difference
> >for not just using ALL as it is almost there anyway ;-)
> >
> >-- Steve
> 
> Yes, this was a 16 CPU box.
> 
> The blocker for CONFIG_RCU_NOCB_CPU_ALL is that the set of
> management/housekeeping CPUs is configurable by the end-user, so
> while it defaults to only CPU0 as management it's not guaranteed
> that it will always be that way.
> 
> On a related note, I found an old email from Paul suggesting that
> the various rcuc/X threads could be affined to the management CPUs
> to free up the "realtime" cores, but when I try that it doesn't let
> me change affinity.  Was that disallowed for technical reasons?
> (It's also possible it's something local, in which case I need to go
> digging.)

The rcuo/X kthreads can be affined, but the rcuc/X kthreads must run on
the corresponding CPU for correctness reasons -- they communicate with
RCU core using protocols that are only single-CPU-safe.  But if you are
running NO_HZ_FULL, these kthreads should never run unless your user
threads are doing syscalls.

So, are they actually running in your setup?

							Thanx, Paul

