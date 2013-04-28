From: Carsten Emde <C.Emde@osadl.org>
Subject: Re: timerfd read does not return - was probably fixed in 3.4.38
Date: Sun, 28 Apr 2013 13:53:52 +0200
Message-ID: <517D0DD0.6040307@osadl.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org> <517B8D91.4010700@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	rostedt@goodmis.org, Thomas Gleixner <tglx@linutronix.de>
To: Stanislav Meduna <stano@meduna.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from toro.web-alm.net ([62.245.132.31]:52462 "EHLO toro.web-alm.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755673Ab3D1MAU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 28 Apr 2013 08:00:20 -0400
In-Reply-To: <517B8D91.4010700@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Stano,

> [..]
> A general question: I am seeing a few recent changes in the tracing
> code. Is it generally safe to have at least latency histogram
> enabled in the production code, or is it advised not to compile these
> features in? I'd like to see the latencies the customer is getting in
> the real environment, but if the code is considered as
> work-in-progress, it is better to play it safe.
There are a number of different built-in latency histograms in the
kernel, some of them are best used to trace a known problem (e.g.
INTERRUPT_OFF_HIST and PREEMPT_OFF_HIST) while others are intended for
continuous latency monitoring (CONFIG_WAKEUP_LATENCY_HIST and
CONFIG_MISSED_TIMER_OFFSETS_HIST). The latter are ideally suitable to
document the real-time capabilities of a production system and to
retrospectively analyze a failure that may be related to a prolonged
latency. We, therefore, configure and enable continuous latency
monitoring histograms (CONFIG_WAKEUP_LATENCY_HIST and
CONFIG_MISSED_TIMER_OFFSETS_HIST) by default in all our farm systems
since more than two years (https://www.osadl.org/?id=864), and we are
not aware of any problem that might be related to them. I, thus, would
like to say that they are save to be used in production systems. Since
we do not have much long-term experience with the other histograms and
they may introduce additional and longer latencies than the former, I
would not recommend to enable them in production systems.

BTW: Your question was whether it is "advised not to compile these
features in". There certainly is very little penalty or risk to
configure these features without enabling them. So I don't see any
reason not to compile them in. Only when you enable them
   cd /sys/kernel/debug/tracing/latency_hist/enable
   for i in wakeup missed_timer_offsets timerandwakeup
   do
     echo 1 >$i
   done
a certain latency penalty and risk of malfunction may apply.

	-Carsten.
