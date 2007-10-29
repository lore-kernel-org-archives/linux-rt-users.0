From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Mon, 29 Oct 2007 09:08:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710290856020.13188@gandalf.stny.rr.com>
References: <8925926.1439951193576410781.JavaMail.www@wwinf6003>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:37550 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757831AbXJ2NIP (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Oct 2007 09:08:15 -0400
In-Reply-To: <8925926.1439951193576410781.JavaMail.www@wwinf6003>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Sun, 28 Oct 2007, Gerrit Binnenmars wrote:

> Hello,
>
> Can someone send me a .config file that shows the options needed to get the interrupt off
> timing values in preempt_max_latency, please. I only see a value of 0 in this file
> I am using kernel 2.6.22.1 with the corresponding rt patch.
>
> Thanks in advance,

Make sure you have event trace and latency tracing as well as
"Interrupts-off critical section latency timing".

Then you need to echo 0 > /proc/sys/kernel/preempt_max_latency.

-- Steve
