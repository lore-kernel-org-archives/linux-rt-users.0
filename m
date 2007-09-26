From: "David Bahi" <dbahi@novell.com>
Subject: nmi_watchdog fix for x86_64 to be more like i386
Date: Wed, 26 Sep 2007 12:03:12 -0600
Message-ID: <46FA4A800200006C000192FE@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartBA9D0BF0.1__="
Cc: <tglx@linutronix.de>, "Gregory Haskins" <GHaskins@novell.com>
To: <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:8930 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666AbXIZSDW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 14:03:22 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--=__PartBA9D0BF0.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Thanks to tglx and ghaskins for all the help in tracking down a very
early nmi_watchdog crash on certain x86_64 machines.


--=__PartBA9D0BF0.1__=
Content-Type: text/plain; name="watchdog_use_timer_and_hpet_on_x86_64.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="watchdog_use_timer_and_hpet_on_x86_64.patch"

This modifies nmi_watchdog_tick behavior for=20
x86_64 arch to consider both timer and hpet IRQs
just as the i386 arch does.

Signed-off-by: David Bahi <dbahi@novell.com>

---
 arch/x86_64/kernel/nmi.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6.22.8-rt9_1267/arch/x86_64/kernel/nmi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22.8-rt9_1267.orig/arch/x86_64/kernel/nmi.c
+++ linux-2.6.22.8-rt9_1267/arch/x86_64/kernel/nmi.c
@@ -369,8 +369,6 @@ int notrace __kprobes nmi_watchdog_tick(
 		touched =3D 1;
 	}
=20
-	sum =3D read_pda(apic_timer_irqs);
-
 	if (__get_cpu_var(nmi_touch)) {
 		__get_cpu_var(nmi_touch) =3D 0;
 		touched =3D 1;
@@ -386,6 +384,12 @@ int notrace __kprobes nmi_watchdog_tick(
 		cpu_clear(cpu, backtrace_mask);
 	}
=20
+	/*
+	 * Take the local apic timer and PIT/HPET into account. We don't
+	 * know which one is active, when we have highres/dyntick on
+	 */
+	sum =3D read_pda(apic_timer_irqs) + kstat_cpu(cpu).irqs[0];
+
 #ifdef CONFIG_X86_MCE
 	/* Could check oops_in_progress here too, but it's safer
 	   not too */

--=__PartBA9D0BF0.1__=
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4yIChHTlUv
TGludXgpCgppRDhEQlFCRytwMzFIMjhKSFlhekxhUVJBZ1FYQUo0eitpbXBpNDg2M25kaUh4RnhS
UDVyeGVUN1FBQ2d3dmpICjdpck12eWZZcGc3ajh4a0M4WmNQdVd3PQo9YlpDeAotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--=__PartBA9D0BF0.1__=--
