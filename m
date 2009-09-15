From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] Add histograms of potential and effective wakeup
 latencies
Date: Mon, 14 Sep 2009 21:01:12 -0400
Message-ID: <1252976472.20020.64.camel@gandalf.stny.rr.com>
References: <4AAEDDD5.4040505@osadl.org>
Reply-To: rostedt@goodmis.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	RT-Users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <Carsten.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:59444 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757716AbZIOBBL (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Sep 2009 21:01:11 -0400
In-Reply-To: <4AAEDDD5.4040505@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2009-09-15 at 02:20 +0200, Carsten Emde wrote:
> Resuscitated and enhanced the kernel latency histograms provided
> originally by Yi Yang and adapted and converted by Steven Rostedt.
> 
> Latency histograms in the current version
> - can be enabled online and independently
> - have virtually no performance penalty when configured but not enabled
> - have very little performance penalty when enabled
> - use already available wakeup and switch tracepoints
> - give corresponding results with the related tracer
> - allow to record wakeup latency histograms of a single process
> - record the process where the highest wakeup latency occurred 
> - are documented in Documentation/trace/histograms.txt
> 
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>

I did a quick scan of the patch and this looks much nicer.

Good work!

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


