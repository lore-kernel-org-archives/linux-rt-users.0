From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [PATCH v2 RT 3.18] irq_work: Provide a soft-irq based queue
Date: Fri, 15 May 2015 09:43:14 +0200
Message-ID: <5555A392.1050203@web.de>
References: <5538A0DF.50401@siemens.com> <20150514195811.GJ13442@linutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="WEmAAsRuFw28C1u4pdj95Lvhfva9hfWbE"
Cc: RT <linux-rt-users@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mike Galbraith <umgwanakikbuti@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150514195811.GJ13442@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WEmAAsRuFw28C1u4pdj95Lvhfva9hfWbE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2015-05-14 21:58, Sebastian Andrzej Siewior wrote:
> * Jan Kiszka | 2015-04-23 09:35:59 [+0200]:
>=20
>> Instead of turning all irq_work requests into lazy ones on -rt, just
>> move their execution from hard into soft-irq context.
>>
>> This resolves deadlocks of ftrace which will queue work from arbitrary=

>> contexts, including those that have locks held that are needed for
>> raising a soft-irq.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Applied

The thread went on, and Mike suggested an alternative implementation [1]
that works fine and is even cleaner. Let's pick his.

Jan

[1] http://thread.gmane.org/gmane.linux.kernel/1937960



--WEmAAsRuFw28C1u4pdj95Lvhfva9hfWbE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlVVo5IACgkQitSsb3rl5xT/FgCeIE05qXf3DpPNPCFuKIeDGB3n
BI8AoJ06Aw3EnUu9ryI1lDXQGYU3TshL
=dXrS
-----END PGP SIGNATURE-----

--WEmAAsRuFw28C1u4pdj95Lvhfva9hfWbE--
