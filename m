From: =?ISO-8859-2?Q?P=E1sztor_Szil=E1rd?= <szilard.pasztor@evosoft.com>
Subject: Re: Mysterious delay (interrupt?)
Date: Mon, 25 Jun 2007 14:57:30 +0200
Message-ID: <20070625145730.6dae3e9b.szilard.pasztor@evosoft.com>
References: <20070625095538.6b642a7b.szilard.pasztor@evosoft.com>
	<1182772906.5493.153.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__25_Jun_2007_14_57_30_+0200_X=QsdyQPwRJ32lpY"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from evo2.evosoft.com ([195.228.139.85]:45565 "HELO evo2.evosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753830AbXFYM7K (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 25 Jun 2007 08:59:10 -0400
Received: from EVOXCH1.evosoft.com (unknown [10.10.110.13])
	by mail2.evosoft.hu (Postfix) with ESMTP id B8CE21BB1C1A
	for <linux-rt-users@vger.kernel.org>; Mon, 25 Jun 2007 15:13:25 +0200 (CEST)
In-Reply-To: <1182772906.5493.153.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Signature=_Mon__25_Jun_2007_14_57_30_+0200_X=QsdyQPwRJ32lpY
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Steven Rostedt:
> Not sure if it would help you trace this down further but have you tried
> running your load with the Latency Tracer configured in?

Not yet, I'll give it a try.

> Is the thread that needs to gain CPU time dependent on the accessing of
> the serial and ethernet ports?

If you by this question suppose that the thread may get blocked because of =
the
ports, the answer is no: all ports are configured asynchronous. I'm all one
thread anyway.

> Can you post the code to your program somewhere, and also show us
> exactly where you see the latency?

I'm afraid I can't post the code due to industrial reasons but it's probably
possible to show some snippets.

It looks like this, commented where necessary:
-----------------------------------------------------------------------
    get_rt_priority();
                   =20
    while (1)  =20
    {      =20
        if (begin_timer)
        {
            clock_gettime(CLOCK_REALTIME, &now);
            begin_timer =3D 0;
        }
        prev =3D next =3D now;
        next.tv_nsec +=3D RT_DELAY;	// RT_DELAY is 980000 ns by default
        tsnorm(&next);

        [...]

	if (sleep_allowed)
            clock_nanosleep(CLOCK_REALTIME, TIMER_ABSTIME, &next, NULL);

	// read klok
        clock_gettime(CLOCK_REALTIME, &now);

	// Few calculations to time cyclic jobs
        handle_timers(calcdiff(now, prev));

	[...various data handling...]

	ioctl(zlvStatus[port].fd, TIOCMGET, &flags); // this ioctl is to blame

	[...some more tinkering with data...]

#ifdef _SHOWTIMER_
        if (!begin_timer)
        {      =20
            /* Now we remember the longest cycle runtime */
            clock_gettime(CLOCK_REALTIME, &next);
            tmp =3D calcdiff(next, now);
            if (tmp > runtime)
                runtime =3D tmp;
        }
#endif

    }
------------------------------------------------------------------------

The symptom is that latency can kick in anywhere within this while() loop.
After timestamping almost every single line, I was unable to bind the delay=
 to
one location. Sometimes a simple variable assignment was shown to last 2-3
milliseconds. This led me to believe that the latency is not directly relat=
ed
to the code but rather an interruption of the running code at "random"
locations.
The latency is not present with the ioctl() call busted out, but the ioctl()
itself is completed in a few microseconds or so.

> The only real thing that happens in get_mctrl that I see is a wake_up.
> So if something is sleeping on an ioctl TIOCMWAIT, it will wake up and
> run.  Do you have something that does this?  Your latency that you are
> seeing, might just be another thread taking up the CPU.

My task is the only one toying with the serial ports, kind of. I generated =
the
high interrupt load with a ping -f and copying over NFS.

> Your personal server or are you talking about the server to download the
> patch?

The server I'm running the code on is the one under use.
But I think it's all the same for the different versions anyway.

> As I said, check your application. I think there's another thread you
> may have that is competing with the thread you are timing.

I'll then try to prevent multiple opens on the serial ports then to avoid r=
ace
conditions. (Do I have to modify the serial driver for that?)

Thanks for the tips,
s.

       -----------------------------------------------------------------
       |  You are one of those bad things that happen to good people.  |
       -----------------------------------------------------------------

--Signature=_Mon__25_Jun_2007_14_57_30_+0200_X=QsdyQPwRJ32lpY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGf7u6xoToz8jNC5ARAlYlAJ4kwacanFX6Z+M94aI3bUhbhRiRZwCg6cKm
9um+PZZlx6QlszQ7vVJ7BO8=
=/nmZ
-----END PGP SIGNATURE-----

--Signature=_Mon__25_Jun_2007_14_57_30_+0200_X=QsdyQPwRJ32lpY--
