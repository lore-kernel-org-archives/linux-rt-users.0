From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch] rt,workqueue: Fix blocking call when !TASK_RUNNING
 splat in rescuer_thread()
Date: Sat, 27 Feb 2016 13:11:20 +0100
Message-ID: <1456575080.3577.3.camel@gmail.com>
References: <1456556755.3759.4.camel@gmail.com>
	 <alpine.DEB.2.11.1602271015550.3638@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35673 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756330AbcB0MLY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 07:11:24 -0500
Received: by mail-wm0-f53.google.com with SMTP id l68so4958517wml.0
        for <linux-rt-users@vger.kernel.org>; Sat, 27 Feb 2016 04:11:24 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1602271015550.3638@nanos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2016-02-27 at 10:16 +0100, Thomas Gleixner wrote:
> On Sat, 27 Feb 2016, Mike Galbraith wrote:
> > [    0.221272] CPU: 1 PID: 69 Comm: khelper Not tainted 4.0.0-rt4
> -lockdep #71
> 
> Can to verify that against some less random rt version?

Yeah, I'll remove the patch from 4.4-rt and see if it still happens. 
 Patch has been moldering for quite a while.

	-Mike 
