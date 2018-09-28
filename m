From: Julia Cartwright <julia@ni.com>
Subject: [PATCH 0/2] Fix watchdogd wakeup deferral on RT
Date: Fri, 28 Sep 2018 21:03:52 +0000
Message-ID: <cover.1538089179.git.julia@ni.com>
References: <73in2vl5mj.fsf@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Tim Sander <tim@krieglstein.org>
To: Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <73in2vl5mj.fsf@pengutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

The following two patches solve an issue reported by Steffen Trumtrar
and Tim Sander to the linux-rt-users mailing list.  Namely, the wakeup
of the watchdogd thread being starved by an RT task due to the hrtimer
deferral through ktimersoftd (on PREEMPT_RT_FULL).

The first patch adjusts the kthread_worker locking to make use of a raw
spinlock, making it suitable for work item queueing from hardirq context
on PREEMPT_RT.  This patch can be applied directly to mainline without
any functional change.

The second patch adjusts the hrtimer used by the watchdog core to be a
_HARD timer (and thus not deferred through ktimersoftd w/ PREEMPT_RT).
This patch depends on hrtimer patches carried in the RT patch, and so
should therefore land there.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Tim Sander <tim@krieglstein.org>

Julia Cartwright (2):
  kthread: convert worker lock to raw spinlock
  watchdog, rt: prevent deferral of watchdogd wakeup

 drivers/watchdog/watchdog_dev.c |  2 +-
 include/linux/kthread.h         |  2 +-
 kernel/kthread.c                | 42 ++++++++++++++++-----------------
 3 files changed, 23 insertions(+), 23 deletions(-)

--=20
2.18.0
