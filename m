From: Eric W Anderson <Eric.Anderson@Colorado.EDU>
Subject: At a loss: Kernel 2.6.19-rt15 with ixp425
Date: Tue, 8 Jun 2010 12:17:52 -0600
Message-ID: <20100608181752.GA19521@colorado.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ipmx3.colorado.edu ([128.138.128.233]:19978 "EHLO
	ipmx3.colorado.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab0FHS1X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Jun 2010 14:27:23 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello All,

I can't figure out (or haven't figured out) how to get actual high-resoluti=
on
timers on the above platform.  I'm kind of stuck with 2.6.19, unfortunately.
I've applied the -rt patch to stock 2.6.19, merged in some random patches to
support my hardware, and gotten it to boot. But, here's what confuses me:  I
have the hrtimer API, but my actual clock resolution is still shown as  10m=
s.

  root@patty:/# cat /proc/timer_list=20
  Timer List Version: v0.1
  HRTIMER_MAX_CLOCK_BASES: 2
  now at 2766685920305 nsecs
 =20
  cpu: 0
   clock 0:
    .index:      0
    .resolution: 10000000 nsecs
    .get_time:   ktime_get_real
  active timers:
   clock 1:
    .index:      1
    .resolution: 10000000 nsecs
    .get_time:   ktime_get
  active timers:
   #0: <c4615ec8>, hrtimer_wakeup
   # expires at 2766802147358 nsecs [in 116227053 nsecs]
   #1: <c4615ec8>, it_real_fn
   # expires at 2767494816966 nsecs [in 808896661 nsecs]
   #2: <c4615ec8>, it_real_fn
   # expires at 3642163204498 nsecs [in 875477284193 nsecs]
   #3: <c4615ec8>, it_real_fn
   # expires at 3643403169278 nsecs [in 876717248973 nsecs]

Additionally, I don't see CONFIG_HIGH_RES_TIMERS anywhere in my kernel
menuconfig.  I've added a patch from Kevin Hilman and Milan Svoboda
(http://lkml.indiana.edu/hypermail/linux/kernel/0607.1/2343.html) which
purports to enable a high-resolution clock event source for this board, but
that doesn't seem to change anything.=20

I think I don't properly understand the preempt_rt / hrtimers /
board-specific-bits ecosystem here.  What are the bits and pieces I need in
order to have high-resolution timers on this platform?

Many, many thanks,
Eric Anderson


--=20
Eric W. Anderson                                   University of Colorado
eric.anderson@colorado.edu                      Dept. of Computer Science
phone: +1-720-984-8864                   Systems Research Lab - ECCR 1B54

                         PGP key fingerprints:
       personal: 1BD4 CFCE 8B59 8D6E EA3E  EBD5 4DC9 3E61 656C 462B
       academic: D3C5 D6FF EDED 9F1F C36D  53A3 74B7 53A6 3C74 5F12

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwOiVAACgkQdLdTpjx0XxI4jwCfbT1q0IlDHRQFBIqeOJnIz1wU
tAcAnRxe1TnWB5HhFXp176ViWjB8fz1q
=8GvU
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
