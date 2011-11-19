From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 4/5] dm: Make rt aware
Date: Fri, 18 Nov 2011 23:45:14 -0500
Message-ID: <20111119044835.609032911@goodmis.org>
References: <20111119044510.811163517@goodmis.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="00GvhwF7k39YY"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0004-dm-Make-rt-aware.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--00GvhwF7k39YY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Thomas Gleixner <tglx@linutronix.de>

Use the BUG_ON_NONRT variant for the irq_disabled() checks. RT has
interrupts legitimately enabled here as we cant deadlock against the
irq thread due to the "sleeping spinlocks" conversion.

Reported-by: Luis Claudio R. Goncalves <lclaudio@uudg.org>
Cc: stable-rt@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/md/dm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 41abc6d..67207d6 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1644,14 +1644,14 @@ static void dm_request_fn(struct request_queue *q)
 		if (map_request(ti, clone, md))
 			goto requeued;
=20
-		BUG_ON(!irqs_disabled());
+		BUG_ON_NONRT(!irqs_disabled());
 		spin_lock(q->queue_lock);
 	}
=20
 	goto out;
=20
 requeued:
-	BUG_ON(!irqs_disabled());
+	BUG_ON_NONRT(!irqs_disabled());
 	spin_lock(q->queue_lock);
=20
 delay_and_out:
--=20
1.7.7.1



--00GvhwF7k39YY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOxzUjAAoJEIy3vGnGbaoAmV4P/2Z616vgSJXD0NLmviFphzp2
rq0iPHZkSgq9xLDXbPOLdTjpar4QdJ+nl5nr/g4sqeNneorKzoTBFF5PV2U6fOrG
dKZPu1YjYaf+1AnJhja1kEJBU4ZsuPRGsA78TCVXXrr+Nudc/SyRJfBaH50r0iiP
CbMMLGRYBiyWZHK1nacB6c6n1uvdj5X5KnuDxPDFi8Q2CcmBoAyJT87t4QSdeLnd
jKppshVsLW/VJ7rR2vxr2T0TLAXo14ml5yDI4ijSsrO44uQQxRNh8QjU08YafFsO
MZGFVW8+GdcUegUqSgN7dtGmLOrtyi0lCMLMLhjA1H1QSjIFSc6VaYFdf1B3bcjs
yxoCNBDXqHsql29viVMbUZ20n8ejeMuxp9R1GYPVHzuJS8afZoUMqqhLIWkcl/d3
QZfIQPnXSIBEw2ThTMMUDxEgnpQN+GUBrUDuKD1nG0oKRHu1PhBiqAeFAq7NqyZh
7wFn8E4yZ1f6tQ0sa7iEN1HbwfCNOfZ21qTCvoqePCt8Yjprth/Wx+RmONuz2qiT
uZRRorWA+worGcUWfRO/k8IkVGU5gYY1W9kVQ6yunJt+SzfI/5o1FPJVF8qxRSP1
CfVzSrin93RXe4zyLSmRLJhDaxhKpOjzzbzz6/rkVWrJsDuUlM8xV2nnivxyqYeE
O8W1SYXfXFQlJmBkyJAE
=w7Qw
-----END PGP SIGNATURE-----

--00GvhwF7k39YY--
