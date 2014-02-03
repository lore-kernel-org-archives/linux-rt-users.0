From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [PATCH 1/2] irq_work: allow certain work in hard irq context
Date: Mon, 03 Feb 2014 03:43:19 +0100
Message-ID: <1391395399.5357.16.camel@marge.simpson.net>
References: <1391178845-15837-1-git-send-email-bigeasy@linutronix.de>
	 <1391314950.5444.18.camel@marge.simpson.net>
	 <52EEA643.1010200@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:61119 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752675AbaBCCnX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Feb 2014 21:43:23 -0500
In-Reply-To: <52EEA643.1010200@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2014-02-02 at 21:10 +0100, Sebastian Andrzej Siewior wrote:

> So CPU5 & CPU52 were eating 100% CPU doing "nothing" instead of runni=
ng
> cc1 & objdump right?

Yeah.

> According to the backtrace both of them are trying to access the
> per-cpu hrtimer (sched_timer) in order to cancel but they seem to fai=
l
> to get the timer lock here. They shouldn't spin there for minutes, I
> have no idea why they did so=E2=80=A6

I dumped it for later-guy.. but he tends to get busy doing other crap,
and just whacks my carefully saved data ;-)

> I guess this problem does not occur without -RT and before that patch
> you saw only that one warning from can_stop_full_tick()?

I didn't try it without -RT, and yes, without, you just get the warning=
=2E

-Mike

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
