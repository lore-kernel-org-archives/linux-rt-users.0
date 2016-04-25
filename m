From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-tests: Update the cyclictest man page
Date: Mon, 25 Apr 2016 18:36:29 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1604251834030.6896@riemann>
References: <alpine.LFD.2.20.1604251614270.6896@riemann> <20160425111913.14c5573c@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34100 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932882AbcDYQgj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Apr 2016 12:36:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id n3so26379917wmn.1
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Apr 2016 09:36:39 -0700 (PDT)
In-Reply-To: <20160425111913.14c5573c@sluggy.hsv.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 25 Apr 2016, Clark Williams wrote:

> On Mon, 25 Apr 2016 16:17:11 +0200 (CEST)
> John Kacur <jkacur@redhat.com> wrote:
> 
> > From 7e007ac70a83f62583d25b10ad2df0430306bf32 Mon Sep 17 00:00:00 2001
> > From: John Kacur <jkacur@redhat.com>
> > Date: Mon, 25 Apr 2016 16:08:28 +0200
> > Subject: [PATCH] rt-tests: Update the cyclictest man page
> > 
> > We have done a good job keeping cyclictest help up-to-date, but we have
> > not been actively updating the man page.
> > 
> > There were many missing options, as well as options that don't exist
> > anymore. To be more precise, some short form options had been removed,
> > but there are still corresponding long-version options.
> > 
> > This patch contains a considerable amount of updates to the man-page to
> > keep it in sync, and in some cases it also updates the cyclictest help
> > where needed. For example, the cyclictest help options were not always
> > in the proper order. In some cases I changed the wording to make it more
> > closely correspond to the man page
> > 
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> > ---
> >  src/cyclictest/cyclictest.8 | 169 ++++++++++++++++++++++++--------------------
> >  src/cyclictest/cyclictest.c |  35 ++++-----
> >  2 files changed, 110 insertions(+), 94 deletions(-)
> 
> Looks good to me John. I did see one spelling issue:
> 
> > +Sned break trace command when latency > USEC
> 
> Thanks for cleaning the man page up. I'm afraid I neglected it.
> 
> Clark
> 

I ran spell on the cyclictest.8 and caught a few more spelling errors, 
I'll fold the following patch into the previous one and add your ack

Thanks

>From 6ce4dbc6e530835af8725977207af052522fb9eb Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Mon, 25 Apr 2016 18:35:14 +0200
Subject: [PATCH] Fix some spelling error in the cyclictest manpage

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/cyclictest.8 | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.8 b/src/cyclictest/cyclictest.8
index 120dae23860e..1d26ecefd010 100644
--- a/src/cyclictest/cyclictest.8
+++ b/src/cyclictest/cyclictest.8
@@ -34,7 +34,7 @@ A summary of options is included below.
 .\" For a complete description, see the Info files.
 .TP
 .B \-a, \-\-affinity[=PROC-SET]
-Run threads on the set of procesors given by PROC-SET.  If PROC-SET is not
+Run threads on the set of processors given by PROC-SET.  If PROC-SET is not
 specified, all processors will be used.  Threads will be assigned to processors
 in the set in numeric order, in a round\-robin fashion.
 .br
@@ -50,7 +50,7 @@ if specified, must be a single CPU number.
 Align thread wakeups to a specific offset in microseconds
 .TP
 .B \-b, \-\-breaktrace=USEC
-Sned break trace command when latency > USEC
+Send break trace command when latency > USEC
 .TP
 .B \-B, \-\-preemptirqs
 Both preempt and irqsoff tracing (used with -b)
@@ -89,7 +89,7 @@ Dump latency histogram to stdout after the run. US is the max latency time to be
 Same as -h except that an additional histogram column is displayed at the right that contains summary data of all thread histograms. If cyclictest runs a single thread only, the -H option is equivalent to -h.
 .TP
 .B \-\-histfile=<path>
-Dump the latecny histogram to <path> instead of stdout.
+Dump the latency histogram to <path> instead of stdout.
 .TP
 .B \-i, \-\-interval=INTV
 Set the base interval of the thread(s) in microseconds (default is 1000us). This sets the interval of the first thread. See also \-d.
@@ -123,7 +123,7 @@ Show results in nanoseconds instead of microseconds, which is the default unit.
 Oscilloscope mode, reduce verbose output by RED.
 .TP
 .B \-O, \-\-traceopt=TRACING_OPTION
-Used to pass tracing options to ftrace tracers. May be invoked mutiple
+Used to pass tracing options to ftrace tracers. May be invoked multiple
 times for multiple trace options. For example trace options look at /sys/kernel/debug/tracing/trace_options
 .TP
 .B \-p, \-\-prio=PRIO
-- 
2.4.11

