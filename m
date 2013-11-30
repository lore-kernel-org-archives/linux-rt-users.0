From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] migrate_disable pushd down in rt_read_trylock
Date: Sat, 30 Nov 2013 03:30:26 +0100
Message-ID: <20131130023026.GB8114@opentech.at>
References: <20131123005158.GA16338@opentech.at> <20131129151401.GD31099@linutronix.de> <20131129154425.GE31099@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:53882 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898Ab3K3Ca2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 21:30:28 -0500
Content-Disposition: inline
In-Reply-To: <20131129154425.GE31099@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 29 Nov 2013, Sebastian Andrzej Siewior wrote:

> * Sebastian Andrzej Siewior | 2013-11-29 16:14:01 [+0100]:
> 
> >* Nicholas Mc Guire | 2013-11-23 01:51:58 [+0100]:
> >
> >>>From 5c9a0c1510ec29c1e148f66f3c111f52f7565df1 Mon Sep 17 00:00:00 2001
> >>From: Nicholas Mc Guire <der.herr@hofr.at>
> >>Date: Fri, 22 Nov 2013 02:41:48 -0500
> >>Subject: [PATCH] migrate_disable pushd down in rt_read_trylock
> >>
> >> No need to migrate_disable before requesting the lock and no need to 
> >> speculatively disable/enable on every recursive call. migration_disable 
> >> can be done at the latest point in the code before returning an acquired 
> >> ``lock.
> >>
> >> patch is on top of 3.12-rt2
> >>
> >> No change of functionality
> >Applied without this line.
> 
> and dropped because there is a problem with this:
> - Now 
>   if you read_lock() and then read_try_lock() then migrate_disable() is
>   called by each caller. Also on read_unlock() migrate_enable() is called
>   by each caller.
> 
> - with patch
>   read_lock() calls migrate_disable() and read_try_lock() does not. Both
>   get the lock. So on read_unlock(), the read_try_lock() owner remains
>   unbalanced.
> 
> disabling migration prior incrementing read_depth should fix this.
>
yup - that one is broken - interesting that the boxes run happily for 
days now with this bug applied :)
4core i3 and a 4core i7

So the fix would be to do the push_down into rt_read_lock and then 
balance it in read_unlock conditioned on read_depth reaching 0.

have a few more cleanups - will give them another scan if I missed 
this in any of the others.

thx!
hofrat 
