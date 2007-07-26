From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH rt[78]] Update externs in wait.h
Date: Thu, 26 Jul 2007 10:37:39 +0200
Message-ID: <20070726083739.GB27774@elte.hu>
References: <1185438039.17414.64.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	RT Users List <linux-rt-users@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:49465 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933376AbXGZIhr (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 04:37:47 -0400
Content-Disposition: inline
In-Reply-To: <1185438039.17414.64.camel@sx.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Sven-Thorsten Dietrich <sven@thebigcorporation.com> wrote:

> This patch syncs up the extern declarations with the changes in 
> sched.c made in rt7 (drop FASTCALL, change signed long to long)
> 
> This fixes a compile error in my debug config for i386.

thx, applied.

	Ingo
