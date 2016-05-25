From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RESEND -rt] mm: perform lru_add_drain_all() remotely
Date: Wed, 25 May 2016 17:59:44 +0200
Message-ID: <20160525155944.GA18036@linutronix.de>
References: <20160509105037.1555d0e0@redhat.com>
 <20160512084230.GA19035@linutronix.de>
 <20160512095149.2a6f7357@redhat.com>
 <20160512144943.GD19035@linutronix.de>
 <20160512155202.46666531@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, riel@redhat.com,
	tglx@linutronix.de, srostedt@redhat.com, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:40927 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751022AbcEYP7r (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 May 2016 11:59:47 -0400
Content-Disposition: inline
In-Reply-To: <20160512155202.46666531@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Luiz Capitulino | 2016-05-12 15:52:02 [-0400]:

>The alternative, which is what I had in mind, was to forward-port
>this change to mainline when local_locks gets merged upstream. But
>I guess this will only happen when sleeping spinlocks are merged?

Yeah, I am not sure about the exact path. Sleeping locks are not
required for this. Let me worry about this later. In the meantime I pick
up this (your v2) in -RT.

Sebastian
