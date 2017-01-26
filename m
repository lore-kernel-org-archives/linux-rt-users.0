From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: wake_up does not return
Date: Thu, 26 Jan 2017 17:57:53 +0100
Message-ID: <20170126165752.lsjdyuheyvzwjess@linutronix.de>
References: <CAAVaN8wqmh9qYYU7TXR58-0=5Lk_s1vMcdHKdWEp4Ln9iEf=wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Andy Ng <andreas2025@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:49895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753368AbdAZRPN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Jan 2017 12:15:13 -0500
Content-Disposition: inline
In-Reply-To: <CAAVaN8wqmh9qYYU7TXR58-0=5Lk_s1vMcdHKdWEp4Ln9iEf=wg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-01-25 13:54:15 [+0000], Andy Ng wrote:
> Dear List,
> 
> I have an interesting problem on 3.0.35 with the rt56 patch on ARM.
> 
> I have some external events that drive my ISR, which I have set it up
> as non_threaded one.
> When the interrupt rate is low, 1.8msec things are going fine, but
> when the rate is higher, the wake_up call from the isr does not
> return. The system is frozen. No Magic SysRq. Nothing.
> 
> All will work fine once I change my ISR to be a threaded one.
> 
> Any ideas where to search?

If you you enable lockdep and sleeping-while-atomic warning you should
see quite a few warnings. That would be a good starting point to search.

> Kind regards,
> Andy

Sebastian
