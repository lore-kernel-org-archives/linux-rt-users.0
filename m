From: Mike Galbraith <efault@gmx.de>
Subject: Re: candidates for @devel-rt localversion-rt++
Date: Sun, 29 Jul 2018 08:55:30 +0200
Message-ID: <1532847330.1618.8.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1532768831.9882.71.camel@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2018-07-28 at 11:07 +0200, Mike Galbraith wrote:
> 1. arm64/acpi/perf: move pmu allocation to an early CPU up hook

Nope, it's an ex-candidate.  Having found/run kvm unit tests, I
discovered that while the above fixes boot time splat, it somehow
manages to break kvm pmu tests, so needs staring at.

	-Mike
