From: Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Tue, 30 Oct 2007 22:09:48 +0100 (CET)
Message-ID: <6252335.1612671193778588591.JavaMail.www@wwinf6102>
Reply-To: gerritbinnenmars@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-2.orange.nl ([193.252.22.242]:50494 "EHLO smtp-2.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754219AbXJ3VJt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 17:09:49 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6106.orange.nl (SMTP Server) with ESMTP id 9F11F7000089
	for <linux-rt-users@vger.kernel.org>; Tue, 30 Oct 2007 22:09:48 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Datum: 30/10/07 10:02 PM
> Van: "Daniel Walker" 
> Aan: gerritbinnenmars@wanadoo.nl
> CC: linux-rt-users@vger.kernel.org
> Onderwerp : Re: CONFIG_CRITICAL_IRQSOFF_TIMING
> 
> On Tue, 2007-10-30 at 21:52 +0100, Gerrit Binnenmars wrote:
> 
> > CONFIG_LTT_PROBE_LOCKING=m
> > # CONFIG_LTT_PROBE_STACK is not set
> 
> I wonder which kernel your using? I don't recall LTT being part of real
> time in the past .. What the architecture too ?

Hello Daniel,
I use version 2.6.22.1-rt4, see the following link for LTT compatibility
http://ltt.polymtl.ca/svn/ltt/branches/poly/doc/developer/lttng-lttv-compatibility.html

I have used LTT on both i386 an on a PowerPC (MPC8555) architecture.
It is a great help in understanding real-time behaviour.

Gerrit

> 
> > CONFIG_CRITICAL_IRQSOFF_TIMING=y
> > CONFIG_INTERRUPT_OFF_HIST=y
> > CONFIG_CRITICAL_TIMING=y
> > CONFIG_DEBUG_TRACE_IRQFLAGS=y
> > CONFIG_LATENCY_TIMING=y
> 
> You might try disabling the histogram option temporarily, it may have be
> effecting things (not sure how tho) ..
> 
> Daniel
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
