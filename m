From: Daniel Walker <dwalker@mvista.com>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Tue, 30 Oct 2007 14:32:43 -0700
Message-ID: <1193779963.4673.34.camel@imap.mvista.com>
References: <25376807.1614051193779617681.JavaMail.www@wwinf6102>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: gerritbinnenmars@wanadoo.nl
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:18617 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbXJ3Vic (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 17:38:32 -0400
In-Reply-To: <25376807.1614051193779617681.JavaMail.www@wwinf6102>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-10-30 at 22:26 +0100, Gerrit Binnenmars wrote:

> Daniel, I first applied the rt patchset and then the LTTng patch 
> (http://ltt.polymtl.ca/lttng/patch-2.6.22.1-rt4-lttng-0.9.10.tar.gz).
> Then LTT can be selected in the Instrumentation part of the config file. 
> further ltt-control is needed (http://ltt.polymtl.ca/lttng/ltt-control-0.43-10082007.tar.gz)
> 
> The viewer is only working on i386 but that is not really a problem.
> 
> So, I applied the available patches without doing anything special.

Ok .

> Is LTT causing troubles with the preempt_max_latency options?

I doubt it .. I haven't used the histogram options in a month or so ..
But if I remember correctly the value of preempt_max_latency is suppose
to remain at zero .. Usually preempt_max_latency is used to prune off
uninteresting latencies (ones under the max) but if you have the
histogram option turn on then all latencies points need to be recorded.
The data can be viewed in in /proc/latency_hist/ .. In 2.6.22 there is
no way to reset the histograms for preempt off, or interrupts off
timing.

Daniel
