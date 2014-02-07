From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT] rt: Make cpu_chill() use hrtimer instead of msleep()
Date: Fri, 7 Feb 2014 12:30:06 +0100
Message-ID: <20140207113006.GD23668@linutronix.de>
References: <20140205115125.3cc950ce@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	John Kacur <jkacur@redhat.com>,
	Ulrich Obergfell <uobergfe@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140205115125.3cc950ce@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2014-02-05 11:51:25 [-0500]:

>Ulrich Obergfell pointed out that cpu_chill() calls msleep() which is woken
>up by the ksoftirqd running the TIMER softirq. But as the cpu_chill() is
>called from softirq context, it may block the ksoftirqd() from running, in
>which case, it may never wake up the msleep() causing the deadlock.
>
>I checked the vmcore, and irq/74-qla2xxx is stuck in the msleep() call,
>running on CPU 8. The one ksoftirqd that is stuck, happens to be the one that
>runs on CPU 8, and it is blocked on a lock held by irq/74-qla2xxx. As that
>ksoftirqd is the one that will wake up irq/74-qla2xxx, and it happens to be
>blocked on a lock that irq/74-qla2xxx holds, we have our deadlock.

could you please tell me which two locks are invovled here?

Sebastian
