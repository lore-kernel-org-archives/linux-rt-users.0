From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG: spinlock trylock failure on UP, i.MX28 3.12.15-rt25
Date: Tue, 22 Apr 2014 13:54:39 +0200
Message-ID: <20140422115439.GA20669@linutronix.de>
References: <534C3606.7010206@meduna.org>
 <534C731F.1050406@meduna.org>
 <534DADF1.6060608@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <534DADF1.6060608@meduna.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Stanislav Meduna | 2014-04-16 00:08:49 [+0200]:

>Hmm... how is it in the rt-case guaranteed that the timer interrupt
>does not preempt someone trying to modify the timer? The run_local_tim=
ers
>looks to have arrived via hardirq context. The spinlock in the tvec_ba=
se
>is a normal one and spin_lock_irqsave does not disable interrupts
>on rt, right?

this is, erm, harmless. We grab the timer lock via trylock in hardirq
context. If the lock is already taken then we fail to get it we go for
plan B. According to lockdep a trylock should not fail on UP. This is
true in general except for this timer case. I was thinking abour
disabling this lockdep check=E2=80=A6

Sebastian
