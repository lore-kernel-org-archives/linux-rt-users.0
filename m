From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/5] allow preemption in
 mem_cgroup_move_account_page_stat
Date: Fri, 14 Feb 2014 14:19:59 +0100
Message-ID: <20140214131959.GG28438@linutronix.de>
References: <20140210153933.GE20017@opentech.at>
 <20140214131705.GF28438@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140214131705.GF28438@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Sebastian Andrzej Siewior | 2014-02-14 14:17:05 [+0100]:

>Now, that I look at it again. Isn't it more efficient to keep preempti=
on
>disabled for this very short time instead instead of invoking
>migrate_disable() which includes preempt_disable()/enable() and a few
>more opcodes=E2=80=A6
>Therefore, I drop it again.

I think doing the same for the 1/5 of this series since it also disable=
s
migration for a handfull of asm opcodes.

Sebastian
