From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [Announce] 2.6.29-rc8-rt2
Date: Fri, 20 Mar 2009 14:19:11 -0500
Message-ID: <1237576751.8951.146.camel@lexx>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain>
	 <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>
	 <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>
	 <alpine.LFD.2.00.0903122013230.29264@localhost.localdomain>
	 <alpine.LFD.2.00.0903200014320.29264@localhost.localdomain>
	 <alpine.LFD.2.00.0903201832590.29264@localhost.localdomain>
Reply-To: will_schmidt@vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:58567 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265AbZCTTTO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Mar 2009 15:19:14 -0400
In-Reply-To: <alpine.LFD.2.00.0903201832590.29264@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-03-20 at 18:45 +0100, Thomas Gleixner wrote:
> We are pleased to announce the next update to our new preempt-rt
> series.
>    =20
>      - resurrected ARM and PowerPC support
>      - tracing fixes for ARM (Uwe Kleine-Koenig)
>=20
> The support for ARM/PowerPC has only been lightly tested. It might
> crash and burn your system, make your hair curl, frigthen your cat an=
d
> give you sleepless nights. You have been warned !

During a build attempt on powerpc, I am seeing:

In file included from include/linux/mmzone.h:776,
                 from include/linux/gfp.h:5,
                 from include/linux/slab.h:13,
                 from include/linux/percpu.h:6,
                 from include/linux/rcupdate.h:40,
                 from include/linux/rculist.h:11,
                 from include/linux/dcache.h:7,
                 from include/linux/fs.h:299,
                 from init/do_mounts_rd.c:4:
/root/linux-2.6.29-rc8/arch/powerpc/include/asm/mmzone.h:32: error:
expected =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99=
, =E2=80=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before
=E2=80=98numa_cpumask_lookup_table=E2=80=99
In file included from include/linux/topology.h:35,
                 from include/linux/gfp.h:8,
                 from include/linux/slab.h:13,
                 from include/linux/percpu.h:6,
                 from include/linux/rcupdate.h:40,
                 from include/linux/rculist.h:11,
                 from include/linux/dcache.h:7,
                 from include/linux/fs.h:299,
                 from init/do_mounts_rd.c:4:
/root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h: In function
=E2=80=98node_to_cpumask=E2=80=99:
/root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h:22: error:
=E2=80=98numa_cpumask_lookup_table=E2=80=99 undeclared (first use in th=
is function)
/root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h:22: error:
(Each undeclared identifier is reported only once
/root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h:22: error:
for each function it appears in.)
/root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h: In function
=E2=80=98node_to_first_cpu=E2=80=99:
/root/linux-2.6.29-rc8/arch/powerpc/include/asm/topology.h:29: error:
=E2=80=98numa_cpumask_lookup_table=E2=80=99 undeclared (first use in th=
is function)
make[1]: *** [init/do_mounts_rd.o] Error 1
make[1]: *** Waiting for unfinished jobs....



I have locally fixed by adding an include just above the cpumask_t
reference.  The include may belong elsewhere, but in case I got it
right,.. :-)

Signed-Off-By:  Will Schmidt <will_schmidt@vnet.ibm.com>

--


diff --git a/arch/powerpc/include/asm/mmzone.h
b/arch/powerpc/include/asm/mmzone.h
index 19f299b..530fa41 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -28,6 +28,8 @@ extern struct pglist_data *node_data[];
  * Following are specific to this numa platform.
  */

+#include <linux/cpumask.h>
+
 extern int numa_cpu_lookup_table[];
 extern cpumask_t numa_cpumask_lookup_table[];
 #ifdef CONFIG_MEMORY_HOTPLUG



Thanks,=20
-Will

>=20
> On PowerPC watch out for the following warning:
>=20
>    __do_IRQ called for irq X. PREEMPT_RT will crash your system soon.
>=20
> __do_IRQ is deprecated and -rt does not support it anymore. Most of
> the PowerPC subarchitectures do not longer use it, but you might be
> unlucky and hit one of the remaining users. RT will spit out the
> message above and then do what it said. :)
>=20
> Download locations:
> =20
>     http://rt.et.redhat.com/download/
>     http://www.kernel.org/pub/linux/kernel/projects/rt/
>  =20
> Information on the RT patch can be found at:
>=20
>     http://rt.wiki.kernel.org/index.php/Main_Page
>=20
> to build the 2.6.29-rc8-rt1 tree, the following patches should be
> applied:
>=20
>   http://www.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.29-rc=
8.tar.bz2
>   http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.29-rc8=
-rt2.bz2
>  =20
> The broken out patches are also available at the same download
> locations.
>=20
> Enjoy !
>=20
>        tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
