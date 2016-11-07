From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] sched/rt: RT_RUNTIME_GREED sched feature
Date: Mon, 7 Nov 2016 12:22:21 -0600
Message-ID: <20161107122221.299d026a@tagon>
References: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/5uxCTfXvNwJ7aSQBeLDZvCB"; protocol="application/pgp-signature"
Cc: Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christoph Lameter <cl@linux.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Daniel Bristot de Oliveira <bristot@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fa5b1b55d8934c6a0e02e04a7ad6afdf4012c2e0.1478506194.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--Sig_/5uxCTfXvNwJ7aSQBeLDZvCB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon,  7 Nov 2016 09:17:55 +0100
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> The rt throttling mechanism prevents the starvation of non-real-time
> tasks by CPU intensive real-time tasks. In terms of percentage,
> the default behavior allows real-time tasks to run up to 95% of a
> given period, leaving the other 5% of the period for non-real-time
> tasks. In the absence of non-rt tasks, the system goes idle for 5%
> of the period.
>=20
> Although this behavior works fine for the purpose of avoiding
> bad real-time tasks that can hang the system, some greed users
> want to allow the real-time task to continue running in the absence
> of non-real-time tasks starving. In other words, they do not want to
> see the system going idle.
>=20
> This patch implements the RT_RUNTIME_GREED scheduler feature for greedy
> users (TM). When enabled, this feature will check if non-rt tasks are
> starving before throttling the real-time task. If the real-time task
> becomes throttled, it will be unthrottled as soon as the system goes
> idle, or when the next period starts, whichever comes first.
>=20
> This feature is enabled with the following command:
>   # echo RT_RUNTIME_GREED > /sys/kernel/debug/sched_features
>=20

I'm still reviewing the patch, but I have to wonder why bother with making =
it a scheduler feature?

The SCHED_FIFO definition allows a fifo thread to starve others because a f=
ifo task will run until it yields. Throttling was added as a safety valve t=
o allow starved SCHED_OTHER tasks to get some cpu time.  Adding this uncond=
itionally gets us a safety valve for throttling a badly written fifo task, =
but allows the fifo task to continue to consume cpu cycles if it's not star=
ving anyone.=20

Or am I missing something that's blazingly obvious?

Clark

--Sig_/5uxCTfXvNwJ7aSQBeLDZvCB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJYIMZdAAoJEOI5asVwYXLrByAQALbmfo/WfrMfMC26NC/KErih
WIanExsJvMjhrfQHe5FstT74g9YXGiTnvvP9oKrMFsPnrnzWUBzZfHsq3hDQ/Ey6
1KGqxmUyn8qgyUw4c2lViC1OnynZj3bHt0BTLQG2ZhgDyUYoGaxDyLCVuUj3Atsq
t+PDMRNn98VMqNLIU53bzHi0uYzyojXZaajVZ0DRFi2QTOTW5GbM8x+9Hqk5csMJ
yS9ub4uhy4VvDdJ/TssuUSIZ4EJmcvoQLh94o95RSq4jBEJ01mygqt9BVh34jMCZ
7KmrxqO6uztkrlCjXGVDSRX/K4TvADh3EfDsjRTLB1UCJepCBYNx5RcPf0YWq4a2
dvvK2ko1oWJNnll/wOdlC+z1o57NvA86iQQ6TGP8sb9W92V8nEmVKWZUGCHRawEX
MD0KBlq+0OvPQUiJ6jbSMl7yBVE2zmfNOaZFLpb+P4/vpCj449yDubZfbWh3d8lv
WRKmosDyEN3skfpLUZ1QYBNUJq2YgNdLZNVf4Td84uBuUjg6kURoEVBKPPpbOldE
uFJE1HyUYxS3d1Ko0KglXGCJHzGSfcLmD3p1cON5LETHu8vO9AcQz8yZSr5nAu3W
d+YTtQ/7q2L/RJQxYucdEopkrwhP9nbd/uzc8M8+RRoDdCGLhsVndbuiPK24A7mF
PhhQ7eJU5UX6x6lNXCZo
=OJOi
-----END PGP SIGNATURE-----

--Sig_/5uxCTfXvNwJ7aSQBeLDZvCB--
