From: Clark Williams <williams@redhat.com>
Subject: Re: RFC: patch to trigger thread stats output from cyclictest with
 SIGHUP
Date: Tue, 12 Mar 2013 08:43:08 -0500
Message-ID: <20130312084308.0def75ca@riff.lan>
References: <20130311111607.587cda32@riff.lan>
	<alpine.LFD.2.03.1303121309370.8036@tycho>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/I6YcLgY_fDbvaRqJhJJE.T="; protocol="application/pgp-signature"
Cc: Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>,
	David Sommerseth <davids@redhat.com>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7486 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754082Ab3CLNnV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Mar 2013 09:43:21 -0400
In-Reply-To: <alpine.LFD.2.03.1303121309370.8036@tycho>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/I6YcLgY_fDbvaRqJhJJE.T=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 12 Mar 2013 13:10:43 +0100 (CET)
John Kacur <jkacur@redhat.com> wrote:

>=20
>=20
> On Mon, 11 Mar 2013, Clark Williams wrote:
>=20
> > John,
> >=20
> > Steven suggested a feature for cyclictest that I'd actually been
> > whining about (internally anyway). During long rteval runs there's
> > really no feedback available if you want to know how the run is
> > progressing. Steven suggested sending SIGHUP and dumping the current
> > state. Below is a patch that seems to work for cyclictest; just
> > wanted to get some feedback on whether this would be acceptable
> > behaviour.=20
> >=20
> > Of course if we get this going then we need to figure out how to wire
> > it into rteval as well :).
> >=20
> > Clark
> >=20
> >=20
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index 0a15dcb..51b97cf 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -199,6 +199,11 @@ static char **traceptr;
> >  static int traceopt_count;
> >  static int traceopt_size;
> > =20
> > +static struct thread_param **parameters;
> > +static struct thread_stat **statistics;
> > +
> > +static void print_stat(struct thread_param *par, int index, int verbos=
e);
> > +
> >  static int latency_target_fd =3D -1;
> >  static int32_t latency_target_value =3D 0;
> > =20
> > @@ -1368,6 +1373,19 @@ static int check_timer(void)
> > =20
> >  static void sighand(int sig)
> >  {
> > +	if (sig =3D=3D SIGHUP) {
> > +		int i;
> > +		int oldquiet =3D quiet;
> > +
> > +		quiet =3D 0;
> > +		printf("#---------------------------\n");
> > +		printf("# cyclictest current status:\n");
> > +		for (i =3D 0; i < num_threads; i++)
> > +			print_stat(parameters[i], i, 0);
> > +		printf("#---------------------------\n");
> > +		quiet =3D oldquiet;
> > +		return;
> > +	}
> >  	shutdown =3D 1;
> >  	if (refresh_on_max)
> >  		pthread_cond_signal(&refresh_on_max_cond);
> > @@ -1503,8 +1521,6 @@ int main(int argc, char **argv)
> >  	sigset_t sigset;
> >  	int signum =3D SIGALRM;
> >  	int mode;
> > -	struct thread_param **parameters;
> > -	struct thread_stat **statistics;
> >  	int max_cpus =3D sysconf(_SC_NPROCESSORS_CONF);
> >  	int i, ret =3D -1;
> >  	int status;
> > @@ -1642,6 +1658,7 @@ int main(int argc, char **argv)
> > =20
> >  	signal(SIGINT, sighand);
> >  	signal(SIGTERM, sighand);
> > +	signal(SIGHUP, sighand);
> > =20
> >  	parameters =3D calloc(num_threads, sizeof(struct thread_param *));
> >  	if (!parameters)
> >=20
>=20
> Where's your SOB Clark? I'm assuming that you and not Steve are the=20
> author. I can add this to my development dir for people to try.
>=20
> Thanks
>=20
> John


I haven't even committed this to my tree yet :). I was actually toying
with the idea of having an option to setup a fifo what would allow you
to get the stats without having to screen-scrape stdout.  Was thinking
about adding a -F/--fifo option where you tell cyclictest where to put
the fifo:

# cyclictest --numa -p95 -m -F /tmp/cyclictest.fifo

Then you could just cat the fifo and get a snapshot, or your program
could open and read it. Still turning this over in my head though.

Clark

--Sig_/I6YcLgY_fDbvaRqJhJJE.T=
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlE/MPUACgkQHyuj/+TTEp0THQCeJu5kwEL35Du/iJCcpzBtGNnZ
ic4An19IJopzb4W7Imfy2j5GBDhoddYN
=bik6
-----END PGP SIGNATURE-----

--Sig_/I6YcLgY_fDbvaRqJhJJE.T=--
