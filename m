From: Pintu Kumar <pintu.ping@gmail.com>
Subject: Re: [PREEMPT_RT]: Using printk-rt-aware.patch in non-rt kernel
Date: Thu, 26 Jul 2018 23:38:05 +0530
Message-ID: <CAOuPNLgXNMm20nuPPDtUoy3qTF9MLDTRNmsOsocYYLrXtS0rBg@mail.gmail.com>
References: <CAOuPNLiK9tdHF6k+mNSqEQG92hA9oo4C+obhiwpjVOi_zaBZXw@mail.gmail.com>
 <CAOuPNLhTBdzj8B_u9f7FLXHwaA5KYVwPoy87LaZNhzLxbuifaQ@mail.gmail.com> <20180726153857.abxfebvxjcp4jqgx@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
To: sebastian.siewior@linutronix.de
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180726153857.abxfebvxjcp4jqgx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jul 26, 2018 at 9:08 PM Sebastian Andrzej Siewior
<sebastian.siewior@linutronix.de> wrote:
>
> On 2018-07-18 20:19:15 [+0530], Pintu Kumar wrote:
> > Hi All,
> Hi,
>
> > I have a question about PREEMPT_RT patch for 3.10 kernel.
> > I am trying to port this rt patch: 0224-printk-rt-aware.patch.patch
> > (see the patch below), in non-rt kernel.
> > I could able to successfully apply this patch after replacing:
> > migrate_enable/disable with preempt_enable/disable.
> > Things were working fine so far.
>
> Why?
>
> > Then, I noticed that "printk" from interrupt context is not appearing
> > on console (minicom), if console shell is active.
> > However, it appears on the dmesg output.
> >
> > So, I am wondering, what could be the cause of this patch for this
> > behavior in non-rt kernel?
> > Is this the expected behavior, even on PREEMPT_RT kernel?
>
> I *think* it is but there are hardly any prints from atomic context for
> anyone to notice. And the next print from non-atomic context should
> flush it out.
>
Yes, we observed the same behavior with CONFIG_PREEMPT_RT_FULL with
beagle bone-rt kernel 4.9.
And yes, after doing : echo "1234" > /dev/kmsg the content were flushed.
So, I guess this is the expected behavior with this patch.

> > Is there a way we can fix this issue on non-rt kernel?
> I would guess that a wakeup to klogd would fix it.
>
Sorry, can you elaborate more about "wakeup to klogd".
I wanted to try it and check.

> > Please help us with your suggestions.
> >
> > Thanks,
> > Pintu
>
> Sebastian
