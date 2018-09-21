Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:47660 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728149AbeIUWcS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Sep 2018 18:32:18 -0400
From: Julia Cartwright <julia@ni.com>
Subject: Re: [BUG] dw_wdt watchdog on linux-rt 4.18.5-rt4 not triggering
Date: Fri, 21 Sep 2018 16:42:04 +0000
Message-ID: <20180921164200.GS8562@jcartwri.amer.corp.natinst.com>
References: <73d0tbdjqz.fsf@pengutronix.de>
 <714e73d5-f7ce-bdcf-b7fd-fc9f02b12693@roeck-us.net>
 <20180919064619.soi27bbq3xtatpxp@pengutronix.de>
 <20180919194303.GA5033@roeck-us.net>
 <20180920204843.GY23084@jcartwri.amer.corp.natinst.com>
 <88588d0f-6673-cb45-85e1-537f69135c86@roeck-us.net>
In-Reply-To: <88588d0f-6673-cb45-85e1-537f69135c86@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E82F554E5C0CD04CBD4950AF0132F8DC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>, Tim Sander <tim@krieglstein.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, Christophe Leroy <christophe.leroy@c-s.fr>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

On Fri, Sep 21, 2018 at 06:34:24AM -0700, Guenter Roeck wrote:
> On 09/20/2018 01:48 PM, Julia Cartwright wrote:
> > On Wed, Sep 19, 2018 at 12:43:03PM -0700, Guenter Roeck wrote:
[..]
> > > Overall, we have a number possibilities to consider:
> > >=20
> > > - The kernel watchdog timer thread is not triggered at all under some
> > >    circumstances, meaning it is not set properly. So far we have no r=
eal
> > >    indication that this is the case (since the code works fine unless=
 some
> > >    userspace task takes all available CPU time).
> >=20
> > What do you mean by "not triggered".  Do you mean woken-up/activated
> > from a scheduling perspective?  In the case I identified in my other
> > email, the watchdogd thread wakeup doesn't even occur, even when the
> > periodic ping timer expires, because ktimersoftd has been starved.
> >=20
>=20
> Sorry for not using the correct term. Sometimes I am a bit sloppy.
> Yes, I meant "woken-up/activated from a scheduling perspective".

Thanks for the clarification.  I think we're on the same page. :)

> > I suspect that's what's going on for Steffen, but am not yet sure.
> >=20
> > > - The watchdog device is closed. The kernel watchdog timer thread is
> > >    starved and does not get to run. The question is what to do in thi=
s
> > >    situation. In a real time system, this is almost always a fatal
> > >    condition. Should the system really be kept alive in this situatio=
n ?
> >=20
> > Sometimes its the right decision, sometimes its not.  The only sensible
> > thing to do is to allow the user make the decision that's right for
> > their application needs by allowing the relative prioritization of
> > watchdogd and their application threads.
>
> Agreed, but that doesn't help if the watchdog daemon is not open or if th=
e
> hardware watchdog interval is too small and the kernel mechanism is neede=
d
> to ping the watchdog.

Makes sense.

> > ...which they can do now, but it's not effective on RT because of the
> > timer deferral through ktimersoftd.
> >=20
> > The solution, in my mind, and like I mentioned in my other email, is to
> > opt-out of the ktimersoftd-deferral mechanism.  This requires some
> > tweaking with the kthread_worker bits to ensure safety in hardirq
> > context, but that seems straightforward.  See the below.
>
> Makes sense to me, though I have no idea what it would take to push
> the necessary changes into the core kernel.

As of now, this bug doesn't exist in mainline because the hrtimer
deferral bits haven't landed yet, as you note below.

> However, I must be missing something: Looking into the kernel code,
> it seems to me that the spin_lock functions call the respective raw_
> spinlock functions right away. With that in mind, why would the kernel
> code change be necessary ? Also, I don't see HRTIMER_MODE_REL_HARD
> defined anywhere. Is this RT specific ?

Yes, there is no functional difference in mainline currently between a
spin_lock_t and a raw_spin_lock_t.  There is also no
HRTIMER_MODE_REL_HARD like mentioned before.  These are
features/concepts currently only in the RT tree, but should be making
their way into mainline soon.

As far as path forward, I'd like to get some confirmation from Steffen
and/or Tim that the proposed patch fixes their issue, then I'll cook
some proper patches; the kthread_worker bits could go mainline now
because there is no dependency, but the watchdog change will need to be
RT-only for now.

   Julia
