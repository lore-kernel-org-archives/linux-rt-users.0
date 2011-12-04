From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 02/11] genirq: fix regression in irqfixup, irqpoll
Date: Sun, 04 Dec 2011 13:54:46 -0500
Message-ID: <20111204190002.599581896@goodmis.org>
References: <20111204185444.411298317@goodmis.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="00GvhwF7k39YY"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Edward Donovan <edward.donovan@numble.net>,
	stable@kernel.org ("2.6.39+")
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0002-genirq-fix-regression-in-irqfixup-irqpoll.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--00GvhwF7k39YY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Edward Donovan <edward.donovan@numble.net>

Commit fa27271bc8d2("genirq: Fixup poll handling") introduced a
regression that broke irqfixup/irqpoll for some hardware configurations.

Amidst reorganizing 'try_one_irq', that patch removed a test that
checked for 'action->handler' returning IRQ_HANDLED, before acting on
the interrupt.  Restoring this test back returns the functionality lost
since 2.6.39.  In the current set of tests, after 'action' is set, it
must precede '!action->next' to take effect.

With this and my previous patch to irq/spurious.c, c75d720fca8a, all
IRQ regressions that I have encountered are fixed.

Signed-off-by: Edward Donovan <edward.donovan@numble.net>
Reported-and-tested-by: Rog=C3=A9rio Brito <rbrito@ime.usp.br>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@kernel.org (2.6.39+)
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 kernel/irq/spurious.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index bfe1004..d09e0f5 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -84,7 +84,9 @@ static int try_one_irq(int irq, struct irq_desc *desc, bo=
ol force)
 	 */
 	action =3D desc->action;
 	if (!action || !(action->flags & IRQF_SHARED) ||
-	    (action->flags & __IRQF_TIMER) || !action->next)
+	    (action->flags & __IRQF_TIMER) ||
+	    (action->handler(irq, action->dev_id) =3D=3D IRQ_HANDLED) ||
+	    !action->next)
 		goto out;
=20
 	/* Already running on another processor */
--=20
1.7.7.1



--00GvhwF7k39YY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO28MyAAoJEIy3vGnGbaoA61IQAJl+l7oQkA5wS3kSPfvCUzk8
IycVSVNbGPuK0saqkaDCSKmGGj9jtAwKfPKKSDp27sLajQvJbVyVDpry4O37AKwY
KP7NVt3OW1QI0SWM7Sqipe8P8Qgf5LZplQwV4hhEyfDdPIoKWMcDSFX0lr4NCNaJ
0KHb2VZu7kEwLP9n20YWZgrgMzJbEdHQFRpxLFntGzkXl5qCQJYgEoWhNdMDWNA3
BroIZlW9mvoZHUhIvGEQqfFS0o9XuZAFlrj3YhxbAK9BCe19zsk4Qm6w03WQjyJX
+JtJ3IW6SzdRVqiekZxOEIW39heL1pOv7qsBpRf//UPr5j3I47gww3k0glh5yWMw
QzgIWYsFf4JOjGTKZuF2K3zDKIHkkePFxVyx7ddJZK6KzLiAikdH0i1hgHjzApA9
U1NwWwSGqvyfdYhPKCeaNk2x/c0T9En1kLw+729ADCgzavAMUpOzqdEKQlc7QYrm
1Pvm0qvcPXgpIMSTvWlRlyGjRdR1vFZTrNPChzNVomr+h8Tf48H03q0wv8q/Mw6K
hYbMCoApl7wkjp3Kgk8nqucmjs//8giAbzInLMM5tcMxrC2pwLWmUbiGH8gL2bAV
sdt8o3yY/9tcq7ED6urliCieB9Gc9DVzMIZ0j1qRHAkR2y3TOn+KyEiqDtH4rPyD
T+sFU+W+nVqFRFGc67/o
=wZCa
-----END PGP SIGNATURE-----

--00GvhwF7k39YY--
