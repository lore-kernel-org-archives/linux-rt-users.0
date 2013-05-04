From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [RFC PATCH] rt, lockdep: double
 MAX_LOCKDEP_ENTRIES/MAX_LOCKDEP_CHAINS_BITS
Date: Sat, 04 May 2013 08:55:59 +0200
Message-ID: <1367650559.5835.6.camel@marge.simpson.net>
References: <1366787475.5977.16.camel@marge.simpson.net>
	 <20130503160312.GE8230@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56864 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753772Ab3EDG4D (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 May 2013 02:56:03 -0400
In-Reply-To: <20130503160312.GE8230@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-05-03 at 18:03 +0200, Sebastian Andrzej Siewior wrote: 
> * Mike Galbraith | 2013-04-24 09:11:15 [+0200]:
> 
> >Test driving v3.6-rt, lockdep shuts itself off soon after boot.
> >
> >[  117.940497] BUG: MAX_LOCKDEP_ENTRIES too low!
> >[  117.940498] turning off the locking correctness validator.
> >[  117.940502] Pid: 5242, comm: kio_trash Not tainted 3.6.11.1-rt32-smp #51
> >
> >Doubling MAX_LOCKDEP_ENTRIES/MAX_LOCKDEP_CHAINS_BITS appeased it.  Box
> >has been up for an hour without lockdep taking it's toys and going home.
> 
> Can you send me your .config offlist please? I haven't seen this yet.

Done.

-Mike

