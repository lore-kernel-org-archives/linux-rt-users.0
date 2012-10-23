From: Miguel Telleria de Esteban <miguel@mtelleria.com>
Subject: About effective resolution of cpu execution clocks
Date: Tue, 23 Oct 2012 12:52:49 +0200
Message-ID: <20121023125249.776fa125@namir.ctr.unican.es>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/dWfsIDbpGklMZmnvSSUS=Nf"; protocol="application/pgp-signature"
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from bounce-vit-2-out.online.net ([88.190.253.117]:33789 "EHLO
	bounce-vit-2.online.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752796Ab2JWLQi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Oct 2012 07:16:38 -0400
Received: from [88.190.253.253] (helo=smtpauth-vit.online.net)
	by bounce-vit-2.online.net with esmtpa (Exim 4.71)
	(envelope-from <miguel@mtelleria.com>)
	id 1TQc7l-0004BB-LB
	for linux-rt-users@vger.kernel.org; Tue, 23 Oct 2012 12:54:17 +0200
Received: from [193.144.198.95] (helo=namir.ctr.unican.es)
	by smtpauth-vit.online.net with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71)
	(envelope-from <miguel@mtelleria.com>)
	id 1TQc7E-0002z4-S0
	for linux-rt-users@vger.kernel.org; Tue, 23 Oct 2012 12:53:44 +0200
Received: from localhost ([127.0.0.1] helo=namir.ctr.unican.es)
	by namir.ctr.unican.es with esmtp (Exim 4.80)
	(envelope-from <miguel@mtelleria.com>)
	id 1TQc6Q-00048M-AB
	for linux-rt-users@vger.kernel.org; Tue, 23 Oct 2012 12:52:54 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/dWfsIDbpGklMZmnvSSUS=Nf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear all,

Please allow me to post this newbie question that must have been
answered many times before.

I have my doubts about the actual resolution of CPU TIME USAGE
MEASUREMENT for individual tasks, that is using the=20

            clock_gettime()

            with the thread clock id.

=46rom one side, it looks as the counter of cpu-time use in each thread
is done with a jiffy resolution:

-  utime and stime fields in task_struct seem to be unsigned long,
   therefore in 32bit archs they cannot have a very high resolution.

   http://lxr.linux.no/#linux+v3.6.3/kernel/posix-cpu-timers.c
   http://lxr.linux.no/linux+*/include/linux/sched.h#L1362
   http://lxr.linux.no/linux+*/include/asm-generic/cputime.h#L7

-  utime and stime fields in /proc/<tid>/stat come out in jiffies
   according to proc man page.

since I guess that these utime and stime fields are the basis of the
cpuclock implementation I infer that the effective resolution of
thread or process usage is limited by the jiffy resolution (4msg with
CONFIG_HZ=3D250) of the utime and stime fields in task_struct.

On the other side, clock_getres() returns 1 nanosec and the well known
hrtimers merge in 2.6.21 announced highly and broadly that the jiffy
barrier has been lifted with real time clocks and timers.

So my questions are:

*  What is the effective resolution of two invocations of
   clock_gettime() on the same running thread for a long period
   involving several CPU preemptions?

*  Are there other fields apart from stime and utime with the
   sufficient precision to maintain a CPU usage count?

*  Does the PREEMPT_RT branch improve this resolution somehow?

Thanks in advance for your time.
Cheers,

       Miguel Telleria


--=20

      (O-O)
---oOO-(_)-OOo-----------------------------------------------------
 Miguel TELLERIA DE ESTEBAN               http://www.mtelleria.com
 Email: miguel at mtelleria.com           Tel GSM:  +34 650 801098
                                          Tel Fix:  +34 942 280174

 Miembro de http://www.linuca.org    Membre du http://www.bxlug.be
 =C2=BFUsuario captivo o libre?    http://www.obtengalinux.org/windows/
 Free or  captive user?        http://www.getgnulinux.org/windows/
-------------------------------------------------------------------


--Sig_/dWfsIDbpGklMZmnvSSUS=Nf
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlCGdwEACgkQFZSFLxwXZdKZdQCaA4T+bBfeHrCazcsXr9W2pKU7
jGEAn355Z2hg35/nEis5zc4oNoFeDT7C
=KtJR
-----END PGP SIGNATURE-----

--Sig_/dWfsIDbpGklMZmnvSSUS=Nf--
