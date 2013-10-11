From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 1/3] ipc/sem: fix -rt livelock
Date: Fri, 11 Oct 2013 17:36:27 +0200
Message-ID: <20131011153627.GJ6983@linutronix.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Manfred Spraul <manfred@colorfullife.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34341 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754807Ab3JKPg3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 11:36:29 -0400
Content-Disposition: inline
In-Reply-To: <1380895727.5432.16.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2013-10-04 16:08:47 [+0200]:

>Cool, that works out rather nicely.  I looked at fixing it, and couldn't
>figure out what the heck was wrong with it :)

Is this the only one needed:

commit 5e9d527591421ccdb16acb8c23662231135d8686
Author: Manfred Spraul <manfred@colorfullife.com>
Date:   Mon Sep 30 13:45:04 2013 -0700

    ipc/sem.c: fix race in sem_lock()

Or is there more? This is the commit I've seen that is tagged stable and
for v3.10+.

>-Mike

Sebastian
