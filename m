From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch 0/6] 3.14-rt1 fixes
Date: Fri, 2 May 2014 15:44:08 +0200
Message-ID: <20140502134408.GF9178@linutronix.de>
References: <1399029159.5233.124.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: RT <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:41061 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaEBNoJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 09:44:09 -0400
Content-Disposition: inline
In-Reply-To: <1399029159.5233.124.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2014-05-02 13:12:39 [+0200]:

>drop: (buggy - calls migrate_disable() _after_ maybe blocking)
>migrate_disable-pushd-down-in-atomic_dec_and_spin_lo.patch

In the thread you quoted also the delayed migrated_disable in
rt_read_lock(). Is this one no longer required?

>-Mike

Sebastian
