From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.12.8-rt11
Date: Fri, 31 Jan 2014 23:11:06 +0100
Message-ID: <20140131221106.GG21238@linutronix.de>
References: <20140125134519.GA9845@linutronix.de>
 <20140129153043.4d3ed46f@tor.valhalla.alchemy.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: Joakim Hernberg <jbh@alchemy.lu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140129153043.4d3ed46f@tor.valhalla.alchemy.lu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Joakim Hernberg | 2014-01-29 15:30:43 [+0100]:

>On Sat, 25 Jan 2014 14:45:19 +0100
>Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>
>> Dear RT folks!
>> 
>> I'm pleased to announce the v3.12.8-rt11 patch set.
>
>So far the only thing seen in the kernel buffer on this 64b system are a
>smattering of "NOHZ: local_softirq_pending 40" and this warning:
>
>[23102.607632] ------------[ cut here ]------------
>[23102.607645] WARNING: CPU: 4 PID: 59 at kernel/time/tick-sched.c:161
>can_stop_full_tick+0x26b/0x280() 

This should be fixed by "irq_work: allow certain work in hard irq
context" I posted to the list today.

>Kernel config file attached:
>

Sebastian
