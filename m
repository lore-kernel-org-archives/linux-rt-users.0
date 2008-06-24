From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] sched: enable interrupts and drop rq-lock during
 newidle balancing
Date: Mon, 23 Jun 2008 20:11:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0806232011220.8540@gandalf.stny.rr.com>
References: <20080623225645.31515.36393.stgit@lsg.lsg.lab.novell.com>
 <20080623230440.31515.97377.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mingo@elte.hu, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	peterz@infradead.org, linux-rt-users@vger.kernel.org,
	dbahi@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:56249 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbYFXAL5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jun 2008 20:11:57 -0400
In-Reply-To: <20080623230440.31515.97377.stgit@lsg.lsg.lab.novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 23 Jun 2008, Gregory Haskins wrote:

>
> We do find_busiest_groups() et. al. without locks held for normal balancing,
> so lets do it for newidle as well.  It will allow other cpus to make
> forward progress (against our RQ) while we try to balance and allow
> some interrupts to occur.
>

I don't see anything wrong with this patch. I'll probably queue it up for
-rt8 since it is too late for -rt7.

-- Steve

