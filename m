From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched: Fix compile warning when using CONFIG_PREEMPT_NONE
Date: Fri, 29 Jul 2016 17:46:02 +0200
Message-ID: <20160729154602.GF21715@linutronix.de>
References: <1467219311-19424-1-git-send-email-minyard@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Corey Minyard <cminyard@mvista.com>
To: minyard@acm.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:51897 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbcG2PqI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 Jul 2016 11:46:08 -0400
Content-Disposition: inline
In-Reply-To: <1467219311-19424-1-git-send-email-minyard@acm.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* minyard@acm.org | 2016-06-29 11:55:11 [-0500]:

>From: Corey Minyard <cminyard@mvista.com>
>
>preemptible_lazy() is only used under CONFIG_PREEMPT, but it was
>always defined.  Move it into a CONFIG_PREEMPT ifdef.

Oh sorry, I missed that one but the problem is gone, right?

Sebastian
