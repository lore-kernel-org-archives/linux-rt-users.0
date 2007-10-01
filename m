From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [HACK] convert i_alloc_sem for direct_io.c craziness!
Date: Mon, 01 Oct 2007 22:39:16 +0200
Message-ID: <1191271156.5574.9.camel@lappy>
References: <Pine.LNX.4.58.0709241700290.13164@gandalf.stny.rr.com>
	 <20071001195256.GB7718@mami.zabbo.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	mingo@goodmis.org, Thomas Gleixner <tglx@linutronix.de>
To: Zach Brown <zach.brown@oracle.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:42432 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbXJAUoJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Oct 2007 16:44:09 -0400
In-Reply-To: <20071001195256.GB7718@mami.zabbo.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Mon, 2007-10-01 at 12:52 -0700, Zach Brown wrote:

> Do you have any suggestions for locking constructs that RT would prefer?

Basically, anything that maps to a simple mutex. Anything more complex
gets real messy real quick.

Locks that have non-exclusive states become non-deterministic because an
unbounded number of contexts can be in this state. Hence acquisition of
the exclusive state has unbounded time. Even when limited to a bounded
number, the ramifications to the PI graph will get you a head-ache.

Also, non-owner locks, ie. semaphores (asymetric acquisition vs release
contexts) are unusable because the lack of ownership undermines PI - who
to boost?
