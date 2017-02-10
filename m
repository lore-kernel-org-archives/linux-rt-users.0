From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] timers: Don't wake ktimersoftd on every tick
Date: Fri, 10 Feb 2017 18:02:08 +0100
Message-ID: <20170210170207.3kzfqyfa4ueh7mih@linutronix.de>
References: <20170203165151.qbpjothhaqctuzx5@linutronix.de>
 <20170203182112.18053-1-haris.okanovic@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com
To: Haris Okanovic <haris.okanovic@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170203182112.18053-1-haris.okanovic@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-02-03 12:21:12 [-0600], Haris Okanovic wrote:
> Collect expired timers in interrupt context to avoid overhead of waking
> ktimersoftd on every tick. ktimersoftd now wakes only when one or more
> timers are ready, which yields a minor reduction in small latency spikes.
> 
> This is implemented by storing lists of expired timers in timer_base,
> updated on each tick. Any addition to the lists wakes ktimersoftd
> (softirq) to process those timers.
> 
> Please refer to the following RFC threads for more details:
> https://www.spinics.net/lists/linux-rt-users/msg16095.html
> https://www.spinics.net/lists/linux-rt-users/msg16113.html
> 
> Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>

applied.

Sebastian
