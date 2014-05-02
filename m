From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [patch 0/6] 3.14-rt1 fixes
Date: Fri, 02 May 2014 15:45:49 +0200
Message-ID: <1399038349.5233.169.camel@marge.simpson.net>
References: <1399029159.5233.124.camel@marge.simpson.net>
	 <20140502134408.GF9178@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:58886 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbaEBNpx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 May 2014 09:45:53 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so3174577eek.6
        for <linux-rt-users@vger.kernel.org>; Fri, 02 May 2014 06:45:52 -0700 (PDT)
In-Reply-To: <20140502134408.GF9178@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2014-05-02 at 15:44 +0200, Sebastian Andrzej Siewior wrote: 
> * Mike Galbraith | 2014-05-02 13:12:39 [+0200]:
> 
> >drop: (buggy - calls migrate_disable() _after_ maybe blocking)
> >migrate_disable-pushd-down-in-atomic_dec_and_spin_lo.patch
> 
> In the thread you quoted also the delayed migrated_disable in
> rt_read_lock(). Is this one no longer required?

Steven submitted a patch for that.

-Mike

