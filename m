From: Chris Friesen <chris.friesen@windriver.com>
Subject: Re: question about rcuc/X tasks
Date: Thu, 15 Dec 2016 09:20:24 -0600
Message-ID: <5852B4B8.1090600@windriver.com>
References: <584F27B8.2090406@windriver.com>    <518a5f66-76d0-e356-b08b-bde2a7a17bb2@bristot.me> <20161215090714.0b62cc03@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Bristot de Oliveira <daniel@bristot.me>,
        <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38132 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933463AbcLOPUh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Dec 2016 10:20:37 -0500
In-Reply-To: <20161215090714.0b62cc03@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/15/2016 08:07 AM, Steven Rostedt wrote:
> On Thu, 15 Dec 2016 14:47:37 +0100
> Daniel Bristot de Oliveira <daniel@bristot.me> wrote:
>
>> Hi Chris,
>>
>> On 12/12/2016 11:42 PM, Chris Friesen wrote:
>>> Based on the fact that Documentation/kernel-per-CPU-kthreads.txt
>>> describes CONFIG_RCU_NOCB_CPU_ALL=y as a solution by preventing the
>>> rcuc/%u kthreads from having any work to do, I had expected that the
>>> "rcu_nocbs=1-15" kernel parameter would have a similar effect.
>
> Paul, would rcu_nocbs=1-15 work? Or should ALL be used ? I'm assuming
> this is on a 16 CPUs box, in which case I don't see much of a difference
> for not just using ALL as it is almost there anyway ;-)
>
> -- Steve

Yes, this was a 16 CPU box.

The blocker for CONFIG_RCU_NOCB_CPU_ALL is that the set of 
management/housekeeping CPUs is configurable by the end-user, so while it 
defaults to only CPU0 as management it's not guaranteed that it will always be 
that way.

On a related note, I found an old email from Paul suggesting that the various 
rcuc/X threads could be affined to the management CPUs to free up the "realtime" 
cores, but when I try that it doesn't let me change affinity.  Was that 
disallowed for technical reasons?  (It's also possible it's something local, in 
which case I need to go digging.)

Thanks,
Chris

