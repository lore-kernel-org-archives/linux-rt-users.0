From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 3.14.23-rt20 - softirq: resurrect softirq threads
Date: Tue, 17 Feb 2015 14:05:54 +0100
Message-ID: <20150217130553.GL26177@linutronix.de>
References: <20141031170326.1491a63f@gandalf.local.home>
 <1414910967.5380.81.camel@marge.simpson.net>
 <1414913507.5380.117.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43670 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932943AbbBQNF4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Feb 2015 08:05:56 -0500
Content-Disposition: inline
In-Reply-To: <1414913507.5380.117.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2014-11-02 08:31:47 [+0100]:

>(sirqs suck, this makes them suck less for some boxen/loads)
>
>Subject: softirq: resurrect softirq threads
>From: Mike Galbraith <mgalbraith@suse.de>
>Date: Mon Jan  6 08:42:11 CET 2014
>
>Some loads cannot tolerate the jitter induced by all softirqs being processed
>at the same priority.  Let the user prioritize them again.
>
>Signed-off-by: Mike Galbraith <mgalbraith@suse.de>

I'm going to postpone this. While it might make sense in general I'm
going to wait for tglx, Steven and others to see if this is what we want
or if there are some plans redoing the softirq handling.

Sebastian
