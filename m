From: Daniel Walker <dwalker@mvista.com>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Tue, 30 Oct 2007 13:56:47 -0700
Message-ID: <1193777808.4673.24.camel@imap.mvista.com>
References: <11542808.1611171193777521160.JavaMail.www@wwinf6102>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: gerritbinnenmars@wanadoo.nl
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:61614 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbXJ3VCg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 17:02:36 -0400
In-Reply-To: <11542808.1611171193777521160.JavaMail.www@wwinf6102>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2007-10-30 at 21:52 +0100, Gerrit Binnenmars wrote:

> CONFIG_LTT_PROBE_LOCKING=m
> # CONFIG_LTT_PROBE_STACK is not set

I wonder which kernel your using? I don't recall LTT being part of real
time in the past .. What the architecture too ?

> CONFIG_CRITICAL_IRQSOFF_TIMING=y
> CONFIG_INTERRUPT_OFF_HIST=y
> CONFIG_CRITICAL_TIMING=y
> CONFIG_DEBUG_TRACE_IRQFLAGS=y
> CONFIG_LATENCY_TIMING=y

You might try disabling the histogram option temporarily, it may have be
effecting things (not sure how tho) ..

Daniel
