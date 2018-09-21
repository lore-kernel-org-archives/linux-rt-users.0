Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43821 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390726AbeIVCMB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Sep 2018 22:12:01 -0400
Date: Fri, 21 Sep 2018 13:21:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [BUG] dw_wdt watchdog on linux-rt 4.18.5-rt4 not triggering
Message-ID: <20180921202129.GA30613@roeck-us.net>
References: <73d0tbdjqz.fsf@pengutronix.de>
 <714e73d5-f7ce-bdcf-b7fd-fc9f02b12693@roeck-us.net>
 <20180919064619.soi27bbq3xtatpxp@pengutronix.de>
 <20180919194303.GA5033@roeck-us.net>
 <20180920204843.GY23084@jcartwri.amer.corp.natinst.com>
 <88588d0f-6673-cb45-85e1-537f69135c86@roeck-us.net>
 <20180921164200.GS8562@jcartwri.amer.corp.natinst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921164200.GS8562@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: Tim Sander <tim@krieglstein.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Christophe Leroy <christophe.leroy@c-s.fr>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On Fri, Sep 21, 2018 at 04:42:04PM +0000, Julia Cartwright wrote:
> On Fri, Sep 21, 2018 at 06:34:24AM -0700, Guenter Roeck wrote:
> > On 09/20/2018 01:48 PM, Julia Cartwright wrote:
> > > On Wed, Sep 19, 2018 at 12:43:03PM -0700, Guenter Roeck wrote:
> [..]
> > > > Overall, we have a number possibilities to consider:
> > > > 
> > > > - The kernel watchdog timer thread is not triggered at all under some
> > > >    circumstances, meaning it is not set properly. So far we have no real
> > > >    indication that this is the case (since the code works fine unless some
> > > >    userspace task takes all available CPU time).
> > > 
> > > What do you mean by "not triggered".  Do you mean woken-up/activated
> > > from a scheduling perspective?  In the case I identified in my other
> > > email, the watchdogd thread wakeup doesn't even occur, even when the
> > > periodic ping timer expires, because ktimersoftd has been starved.
> > > 
> > 
> > Sorry for not using the correct term. Sometimes I am a bit sloppy.
> > Yes, I meant "woken-up/activated from a scheduling perspective".
> 
> Thanks for the clarification.  I think we're on the same page. :)
> 
> > > I suspect that's what's going on for Steffen, but am not yet sure.
> > > 
> > > > - The watchdog device is closed. The kernel watchdog timer thread is
> > > >    starved and does not get to run. The question is what to do in this
> > > >    situation. In a real time system, this is almost always a fatal
> > > >    condition. Should the system really be kept alive in this situation ?
> > > 
> > > Sometimes its the right decision, sometimes its not.  The only sensible
> > > thing to do is to allow the user make the decision that's right for
> > > their application needs by allowing the relative prioritization of
> > > watchdogd and their application threads.
> >
> > Agreed, but that doesn't help if the watchdog daemon is not open or if the
> > hardware watchdog interval is too small and the kernel mechanism is needed
> > to ping the watchdog.
> 
> Makes sense.
> 
> > > ...which they can do now, but it's not effective on RT because of the
> > > timer deferral through ktimersoftd.
> > > 
> > > The solution, in my mind, and like I mentioned in my other email, is to
> > > opt-out of the ktimersoftd-deferral mechanism.  This requires some
> > > tweaking with the kthread_worker bits to ensure safety in hardirq
> > > context, but that seems straightforward.  See the below.
> >
> > Makes sense to me, though I have no idea what it would take to push
> > the necessary changes into the core kernel.
> 
> As of now, this bug doesn't exist in mainline because the hrtimer
> deferral bits haven't landed yet, as you note below.
> 
> > However, I must be missing something: Looking into the kernel code,
> > it seems to me that the spin_lock functions call the respective raw_
> > spinlock functions right away. With that in mind, why would the kernel
> > code change be necessary ? Also, I don't see HRTIMER_MODE_REL_HARD
> > defined anywhere. Is this RT specific ?
> 
> Yes, there is no functional difference in mainline currently between a
> spin_lock_t and a raw_spin_lock_t.  There is also no
> HRTIMER_MODE_REL_HARD like mentioned before.  These are
> features/concepts currently only in the RT tree, but should be making
> their way into mainline soon.
> 
> As far as path forward, I'd like to get some confirmation from Steffen
> and/or Tim that the proposed patch fixes their issue, then I'll cook
> some proper patches; the kthread_worker bits could go mainline now
> because there is no dependency, but the watchdog change will need to be
> RT-only for now.
> 
SGTM.

Thanks,
Guenter
