From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: Panic when running 'halt' on 3.2.9-rt15
Date: Mon, 05 Mar 2012 11:48:12 -0800
Message-ID: <4F55187C.6000604@localhost>
References: <20120305160522.GB5334@uudg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Clark Williams <clark@redhat.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>
To: RT users list <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.Stanford.EDU ([171.67.219.82]:43335 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757515Ab2CETzD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Mar 2012 14:55:03 -0500
In-Reply-To: <20120305160522.GB5334@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 03/05/2012 08:05 AM, Luis Claudio R. Goncalves wrote:
>
> Two backtraces, one with warnings and another one with a kernel panic:

Hi, I also see a panic here on a Lenovo T61 (Core 2 Duo) on shutdown 
(I'll post a picture of the screen later) and some of my users in Planet 
CCRMA report similar issues with 3.2.9 rt15:

On 03/04/2012 01:27 AM, Mark Knoop wrote:
> At 10:54 on 03 Mar 2012, Fernando Lopez-Lezcano wrote:
>> On 03/02/2012 09:22 PM, Michael J. Wilson wrote:
>>> Hi Nando,
>>>
>>> Lenovo Thinkpad x220, FC16.
>>>
>>> 3.2.7-1.rt13 was giving me some shutdown problems (after drives
>>> unmounted device would not halt; maybe ACPI issue?)
>>
>> Hmm, yes, I saw a problem with my test laptop last night after testing
>> 3.2.9, I got a panic on shutdown (which I had not seen before, I
>> think). I was about to go home so I did not try to document it and
>> submit a bug report.
>>
>> Did you see a kernel panic as well? Or just hangs?
>
> Hi, yes I'm seeing these problems too on shutdown.
>
> 3.2.7-1.rt13 hangs for a while (1-2 minutes) with no output then
> eventually shuts down fine (from Sending SIGTERM to all running
> tasks...)
>
> 3.2.9-rt15 I get a panic on shutdown, the details scroll offscreen but
> it looks like a general protection fault. What's the best way to debug
> this?
>
> But I should also say that both kernels seem to run very well except
> for these problems.

-- Fernando



> Backtrace 01: (panic)
> -------------
>
> [root@lab ~]# halt
>
> [  428.406096] ACPI: Preparing to enter system sleep state S5
> [  428.407145] Disabling non-boot CPUs ...
> [  428.410419] lockdep: fixing up alternatives.
> [  428.415125] ------------[ cut here ]------------
> [  428.443541] WARNING: at kernel/sched.c:4415 migrate_disable+0x5d/0xbf()
> [  428.450179] Hardware name: 8810A56
> [  428.454001] BUG: unable to handle kernel paging request at ffffffff8103e98f
> [  428.454001] IP: [<ffffffff8106b749>] __lock_acquire+0xa9/0x42e
> [  428.454001] PGD 1810067 PUD 1814063 PMD 10001e1
> [  428.454001] Thread overran stack, or stack corrupted
> [  428.454001] Oops: 0003 [#1] PREEMPT SMP
> [  428.454001] CPU 0
> [  428.454001] Modules linked in: bridge stp autofs4 nf_conntrack_ipv6 nf_defrag_ipv6 ipv6 binfmt_misc ext3 jbd ext2 dm_mirror dm_regio]
> [  428.454001]
> [  428.454001] Pid: 12, comm: ksoftirqd/1 Not tainted 3.2.9-rt15+ #36 LENOVO 8810A56/LENOVO
> [  428.454001] RIP: 0010:[<ffffffff8106b749>]  [<ffffffff8106b749>] __lock_acquire+0xa9/0x42e
> [  428.454001] RSP: 0018:ffff88007ea03cf8  EFLAGS: 00010082
> [  428.454001] RAX: ffffffff8103e7f7 RBX: ffff88007c07a2b8 RCX: 0000000000000000
> [  428.454001] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88007c07a2b8
> [  428.454001] RBP: ffff88007ea03d48 R08: 0000000000000001 R09: 0000000000000001
> [  428.454001] R10: 00000000000001ab R11: ffff88007c090300 R12: 0000000000000000
> [  428.454001] R13: ffff88007c090300 R14: 0000000000000000 R15: 0000000000000001
> [  428.454001] FS:  0000000000000000(0000) GS:ffff88007ea00000(0000) knlGS:0000000000000000
> [  428.454001] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  428.454001] CR2: ffffffff8103e98f CR3: 00000000771ae000 CR4: 00000000000006f0
> [  428.454001] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  428.454001] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
> [  428.454001] Process ksoftirqd/1 (pid: 12, threadinfo ffff88007c08a000, task ffff88007c090300)
> [  428.454001] Stack:
> [  428.454001]  ffff880000000000 ffffffff00000000 000000007ea03d28 ffffffff81060993
> [  428.454001]  0000000000000000 0000000000000000 ffff88007c090300 ffffffff810341dc
> [  428.454001]  0000000000000001 0000000000000000 ffff88007ea03dc8 ffffffff8106bb92
...
