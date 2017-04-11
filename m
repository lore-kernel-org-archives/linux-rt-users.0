From: Clark Williams <williams@redhat.com>
Subject: Re: Kernel ISR Latency
Date: Tue, 11 Apr 2017 17:06:56 -0500
Message-ID: <20170411170656.2eda2c21@tagon>
References: <CAEYdEeQ5UVR6Zn6ZysnqcW1kDBPriMvEVUrW0a3NUhfeuM+Hxw@mail.gmail.com>
        <20170410195536.GK16052@jcartwri.amer.corp.natinst.com>
        <CAEYdEeR4Y138B9NinTso3hvJ6trEUa5OprsNEecDHFFrmP8j4Q@mail.gmail.com>
        <CAEYdEeR19sXd79DsZnYKy2+YFnEADSLzAiDq64Hw5kOiTqLLGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/yusHpP7WdOP8/M6Kr18fVxd"; protocol="application/pgp-signature"
Cc: Julia Cartwright <julia@ni.com>, linux-rt-users@vger.kernel.org
To: Brian Wrenn <dcbrianw@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753228AbdDKWHE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Apr 2017 18:07:04 -0400
In-Reply-To: <CAEYdEeR19sXd79DsZnYKy2+YFnEADSLzAiDq64Hw5kOiTqLLGw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/yusHpP7WdOP8/M6Kr18fVxd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Apr 2017 17:31:52 -0400
Brian Wrenn <dcbrianw@gmail.com> wrote:

> I imagine that it would be a bad idea to prioritize my ISR ahead of
> any one of these?
>=20
>    12  FF     99 139   - [posixcputmr/0]
>    14  FF     99 139   - [migration/0]
>    15  FF     99 139   - [watchdog/0]
>    16  FF     99 139   - [watchdog/1]
>    17  FF     99 139   - [migration/1]
>    21  FF     99 139   - [posixcputmr/1]
>    24  FF     99 139   - [watchdog/2]
>    25  FF     99 139   - [migration/2]
>    29  FF     99 139   - [posixcputmr/2]
>    32  FF     99 139   - [watchdog/3]
>    33  FF     99 139   - [migration/3]
>    37  FF     99 139   - [posixcputmr/3]
>=20
> At this stage, that's all that prioritized higher.

Yeah, it's never a good idea to use FIFO:99 and compete with these guys.=20

>=20
> On Mon, Apr 10, 2017 at 4:48 PM, Brian Wrenn <dcbrianw@gmail.com> wrote:
> > On Mon, Apr 10, 2017 at 3:55 PM, Julia Cartwright <julia@ni.com> wrote:=
 =20
> >> On Mon, Apr 10, 2017 at 03:12:28PM -0400, Brian Wrenn wrote: =20
> >>> Hi, I'm trying to track down the source of some ISR latency that I'm
> >>> observing on a logic analyzer.
> >>>
> >>> Just for some background, my setup is the following.  I'm running
> >>> Linaro 4.4.9 with PREEMPT RT Patch 17 on a Variscite SD410 SOM devkit.
> >>> My kernel has the following PREEMPT RT options. =20
> >> [..] =20
> >>>
> >>> I have a micro-controller attached to a GPIO pin and two separate SPI
> >>> ports.  Every 10 milliseconds the micro-controller writes 18 Kbytes of
> >>> data to each of 2 SPI ports (total of 36 Kbytes between the two) and
> >>> issues an interrupt on the GPIO.  A kernel module has an ISR
> >>> registered to the GPIO pin.  When the ISR executes, it copies 18
> >>> Kbytes of data from each SPI.  There are two RT threads executing in
> >>> user space as SCHED_RR with identical priorities less than (i.e. lower
> >>> than) 50, where as I understand the kernel runs at priority 50. =20
> >>
> >> It's a bit more complicated than "the kernel runs at priority 50". =20
> >
> > Yes, better stated, my kernel space IRQ gets a priority of 50.  (Most
> > of the others seem to have 50 as well.)

The RT kernel assigns all threaded IRQs  default priority of fifo:50.=20

> > =20
> >>
> >> Perhaps what you're getting at is that by default, with irq forced
> >> threading enabled (which is the default with -rt build kernels) the
> >> irqthreads have the default scheduling policy FIFO with priority 50.
> >> It's up to the administrator/system integrator to appropriately
> >> prioritize these irqthreads to suit the application.
> >> =20
> >
> > Pursuant to that, I'm reviewing this to gain a better understanding of
> > such things.  Please forgive me; I hadn't found this link prior to
> > messaging the listserve.
> >
> > http://subversion.ffado.org/wiki/IrqPriorities
> > =20
> >> For your usecase, this means that likely _all_ of the peripheral
> >> interrupts, including the low priority stuff you might not care about
> >> for your application (like networking or uart or whatever) are being
> >> prioritized right alongside your latency sensitive gpio handler.
> >> =20
> >>> Each of those user space threads copies data from some shared memory
> >>> within the kernel module and performs some basic data integrity
> >>> checks, i.e.  a SHA1. =20
> >>
> >> Just to better understand: how are your RT threads signalled by your
> >> gpio handler? =20
> >
> > The user space RT threads have mmap'ed memory shared with the kernel
> > module.  The kernel module writes to a designated memory location the
> > current read offset so that the user space RT threads know where to
> > read from iteration to iteration.
> > =20
> >> =20
> >>> The vast majority of interrupts incur a delay in range of tens of
> >>> MICROseconds, meaning the ISR executes within such amount of time of
> >>> the micro-controller raising the GPIO pin of the ISR.  However,
> >>> occasionally, more than six MILLIseconds passes between the time of
> >>> the micro-controller issuing the GPIO interrupt and the ISR beginning
> >>> to execute. =20
> >>
> >> Also: how are you measuring this latency?  In particular, where is your
> >> test point for the "ISR beginning"? =20
> >>> =20
> >
> > Upon detection of a bad CRC or bad sequence number, the user space
> > threads raise another GPIO, not the GPIO of the ISR, another one that
> > triggers a logic analyzer to dump a forward captured buffer.  Then, I
> > got back through the capture and identify the high latency ISR
> > execution.  (See attached image.)
> > =20
> >>> I'm trying to track down the cause of the 6+ MILLIsecond latency,
> >>> which I would not expect to happen.  Are there any well practiced
> >>> techniques for determining what factor(s) may be introducing this
> >>> latency?  I looked at the description for RT Watchdog, but I don't
> >>> think it would help me much because the only two RT threads other than
> >>> the kernel have a lower priority. =20
> >>
> >> I don't think the RT watchdog will help you here, however, I would
> >> recommend that you get acquainted with using ftrace/trace-cmd and the
> >> irq and sched traceevents.
> >>
> >>    Julia =20
> >
> > It sounds like to me that maybe you've confirmed that I'm looking in
> > the right direction w.r.t. modifying the kernel ISRs with something
> > like 'chrt' and 'rtiq'.  Yes?  But I also will look into
> > ftrace/trace-cmd and irq and sched trace events.

I'd suggest using chrt to boost your irq(s) up above the default 50 to say =
51. That would insure that they're scheduled in before the other interrupt =
threads are processed.=20

Of course that just means your interrupt gets serviced first and does nothi=
ng to help if some other interrupt (or other entity) is delaying the schedu=
ling of your user-space threads. As Julia said, you probably want to look a=
t ftrace and run your application with some tracepoints enabled. That will =
let you look at the timestamps when various events are hit and hopefully gi=
ve you an idea of what's happening when your latency spike hits.=20

If you want to get fancy, look at what cyclictest (from the rt-tests packag=
e) does when the --breaktrace option is used. It takes a threshold value an=
d stops processing when the threshold is exceeded. In addition it stops any=
 active trace and writes a message to the trace buffers, so it's quite obvi=
ous when you've hit a spike and you get a nice event trace leading up to th=
e spike.=20

Clark

--=20
The United States Coast Guard
Ruining Natural Selection since 1790

--Sig_/yusHpP7WdOP8/M6Kr18fVxd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJY7VOAAAoJEBO1XdB8U7hRjA8P/17orxL/stO80YK3eR6bRNcZ
i+t1sL/LV5iz78jLWWayiiNQ+VpdddrS7RQRkNPpWofCQRdlVWUQnsTz4z5ctYaU
R+gQ6CMtdg4CydwPCie5YoGnmet2wXuw4gtKyiL7iLYRClyBO+t9bYZwSYe+Es6X
iuu3HX44uUx8LsXm9njiNd0nPR50gRlXVVZ7O6nZ9SjFRlh1UaTWBFygKdWLbBWn
fMvz6bLZduF034uoTLVsuaKfsMRSM/RSOn0rLqyIYGGq8N8Lka4fM2k/eufG3EAA
RrDuuUERbIqVr3OW8TTN35GNyMxBrH8YHFhkrWlhW7oJX8kZM1j2GTSpAi+6DQPz
O8aObKrpCK6Ix7z5/Y0Bma47ZnvTjiB7fpkjKhSRi3u1fXgdqXwScsBrznADaFE2
CnO9ZlIlHNzL1r8pCDykg/WCkLYlUPriAQ/MedwnDFbd0yTTrRG6yig0rLgZpKqZ
rKuQS8jFGnzS+91g0NSqhRNUv9QoU11pP2dHjZL+AHcj+BBYLyV4q8kGM2mwirU3
V66tbkRI5Swa+mDLkV39YZWdQW1fTGthtGm5+XGBkQjrnHCJfHt4DPnbIMlagZEe
IEaE6gHsger40+fME6bdERkw2ScbwUdyXuQbwlwMlKZmXPI9omWc5zEUQBeJEn0d
85uLXl6nbM3A0hYZb9C6
=Kv8c
-----END PGP SIGNATURE-----

--Sig_/yusHpP7WdOP8/M6Kr18fVxd--
