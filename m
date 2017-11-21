From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH PREEMPT RT] rt-mutex: fix deadlock in device mapper
Date: Tue, 21 Nov 2017 04:20:30 +0100
Message-ID: <1511234430.7672.26.camel@gmx.de>
References: <alpine.LRH.2.02.1711131245580.23280@file01.intranet.prod.int.rdu2.redhat.com>
         <20171117145744.t366d2ztxj2qqnco@linutronix.de>
         <1511030230.12841.42.camel@gmx.de>
         <alpine.LRH.2.02.1711201607230.24006@file01.intranet.prod.int.rdu2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 8BIT
Cc: Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
To: Mikulas Patocka <mpatocka@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.02.1711201607230.24006@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 2017-11-20 at 16:33 -0500, Mikulas Patocka wrote:
> 
> Is there some specific scenario where you need to call 
> blk_schedule_flush_plug from rt_spin_lock_fastlock?

Excellent question.  What's the difference between not getting IO
started because you meet a mutex with an rt_mutex under the hood, and
not getting IO started because you meet a spinlock with an rt_mutex
under the hood?  If just doing the mutex side puts this thing back to
sleep, I'm happy.

	-Mike
