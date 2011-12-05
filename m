From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 05/12 rc3] KVM: fix XSAVE bit scanning (now properly)
Date: Mon, 05 Dec 2011 18:00:51 -0500
Message-ID: <20111205230255.683826536@goodmis.org>
References: <20111205230046.736851081@goodmis.org>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="00GvhwF7k39YY"
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Andre Przywara <andre.przywara@amd.com>,
	Avi Kivity <avi@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=0005-KVM-fix-XSAVE-bit-scanning-now-properly.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--00GvhwF7k39YY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Andre Przywara <andre.przywara@amd.com>

commit 123108f1c1aafd51d6a5c79cc04d7999dd88a930 tried to fix KVMs
XSAVE valid feature scanning, but it was wrong. It was not considering
the sparse nature of this bitfield, instead reading values from
uninitialized members of the entries array.
This patch now separates subleaf indicies from KVM's array indicies
and fills the entry before querying it's value.
This fixes AVX support in KVM guests.

Signed-off-by: Andre Przywara <andre.przywara@amd.com>
Signed-off-by: Avi Kivity <avi@redhat.com>
---
 arch/x86/kvm/x86.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f168c61..3567c76 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2419,16 +2419,17 @@ static void do_cpuid_ent(struct kvm_cpuid_entry2 *e=
ntry, u32 function,
 		break;
 	}
 	case 0xd: {
-		int i;
+		int idx, i;
=20
 		entry->flags |=3D KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-		for (i =3D 1; *nent < maxnent && i < 64; ++i) {
-			if (entry[i].eax =3D=3D 0 || !supported_xcr0_bit(i))
+		for (idx =3D 1, i =3D 1; *nent < maxnent && idx < 64; ++idx) {
+			do_cpuid_1_ent(&entry[i], function, idx);
+			if (entry[i].eax =3D=3D 0 || !supported_xcr0_bit(idx))
 				continue;
-			do_cpuid_1_ent(&entry[i], function, i);
 			entry[i].flags |=3D
 			       KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
 			++*nent;
+			++i;
 		}
 		break;
 	}
--=20
1.7.7.1



--00GvhwF7k39YY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO3U2fAAoJEIy3vGnGbaoARYYP/jixFyVmS0JIEevd0O1K0uun
JyY1gWdtd5gWRWZvSG0SyYecg6MA/KoSCpuhFE/M3yRi1X6K+XxsuV+lfEhOgxXR
mewRytB6SqYFjRjw7yWiAz6ndhr/irq2Tqd5U8acoDAbPSy4Jlm6m4itjd4aTcfJ
1fLOgygsKBJrlw5q8JaGFh904ip96oE452/Aoc97V++AS6g0qfWk83hYfYvk90P+
pVRJLXu6/bJdh0ruinRGOErL8jGCodQL9Jjmkzta42aXDuxKqr1rdVxhHEVR+1bc
uT1DsZYOmLXq+ay6KRBrDbwMEiMi+geb1HwW13hez0jfoY+C89OtRHXKQFrnYAkW
TdctsSu4xIHw9D1Bc5cpeRAallMGbxmgWHpnyfdRSrrsl6EENHa0Aaf+lz7v2J8M
+gHyKYqWMxqYArkZu39s9A0/dJtgu9ObmZOyLOptMSiTdCCW44RLlbtp/Coa6it1
PZzPMEWBdC5nENSUNbi7oYHmjUtsG3al5iyqqsQ/Eja7EpukILoCFQWGK7c/h4eE
aTYsA12hRwBs5qjQu1DAONABctZYRFu1sg0/wkA5baEqDpdboaJkgstJLvfb/ce9
47uG/hyrhacnUscuglpMpdDmbBNhZmsxRs65ukCc11IJLrTdXomEo7QY2+VjG+l/
DjCy8fPiO8cMJjHrAqRe
=5r29
-----END PGP SIGNATURE-----

--00GvhwF7k39YY--
