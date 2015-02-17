From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] sched: Do not clear PF_NO_SETAFFINITY flag in
 select_fallback_rq()
Date: Tue, 17 Feb 2015 10:37:26 +0100
Message-ID: <20150217093726.GD26177@linutronix.de>
References: <20140701111444.0cfebaa1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140701111444.0cfebaa1@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2014-07-01 11:14:44 [-0400]:

>I talked with Peter Zijlstra about this, and he told me that the clearing
>of the PF_NO_SETAFFINITY flag was to deal with the optimization of
>migrate_disable/enable() that ignores tasks that have that flag set. But
>that optimization was removed when I did a rework of the cpu hotplug code.

This has been already applied. You took it into v3.14 and while applying
the latest v3.14 patches it made its way into v3.18 as well.

Sebastian
