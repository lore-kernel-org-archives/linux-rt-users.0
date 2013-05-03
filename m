From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC PATCH] rt, lockdep: double
 MAX_LOCKDEP_ENTRIES/MAX_LOCKDEP_CHAINS_BITS
Date: Fri, 3 May 2013 18:03:12 +0200
Message-ID: <20130503160312.GE8230@linutronix.de>
References: <1366787475.5977.16.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:45947 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933207Ab3ECQDN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 May 2013 12:03:13 -0400
Content-Disposition: inline
In-Reply-To: <1366787475.5977.16.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2013-04-24 09:11:15 [+0200]:

>Test driving v3.6-rt, lockdep shuts itself off soon after boot.
>
>[  117.940497] BUG: MAX_LOCKDEP_ENTRIES too low!
>[  117.940498] turning off the locking correctness validator.
>[  117.940502] Pid: 5242, comm: kio_trash Not tainted 3.6.11.1-rt32-smp #51
>
>Doubling MAX_LOCKDEP_ENTRIES/MAX_LOCKDEP_CHAINS_BITS appeased it.  Box
>has been up for an hour without lockdep taking it's toys and going home.

Can you send me your .config offlist please? I haven't seen this yet.

Sebastian
