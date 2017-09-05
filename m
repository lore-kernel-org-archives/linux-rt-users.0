From: Jacek Konieczny <jajcus@jajcus.net>
Subject: Re: RT kernel on Acer laptop unreliable
Date: Tue, 5 Sep 2017 21:37:48 +0200
Message-ID: <6def1dd2-eaae-a5d2-8bdb-26070ee5de7a@jajcus.net>
References: <8c1a0cb6-d90c-1f6f-2d23-9865a17b379e@jajcus.net>
 <20170807131937.ijj7n4yuk6inds4h@linutronix.de>
 <56cb9f42-83e3-6648-2489-7c9e486c8ecc@jajcus.net>
 <20170818124406.6cem4po52xrzi5qc@linutronix.de>
 <b1209f35-67a2-5cb2-d0e1-ad142b34aab9@jajcus.net>
 <20170821131254.5nuacfv62d3l4rhe@linutronix.de>
 <52e67cfd-0bb3-ce97-7b28-f2afb1d3c1cb@jajcus.net>
 <20170905091712.koywolqt5qwaslpk@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tropek.jajcus.net ([31.179.132.94]:57182 "EHLO
        tropek.jajcus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbdIETh6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 5 Sep 2017 15:37:58 -0400
In-Reply-To: <20170905091712.koywolqt5qwaslpk@linutronix.de>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-09-05 11:17, Sebastian Andrzej Siewior wrote:
> On 2017-08-23 19:04:20 [+0200], Jacek Konieczny wrote:
>> I have applied the patch, no crash since then, but I got another problem
>> detected:
> I'm sorry, I missed that.

No problem. I was away on my holidays anyway.

> What about this on-top?

That would not apply on top of my previous source, but I took
patch-4.11.12-rt13.patch and applied over that. I should have some
results in a few days.

Jacek
