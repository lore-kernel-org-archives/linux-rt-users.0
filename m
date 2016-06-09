From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: RT trees fail ltp futex_wait04  - culprit=65d8fc777f6d (futex:
 Remove requirement for lock_page() in get_futex_key())
Date: Thu, 9 Jun 2016 14:04:00 +0200
Message-ID: <20160609120400.GA6305@linutronix.de>
References: <1465052027.4104.19.camel@gmail.com>
 <1465056478.4212.3.camel@gmail.com>
 <1465057019.4178.0.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:51523 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751240AbcFIMED (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jun 2016 08:04:03 -0400
Content-Disposition: inline
In-Reply-To: <1465057019.4178.0.camel@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

- Mel, tglx
* Mike Galbraith | 2016-06-04 18:16:59 [+0200]:

>On Sat, 2016-06-04 at 18:07 +0200, Mike Galbraith wrote:
>> Oho, actually, it's not only RT kernels, master with an enterprise like
>> NOPREEMPT config fails as well, so it's a garden variety regression.
>> 
>> futex_wake04    1  TFAIL  :  futex_wake04.c:126: Bug: wait_thread2 did not wake after 30 secs.
>
>And again, swiped bits fixed it.

for reference, this thread ends here:
  http://git.kernel.org/tip/077fa7aed17de5022e44bf07dbaf732078b7b5b2

Sebastian
