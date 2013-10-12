From: Mike Galbraith <bitbucket@online.de>
Subject: Re: [patch 1/3] ipc/sem: fix -rt livelock
Date: Sat, 12 Oct 2013 06:34:57 +0200
Message-ID: <1381552497.5442.47.camel@marge.simpson.net>
References: <1379051751.5455.112.camel@marge.simpson.net>
	 <1379052760.5455.127.camel@marge.simpson.net>
	 <5234D94D.8010608@colorfullife.com>
	 <1379220340.5545.93.camel@marge.simpson.net>
	 <20131004104450.GB19953@linutronix.de>
	 <1380885410.5432.5.camel@marge.simpson.net>
	 <524EA673.5050400@linutronix.de>
	 <1380894919.5432.12.camel@marge.simpson.net>
	 <524ECA5F.1090803@colorfullife.com>
	 <1380895727.5432.16.camel@marge.simpson.net>
	 <20131011153627.GJ6983@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Manfred Spraul <manfred@colorfullife.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54435 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736Ab3JLEfN (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 12 Oct 2013 00:35:13 -0400
In-Reply-To: <20131011153627.GJ6983@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2013-10-11 at 17:36 +0200, Sebastian Andrzej Siewior wrote:

> Is this the only one needed:
> 
> commit 5e9d527591421ccdb16acb8c23662231135d8686
> Author: Manfred Spraul <manfred@colorfullife.com>
> Date:   Mon Sep 30 13:45:04 2013 -0700
> 
>     ipc/sem.c: fix race in sem_lock()

That fixes the only killer I hit in generic beating.
> Or is there more? This is the commit I've seen that is tagged stable and
> for v3.10+.

It may also want part of this one... 
     53dad6d3a8e5ac1af8bacc6ac2134ae1a8b085f1 ipc: fix race with LSMs
..this one..
     d8c633766ad88527f25d9f81a5c2f083d78a2b39 ipc/sem.c: synchronize the proc interface
..and this one from mmotm.
     ipc-semc-synchronize-semop-and-semctl-with-ipc_rmid.patch

I didn't look hard though, that's just what sticks out when I look at my
ipc 3.10... wedged into 3.10-rt list.

-Mike

