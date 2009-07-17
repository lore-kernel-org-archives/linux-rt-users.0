From: Henrik Austad <henrik@austad.us>
Subject: Re: RFC for a new Scheduling policy/class in the Linux-kernel
Date: Fri, 17 Jul 2009 09:40:59 +0200
Message-ID: <200907170941.01559.henrik@austad.us>
References: <200907102350.47124.henrik@austad.us> <200907142128.48558.henrik@austad.us> <20090715215305.GD14993@cs.fsu.edu>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8555340.AL0qO5eOnX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "James H. Anderson" <anderson@cs.unc.edu>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Chris Friesen <cfriesen@nortel.com>,
	Raistlin <raistlin@linux.it>,
	Douglas Niehaus <niehaus@ittc.ku.edu>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Bill Huey <billh@gnuppy.monkey.org>,
	Linux RT <linux-rt-users@vger.kernel.org>,
	Fabio Checconi <fabio@gandalf.sssup.it>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dhaval Giani <dhaval.giani@gmail.com>,
	Noah Watkins <jayhawk@soe.ucsc.edu>,
	KUSP Google Group <kusp@googlegroups.com>,
	Tommaso Cucinotta <cucinotta@sssup.it>,
	Giuseppe Lipari <lipari@retis.sssup.it>,
	Bjoern Brandenburg <bbb@cs.unc.edu>
To: Ted Baker <baker@cs.fsu.edu>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934189AbZGQHlN@vger.kernel.org>
In-Reply-To: <20090715215305.GD14993@cs.fsu.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--nextPart8555340.AL0qO5eOnX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 15 July 2009 23:53:05 Ted Baker wrote:
> On Tue, Jul 14, 2009 at 09:28:47PM +0200, Henrik Austad wrote:
> > ... In MC you need to do this the hard way, namely compute the
> > point in time not when the task misses the deadline, but when it
> > will *eventually* fail a deadline. By doing that, you combine
> > deadline, wcet and granted time in one variable, and you have a
> > *single* variable to compare.
>
> This is true in a theoretical sense, and is the basis of some
> "optimal" scheduling algorithms, including the "throwforward
> scheduling" algorithm.  It makes sense in some environments, where
> you actually know the WCET of the task in advance.  However, I
> don't believe a Linux system can expect all applications to
> provide this kind of information.

Why cannot you expect real-time tasks using a deadline scheduler to provide=
=20
some estimate of the execution cost? How can you ever hope to run a deadlin=
e=20
scheduler without this?

> In a system programmed using process and threads, the decision to
> sleep or wake is embedded in the internal logic of the thread, and
> implemented by system calls.  The existing system calls do not
> convey how long the thread needs to execute before it reaches its
> next suspension point.  Therefore, without a new API you cannot
> use WCET.=20

Yes, you would need to introduce a new set of syscalls. 2 in fact. When=20
working with PD^2, I added 3 (as reweighing was a special case), but:

sched_dl_update(pid, wcet, period, deadline)
sched_dl_release(pid, abs_releease_time)

How can you use deadlines based on priorities? A priority is a one-way mapp=
ing=20
of deadlines for a set of tasks.

> If you create a new API for this, you are limiting this=20
> form of scheduling to threads that choose to use that API, and are
> able to provide the needed WCET information.  This seems like a
> small number of cases among the full range of real-time Linux
> applications.

Are we going to place all tasks in the kernel into rt-deadline tasks? I had=
=20
the impression that we wanted a class for a special set of tasks.=20

> Ted

=2D-=20
     henrik

--nextPart8555340.AL0qO5eOnX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBKYCsN6k5VT6v45lkRAvwiAKCA9aoI67x8F+vaDrRLG1QRqbH4gQCg/iPL
js4pxSirk97a+bF3ebqpT8E=
=WYNZ
-----END PGP SIGNATURE-----

--nextPart8555340.AL0qO5eOnX--
