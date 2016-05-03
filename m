From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclictest: stop any tracing after hitting a breaktrace
 threshold
Date: Tue, 3 May 2016 15:28:39 -0500
Message-ID: <20160503152839.4543a973@sluggy.hsv.redhat.com>
References: <20160503125953.1987bedd@sluggy.hsv.redhat.com>
	<20160503155644.0aa34c34@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/AML.4YLjPj//fN.y/UYozht"; protocol="application/pgp-signature"
Cc: John Kacur <jkacur@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35568 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756388AbcECU2p (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 May 2016 16:28:45 -0400
In-Reply-To: <20160503155644.0aa34c34@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_/AML.4YLjPj//fN.y/UYozht
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 3 May 2016 15:56:44 -0400
Luiz Capitulino <lcapitulino@redhat.com> wrote:

> On Tue, 3 May 2016 12:59:53 -0500
> Clark Williams <williams@redhat.com> wrote:
>=20
> > John,
> >=20
> > This patch is against the devel/v0.98 branch. It turns off tracing in t=
he tracemark() so that we don't lose information about what was going on wh=
en we hit the latency:
> >=20
> >=20
> > The current logic of using --tracemark and --notrace works for running
> > cyclictest with trace-cmd, but even if we are not doing any trace
> > manipulation in cyclictest, we still need to stop tracing when we hit a
> > breaktrace threshold (i.e. -b <n>). =20
>=20
> Does it solve the problem for you if you revert ba4dd1bf54 and start
> cyclictest with:
>=20
> # cyclictest [...] -bX
>=20
> Or with:
>=20
> # cyclictest [...] -bX --tracemark
>=20
> Also, how do I reproduce your issue? Are you doing tracing by hand?

I'm running:=20
	trace-cmd start -e all -p function

Then kicking off loads and finally running:
	cyclictest --numa -p95 -qmu -b 300 --tracemark --notrace

The intent here is that cyclictest do nothing wrt tracing other than stop i=
t when the breaktrace threshold is set.=20


> > +
> > +	/* write the tracemark message */
> >  	write(tracemark_fd, tracebuf, len);
> > +
> > +	/* now stop any trace */
> > +	write(trace_fd, "0\n", 2);
> >  } =20
>=20
> We do tracing(0) when we hit the latency threshold, so I don't
> think this is necessary.

Tracing didn't seem to stop in my scenario above. I suspect it's the --notr=
ace option, which I used to make absolutely certain we didn't touch any tra=
cing bits.=20

>=20
> However, have you checked that writing to tracing_on won't break
> trace-cmd when it exec()ed cyclictest?
>=20

I haven't run cyclictest as a child of trace-cmd. I'll try that, but my use=
-case is really in running rteval, which runs cyclictest as a measurement t=
ool. So for tracing I need to to 'trace-cmd start' before running rteval.=20

The intent is to be able to do something like this:

    trace-cmd start -e all -p function
    rteval --duration=3D12h --cyclictest-breaktrace=3D150
    trace-cmd extract

That sets a breaktrace threshold of 150 microseconds so that if we terminat=
e the run early, I'll have an ftrace file I can use narrow down on what's c=
ausing latency spikes.=20

Clark

--Sig_/AML.4YLjPj//fN.y/UYozht
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXKQn3AAoJEOI5asVwYXLro2QP/1dB6XaG/zo6utJR0yqWUSR8
4Py1rw0QbFQM0EzfYnrIl/ECRt8rfrZBi++BnLnp++DfSyTmpkCl50nrzNilS4mZ
x6gAHXmYiY28c0pApvzr2nwd5NLT5eEEUnYLXmonYRehDO1cjE3OA8vEqFxO7BmO
9eeJ918/WiXIpnHrkw7TLaBFydIwb3JSOd5wOUc6qyrMBaVMTIDHeKH0V/Yz9IVa
KdsEYHH+uZg5+7CyLLxfB5QKnFwBowfRNo9djFs3d8tu12NJumpbOrkebEdfqvF9
Jn3a8jishP8IMEmo0nGGbgSdCVMztDB2HaNJZ85vUJVW3ZEgx1opRpxCBrvnupJt
GmuLd/894oGM9KfUj6TLj0NnQlfD2mEGCFmbgEk2G+uXooohH9lynkuu/jcVY8Iz
N9yvPjWkUVuxX9PLDyYe5mV1CPSWlPPru22a75LdENgcYpu/2Oy7QYKNYZH1Wd//
ZX/LMRnZ6x2tNw5dL3qcHrygsVJCUtsMk6G4byuUclCIm3x5cfSbW8liermPtiiN
VDBT5DFr78epvVRrsQmG+0LGVAwyaVH+YeiAV4CiMmK9JLIPrTi+FP+Q9wYRVePO
ErIvlUA3S2ZaaOkGtGQ07cMdiCiK9bpwUyaMGWj6VWanYkUTxOSINUJJsv28Ta5z
9j/FlC8ogU5VuqCA6cbg
=Z48u
-----END PGP SIGNATURE-----

--Sig_/AML.4YLjPj//fN.y/UYozht--
