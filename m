From: Clark Williams <williams@redhat.com>
Subject: Re: Realtime System only works after running cyclictest with -b
 option
Date: Thu, 1 Aug 2013 16:03:43 -0500
Message-ID: <20130801160343.274f751b@riff.lan>
References: <51FA9C27.7050409@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_//P8ZVj7=UeRrcyfWYjjvxlI"; protocol="application/pgp-signature"
Cc: linux-rt-users@vger.kernel.org
To: "Paul-Ehrlich@gmx.de" <Paul-Ehrlich@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53956 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957Ab3HAVDx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 1 Aug 2013 17:03:53 -0400
In-Reply-To: <51FA9C27.7050409@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_//P8ZVj7=UeRrcyfWYjjvxlI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 01 Aug 2013 19:34:31 +0200
"Paul-Ehrlich@gmx.de" <Paul-Ehrlich@gmx.de> wrote:

> Hello linux-rt-users,
> I have a question concerning RT-Patch, which shows strange behavior=20
> discoverd using cyclictest. I have an embedded system with patched RT.=20
> The max latency of the cyclictest isn=E2=80=99t as low as expected and my=
 only=20
> application hangs to, so I included tracing abilities to the kernel to=20
> use the =E2=80=9C-b=E2=80=9D switch of cyclictest. But the kernel behaves=
 different if=20
> switched on (detailed below)? Maybe you can give me a hint what the=20
> cyclictest does when using the =E2=80=93b switch. It somehow persists aft=
er the=20
> option is used once and my own application runs fine afterwards too. So=20
> in order to run my application right now I have to run cyclictest with=20
> the -b option after each reboot.
> Many Thanks in Advance
> Paul Ehrlich

The -b (breaktrace) switch is used to stop cyclictest after a
measured latency on any processor exceeds the value specified with -b.
To do this it mounts the debugfs and sets up latency tracing. When any
latency value exceeds the threshold, cyclictest writes a trace-mark
into the tracing buffer, stops ftrace and then stops the run.=20

The only thing that's persistent when using the -b option is that
debugfs remains mounted (so you can access the latency tracing data).
Not sure why debugfs would help here. Might be interesting to see if
it's just the fact that debugfs is mounted or if you have to access
some of the ftrace knobs (/sys/kernel/debug/tracing/*).=20

What kind of processor are you using?

Clark

>=20
>=20
> First test run after boot - showing huge latencies:
> linaro@linaro-ubuntu-desktop:~$ sudo cyclictest -t1 -p 80 -n -i 250 -l=20
> 10000 -a 1
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.74 0.34 0.13 1/144 1966
> T: 0 ( 1966) P:80 I:250 C: 10000 Min: 18 Act: 27 Avg: 36 Max: 1590
>=20
> Secound test run after boot - just to make sure:
> linaro@linaro-ubuntu-desktop:~$ sudo cyclictest -t1 -p 80 -n -i 250 -l=20
> 10000 -a 1
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.93 0.30 0.10 1/142 1948
> T: 0 ( 1948) P:80 I:250 C: 10000 Min: 18 Act: 46 Avg: 38 Max: 3639
>=20
> Third test run after boot now using -b option - result looks ok for the=20
> system:
> linaro@linaro-ubuntu-desktop:~$ sudo cyclictest -t1 -p 80 -n -i 250 -l=20
> 10000 -a 1 -b 1000
> # /dev/cpu_dma_latency set to 0us
> INFO: debugfs mountpoint: /sys/kernel/debug/tracing/
> policy: fifo: loadavg: 0.51 0.32 0.13 1/144 1979
> T: 0 ( 1979) P:80 I:250 C: 10000 Min: 85 Act: 101 Avg: 114 Max: 179
>=20
> Fourth run after boot - now without -b even faster?:
> # Thread Ids: 01979
> linaro@linaro-ubuntu-desktop:~$ sudo cyclictest -t1 -p 80 -n -i 250 -l=20
> 10000 -a 1
> # /dev/cpu_dma_latency set to 0us
> policy: fifo: loadavg: 0.66 0.38 0.16 1/157 2283
> T: 0 ( 2279) P:80 I:250 C: 10000 Min: 6 Act: 27 Avg: 27 Max: 51
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--Sig_//P8ZVj7=UeRrcyfWYjjvxlI
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlH6zTMACgkQHyuj/+TTEp2sbwCfdPZzATaMB/r0BxtIxXJVd6ZT
9SAAoK143IGsiXS9fKkAdq7PFBBdNKOp
=9nwo
-----END PGP SIGNATURE-----

--Sig_//P8ZVj7=UeRrcyfWYjjvxlI--
