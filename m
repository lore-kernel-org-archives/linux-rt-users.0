From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch] rt,workqueue: Fix blocking call when !TASK_RUNNING
 splat in rescuer_thread()
Date: Sat, 27 Feb 2016 14:48:06 +0100
Message-ID: <1456580886.3577.6.camel@gmail.com>
References: <1456556755.3759.4.camel@gmail.com>
	 <alpine.DEB.2.11.1602271015550.3638@nanos>
	 <1456575080.3577.3.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35517 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756241AbcB0NsK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 08:48:10 -0500
Received: by mail-wm0-f45.google.com with SMTP id l68so6684515wml.0
        for <linux-rt-users@vger.kernel.org>; Sat, 27 Feb 2016 05:48:09 -0800 (PST)
In-Reply-To: <1456575080.3577.3.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2016-02-27 at 13:11 +0100, Mike Galbraith wrote:
> On Sat, 2016-02-27 at 10:16 +0100, Thomas Gleixner wrote:
> > On Sat, 27 Feb 2016, Mike Galbraith wrote:
> > > [    0.221272] CPU: 1 PID: 69 Comm: khelper Not tainted 4.0.0-rt4
> > -lockdep #71
> > 
> > Can to verify that against some less random rt version?
> 
> Yeah, I'll remove the patch from 4.4-rt and see if it still happens. 
>  Patch has been moldering for quite a while.

Hohum, elves and gremlins at play I suppose.  I think it's safe to say
oh, never mind to that one.

	-Mike
