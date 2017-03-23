From: Henrik Austad <henrik@austad.us>
Subject: Re: [PATCH] cyclictest: make clock_nanosleep as default and add
 option for POSIX timers.
Date: Thu, 23 Mar 2017 20:14:51 +0100
Message-ID: <20170323191451.GA32101@sisyphus.home.austad.us>
References: <alpine.LFD.2.20.1703141646001.10659@riemann.fritz.box>
 <1489520628-9288-1-git-send-email-vedang.patel@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Cc: williams@redhat.com, jkacur@redhat.com,
        linux-rt-users@vger.kernel.org
To: Vedang Patel <vedang.patel@intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35792 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932308AbdCWTO5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Mar 2017 15:14:57 -0400
Received: by mail-lf0-f66.google.com with SMTP id v2so17853942lfi.2
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Mar 2017 12:14:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1489520628-9288-1-git-send-email-vedang.patel@intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 14, 2017 at 12:43:48PM -0700, Vedang Patel wrote:
> it is recommended that clock_nanosleep should be used for real-time

extreme nitpick: Captialize first word in a sentence.

> wherever available. So, make sure that cyclictest runs clock_nanosleep
> by default. Added an option to run POSIX timers. Removing the '-n'
> option because it is redundant now.
>=20
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> ---
>  src/cyclictest/cyclictest.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 3f1bef1ffca9..cf82f8e1deaa 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1321,7 +1321,6 @@ static void display_help(int error)
>  	       "-m       --mlockall        lock current and future memory alloc=
ations\n"
>  	       "-M       --refresh_on_max  delay updating the screen until a ne=
w max\n"
>  	       "			   latency is hit. Userful for low bandwidth.\n"
> -	       "-n       --nanosleep       use clock_nanosleep\n"
>  	       "	 --notrace	   suppress tracing\n"
>  	       "-N       --nsecs           print results in ns instead of us (d=
efault us)\n"
>  	       "-o RED   --oscope=3DRED      oscilloscope mode, reduce verbose =
output by RED\n"
> @@ -1364,7 +1363,8 @@ static void display_help(int error)
>  	       "                           format: n:c:v n=3Dtasknum c=3Dcount =
v=3Dvalue in us\n"
>  	       "-w       --wakeup          task wakeup tracing (used with -b)\n"
>  	       "-W       --wakeuprt        rt task wakeup tracing (used with -b=
)\n"
> -	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\=
n",
> +	       "	 --dbg_cyclictest  print info useful for debugging cyclictest\=
n"
> +	       "-x	 --posix_timers    use POSIX timers\n",

Since we are now removing all references to clock_nanosleep, perhaps add=20
note here indicating that nanosleep is the default, i.e. something like

"use POSIX timers instead of clock_nanosleep"

>  	       tracers
>  		);
>  	if (error)
> @@ -1372,7 +1372,7 @@ static void display_help(int error)
>  	exit(EXIT_SUCCESS);
>  }
> =20
> -static int use_nanosleep;
> +static int use_nanosleep =3D MODE_CLOCK_NANOSLEEP; /* use clock_nanoslee=
p by default. */

Not sure if you really need the trailing comment, but I'll leave that up to=
=20
John (I'd drop it)

>  static int timermode =3D TIMER_ABSTIME;
>  static int use_system;
>  static int priority;
> @@ -1493,6 +1493,7 @@ enum option_values {
>  	OPT_TRIGGER_NODES, OPT_UNBUFFERED, OPT_NUMA, OPT_VERBOSE, OPT_WAKEUP,
>  	OPT_WAKEUPRT, OPT_DBGCYCLIC, OPT_POLICY, OPT_HELP, OPT_NUMOPTS,
>  	OPT_ALIGNED, OPT_SECALIGNED, OPT_LAPTOP, OPT_SMI, OPT_TRACEMARK,
> +	OPT_POSIX_TIMERS,
>  };
> =20
>  /* Process commandline options */
> @@ -1530,7 +1531,6 @@ static void process_options (int argc, char *argv[]=
, int max_cpus)
>  			{"loops",            required_argument, NULL, OPT_LOOPS },
>  			{"mlockall",         no_argument,       NULL, OPT_MLOCKALL },
>  			{"refresh_on_max",   no_argument,       NULL, OPT_REFRESH },
> -			{"nanosleep",        no_argument,       NULL, OPT_NANOSLEEP },
>  			{"nsecs",            no_argument,       NULL, OPT_NSECS },
>  			{"oscope",           required_argument, NULL, OPT_OSCOPE },
>  			{"traceopt",         required_argument, NULL, OPT_TRACEOPT },
> @@ -1557,9 +1557,10 @@ static void process_options (int argc, char *argv[=
], int max_cpus)
>  			{"dbg_cyclictest",   no_argument,       NULL, OPT_DBGCYCLIC },
>  			{"policy",           required_argument, NULL, OPT_POLICY },
>  			{"help",             no_argument,       NULL, OPT_HELP },
> +			{"posix_timers",     no_argument,	NULL, OPT_POSIX_TIMERS },
>  			{NULL, 0, NULL, 0}
>  		};
> -		int c =3D getopt_long(argc, argv, "a::A::b:Bc:Cd:D:Efh:H:i:Il:MnNo:O:p=
:PmqrRsSt::uUvD:wWT:",
> +		int c =3D getopt_long(argc, argv, "a::A::b:Bc:Cd:D:Efh:H:i:Il:MNo:O:p:=
PmqrRsSt::uUvD:wWT:x",
>  				    long_options, &option_index);
>  		if (c =3D=3D -1)
>  			break;
> @@ -1651,9 +1652,6 @@ static void process_options (int argc, char *argv[]=
, int max_cpus)
>  		case 'M':
>  		case OPT_REFRESH:
>  			refresh_on_max =3D 1; break;
> -		case 'n':
> -		case OPT_NANOSLEEP:
> -			use_nanosleep =3D MODE_CLOCK_NANOSLEEP; break;
>  		case 'N':
>  		case OPT_NSECS:
>  			use_nsecs =3D 1; break;
> @@ -1760,6 +1758,9 @@ static void process_options (int argc, char *argv[]=
, int max_cpus)
>  		case 'W':
>  		case OPT_WAKEUPRT:
>  			tracetype =3D WAKEUPRT; break;
> +		case 'x':
> +		case OPT_POSIX_TIMERS:
> +			use_nanosleep =3D MODE_CYCLIC; break;
>  		case '?':
>  		case OPT_HELP:
>  			display_help(0); break;

As a side-observation that does not have anything to do with your patch, it=
=20
seems like there's a lovely mix of spaces and TABS in this file (i.e.=20
starting a line with a few spaces, then TABs and then possibly more spaces=
=20
for final alignment).

Could be my mailclient pulling my foot though, I just found it a bit=20
strange.

> --=20
> 2.7.3
>=20

A part form my minor nitpicks, nice change!

--=20
Henrik Austad

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljUHqsACgkQ6k5VT6v45lkK/wCgnsRfp6QgFsm7huhVX7GJ8adD
jdIAnjmnJilQjYCJGI/nkH6UDL6JoL5q
=RSQ5
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
