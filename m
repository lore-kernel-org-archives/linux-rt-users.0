From: Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Tue, 30 Oct 2007 22:46:44 +0100 (CET)
Message-ID: <31957022.1615381193780804539.JavaMail.www@wwinf6102>
Reply-To: gerritbinnenmars@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-2.orange.nl ([193.252.22.242]:44330 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753830AbXJ3Vqq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 17:46:46 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6101.orange.nl (SMTP Server) with ESMTP id 895561C00089
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Oct 2007 22:46:44 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Datum: 30/10/07 10:38 PM
> Van: "Daniel Walker" 
> Aan: gerritbinnenmars@wanadoo.nl
> CC: linux-rt-users@vger.kernel.org
> Onderwerp : Re: CONFIG_CRITICAL_IRQSOFF_TIMING
> 
> On Tue, 2007-10-30 at 22:26 +0100, Gerrit Binnenmars wrote:
> 
> > Daniel, I first applied the rt patchset and then the LTTng patch 
> > (http://ltt.polymtl.ca/lttng/patch-2.6.22.1-rt4-lttng-0.9.10.tar.gz).
> > Then LTT can be selected in the Instrumentation part of the config file. 
> > further ltt-control is needed (http://ltt.polymtl.ca/lttng/ltt-control-0.43-10082007.tar.gz)
> > 
> > The viewer is only working on i386 but that is not really a problem.
> > 
> > So, I applied the available patches without doing anything special.
> 
> Ok .
> 
> > Is LTT causing troubles with the preempt_max_latency options?
> 
> I doubt it .. I haven't used the histogram options in a month or so ..
> But if I remember correctly the value of preempt_max_latency is suppose
> to remain at zero .. Usually preempt_max_latency is used to prune off
> uninteresting latencies (ones under the max) but if you have the
> histogram option turn on then all latencies points need to be recorded.
> The data can be viewed in in /proc/latency_hist/ .. In 2.6.22 there is
> no way to reset the histograms for preempt off, or interrupts off
> timing.

Daniel,
Thanks for your suggestion. The latency_hist shows a max long value for the minimum latency. 
All other values remain 0. I think the tracer is not running at all, but I am not sure. 
I will remove the latency_hist option tomorrow and recheck preempt_max_latency.

Gerrit
> 
> Daniel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
