From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Old split quilt queues
Date: Fri, 29 Jan 2016 20:56:29 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1601292053330.3886@nanos>
References: <569D6AE1.2090301@ramses-pyramidenbau.de> <alpine.DEB.2.11.1601202151200.3575@nanos> <56AA25D6.3070701@ramses-pyramidenbau.de> <alpine.DEB.2.11.1601291210330.3886@nanos> <56ABAE2A.2030902@ramses-pyramidenbau.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:59012 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640AbcA2T5f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jan 2016 14:57:35 -0500
In-Reply-To: <56ABAE2A.2030902@ramses-pyramidenbau.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 29 Jan 2016, Ralf Ramsauer wrote:
> As I expected, inside that repo are a lot of tags for the various -rt
> versions.
> First I thought, RT would make use of rebasing, like:
>   - Rebase onto the next kernel version and drop unnecessary commits
> (e.g. patches that went upstream)
>   - Do some additional changes
>   - Export vA.B.C...vA.B.C-rtX as split quilt queue
> 
> But afaict, (at least on the old rt-history), you made a lot of merges
> from rt/* branches and added tags describing the -rt version. Then you
> went on merging against master in order to keep up with upstream.
> 
> Given that, how do you create a split quilt queue, that applies against
> an upstream tag?
> 
> For example, let's take the first RT Tag of rt-history: v2.6.31-rc6-rt2
> How would you create a split quilt queue, that applies against v2.6.31-rc6?
> 
> (I need to extract all those split quilt queues RT version<->base
> upstream version)

As I said before: That was an experiment whether git is usable as a tool to
manage something complex as rt. It turned out, that it's not. I recreated a
new quilt queue after I abondoned git for rt.

So creating split queues is going to be a very interesting and tedious
detective work.

Thanks,

	tglx
