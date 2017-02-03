From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC v2] timers: Don't wake ktimersoftd on every tick
Date: Fri, 3 Feb 2017 17:51:51 +0100
Message-ID: <20170203165151.qbpjothhaqctuzx5@linutronix.de>
References: <20161213214405.28554-1-haris.okanovic@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com
To: Haris Okanovic <haris.okanovic@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:44817 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbdBCQvz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Feb 2017 11:51:55 -0500
Content-Disposition: inline
In-Reply-To: <20161213214405.28554-1-haris.okanovic@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-12-13 15:44:05 [-0600], Haris Okanovic wrote:
> Changed the way timers are collected per Julia and Thomas'
> recommendation: Expired timers are now collected in interrupt context
> and fired in ktimersoftd to avoid double-walk of `pending_map`.
…
> Thanks,
> Haris

I've been staring at it for a while now and now I applied it locally and
look how it goes.
I would need that patch signed as per
	https://kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
if you want it applied.
> ---
>  kernel/time/timer.c | 97 ++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 67 insertions(+), 30 deletions(-)

Sebastian
