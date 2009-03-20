From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [Announce] 2.6.29-rc8-rt2
Date: Fri, 20 Mar 2009 20:25:21 +0100
Message-ID: <20090320192521.GH6224@elte.hu>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain> <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain> <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain> <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain> <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain> <alpine.LFD.2.00.0903122013230.29264@localhost.localdomain> <alpine.LFD.2.00.0903200014320.29264@localhost.localdomain> <alpine.LFD.2.00.0903201832590.29264@localhost.localdomain> <1237576751.8951.146.camel@lexx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:52313 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689AbZCTTZj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Mar 2009 15:25:39 -0400
Content-Disposition: inline
In-Reply-To: <1237576751.8951.146.camel@lexx>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


* Will Schmidt <will_schmidt@vnet.ibm.com> wrote:

> On Fri, 2009-03-20 at 18:45 +0100, Thomas Gleixner wrote:
> > We are pleased to announce the next update to our new preempt-rt
> > series.
> >    =20
> >      - resurrected ARM and PowerPC support
> >      - tracing fixes for ARM (Uwe Kleine-Koenig)
> >=20
> > The support for ARM/PowerPC has only been lightly tested. It might
> > crash and burn your system, make your hair curl, frigthen your cat =
and
> > give you sleepless nights. You have been warned !
>=20
> During a build attempt on powerpc, I am seeing:
>=20
> In file included from include/linux/mmzone.h:776,
>                  from include/linux/gfp.h:5,
>                  from include/linux/slab.h:13,
>                  from include/linux/percpu.h:6,
>                  from include/linux/rcupdate.h:40,
>                  from include/linux/rculist.h:11,
>                  from include/linux/dcache.h:7,
>                  from include/linux/fs.h:299,
>                  from init/do_mounts_rd.c:4:
> /root/linux-2.6.29-rc8/arch/powerpc/include/asm/mmzone.h:32: error:
> expected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=
=99, =E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before
> =E2=80=98numa_cpumask_lookup_table=E2=80=99
> In file included from include/linux/topology.h:35,
>                  from include/linux/gfp.h:8,
>                  from include/linux/slab.h:13,
>                  from include/linux/percpu.h:6,
>                  from include/linux/rcupdate.h:40,
>                  from include/linux/rculist.h:11,
>                  from include/linux/dcache.h:7,
>                  from include/linux/fs.h:299,
>                  from init/do_mounts_rd.c:4:
> /root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h: In functi=
on
> =E2=80=98node_to_cpumask=E2=80=99:
> /root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h:22: error:
> =E2=80=98numa_cpumask_lookup_table=E2=80=99 undeclared (first use in =
this function)
> /root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h:22: error:
> (Each undeclared identifier is reported only once
> /root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h:22: error:
> for each function it appears in.)
> /root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h: In functi=
on
> =E2=80=98node_to_first_cpu=E2=80=99:
> /root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h:29: error:
> =E2=80=98numa_cpumask_lookup_table=E2=80=99 undeclared (first use in =
this function)
> make[1]: *** [init/do_mounts_rd.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
>=20
>=20
>=20
> I have locally fixed by adding an include just above the cpumask_t
> reference.  The include may belong elsewhere, but in case I got it
> right,.. :-)
>=20
> Signed-Off-By:  Will Schmidt <will_schmidt@vnet.ibm.com>

you got it right :-) The full fix (the bug also affects sparc) is=20
already queued up - see it below.

	Ingo

-------------->
=46rom 0c7e5b187fc599a40c1e6392926424d26cd0cf41 Mon Sep 17 00:00:00 200=
1
=46rom: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 19 Mar 2009 22:03:22 +1100
Subject: [PATCH] numa, cpumask: move numa_node_id default implementatio=
n to topology.h, fix

Impact: build fix for powerpc and sparc

Today's linux-next build (powerpc allyesconfig) failed like this:

> In file included from include/linux/mmzone.h:776,
>                  from include/linux/gfp.h:5,
>                  from include/linux/kmod.h:23,
>                  from include/linux/module.h:14,
>                  from init/version.c:11:
> arch/powerpc/include/asm/mmzone.h:32: error: expected '=3D', ',', ';'=
, 'asm' or '__attribute__' before 'numa_cpumask_lookup_table'

Caused by commit 082edb7bf443eb8eda15b482d16ad9dd8137ad24 ("numa,
cpumask: move numa_node_id default implementation to topology.h") from
the cpus4096 tree which removed the include of linux/topology.h from
linux/mmzone.h.

Same for sparc64 defconfig.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-b: Rusty Russell <rusty@rustcorp.com.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
LKML-Reference: <20090319220322.3baa4613.sfr@canb.auug.org.au>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/powerpc/include/asm/mmzone.h |    1 +
 arch/sparc/include/asm/mmzone.h   |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/a=
sm/mmzone.h
index 19f299b..35acac9 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -8,6 +8,7 @@
 #define _ASM_MMZONE_H_
 #ifdef __KERNEL__
=20
+#include <linux/cpumask.h>
=20
 /*
  * generic non-linear memory support:
diff --git a/arch/sparc/include/asm/mmzone.h b/arch/sparc/include/asm/m=
mzone.h
index ebf5986..e8c6487 100644
--- a/arch/sparc/include/asm/mmzone.h
+++ b/arch/sparc/include/asm/mmzone.h
@@ -3,6 +3,8 @@
=20
 #ifdef CONFIG_NEED_MULTIPLE_NODES
=20
+#include <linux/cpumask.h>
+
 extern struct pglist_data *node_data[];
=20
 #define NODE_DATA(nid)		(node_data[nid])
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
