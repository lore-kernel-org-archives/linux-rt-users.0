From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 0/3] hwlat-detector: Have it actually find hardware
 latency
Date: Wed, 21 Aug 2013 17:59:45 +0200
Message-ID: <20130821155945.GC16913@linutronix.de>
References: <20130819213324.405942342@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <clark.williams@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130819213324.405942342@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Steven Rostedt | 2013-08-19 17:33:24 [-0400]:

>Thi patch series fixes up hwlat-detector to check the entire path
>of time for a latency being hit, instead of the quick check between
>two time stamps.
>
>It also uses the trace_local_clock() if available, which is much lighter
>weight than ktime_get() which might produce false positives. As
>the trace clock is used to detect irq latencies, it's suitable for
>hardware latency.
>
>Finally, stop machine is removed and the test is run by a single thread.

Applied, thanks.

Sebastian
