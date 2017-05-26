From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Revert "timers: Don't wake ktimersoftd on every tick"
Date: Fri, 26 May 2017 21:49:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1705262147510.2137@nanos>
References: <20170203165151.qbpjothhaqctuzx5@linutronix.de> <20170203182112.18053-1-haris.okanovic@ni.com> <20170210170207.3kzfqyfa4ueh7mih@linutronix.de> <alpine.DEB.2.20.1705261911230.11993@hypnos.tec.linutronix.de>
 <faa23f3e-28c0-6de1-66a6-2b6ab5e99462@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        julia.cartwright@ni.com, gratian.crisan@ni.com
To: Haris Okanovic <haris.okanovic@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <faa23f3e-28c0-6de1-66a6-2b6ab5e99462@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 26 May 2017, Haris Okanovic wrote:

> Anna-Maria,
> 
> Look-ahead is implemented by tick_find_expired() and expiry by __run_timers(),
> both of which hold timer_base::lock (raw spin lock) while running. Those two
> routines shouldn't be able to run simultaneously on the same timer_base. Are
> you sure the race isn't in another code path?

It happens when softirq runs and drops the spinlock to call the timer
function. And from there stuff goes down the drain.

Anna-Maria will send you the test case on monday.

Thanks,

	tglx

	
