From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Fri, 18 Aug 2017 14:44:06 +0200
Message-ID: <20170818124406.6cem4po52xrzi5qc@linutronix.de>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
 <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Jacek Konieczny <jajcus@jajcus.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:42100 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbdHRMoH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2017 08:44:07 -0400
Content-Disposition: inline
In-Reply-To: <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-08-14 20:03:26 [+0200], Jacek Konieczny wrote:
> On 2017-08-07 15:19, Sebastian Andrzej Siewior wrote:
> > One thing you could try, is to see if the latest v4.11 based RT kernel
> > works more reliable.
> 
> I tried 4.11.12-rt9 (with your patch applied, just in case). It worked
> find for a day and then failed like the older kernels:

I see. Could you try to enable lockdep and see if it yell in dmesg?
lockdep would be:
	CONFIG_DEBUG_RT_MUTEXES=y
	CONFIG_PROVE_LOCKING=y
	CONFIG_DEBUG_ATOMIC_SLEEP=y

> Jacek

Sebastian
