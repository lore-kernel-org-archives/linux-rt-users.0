From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Using random in interrupts for RT
Date: Tue, 14 Aug 2012 17:17:07 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1208141716170.32033@ionos>
References: <1344954649.6724.13.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>,
	RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59707 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752167Ab2HNPRJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Aug 2012 11:17:09 -0400
In-Reply-To: <1344954649.6724.13.camel@gandalf.stny.rr.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 14 Aug 2012, Steven Rostedt wrote:
> Ben Hutchings asked me if we still need "genirq: Disable random call on
> preempt-rt" for -rt? With commit 902c098a366 "random: use lockless
> techniques in the interrupt path" there is no more locks used. But does
> it still produce high latencies?

Haven't tested it. Will put it on my ever growing todo list....
