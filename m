From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: replacement of tasklet_hrtimer_init in RT
Date: Thu, 26 Oct 2017 17:40:25 +0200
Message-ID: <20171026154024.wtasnkdenoqhbwvx@linutronix.de>
References: <69d8d76f1173a449bce4a3bc3a9e1a06.squirrel@email.powweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Chris Caudle <chris@chriscaudle.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:59561 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932415AbdJZPk0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Oct 2017 11:40:26 -0400
Content-Disposition: inline
In-Reply-To: <69d8d76f1173a449bce4a3bc3a9e1a06.squirrel@email.powweb.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-10-24 11:33:46 [-0500], Chris Caudle wrote:
> I recently began helping someone test a new multimedia driver (network
> audio) and found that the driver would not compile on my machine running
> an RT kernel because the driver used tasklet_hrtimer_init(), but that
> function is not defined in interrupt.h in the RT  patched kernel.
> 
> What should be used in place of that, and where should be look for
> documentation describing any differences that need to be accomodated?

So what you want to do in -RT right now is to use something like the
mac80211_hwsim.c:
	https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.13.y-rt&id=29158ad20a5363c581110497f430fa98b4280c5c
	
but I will update that softirq patch I have now in tree with the
version which is staged for upstream and then it will change slightly:
	https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=WIP.timers&id=77d37439a5b64036c1c168752a95e80f6ebe241a

Sebastian
