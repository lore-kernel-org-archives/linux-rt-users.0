From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: [RFC PATCH RT V3] rwsem: The return of multi-reader PI rwsems
Date: Fri, 11 Apr 2014 14:47:49 +0200
Message-ID: <5347E475.4020009@osadl.org>
References: <20140409151922.5fa5d999@gandalf.local.home>	<20140410134217.38cd6db7@gandalf.local.home> <20140410223508.6d0fc135@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140410223508.6d0fc135@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Steven,

> [..] I added Carsten to the Cc, so I'll post the entire change log
> of v1 here again.
I've been listening and testing boxes all the time ...

> [..] If you have any benchmark on large machines I would be very
> happy if you could test this patch against the unpatched version of
> -rt.
Three machines
- an X32 x86_64 (AMD Opteron 6272 @2100 MHz) at rack #1/slot #1,
- an X4x2 x86_64 (Intel i7-2600K @3400 MHz) at rack #4/slot #6, and
- an X4 ARM (i.MX6 Quad @996 MHz) at rack #8/slot #7
are running a v3-patched 3.12.15-rt25 kernel now. I'll equip more
machines later.

What I can say so far is:
- No evidence for any regression, no crashes
- Performance certainly at least as good as unpatched, probably better

I'll do more tests and come back with more precise performance
comparison data.

Thanks,
	-Carsten.
