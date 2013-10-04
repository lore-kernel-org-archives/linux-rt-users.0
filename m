From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 1/3] ipc/sem: fix -rt livelock
Date: Fri, 4 Oct 2013 12:44:50 +0200
Message-ID: <20131004104450.GB19953@linutronix.de>
References: <1379051751.5455.112.camel@marge.simpson.net>
 <1379052760.5455.127.camel@marge.simpson.net>
 <5234D94D.8010608@colorfullife.com>
 <1379220340.5545.93.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Manfred Spraul <manfred@colorfullife.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52992 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab3JDKov (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 06:44:51 -0400
Content-Disposition: inline
In-Reply-To: <1379220340.5545.93.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2013-09-15 06:45:40 [+0200]:

Hi,

>On Sat, 2013-09-14 at 23:46 +0200, Manfred Spraul wrote: 
>> Could you check that?
>
>I think you're right.
>
>> Or alternatively: Is my proposed sem_lock() function -rt friendly?
>
>Some way of making spin_unlock_wait() _go away_ along with the livelock
>would be better, but patches look good to me.  I'll apply both and stare
>at the sum, and ask boxen what they think.. they're better at spotting
>locking troubles ;-)

Do you post a new series of those three patches with the live lock
Manfred mentioned fixed or should I look at this serie?

>-Mike

Sebastian
