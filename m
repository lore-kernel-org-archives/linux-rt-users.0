From: Clark Williams <williams@redhat.com>
Subject: Re: [RFC][PATCH 0/3] tracing: Add Hardware Latency detector tracer
Date: Tue, 9 Aug 2016 13:15:16 -0500
Message-ID: <20160809131516.6a83e93e@sluggy.hsv.redhat.com>
References: <20160804145708.158968389@goodmis.org>
	<20160804113033.78132a93@gandalf.local.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/g=e.BAs97YUI.wtvYg9a/sO"; protocol="application/pgp-signature"
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jon Masters <jcm@redhat.com>, Daniel Wagner <wagi@monom.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>,
	Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160804113033.78132a93@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/g=e.BAs97YUI.wtvYg9a/sO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Aug 2016 11:30:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Note, I'm currently working on adding code to detect NMIs to this as
> well. And perhaps even tracing SMI counters. Just to show what caused
> the latency, as latency isn't measured by the counters (that I know of).
>=20

I like the trace report, but for one small thing; I think it's worth either=
 adding units to the reported latency values (us suffix) or putting in a he=
ader line that hwlatdetect values are reported in microseconds.

>    <...>-2644  [001] d...   202.735708: [99] inner:13 outer:16 ts:1470352=
534.886878855
>    <...>-2644  [001] d...   206.767274: [100] inner:14 outer:18747 ts:147=
0352538.917966818 smi-total:2
>    <...>-2644  [002] d...   207.775164: [101] inner:0 outer:19162 ts:1470=
352539.920988709 smi-total:6
>    <...>-2644  [003] d...   208.783067: [102] inner:19376 outer:19276 ts:=
1470352540.923010578 smi-total:6
>    <...>-2644  [000] d...   209.827416: [103] inner:19650 outer:20665 ts:=
1470352541.926032469 smi-total:6
>    <...>-2644  [001] d...   210.831062: [104] inner:20526 outer:20680 ts:=
1470352542.973055312 smi-total:6

Clark

--=20
The United States Coast Guard:
Ruining natural selection since 1790

--Sig_/g=e.BAs97YUI.wtvYg9a/sO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXqh20AAoJEOI5asVwYXLrEWAP/0f2aQf9Fta6uazE7759ijuq
b0dB+JwrJEi2+15pXZhk5JmF7vq3Bt3YgDk4hkLzMNyqiI/FLN/U3lL/LWhgDaY3
a2PUe9H++W6PfGh8ITqEUzKGp7bfw1W8YS1hc/7De2M5Zmr6sbDWDFuBBRSynsak
7ZzYnmuefDbYCvSV6CQWZ+ib/faUhvj7C58zYaBxP1fsWxiVykjXr6R1CGOPBUTt
06Dl5FOrlJCZxfkvRuk+oi57am107xhET+0Dd34Sl/L7wUPBqnRGM6WPlP7uJ6KD
Jsei0ESsZRMWVwg7wCORgsUWYpti/ZVfbJJxViHnPbdzVmSCEY/YfmTla0CibY8r
5n681c9YT8PoW7I62QSJftv+L4tnzmDQ0KM4volP51LRQQPsmgGzxhGdfD66sQrY
da/acJc/f0atHOCojZDvnUItILQgFocuh+iAjKjzwz5EQWjMxpKAEHyD5giIxV5O
dzByRj+16Yxc08H0ypwTUVvbt0epIr9I+4rtBYp9xMzJpdHyUoseF4k3SI/0PUrC
QRpBfwfuYYhruGT7m/6Rhuvgsbp5DyKSJ86mErIAhB1z48Ec8+IaFjVTXg6xmnU/
A/2caIdo5oOtnePQj4XEVhacal3IUSq9SA+jRfqX0eF+fsePcF2/kPzByj3B0DiZ
DHkMXVC+RbShcc37/Vx5
=1eqv
-----END PGP SIGNATURE-----

--Sig_/g=e.BAs97YUI.wtvYg9a/sO--
