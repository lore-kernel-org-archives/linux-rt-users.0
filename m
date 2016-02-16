From: Clark Williams <williams@redhat.com>
Subject: Re: [ANNOUNCE] 4.4.1-rt6
Date: Tue, 16 Feb 2016 13:19:32 -0600
Message-ID: <20160216131932.7a7c8abd@sluggy.hsv.redhat.com>
References: <20160212234708.GB7694@linutronix.de>
	<20160215225358.135e9227@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/0h.eoOC8z/6Z5bHQpKTAi+G"; protocol="application/pgp-signature"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160215225358.135e9227@sluggy.hsv.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/0h.eoOC8z/6Z5bHQpKTAi+G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Feb 2016 22:53:58 -0600
Clark Williams <williams@redhat.com> wrote:

> On Sat, 13 Feb 2016 00:47:08 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>=20
> > - There is a useless rcu_bh thread which has been deactivated.
> >  =20
>=20
> For some strange reason I had RCU_TORTURE_TEST defined in my config. This=
 caused my compile to blow up because kernel/rcu/rcutorture.c wanted to tes=
t the (now ifdef'ed out) rcu_bh routines. This fixes the compile issue but =
is untested for actually *running* rcutorture. I'll try that on a test box =
tomorrow.=20
>=20
>

Successfully ran rcutorture for 5m on my test system with no errors reporte=
d and no _bh_ threads started.=20

Clark

--Sig_/0h.eoOC8z/6Z5bHQpKTAi+G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJWw3ZEAAoJEOI5asVwYXLrbsAP/1x25WZT84cfIAIoXvyC9lg3
FznPTI/974g2qXjy6ouqG86qOmTYpsQzwJPMACQFEzKgzbgjhy6HUmh/HL2zIlOM
x7uarhAQPIMsJ0TejDSLg5Vjn+eh/2IH02Er506h7qEtpp2YWzLIRdCmRoBMiSQ4
z1lJMW+PTcZ+dyioh0BjMYdzKaaRI+yeYdenCvH7ab2n50oT6lQfvpK/lGXAzYGJ
XhAAxmsyksUadr/Cuu0OGw7sB9H0iLQDGuP5/o20t+c2rFICXHI8+ieeEOEUxjIg
gaorAeewA20yA3gcv9fCLFgZmo2lG1tNF2GMp7dRHcF9RLhIqe7DJpe1Iki4nYQx
UyDoyvlWoyLmxYIE0uctZV2ByHXSMAgleLZ63N0sKfTigcWooPvr3WNvefEbs9HS
UJDssmZEgfkgU9LFVJEdl0IdA0pIzrz37rw/xHtxZV4Z4k79GqsdeASNm/j7r2zk
JBOCuAvKBQwyQmLQKQL3wVwMVSMRRpT8kx34qClNQnWLLwTVOVc4oTiOe/0OMPrr
psYpzTWTuLVG2/LRz/wd8bvFd25l3Q/qUdiaCAMLVYqN57tfI4/UDf6Ph8CxQAlC
z8FeFlQyR2ioVd5XZPD16SOgMLqIZ3brYC+WPnyRad38a5kb6gTTmsiDJZ/+FfBB
2Fjtx3kH7pZVQOcmnsAN
=1rGi
-----END PGP SIGNATURE-----

--Sig_/0h.eoOC8z/6Z5bHQpKTAi+G--
