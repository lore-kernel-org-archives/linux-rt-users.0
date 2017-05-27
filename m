From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] Revert "timers: Don't wake ktimersoftd on every tick"
Date: Sat, 27 May 2017 09:47:47 +0200
Message-ID: <20170527074746.6w7vakbuelurs245@linutronix.de>
References: <20170203165151.qbpjothhaqctuzx5@linutronix.de>
 <20170203182112.18053-1-haris.okanovic@ni.com>
 <20170210170207.3kzfqyfa4ueh7mih@linutronix.de>
 <alpine.DEB.2.20.1705261911230.11993@hypnos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Haris Okanovic <haris.okanovic@ni.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, julia.cartwright@ni.com, gratian.crisan@ni.com
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1705261911230.11993@hypnos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-05-26 19:16:07 [+0200], Anna-Maria Gleixner wrote:
> This reverts commit 032f93cae150a.
> 
> The problem is that the look ahead optimization from the tick timer
> interrupt context can race with the softirq thread expiring timer. As
> a consequence the temporary hlist heads which hold the to expire
> timers are overwritten and the timers which are already removed from
> the wheel bucket for expiry are now dangling w/o a list head.
> 
> That means those timers never get expired. If one of those timers is
> canceled the removal operation will result in a hlist corruption.
> 
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

Applied

Sebastian
