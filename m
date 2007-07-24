From: Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: v2.6.23-rc1-rt0
Date: Tue, 24 Jul 2007 17:02:01 +0200
Message-ID: <20070724150201.GA27113@slug>
References: <20070724121227.GA18670@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764844AbXGXPFg@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070724121227.GA18670@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, Jul 24, 2007 at 02:12:27PM +0200, Ingo Molnar wrote:
> i've released the v2.6.23-rc1-rt0 kernel, which can be downloaded from 
> the usual place:
>  
>    http://redhat.com/~mingo/realtime-preempt/
Hi Ingo,

  CC      kernel/latency_hist.o
  kernel/latency_hist.c: In function 'u64_div':
  kernel/latency_hist.c:54: error: implicit declaration of function 'do_div'
  make[1]: *** [kernel/latency_hist.o] Error 1
  make: *** [kernel] Error 2

This was needed to compile rt0 with LATENCY_TRACE on i386:

Add asm/div64.h header to define do_div()

Signed-off-by: Frederik Deweerdt <frederik.deweerdt@gmail.com>

--- kernel/latency_hist..ori	2007-07-24 16:04:20.000000000 +0200
+++ kernel/latency_hist.c	2007-07-24 16:04:50.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/percpu.h>
 #include <linux/latency_hist.h>
 #include <asm/atomic.h>
+#include <asm/div64.h>
 
 typedef struct hist_data_struct {
 	atomic_t hist_mode; /* 0 log, 1 don't log */
