Return-Path: <rhel-rt-internal-bounces@redhat.com>
Message-Id: <200711061451.lA6EpYDh007567@post-office.corp.redhat.com>
Date: Tue, 23 Oct 2007 19:13:03 +0200
From: Andi Kleen <ak@suse.de>
Subject: [PATCH] Fix rt preempt slab NUMA freeing
Reply-To: rhel-rt-internal@redhat.com
List-Unsubscribe: <http://post-office.corp.redhat.com/mailman/listinfo/rhel-rt-internal>,
	<mailto:rhel-rt-internal-request@redhat.com?subject=unsubscribe>
List-Archive: <http://post-office.corp.redhat.com/mailman/private/rhel-rt-internal>
List-Post: <mailto:rhel-rt-internal@redhat.com>
List-Help: <mailto:rhel-rt-internal-request@redhat.com?subject=help>
List-Subscribe: <http://post-office.corp.redhat.com/mailman/listinfo/rhel-rt-internal>,
	<mailto:rhel-rt-internal-request@redhat.com?subject=subscribe>
Sender: rhel-rt-internal-bounces@redhat.com
Errors-To: rhel-rt-internal-bounces@redhat.com
To: linux-rt-users@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


When this_cpu changes in the free path node needs to change too.
Otherwise the slab can end up in the wrong node's list and this
eventually leads to WARN_ONs and of course worse NUMA performace.

This patch is likely not complete (the NUMA slab code is *very* hairy), 
but seems to make the make -j128 test survive for at least two hours.

But at least it fixes one case that regularly triggered during 
testing, resulting in slabs in the wrong node lists and triggering
WARN_ONs in slab_put/get_obj

I tried a complete audit of keeping this_cpu/node/slabp in sync when needed, but 
it is very hairy code and I likely missed some cases. This so far
fixes only the simple free path; but it seems to be good enough
to not trigger easily anymore on a NUMA system with memory pressure.

Longer term the only good fix is probably to migrate to slub.
Or disable NUMA slab for PREEMPT_RT (its value has been disputed
in some benchmarks anyways)

Signed-off-by: Andi Kleen <ak@suse.de>

---
 mm/slab.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux-2.6.21-rt-hack/mm/slab.c
===================================================================
--- linux-2.6.21-rt-hack.orig/mm/slab.c
+++ linux-2.6.21-rt-hack/mm/slab.c
@@ -1205,7 +1205,7 @@ cache_free_alien(struct kmem_cache *cach
 	struct array_cache *alien = NULL;
 	int node;
 
-	node = numa_node_id();
+	node = cpu_to_node(*this_cpu);
 
 	/*
 	 * Make sure we are not freeing a object from another node to the array
@@ -4199,6 +4199,8 @@ static void cache_reap(struct work_struc
 
 		work_done += reap_alien(searchp, l3, &this_cpu);
 
+		node = cpu_to_node(this_cpu);
+
 		work_done += drain_array(searchp, l3,
 			    cpu_cache_get(searchp, this_cpu), 0, node);
 

--------------050607000601000003090500--
