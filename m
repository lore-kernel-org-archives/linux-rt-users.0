From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] migrate_disable pushd down in rt_read_trylock
Date: Fri, 29 Nov 2013 16:14:01 +0100
Message-ID: <20131129151401.GD31099@linutronix.de>
References: <20131123005158.GA16338@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34814 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710Ab3K2POC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Nov 2013 10:14:02 -0500
Content-Disposition: inline
In-Reply-To: <20131123005158.GA16338@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Nicholas Mc Guire | 2013-11-23 01:51:58 [+0100]:

>>From 5c9a0c1510ec29c1e148f66f3c111f52f7565df1 Mon Sep 17 00:00:00 2001
>From: Nicholas Mc Guire <der.herr@hofr.at>
>Date: Fri, 22 Nov 2013 02:41:48 -0500
>Subject: [PATCH] migrate_disable pushd down in rt_read_trylock
>
> No need to migrate_disable before requesting the lock and no need to 
> speculatively disable/enable on every recursive call. migration_disable 
> can be done at the latest point in the code before returning an acquired 
> ``lock.
>
> patch is on top of 3.12-rt2
>
> No change of functionality
Applied without this line.

>Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>

Sebastian
