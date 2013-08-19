From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 0/3] hwlat-detector: Have it actually find hardware latency
Date: Mon, 19 Aug 2013 17:33:24 -0400
Message-ID: <20130819213324.405942342@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <clark.williams@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thi patch series fixes up hwlat-detector to check the entire path
of time for a latency being hit, instead of the quick check between
two time stamps.

It also uses the trace_local_clock() if available, which is much lighter
weight than ktime_get() which might produce false positives. As
the trace clock is used to detect irq latencies, it's suitable for
hardware latency.

Finally, stop machine is removed and the test is run by a single thread.
