From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RESEND -rt] mm: perform lru_add_drain_all() remotely
Date: Thu, 12 May 2016 16:49:43 +0200
Message-ID: <20160512144943.GD19035@linutronix.de>
References: <20160509105037.1555d0e0@redhat.com>
 <20160512084230.GA19035@linutronix.de>
 <20160512095149.2a6f7357@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, riel@redhat.com,
	tglx@linutronix.de, srostedt@redhat.com, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:54107 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbcELOtq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 May 2016 10:49:46 -0400
Content-Disposition: inline
In-Reply-To: <20160512095149.2a6f7357@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luiz Capitulino | 2016-05-12 09:51:49 [-0400]:

>That's correct. This is an -RT patch for two reasons:
>
> 1. This solution builds on top of the per-cpu locks API implemented
>    by -RT and already in place in the pagevecs drain code
>
> 2. As SCHED_FIFO is the norm in -RT, the problem is more common there

more common so not RT-only. Would you people prefer this for mainline or
would you rather something else in case this needs to be fixed
mainline, too?

Sebastian
