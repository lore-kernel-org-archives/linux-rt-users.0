From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [3.4-rt] backport of completion-use-simple-wait-queues.patch
Date: Fri, 29 Nov 2013 17:21:55 -0500
Message-ID: <20131129172155.64ac1eef@gandalf.local.home>
References: <20131128201029.GA28966@windriver.com>
	<20131129124931.GA31099@linutronix.de>
	<5298AE91.6010309@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:36801 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754072Ab3K2WV7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 17:21:59 -0500
In-Reply-To: <5298AE91.6010309@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Burp!  /me is still recovering from Turkey day.

On Fri, 29 Nov 2013 10:11:13 -0500
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> 
> Thanks for spotting that.  I guess the completion patch wouldn't hurt
> to be in 3.4-rt anyway, but it is more a feature than a fix, it now seems.
> [Not sure if Steve is still adding to the v3.4-rt-features branch...]

If people actually showed real interest for that branch, I would. But I
haven't heard anything about anyone using it, so I haven't wasted my
time on it.

-- Steve
