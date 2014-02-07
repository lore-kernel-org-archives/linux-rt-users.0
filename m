From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Cyclictest results on Sparc64 with PREEMPT_RT
Date: Fri, 7 Feb 2014 13:35:29 +0100
Message-ID: <20140207123529.GA2382@linutronix.de>
References: <52E616DB.2040202@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, davem@davemloft.net,
	SebastianAndrzejSiewiorbigeasy@linutronix.de
To: Allen Pais <allen.pais@oracle.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44168 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbaBGMfc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Feb 2014 07:35:32 -0500
Content-Disposition: inline
In-Reply-To: <52E616DB.2040202@oracle.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Allen Pais | 2014-01-27 13:50:43 [+0530]:

>Hi,
Hi,

>[ 1143.894099] INFO: rcu_preempt self-detected stall on CPU { 36}  (t=3D=
2100 jiffies g=3D373 c=3D372 q=3D61)
>[ 1143.894130]   CPU[  0]: TSTATE[0000009980001602] TPC[000000000048d1=
ac] TNPC[000000000048d1b0] TASK[ksoftirqd/0:3]
>[ 1143.894151]              TPC[idle_cpu+0x2c/0x80] O7[cpumask_next_an=
d+0x18/0x80] I7[find_busiest_group+0x21c/0xa40] RPC[load_balance+0xe8/0=
x880]

so you have CPU stall on cpu36
>
>[ 1150.135499] BUG: soft lockup - CPU#36 stuck for 23s! [swapper/36:0]
>[ 1150.135564] TPC: <rtrap_no_irq_enable+0x0/0xc>
>[ 1150.135572] RPC: <tl0_irq15+0x14/0x20>
>[ 1150.135581] I7: <tl0_irq15+0x14/0x20>

This is your NMI handler where you are right now=E2=80=A6

>[ 1150.135582] Call Trace:
>[ 1150.135584]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
>[ 1150.135586]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
>[ 1150.135588]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
>[ 1150.135590]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
>[ 1150.135592]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
>[ 1150.135594]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
>[ 1150.135595]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
>[ 1150.135597]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
>[ 1150.135599]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc
>[ 1150.135600]  [0000000000404b54] rtrap_no_irq_enable+0x0/0xc

This is the stack where the NMI got injected. Not sure why this is more
than once here but then this the sparc64 trace I see :)

>[ 1150.135604]  [00000000004acc00] in_lock_functions+0x0/0x40
>[ 1150.135608]  [000000000080a038] add_preempt_count+0xd8/0x140
>[ 1150.135610]  [000000000080617c] __schedule+0x1c/0x500
>[ 1150.135613]  [0000000000806b7c] schedule+0x1c/0xc0
>[ 1150.135615]  [0000000000806f8c] schedule_preempt_disabled+0xc/0x40
>[ 1150.135617]  [000000000049dd10] cpu_startup_entry+0x150/0x300

And this where the CPU was before the NMI. Doesn't look blocking.
in_lock_functions() compares a few values no locking involved so the CP=
U
probably was here while the NMI hit and an usec later it might be an
instruction later. What I thnig is odd, is that it is exactly at the
begin of the function, not an instruction later.

>Am yet to debug what went wrong.=20
>
>- Allen

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
