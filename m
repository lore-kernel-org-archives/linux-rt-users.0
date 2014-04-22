From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: BUG: spinlock trylock failure on UP, i.MX28 3.12.15-rt25
Date: Tue, 22 Apr 2014 09:46:57 -0400
Message-ID: <20140422094657.5b6ca1e2@gandalf.local.home>
References: <534C3606.7010206@meduna.org>
	<534C731F.1050406@meduna.org>
	<534DADF1.6060608@meduna.org>
	<20140422115439.GA20669@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stanislav Meduna <stano@meduna.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140422115439.GA20669@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

[ added Peter ]

On Tue, 22 Apr 2014 13:54:39 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
=20
> this is, erm, harmless. We grab the timer lock via trylock in hardirq
> context. If the lock is already taken then we fail to get it we go fo=
r
> plan B. According to lockdep a trylock should not fail on UP. This is
> true in general except for this timer case. I was thinking abour
> disabling this lockdep check=E2=80=A6

trylock not failing on UP, can that be an issue? I mean, if a hardirq
does a trylock to see if it can grab a lock that is not protected by
disabling irqs, and will go to plan B if it fails, on UP, it will
always get it.  But the issue is still there. That would mean that a
hardirq could have preempted a critical section and doing a trylock
here would succeed when it really should have failed.

-- Steve
