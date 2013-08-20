From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.10.6-rt3
Date: Mon, 19 Aug 2013 20:29:03 -0400
Message-ID: <20130819202903.692097ea@gandalf.local.home>
References: <20130812163413.GI23040@linutronix.de>
	<520D212F.7030400@localhost>
	<20130815152210.5ed93696@gandalf.local.home>
	<520DCE5F.1040402@linutronix.de>
	<521254A0.6050603@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kent Overstreet <kmo@daterainc.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:20651 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab3HTA3E (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 19 Aug 2013 20:29:04 -0400
In-Reply-To: <521254A0.6050603@localhost>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 19 Aug 2013 10:23:44 -0700
Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:


> > The problem is that bcache is using new semaphore functions which it
> > just introduced which rt does not know about. The comment above their
> > definition says that it is wrong to use them and completion is the
> > right way to do it.
> > So my question is, why don't we use completion but this nasty hack?

I think I'm going to send them an email about that.

> 
> In the meanwhile, any hope of a patch to be able to compile and test 
> with my current configuration?

Can you boot without enabling CONFIG_BCACHE?

-- Steve

