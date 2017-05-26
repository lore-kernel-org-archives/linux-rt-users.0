From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [PATCH] Revert "timers: Don't wake ktimersoftd on every tick"
Date: Fri, 26 May 2017 15:25:50 -0500
Message-ID: <4b4df775-53b8-cdeb-381b-af8cabb364a8@ni.com>
References: <20170203165151.qbpjothhaqctuzx5@linutronix.de>
 <20170203182112.18053-1-haris.okanovic@ni.com>
 <20170210170207.3kzfqyfa4ueh7mih@linutronix.de>
 <alpine.DEB.2.20.1705261911230.11993@hypnos.tec.linutronix.de>
 <faa23f3e-28c0-6de1-66a6-2b6ab5e99462@ni.com>
 <alpine.DEB.2.20.1705262147510.2137@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        julia.cartwright@ni.com, gratian.crisan@ni.com
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.20.1705262147510.2137@nanos>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Oh crap. I think I see the problem. I decrement expired_count before 
processing the list. Dropping the lock permits another run of 
tick_find_expired()->find_expired_timers() in the middle of 
__expire_timers() since it uses expired_count==0 as a condition.

This should fix it, but I'll wait for Anna-Maria's test next week before 
submitting a patch.

>  static void expire_timers(struct timer_base *base)
>  {
>         struct hlist_head *head;
> +       int expCount = base->expired_count;
>
> -       while (base->expired_count--) {
> -               head = base->expired_lists + base->expired_count;
> +       while (expCount--) {
> +               head = base->expired_lists + expCount;
>                 __expire_timers(base, head);
>         }
>         base->expired_count = 0;
>  }

Thanks,
Haris


On 05/26/2017 02:49 PM, Thomas Gleixner wrote:
> On Fri, 26 May 2017, Haris Okanovic wrote:
>
>> Anna-Maria,
>>
>> Look-ahead is implemented by tick_find_expired() and expiry by __run_timers(),
>> both of which hold timer_base::lock (raw spin lock) while running. Those two
>> routines shouldn't be able to run simultaneously on the same timer_base. Are
>> you sure the race isn't in another code path?
>
> It happens when softirq runs and drops the spinlock to call the timer
> function. And from there stuff goes down the drain.
>
> Anna-Maria will send you the test case on monday.
>
> Thanks,
>
> 	tglx
>
> 	
>
