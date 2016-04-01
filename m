From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [rfc patch] drivers/block/zram: Replace bit spinlocks with
 rtmutex for -rt
Date: Fri, 1 Apr 2016 12:42:21 +0200
Message-ID: <20160401104221.GB29603@linutronix.de>
References: <1458641979.15742.6.camel@gmail.com>
 <20160330085622.GA21849@linutronix.de>
 <1459329836.4175.16.camel@gmail.com>
 <1459390108.4030.5.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52999 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbcDAKmY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Apr 2016 06:42:24 -0400
Content-Disposition: inline
In-Reply-To: <1459390108.4030.5.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Mike Galbraith | 2016-03-31 04:08:28 [+0200]:

>(fixed the missed bit spinlock whackage you pointed out)
thanks.

>drivers/block/zram: Replace bit spinlocks with rtmutex for -rt
>
>They're nondeterministic, and lead to ___might_sleep() splats in -rt.
>OTOH, they're a lot less wasteful than an rtmutex per page.
Applied.
Although I'm disapointed about Sergey's argument against the spinlock in
general due to a few bytes used by lockdep which can be disabled. Not to
mention the usefull debug facility lockdep provides if one decides to
use.

Sebastian
