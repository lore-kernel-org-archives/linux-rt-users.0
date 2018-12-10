Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:33373 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbeLJOIc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Dec 2018 09:08:32 -0500
Date: Mon, 10 Dec 2018 15:08:29 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: outliers when measuring boost msqueues latency v4.14.79-rt47
 RT-Preempt
Message-ID: <20181210140828.ytut6wktdjsbopze@linutronix.de>
References: <VI1PR06MB44627C92EA94534421191FEBCEA90@VI1PR06MB4462.eurprd06.prod.outlook.com>
 <20181207114450.pypgcipls27f3izw@linutronix.de>
 <AM0PR06MB445132FA3FB5915AFB3A736ECEAA0@AM0PR06MB4451.eurprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM0PR06MB445132FA3FB5915AFB3A736ECEAA0@AM0PR06MB4451.eurprd06.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Andreas Hoefler <andreas.hoefler@ch.abb.com>
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On 2018-12-07 14:46:26 [+0000], Andreas Hoefler wrote:
> Hi
Hi,

> I am tracing futexes, what I see is :
> Channel CPU	Event type		Contents									TID	 Prio
> k_0	0	syscall_entry_futex	uaddr=2079364, op=139, val=19377, utime=0, uaddr2=2079336, val3=2079360	867	-49				
> 
> not sure where to find FUTEX_UNLOCK_PI etc..(sorry quite new to this stuff)

In include/uapi/linux/futex.h you have 
| #define FUTEX_LOCK_PI           6
| #define FUTEX_WAIT_BITSET       9

among other defines. So op=139 is FUTEX_PRIVATE_FLAG +
FUTEX_WAIT_REQUEUE_PI. This looks good.

> Therefore I think it is correct that I am seeing a tick each 10ms, I guess.

For HZ=100, yes. No idea why I assumed HZ=1000.
 
> This is a snippet from the tracing just before it hangs:
> In this case a message has been successfully sent and the sending thread is again at the beginning of its while loop and waiting on the semaphore.
> Furthermore the receiving thread has successfully received the message (msqueue->timed_receive()). Right after that it should do a clock_gettime() put the result in a vector,post the semaphore and return to the start of its while loop and wait again for the next message. But it takes 40ms to do this.
> Sorry for the lengthy trace here:
…
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.277 048 991	k_0	0	sched_switch	prev_comm=ktimersoftd/0, prev_tid=8, prev_prio=-64, prev_state=1, next_comm=CPU-BG-Thread0, next_tid=836, next_prio=-20	8	-64				
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.277 052 407	k_1	1	sched_switch	prev_comm=ksoftirqd/1, prev_tid=22, prev_prio=20, prev_state=1, next_comm=kworker/1:0, next_tid=798, next_prio=20	22	20				
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.277 060 541	k_1	1	rcu_utilization	s=Start context switch	798	20				
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.277 061 517	k_1	1	rcu_utilization	s=End context switch	798	20				
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.277 062 818	k_1	1	sched_stat_runtime	comm=kworker/1:0, tid=798, runtime=19683, vruntime=32342094773	798	20				
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.277 072 253	k_1	1	workqueue_execute_start	work=0xedc26e60, function=0xc07c2c00	798	20	
> ..
> .. doing basically nothing here for 40ms ..

So CPU0 switched ktimersoftd/0 -> CPU-BG-Thread0 and
CPU siwtched ksoftirqd/1 -> kworker/1:0.
CPU0 is in userland so we don't see much. CPU1 does the work-func and
don't see much either. The latter is little odd.

> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.316 982 356	k_0	0	irq_handler_entry	irq=19, name=arch_timer	777	20				
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.316 983 007	k_1	1	irq_handler_entry	irq=19, name=arch_timer	0	20				
…
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.317 031 807	k_0	0	sched_switch	prev_comm=lttng-consumerd, prev_tid=777, prev_prio=20, prev_state=4096, next_comm=ktimersoftd/0, next_tid=8, next_prio=-64	777	20				
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.317 036 199	k_1	1	rcu_utilization	s=Start context switch	0	20				
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.317 037 500	k_1	1	rcu_utilization	s=End context switch	0	20				
> 10.41.140.114/vos70-20161103-195610/kernel	20:57:42.317 039 940	k_1	1	sched_switch	prev_comm=swapper/1, prev_tid=0, prev_prio=20, prev_state=0, next_comm=ktimersoftd/1, next_tid=21, next_prio=-64	0	20				

and here we switch on CPU0 lttng-consumerd -> ktimersoftd/0 and 
on CPU1 swapper/1 -> timersoftd/1.
But based on last output CPU0/1 switched to CPU-BG-Thread0 and
kworker/1:0. So I would expect for CPU0 to switch *from* CPU-BG-Thread0
instead lttng-consumerd unless some output is missing.

> ..
> ..
> Resumes again as normal...
> 
> BR
> Andy

Sebastian
