From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 3.12.1-rt4
Date: Mon, 02 Dec 2013 09:43:57 +0100
Message-ID: <529C484D.3080905@linutronix.de>
References: <20131116194633.GD11518@linutronix.de> <20131122211119.GL8698@linutronix.de> <529BB74C.4000702@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, rostedt@goodmis.org,
	John Kacur <jkacur@redhat.com>
To: pavel@pavlinux.ru
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <529BB74C.4000702@pavlinux.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 12/01/2013 11:25 PM, Pavel Vasilyev wrote:
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 10 at kernel/time/tick-sched.c:191 0xffffffff8107bac6()
> NO_HZ FULL will not work with unstable sched clock
> Call Trace:
>  <IRQ>  [<ffffffff81501a58>] 0xffffffff81501a58
>  [<ffffffff8102f992>] 0xffffffff8102f992

Okay. Now we have a backstrace. Better. Now there is an option named
CONFIG_DEBUG_INFO which resolves a number like 0xffffffff81501a58 to
the function name. Without it enabled, the backtrace is of no use to me.

However, in this case you triggered the warning in tick-sched.c. The
good news is that FULL-NO-HZ mode is not available because your TSC is
unstable and this is all the backtrace is about so it is harmless. You
should see it even without -RT enabled. The bad news is that I don't
think that this has anything to do with your SATA problem.

Sebastian
