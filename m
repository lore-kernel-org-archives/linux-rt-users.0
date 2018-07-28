From: Mike Galbraith <efault@gmx.de>
Subject: candidates for @devel-rt localversion-rt++
Date: Sat, 28 Jul 2018 11:07:11 +0200
Message-ID: <1532768831.9882.71.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

1. arm64/acpi/perf: move pmu allocation to an early CPU up hook
2. sched: Introduce raw_cond_resched_lock()
3. arm, KVM: convert vgic_irq.irq_lock to raw_spinlock_t

With these applied, 4 socket TaiShan 2280 box boots shiny new -rt11
gripe free, and has been tossed into SUSE's kvm build-bot slave pit,
where it is presumably performing acceptably, given its boss keeps
giving it more work to do.  (I see only lack of smoke/flame)

1 should fly, 2 and 3 may well die.. as box does without them.

	-Mike
