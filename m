From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH][RT] xfs: Disable percpu SB on PREEMPT_RT_FULL
Date: Thu, 14 May 2015 18:32:19 +0200
Message-ID: <20150514163219.GF13442@linutronix.de>
References: <20150430123303.30f5bd12@gandalf.local.home>
 <20150504004844.GA21261@dastard>
 <20150513113632.7d902a0f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: LKML <linux-kernel@vger.kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150513113632.7d902a0f@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2015-05-13 11:36:32 [-0400]:

>Running a test on a large CPU count box with xfs, I hit a live lock
>with the following backtraces on several CPUs:
Applied.

Sebastian
