From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH [RT] 08/14] add a loop counter based timeout mechanism
Date: Thu, 21 Feb 2008 17:41:09 +0100
Message-ID: <200802211741.10299.ak@suse.de>
References: <20080221152504.4804.8724.stgit@novell1.haskins.net> <20080221152707.4804.59177.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, a.p.zijlstra@chello.nl, tglx@linutronix.de,
	rostedt@goodmis.org, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, bill.huey@gmail.com,
	kevin@hilman.org, cminyard@mvista.com, dsingleton@mvista.com,
	dwalker@mvista.com, npiggin@suse.de, dsaxena@plexity.net,
	gregkh@suse.de, sdietrich@novell.com, pmorreale@novell.com,
	mkohari@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:35741 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755411AbYBUQmA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 21 Feb 2008 11:42:00 -0500
In-Reply-To: <20080221152707.4804.59177.stgit@novell1.haskins.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> +config RTLOCK_DELAY
> +	int "Default delay (in loops) for adaptive rtlocks"
> +	range 0 1000000000
> +	depends on ADAPTIVE_RTLOCK

I must say I'm not a big fan of putting such subtle configurable numbers
into Kconfig. Compilation is usually the wrong place to configure
such a thing. Just having it as a sysctl only should be good enough.

> +	default "10000"

Perhaps you can expand how you came up with that default number? 
It looks suspiciously round and worse the actual spin time depends a lot on the 
CPU frequency (so e.g. a 3Ghz CPU will likely behave quite 
differently from a 2Ghz CPU) Did you experiment with other spin times? 
Should it be scaled with number of CPUs? And at what point is real
time behaviour visibly impacted? 

Most likely it would be better to switch to something that is more
absolute time, like checking RDTSC every few iteration similar to what
udelay does. That would be at least constant time.

-Andi
