From: David Hauck <davidh@netacquire.com>
Subject: RE: [PATCH RT] sched: Prevent task state corruption by spurious
 lock wakeup
Date: Fri, 2 Jun 2017 17:25:53 +0000
Message-ID: <FCC5AC80E299464B82E1345E2C10FC9D9B652D6A@S1P5DAG10E.EXCHPROD.USA.NET>
References: <alpine.DEB.2.20.1706021834070.1899@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
        Sebastian Sewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathias Koehrer <mathias.koehrer@etas.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1706021834070.1899@nanos>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas,
 
On Friday, June 02, 2017 9:40 AM, Thomas Gleixner wrote:
> Mathias and some others reported GDB failures on RT.

I've run an initial test of this on our build/application and the debugger is working *way* better now. So far no immediate issues - I'll continue testing. Thanks so much for finding, fixing, and sending this along.

FYI, my target:
	- kernel: v4.9.30-rt20
	- GDB/gdbserver: v7.11.1
	- GLibC: v2.25

Regards,
-David Hauck

PS: Mathias, my runs of your gdb-issue test utility also appear to run fine.
