From: Clark Williams <williams@redhat.com>
Subject: [PATCH][RT] - fix 32-bit breakage on rt/threadirqs branch
Date: Fri, 12 Dec 2008 14:03:21 -0600
Message-ID: <20081212140321.7dc1e04f@torg>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/dA/Hjp3GP6JUvoYgFwiGwMI"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <srostedt@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:37854 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbYLLUDc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 12 Dec 2008 15:03:32 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mBCK3Wbn023989
	for <linux-rt-users@vger.kernel.org>; Fri, 12 Dec 2008 15:03:32 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--MP_/dA/Hjp3GP6JUvoYgFwiGwMI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: base64
Content-Disposition: inline

LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQ0KSGFzaDogU0hBMQ0KDQpTdGV2ZW4s
DQoNCkF0dGFjaGVkIGlzIGEgcGF0Y2ggdGhhdCBmaXhlcyB0aGUgMzItYml0IGNvbXBpbGUgYnJl
YWthZ2UgeW91IHRvbGQgbWUNCmFib3V0IG9uIHRoZSBydC90aHJlYWRpcnFzIGJyYW5jaC4gQ29t
cGlsZXMgd2l0aCBhbiBhbGxtb2Rjb25maWcgYnVpbGQuDQoNCkNsYXJrDQotLS0tLUJFR0lOIFBH
UCBTSUdOQVRVUkUtLS0tLQ0KVmVyc2lvbjogR251UEcgdjIuMC45IChHTlUvTGludXgpDQoNCmlF
WUVBUkVDQUFZRkFrbEN3NDhBQ2drUUh5dWovK1RURXAwcjN3Q2FBajBRTjRCeExKZ2lmcnFZeEUx
dzJEcmsNCnV0a0FvSnlZU3ZiKzZ2clduNmIrSS9Td2MrNGpXVXlrDQo9SGhTMw0KLS0tLS1FTkQg
UEdQIFNJR05BVFVSRS0tLS0tDQo=

--MP_/dA/Hjp3GP6JUvoYgFwiGwMI
Content-Type: text/x-patch; name=fix-32-bit-breakage.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=fix-32-bit-breakage.patch

=46rom e1d9cd6f8aa7261cbf299ad222e7e7cf8b0cce65 Mon Sep 17 00:00:00 2001
From: Clark Williams <williams@redhat.com>
Date: Fri, 12 Dec 2008 12:21:04 -0600
Subject: [PATCH] fixed 32-bit breakage in arch/x86/kernel/io_apic.c

I pulled in the wrong functions when merging 32 and 64-bit for threaded
IRQs, then didn't test the 32-bit build. Builds now with allmodconfig.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 arch/x86/kernel/io_apic.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/io_apic.c b/arch/x86/kernel/io_apic.c
index 311d003..a66efd7 100644
--- a/arch/x86/kernel/io_apic.c
+++ b/arch/x86/kernel/io_apic.c
@@ -2412,10 +2412,8 @@ static void ack_apic_level(unsigned int irq)
 	if (!(v & (1 << (i & 0x1f)))) {
 		atomic_inc(&irq_mis_count);
 		spin_lock(&ioapic_lock);
-		/* mask =3D 1, trigger =3D 0 */
-		__modify_IO_APIC_irq(irq, 0x00010000, 0x00008000);
-		/* mask =3D 0, trigger =3D 1 */
-		__modify_IO_APIC_irq(irq, 0x00008000, 0x00010000);
+                __mask_and_edge_IO_APIC_irq(irq);
+                __unmask_and_level_IO_APIC_irq(irq);
 		spin_unlock(&ioapic_lock);
 	}
 #endif
--=20
1.5.5.1


--MP_/dA/Hjp3GP6JUvoYgFwiGwMI--
