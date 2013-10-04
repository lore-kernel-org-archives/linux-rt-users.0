From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 1/3] ipc/sem: fix -rt livelock
Date: Fri, 04 Oct 2013 13:28:51 +0200
Message-ID: <524EA673.5050400@linutronix.de>
References: <1379051751.5455.112.camel@marge.simpson.net>  <1379052760.5455.127.camel@marge.simpson.net>  <5234D94D.8010608@colorfullife.com>  <1379220340.5545.93.camel@marge.simpson.net>  <20131004104450.GB19953@linutronix.de> <1380885410.5432.5.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Manfred Spraul <manfred@colorfullife.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <bitbucket@online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:53203 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab3JDL2y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 07:28:54 -0400
In-Reply-To: <1380885410.5432.5.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/04/2013 01:16 PM, Mike Galbraith wrote:
> Manfred's race fix also kills loop, and thereby the -rt livelock, so the
> only question is does -rt want to use his completion wakeup scheme, and
> does it want to do something about spin_unlock_wait() unconditionally
> grabbing/releasing every lock in the array.

So his patches went into v3.11 or so right? So all -RT released post
this point will have it fixed right?
However if this is something that bugs people using -RT it might worth
looking at it.

> -Mike
> 
Sebastian
