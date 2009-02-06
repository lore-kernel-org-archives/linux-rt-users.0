From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: Hard lockup with 2.6.24.7-rt26 on x86 - cause found
Date: Fri, 06 Feb 2009 07:39:47 -0500
Message-ID: <498C2F93.9090405@novell.com>
References: <49725.1233916457@vtxmail.ch> <1233919704.10894.5.camel@laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC456B1216A67CCC1FEA983D3"
Cc: m.luescher@vtxmail.ch,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten.Emde@osadl.org, rostedt@goodmis.org,
	Thomas Gleixner <tglx@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:43054 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863AbZBFMhH (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Feb 2009 07:37:07 -0500
In-Reply-To: <1233919704.10894.5.camel@laptop>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC456B1216A67CCC1FEA983D3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Peter Zijlstra wrote:
> On Fri, 2009-02-06 at 11:34 +0100, Matthias Luescher wrote:
>  =20
>> Hi
>>
>> I finally found out which patch does not work well with my configurati=
on:
>>
>> 2.6.24.7-rt12 seems to be ok, with 2.6.24.7-rt13 the command cyclictes=
t -p99 -t10 -n -i250 crashes the kernel.
>>
>> 2.6.24.7-rt13 has the follwing new patches:
>> ftrace-hotplug-fix.patch
>> ftrace-wakeup-rawspinlock.patch
>> radix-tree-lockdep-plus1.patch
>> sched-cpupri-hotplug-support.patch
>> sched-cpupri-priocount.patch
>>
>> No I went again to 2.6.24.7-rt26 but removed some patches:
>> 2.6.24.7-rt26 with all patches -> CRASH
>> 2.6.24.7-rt26 without sched-cpupri-hotplug-support.patch and without s=
ched-cpupri-priocount.patch ->OK
>> 2.6.24.7-rt26 without sched-cpupri-hotplug-support.patch ->CRASH
>>    =20
>
> sched-cpupri-priocount.patch is buggy
>
> +#define CPUPRI_NR_PRI_WORDS (CPUPRI_NR_PRIORITIES + BITS_PER_LONG/2)/B=
ITS_PER_LONG
>  =20

Thomas fixed this somewhere along the way with the inlined patch.=20
Steven, this should be pulled into all actively maintained -rt branches
that do not already have it.

commit e539d8fcd11af811db70707d47ea436d5621d0da
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Thu Jun 5 10:28:00 2008 +0200

    sched: fix the cpuprio count really
  =20
    Peter pointed out that the last version of the "fix" was still one of=
f
    under certain circumstances. Use BITS_TO_LONG instead to get an
    accurate result.
  =20
    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/kernel/sched_cpupri.h b/kernel/sched_cpupri.h
index 6b38355..f25811b 100644
--- a/kernel/sched_cpupri.h
+++ b/kernel/sched_cpupri.h
@@ -3,8 +3,8 @@
=20
 #include <linux/sched.h>
=20
-#define CPUPRI_NR_PRIORITIES 2+MAX_RT_PRIO
-#define CPUPRI_NR_PRI_WORDS (CPUPRI_NR_PRIORITIES +
BITS_PER_LONG/2)/BITS_PER_LONG
+#define CPUPRI_NR_PRIORITIES   (MAX_RT_PRIO + 2)
+#define CPUPRI_NR_PRI_WORDS    BITS_TO_LONGS(CPUPRI_NR_PRIORITIES)
=20
 #define CPUPRI_INVALID -1
 #define CPUPRI_IDLE     0



--------------enigC456B1216A67CCC1FEA983D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkmML5QACgkQlOSOBdgZUxmVVACgitXFI7rk1tG/PhMtRoICm9xN
5nMAnjRHE6bYK8yeXpnkosmBOsP7fsue
=0wiU
-----END PGP SIGNATURE-----

--------------enigC456B1216A67CCC1FEA983D3--
