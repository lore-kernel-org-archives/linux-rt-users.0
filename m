From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [rfc patch] drivers/block/zram: Replace bit spinlocks with
 rtmutex for -rt
Date: Mon, 4 Apr 2016 09:27:57 +0900
Message-ID: <20160404002756.GA6164@swordfish>
References: <1458641979.15742.6.camel@gmail.com>
 <20160330085622.GA21849@linutronix.de>
 <1459329836.4175.16.camel@gmail.com>
 <1459390108.4030.5.camel@gmail.com>
 <20160401104221.GB29603@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33466 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbcDDA1h (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 3 Apr 2016 20:27:37 -0400
Received: by mail-pa0-f46.google.com with SMTP id zm5so131888069pac.0
        for <linux-rt-users@vger.kernel.org>; Sun, 03 Apr 2016 17:27:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160401104221.GB29603@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On (04/01/16 12:42), Sebastian Andrzej Siewior wrote:
> >They're nondeterministic, and lead to ___might_sleep() splats in -rt.
> >OTOH, they're a lot less wasteful than an rtmutex per page.
> Applied.
> Although I'm disapointed about Sergey's argument against the spinlock in
> general due to a few bytes used by lockdep which can be disabled. Not to
> mention the usefull debug facility lockdep provides if one decides to
> use.

I'll take a look.

	-ss
