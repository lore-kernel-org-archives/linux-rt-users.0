From: PRINGLE Chris <chris.pringle@miranda.com>
Subject: kmem_cache_destroy issue with RT12 patch on v3.0.3 (perhaps
 related to thread 3.0.4 + rt12: deadlock?)
Date: Fri, 2 Sep 2011 12:02:59 +0100
Message-ID: <FBCF5AA02BB36243866FEDBD9889FC720637233484@uk-ops-exch01>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [193.200.114.15] ([193.200.114.15]:4143 "EHLO oxtel.com"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S933366Ab1IBLDW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Sep 2011 07:03:22 -0400
Received: from uk-ops-exch01.miranda.com ([10.96.1.123]) by oxtel.com
 ([10.96.1.33] running VPOP3) with ESMTP for
 <linux-rt-users@vger.kernel.org>; Fri, 2 Sep 2011 12:03:00 +0100
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Dear All,

I've just upgraded to v3.0.3 of the kernel and the latest set of corres=
ponding RT patches (rt12) and have run into a kernel OOPS/hang. This di=
dn't happen on earlier kernels (2.6.33.7 was the last I tried), and doe=
sn't happen without the RT patch.

The following code causes the a kernel OOPS at the point where I call k=
mem_cache_destroy:

struct test_struct
{
=A0=A0=A0 unsigned int test[4096];
};

#define NUM_TESTS 1000

bool test_func(void)
{
=A0=A0=A0 struct kmem_cache* testcache;
=A0=A0=A0 struct test_struct* structs[NUM_TESTS];
=A0=A0=A0 int i;

=A0=A0=A0 printk(KERN_ERR "Creating\n");
=A0=A0=A0 testcache=3D KMEM_CACHE(test_struct, 0);
=A0=A0=A0 if (testcache =3D=3D NULL)
=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0 printk(KERN_ERR "ERROR: %s: Failed to allocate lo=
okaside cache \n", __func__);
=A0=A0=A0=A0=A0=A0=A0 return false;
=A0=A0=A0 }

=A0=A0=A0 printk(KERN_ERR "Allocating\n");
=A0=A0=A0 for (i=3D 0; i < NUM_TESTS; i++)
=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0 structs[i]=3D kmem_cache_alloc(testcache, GFP_KER=
NEL);
=A0=A0=A0=A0=A0=A0=A0 if (structs[i] =3D=3D NULL)
=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 printk(KERN_ERR "ERROR: Failed to all=
ocate\n");
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0 }

=A0=A0=A0 printk(KERN_ERR "Freeing\n");
=A0=A0=A0 for (i=3D 0; i < NUM_TESTS; i++)
=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0 if (structs[i])
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kmem_cache_free(testcache, structs[i]=
);
=A0=A0=A0 }

=A0=A0=A0 printk(KERN_ERR "Destroying\n");
=A0=A0=A0 kmem_cache_destroy(testcache);
}

Stack trace (from gdb) is as follows:
#23 0xc137ee53 in rt_spin_lock_slowlock (lock=3D0xcf802be0) at kernel/r=
tmutex.c:781
#24 0xc137f120 in rt_spin_lock_fastlock (lock=3D0xcedf00f1) at kernel/r=
tmutex.c:650
#25 rt_spin_lock (lock=3D0xcedf00f1) at kernel/rtmutex.c:815
#26 0xc1099818 in __local_lock_irq (cachep=3D0xcf400200, objp=3D<value =
optimised out>) at include/linux/locallock.h:89
#27 __local_lock_irqsave (cachep=3D0xcf400200, objp=3D<value optimised =
out>) at include/linux/locallock.h:117
#28 kmem_cache_free (cachep=3D0xcf400200, objp=3D<value optimised out>)=
 at mm/slab.c:3940
#29 0xc10999b7 in slab_destroy (cachep=3D0xcec0bf00, slabp=3D<value opt=
imised out>, delayed=3D<value optimised out>) at mm/slab.c:2100
#30 0xc1099b34 in free_block (cachep=3D0xcec0bf00, objpp=3D<value optim=
ised out>, nr_objects=3D<value optimised out>, node=3D0) at mm/slab.c:3=
674
#31 0xc1099f6e in __do_drain (arg=3D0xcec0bf00, cpu=3D<value optimised =
out>) at mm/slab.c:2606
#32 do_drain (arg=3D0xcec0bf00, cpu=3D<value optimised out>) at mm/slab=
=2Ec:2622
#33 0xc1098bde in slab_on_each_cpu (func=3D0xc1099f10 <do_drain>, arg=3D=
0xcec0bf00) at mm/slab.c:737
#34 0xc109a296 in drain_cpu_caches (cachep=3D0xcec0bf00) at mm/slab.c:2=
634
#35 __cache_shrink (cachep=3D0xcec0bf00) at mm/slab.c:2696
#36 0xc109a46c in kmem_cache_destroy (cachep=3D0xcec0bf00) at mm/slab.c=
:2760

The code is running on an SMP i686 kernel with full pre-emption enabled=
=2E The kernel is running on an i686 VMWare virtual machine.

If I add SLAB_RED_ZONE | SLAB_DEBUG_OBJECTS to KMEM_CACHE flags the pro=
blem doesn't appear to show itself.

Any ideas?
Cheers,
Chris

____________________________

Miranda Technologies Limited
Registered in England and Wales CN 02017053
Registered Office: James House, Mere Park, Dedmere Road, Marlow, Bucks,=
 SL7 1FJ

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
