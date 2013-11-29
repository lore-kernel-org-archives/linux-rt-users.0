From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [3.4-rt] backport of completion-use-simple-wait-queues.patch
Date: Fri, 29 Nov 2013 18:29:47 -0500
Message-ID: <20131129232946.GA31239@windriver.com>
References: <20131128201029.GA28966@windriver.com>
 <20131129124931.GA31099@linutronix.de>
 <5298AE91.6010309@windriver.com>
 <20131129172155.64ac1eef@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	<linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:45125 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab3K2X3o (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 18:29:44 -0500
Content-Disposition: inline
In-Reply-To: <20131129172155.64ac1eef@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

[Re: [3.4-rt] backport of completion-use-simple-wait-queues.patch] On 29/11/2013 (Fri 17:21) Steven Rostedt wrote:

> Burp!  /me is still recovering from Turkey day.

I'm jealous.  :)   [and now craving turkey...]

> 
> On Fri, 29 Nov 2013 10:11:13 -0500
> Paul Gortmaker <paul.gortmaker@windriver.com> wrote:
> 
> > 
> > Thanks for spotting that.  I guess the completion patch wouldn't hurt
> > to be in 3.4-rt anyway, but it is more a feature than a fix, it now seems.
> > [Not sure if Steve is still adding to the v3.4-rt-features branch...]
> 
> If people actually showed real interest for that branch, I would. But I
> haven't heard anything about anyone using it, so I haven't wasted my
> time on it.

So while we've not used it directly, we have definitely used the content
on that branch (i.e. rebasing to latest stable and logistical details
like that that would preclude direct use).  And while having it on
3.4-rt-features wasn't critically important, in that the content was
obviously present on newer releases, it did add a certain value in the
fact that folks in the know were indicating that the backports made
sense, and it wasn't just me alone wondering if the backport was valid.

With all the RT releases, and doing some stable baseline releases to
support them that you do, I'd not want to say that 3.4-rt-features
should get any special attention.  But at the same time, I'd not want
you to think it was a complete waste of time either.  I expect it is the
same for others, but in the typical haste of getting things done, and
the general level of "silent" users that was discussed at RTLWS, I do
suspect that once again, unfortunately nobody has bothered to
actually explicitly say "hey, thanks - we are glad this exists".

So, I'll start  -- thanks Steve. :)

Too little, too late?  Perhaps.  But better late than never, I hope.
`
Paul.
