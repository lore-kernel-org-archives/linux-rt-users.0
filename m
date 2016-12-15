From: Chris Friesen <chris.friesen@windriver.com>
Subject: Re: question about rcuc/X tasks
Date: Thu, 15 Dec 2016 16:23:27 -0600
Message-ID: <585317DF.7080502@windriver.com>
References: <584F27B8.2090406@windriver.com> <518a5f66-76d0-e356-b08b-bde2a7a17bb2@bristot.me> <20161215090714.0b62cc03@gandalf.local.home> <5852B4B8.1090600@windriver.com> <20161215190405.GZ3924@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <daniel@bristot.me>,
        <linux-rt-users@vger.kernel.org>
To: <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:63014 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753929AbcLOWXl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Dec 2016 17:23:41 -0500
In-Reply-To: <20161215190405.GZ3924@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/15/2016 01:04 PM, Paul E. McKenney wrote:
> On Thu, Dec 15, 2016 at 09:20:24AM -0600, Chris Friesen wrote:

>> On a related note, I found an old email from Paul suggesting that
>> the various rcuc/X threads could be affined to the management CPUs
>> to free up the "realtime" cores, but when I try that it doesn't let
>> me change affinity.  Was that disallowed for technical reasons?
>> (It's also possible it's something local, in which case I need to go
>> digging.)
>
> The rcuo/X kthreads can be affined, but the rcuc/X kthreads must run on
> the corresponding CPU for correctness reasons -- they communicate with
> RCU core using protocols that are only single-CPU-safe.  But if you are
> running NO_HZ_FULL, these kthreads should never run unless your user
> threads are doing syscalls.
>
> So, are they actually running in your setup?

Yes, but I wasn't setting nohz_full.  With "rcu_nocb_poll isolcpus=1-15 
rcu_nocbs=1-15 nohz_full=1-15" I'm not seeing the rcuc/X kthreads running.

So in the non-nohz_full case, what are they waking up to do?  Something 
timer-related?

Thanks,
Chris
