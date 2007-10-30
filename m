From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] remove in_interrupt() BUG_ON in exit path
Date: Tue, 30 Oct 2007 19:44:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710301939340.31349@gandalf.stny.rr.com>
References: <20071030224004.417523706@mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, kraj@mvista.com
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:45881 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095AbXJ3XoU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Oct 2007 19:44:20 -0400
In-Reply-To: <20071030224004.417523706@mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
On Tue, 30 Oct 2007, Daniel Walker wrote:

> As you can see from the patch there is already a case to catch this type
> of problem. This BUG_ON() adds a resursive OOPS , since BUG() causes an OOPS
> and the OOPS just calls do_exit() , and do_exit() just causes another OOPS with
> this BUG_ON().. If we call panic() here then it's clear what the problem was,
> instead of causing an endless recursive crash.
>
> Signed-off-by: Daniel Walker <dwalker@mvista.com>
>
> ---
>  kernel/exit.c |    1 -
>  1 file changed, 1 deletion(-)
>
> Index: linux-2.6.23.1/kernel/exit.c
> ===================================================================
> --- linux-2.6.23.1.orig/kernel/exit.c
> +++ linux-2.6.23.1/kernel/exit.c
> @@ -895,7 +895,6 @@ fastcall NORET_TYPE void do_exit(long co
>
>  	WARN_ON(atomic_read(&tsk->fs_excl));
>
> -	BUG_ON(in_interrupt());
>  	if (unlikely(in_interrupt()))
>  		panic("Aiee, killing interrupt handler!");
>  	if (unlikely(!tsk->pid))

I did this change once before, while debugging. I had the same issue. This
BUG_ON was giving me recursive crashes that prevented me knowing WTF was
going on.  I thought I even submitted a patch to remove it. Perhaps I
forgot to. Nope, I did!

http://www.ussg.iu.edu/hypermail/linux/kernel/0707.0/1804.html

Since the change is added by the preempt-realtime-core.patch, I'll just
remove it from there.

IOW, I'll fold this into that patch.

-- Steve
