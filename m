From: Julia Cartwright <julia@ni.com>
Subject: Re: Kernel ISR Latency
Date: Mon, 10 Apr 2017 14:55:36 -0500
Message-ID: <20170410195536.GK16052@jcartwri.amer.corp.natinst.com>
References: <CAEYdEeQ5UVR6Zn6ZysnqcW1kDBPriMvEVUrW0a3NUhfeuM+Hxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Cc: <linux-rt-users@vger.kernel.org>
To: Brian Wrenn <dcbrianw@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:48643 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751588AbdDJTzj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Apr 2017 15:55:39 -0400
Content-Disposition: inline
In-Reply-To: <CAEYdEeQ5UVR6Zn6ZysnqcW1kDBPriMvEVUrW0a3NUhfeuM+Hxw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2017 at 03:12:28PM -0400, Brian Wrenn wrote:
> Hi, I'm trying to track down the source of some ISR latency that I'm
> observing on a logic analyzer.
>=20
> Just for some background, my setup is the following.  I'm running
> Linaro 4.4.9 with PREEMPT RT Patch 17 on a Variscite SD410 SOM devkit.
> My kernel has the following PREEMPT RT options.
[..]
>=20
> I have a micro-controller attached to a GPIO pin and two separate SPI
> ports.  Every 10 milliseconds the micro-controller writes 18 Kbytes of
> data to each of 2 SPI ports (total of 36 Kbytes between the two) and
> issues an interrupt on the GPIO.  A kernel module has an ISR
> registered to the GPIO pin.  When the ISR executes, it copies 18
> Kbytes of data from each SPI.  There are two RT threads executing in
> user space as SCHED_RR with identical priorities less than (i.e. lower
> than) 50, where as I understand the kernel runs at priority 50.

It's a bit more complicated than "the kernel runs at priority 50".

Perhaps what you're getting at is that by default, with irq forced
threading enabled (which is the default with -rt build kernels) the
irqthreads have the default scheduling policy FIFO with priority 50.
It's up to the administrator/system integrator to appropriately
prioritize these irqthreads to suit the application.

For your usecase, this means that likely _all_ of the peripheral
interrupts, including the low priority stuff you might not care about
for your application (like networking or uart or whatever) are being
prioritized right alongside your latency sensitive gpio handler.

> Each of those user space threads copies data from some shared memory
> within the kernel module and performs some basic data integrity
> checks, i.e.  a SHA1.

Just to better understand: how are your RT threads signalled by your
gpio handler?

> The vast majority of interrupts incur a delay in range of tens of
> MICROseconds, meaning the ISR executes within such amount of time of
> the micro-controller raising the GPIO pin of the ISR.  However,
> occasionally, more than six MILLIseconds passes between the time of
> the micro-controller issuing the GPIO interrupt and the ISR beginning
> to execute.

Also: how are you measuring this latency?  In particular, where is your
test point for the "ISR beginning"?
>
> I'm trying to track down the cause of the 6+ MILLIsecond latency,
> which I would not expect to happen.  Are there any well practiced
> techniques for determining what factor(s) may be introducing this
> latency?  I looked at the description for RT Watchdog, but I don't
> think it would help me much because the only two RT threads other than
> the kernel have a lower priority.

I don't think the RT watchdog will help you here, however, I would
recommend that you get acquainted with using ftrace/trace-cmd and the
irq and sched traceevents.

   Julia

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgKAEF431w1EL96k9jNrC4UVNdG8FAljr4zQACgkQjNrC4UVN
dG8C2Qf/fKAR/sh/1f/HU6InXTjZF+9J3r6OyJU2zsSbwLl5uBeGtVB8yWPVhNGn
G+SCrYt/neNa5di8VZHTnzFL5IgG2iQpbu2praiVN+LwdKX1UMHNvlD78DPo8tF7
QDauXNDfDgTuxj2V5GK1DIYaXj/c/v+uXNjiad4JW4dgGyhKukJgIRN6VaBbbwtO
uJveyz7nqEsLUugM3IdrQdnFcvKShpNLFIGZHQtn6tIqIOfJ8us1BgHxon3QmZ6J
Lntu1POEeqtX81K9EsN9a2GxkM6DlnmoC4NvPUezqDfPgYxJg0awtnqFT+1MsJd2
BjCpkHWfEKFPlZuDYlpUceBRO3yK+Q==
=pVQN
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
