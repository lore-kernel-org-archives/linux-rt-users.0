From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: Host latency peaks due to kvm-intel
Date: Sat, 25 Jul 2009 11:55:42 +0200
Message-ID: <4A6AD69E.7030201@web.de>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com> <4A6981B0.3000008@siemens.com> <4A6ABF28.1010602@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2265B4128C78200ECEFA2466"
Cc: Gregory Haskins <gregory.haskins@gmail.com>,
	kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Avi Kivity <avi@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <4A6ABF28.1010602@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2265B4128C78200ECEFA2466
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Avi Kivity wrote:
> On 07/24/2009 12:41 PM, Jan Kiszka wrote:
>> I vaguely recall that someone promised to add a feature reporting
>> facility for all those nice things, modern VM-extensions may or may no=
t
>> support (something like or even an extension of /proc/cpuinfo). What i=
s
>> the state of this plan? Would be specifically interesting for Intel CP=
Us
>> as there seem to be many of them out there with restrictions for speci=
al
>> use cases - like real-time.
>>   =20
>=20
> Newer kernels do report some vmx features (like flexpriority) in
> /proc/cpuinfo but not all.
>=20

Ah, nice. Then we just need this?

------------>

From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] x86: Report VMX feature vwbinvd

Not all VMX-capable CPUs support guest exists on wbinvd execution. If
this is not supported, the instruction will run natively on behalf of
the guest. This can cause multi-millisecond latencies to the host which
is very problematic in real-time scenarios.

Report the wbinvd trapping feature along with other VMX feature flags,
calling it 'vwbinvd' ('virtual wbinvd').

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

 arch/x86/include/asm/cpufeature.h |    1 +
 arch/x86/kernel/cpu/intel.c       |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpu=
feature.h
index 4a28d22..8647524 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -165,6 +165,7 @@
 #define X86_FEATURE_FLEXPRIORITY (8*32+ 2) /* Intel FlexPriority */
 #define X86_FEATURE_EPT         (8*32+ 3) /* Intel Extended Page Table *=
/
 #define X86_FEATURE_VPID        (8*32+ 4) /* Intel Virtual Processor ID =
*/
+#define X86_FEATURE_VWBINVD     (8*32+ 5) /* Guest Exiting on WBINVD */
=20
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
=20
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 3260ab0..2d921b0 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -297,6 +297,7 @@ static void __cpuinit detect_vmx_virtcap(struct cpuin=
fo_x86 *c)
 #define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
 #define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
 #define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
+#define X86_VMX_FEATURE_PROC_CTLS2_VWBINVD	0x00000040
=20
 	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
=20
@@ -305,6 +306,7 @@ static void __cpuinit detect_vmx_virtcap(struct cpuin=
fo_x86 *c)
 	clear_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
 	clear_cpu_cap(c, X86_FEATURE_EPT);
 	clear_cpu_cap(c, X86_FEATURE_VPID);
+	clear_cpu_cap(c, X86_FEATURE_VWBINVD);
=20
 	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
 	msr_ctl =3D vmx_msr_high | vmx_msr_low;
@@ -323,6 +325,8 @@ static void __cpuinit detect_vmx_virtcap(struct cpuin=
fo_x86 *c)
 			set_cpu_cap(c, X86_FEATURE_EPT);
 		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
 			set_cpu_cap(c, X86_FEATURE_VPID);
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VWBINVD)
+			set_cpu_cap(c, X86_FEATURE_VWBINVD);
 	}
 }
=20


--------------enig2265B4128C78200ECEFA2466
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkpq1qIACgkQniDOoMHTA+kv7ACaAh7wod2svqQLJKiqI6BnF201
hc8AnjmYpMS+nGxEEDPyPXmmyreGuSit
=W697
-----END PGP SIGNATURE-----

--------------enig2265B4128C78200ECEFA2466--
