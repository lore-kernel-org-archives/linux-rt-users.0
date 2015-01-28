From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 3.14-rt ARM performance regression?
Date: Tue, 27 Jan 2015 23:08:46 -0500
Message-ID: <20150127230846.12aaf405@gandalf.local.home>
References: <20150124020341.GA2861@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:46176 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759991AbbA1EIt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Jan 2015 23:08:49 -0500
In-Reply-To: <20150124020341.GA2861@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 23 Jan 2015 20:03:41 -0600
Josh Cartwright <joshc@ni.com> wrote:

> Hey folks-
> 
> We've recently undertaken an upgrade of our kernel from 3.2-rt to
> 3.14-rt, and have run into a performance regression on our ARM boards.
> We're still in the process of trying to isolate what we can, but
> hopefully someone's already run into this and has a solution or might
> have some useful debugging ideas.
> 
> The first test we did was to run cyclictest[1] for comparison:
> 
>    3.2.35-rt52
>    # Total: 312028761 312028761 624057522
>    # Min Latencies: 00010 00011
>    # Avg Latencies: 00018 00020
>    # Max Latencies: 00062 00066 00066
>    # Histogram Overflows: 00000 00000 00000
> 
>    3.14.25-rt22
>    # Total: 304735655 304735657 609471312
>    # Min Latencies: 00013 00013
>    # Avg Latencies: 00023 00024
>    # Max Latencies: 00086 00083 00086
>    # Histogram Overflows: 00000 00000 00000
> 

I'm curious if the vanilla kernels (non-rt) show the same regression.

Max latencies for vanilla kernels will probably go through the roof,
but the min and average should give you some hint.

-- Steve
