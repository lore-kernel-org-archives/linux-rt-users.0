From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch] rt,workqueue: Fix blocking call when !TASK_RUNNING splat
 in rescuer_thread()
Date: Sat, 27 Feb 2016 10:16:42 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1602271015550.3638@nanos>
References: <1456556755.3759.4.camel@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35462 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316AbcB0JSC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 27 Feb 2016 04:18:02 -0500
In-Reply-To: <1456556755.3759.4.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 27 Feb 2016, Mike Galbraith wrote:
> [    0.221272] CPU: 1 PID: 69 Comm: khelper Not tainted 4.0.0-rt4-lockdep #71

Can to verify that against some less random rt version?

Thanks,

	tglx
