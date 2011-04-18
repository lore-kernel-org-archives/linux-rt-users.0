From: Jan Kiszka <jan.kiszka@web.de>
Subject: Re: [ANNOUNCE] 2.6.33.9-rt31
Date: Mon, 18 Apr 2011 21:14:06 +0200
Message-ID: <4DAC8D7E.5080307@web.de>
References: <alpine.LFD.2.00.1104111723020.4501@localhost6.localdomain6>	<4DA582AE.9020706@autostatic.com>	<4DA5A786.8060001@siemens.com> <20110418100850.135e3f4c@riff>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6EFF47AC2909CB958B917DAF"
Cc: Jeremy Jongepier <jeremy@autostatic.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate01.web.de ([217.72.192.221]:50762 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756502Ab1DRTON (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Apr 2011 15:14:13 -0400
In-Reply-To: <20110418100850.135e3f4c@riff>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6EFF47AC2909CB958B917DAF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2011-04-18 17:08, Clark Williams wrote:
> On Wed, 13 Apr 2011 15:39:18 +0200
> Jan Kiszka <jan.kiszka@siemens.com> wrote:
>=20
>> A nouveau hacker recently explained to me that it's fairly hard to
>> backport their improvements to older kernels as they heavily depend on=

>> infrastructure changes. That likely explains why you don't see many
>> stable fixes or a nouveau-compat package.
>>
>> If you can live with the nvidia driver, I can share a patch that makes=

>> it build&work for me (Quadro FX 880M).
>>
>> Jan
>=20
>=20
> I'd like to see that patch. Looking at fixing the nvidia wrapper
> locking for -rt has been on my list for a while, it just hasn't bubbled=

> up to the top :).

Here comes the hack to make -rt work. It obviously break kernels
< 2.6.16 -- I really wonder why NVIDIA is still trying to support them.

Once you applied it and force-enabled (tainted kernel...) lockdep:
surprise, surprise! The driver has an ABBA locking bug (mmap_sem vs.
sp_lock). At least a theoretical one, not sure if something prevents
that this can bite in reality.

Also, I was not able to find a solution for that as the code paths and
callbacks the blob takes are hidden from "ordinary" people. NVIDIA
should be aware of it, but it looks they are not reading their public
bug tracker.

HTH,
Jan -- who wishes nouveau would already have the same low-power profile
       as the blob...

---
 nv-linux.h |   45 +++++++++++-------------------------
 nv.c       |   72 ++++++++++++++++++++++++++++++------------------------=
------
 2 files changed, 50 insertions(+), 67 deletions(-)

diff --git a/nv-linux.h b/nv-linux.h
index 38f7620..45942b9 100644
--- a/nv-linux.h
+++ b/nv-linux.h
@@ -127,11 +127,6 @@
 #endif
=20
 #include <linux/spinlock.h>
-#if defined(NV_LINUX_SEMAPHORE_H_PRESENT)
-#include <linux/semaphore.h>
-#else
-#include <asm/semaphore.h>
-#endif
 #include <linux/completion.h>
 #include <linux/highmem.h>
=20
@@ -242,16 +237,16 @@ extern int nv_pat_mode;
 #endif
=20
 #if defined(CONFIG_PREEMPT_RT)
-typedef atomic_spinlock_t         nv_spinlock_t;
-#define NV_SPIN_LOCK_INIT(lock)   atomic_spin_lock_init(lock)
-#define NV_SPIN_LOCK_IRQ(lock)    atomic_spin_lock_irq(lock)
-#define NV_SPIN_UNLOCK_IRQ(lock)  atomic_spin_unlock_irq(lock)
-#define NV_SPIN_LOCK_IRQSAVE(lock,flags) atomic_spin_lock_irqsave(lock,f=
lags)
+typedef raw_spinlock_t            nv_spinlock_t;
+#define NV_SPIN_LOCK_INIT(lock)   raw_spin_lock_init(lock)
+#define NV_SPIN_LOCK_IRQ(lock)    raw_spin_lock_irq(lock)
+#define NV_SPIN_UNLOCK_IRQ(lock)  raw_spin_unlock_irq(lock)
+#define NV_SPIN_LOCK_IRQSAVE(lock,flags) raw_spin_lock_irqsave(lock,flag=
s)
 #define NV_SPIN_UNLOCK_IRQRESTORE(lock,flags) \
-  atomic_spin_unlock_irqrestore(lock,flags)
-#define NV_SPIN_LOCK(lock)        atomic_spin_lock(lock)
-#define NV_SPIN_UNLOCK(lock)      atomic_spin_unlock(lock)
-#define NV_SPIN_UNLOCK_WAIT(lock) atomic_spin_unlock_wait(lock)
+  raw_spin_unlock_irqrestore(lock,flags)
+#define NV_SPIN_LOCK(lock)        raw_spin_lock(lock)
+#define NV_SPIN_UNLOCK(lock)      raw_spin_unlock(lock)
+#define NV_SPIN_UNLOCK_WAIT(lock) raw_spin_unlock_wait(lock)
 #else
 typedef spinlock_t                nv_spinlock_t;
 #define NV_SPIN_LOCK_INIT(lock)   spin_lock_init(lock)
@@ -822,19 +817,7 @@ static inline int nv_execute_on_all_cpus(void (*func=
)(void *info), void *info)
     return ret;
 }
=20
-#if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) semaphore_init(mutex)
-#else
-#if !defined(__SEMAPHORE_INITIALIZER) && defined(__COMPAT_SEMAPHORE_INIT=
IALIZER)
-#define __SEMAPHORE_INITIALIZER __COMPAT_SEMAPHORE_INITIALIZER
-#endif
-#define NV_INIT_MUTEX(mutex)                       \
-    {                                              \
-        struct semaphore __mutex =3D                 \
-            __SEMAPHORE_INITIALIZER(*(mutex), 1);  \
-        *(mutex) =3D __mutex;                        \
-    }
-#endif
+#define NV_INIT_MUTEX(mutex) mutex_init(mutex)
=20
 #if defined (KERNEL_2_4)
 #  define NV_IS_SUSER()                 suser()
@@ -1351,17 +1334,17 @@ typedef struct nv_linux_state_s {
     struct timer_list rc_timer;
=20
     /* lock for linux-specific data, not used by core rm */
-    struct semaphore ldata_lock;
+    struct mutex ldata_lock;
=20
     /* lock for linux-specific alloc queue */
-    struct semaphore at_lock;
+    struct mutex at_lock;
=20
 #if defined(NV_USER_MAP)
     /* list of user mappings */
     struct nv_usermap_s *usermap_list;
=20
     /* lock for VMware-specific mapping list */
-    struct semaphore mt_lock;
+    struct mutex mt_lock;
 #endif /* defined(NV_USER_MAP) */
=20
 #if defined(NV_PM_SUPPORT_OLD_STYLE_APM)
@@ -1417,7 +1400,7 @@ typedef struct nvidia_event
 typedef struct
 {
     nv_stack_t *sp;
-    struct semaphore sp_lock;
+    struct mutex sp_lock;
     void *nvptr;
     nvidia_event_t *event_head;
     nvidia_event_t *event_tail;
diff --git a/nv.c b/nv.c
index d3d2097..a0c8cfb 100644
--- a/nv.c
+++ b/nv.c
@@ -876,10 +876,10 @@ static int nvl_add_alloc(
     nv_alloc_t *at
 )
 {
-    down(&nvl->at_lock);
+    mutex_lock(&nvl->at_lock);
     at->next =3D nvl->alloc_queue;
     nvl->alloc_queue =3D at;
-    up(&nvl->at_lock);
+    mutex_unlock(&nvl->at_lock);
     return 0;
 }
=20
@@ -2144,7 +2144,7 @@ int nv_kern_open(
     nv =3D NV_STATE_PTR(nvl);
=20
     nv_printf(NV_DBG_INFO, "NVRM: nv_kern_open on device %d\n", devnum);=

-    down(&nvl->ldata_lock);
+    mutex_lock(&nvl->ldata_lock);
=20
     NV_CHECK_PCI_CONFIG_SPACE(sp, nv, TRUE, TRUE, NV_MAY_SLEEP());
=20
@@ -2315,7 +2315,7 @@ done:
     NV_ATOMIC_INC(nvl->usage_count);
=20
 failed:
-    up(&nvl->ldata_lock);
+    mutex_unlock(&nvl->ldata_lock);
=20
     if (rc !=3D 0)
     {
@@ -2377,7 +2377,7 @@ int nv_kern_close(
=20
     NV_RELEASE_USERMAP_LIST(nv,nvfp);
=20
-    down(&nvl->at_lock);
+    mutex_lock(&nvl->at_lock);
     if (nvl->alloc_queue !=3D NULL)
     {
         nv_alloc_t *at =3D nvl->alloc_queue, *next;
@@ -2388,7 +2388,7 @@ int nv_kern_close(
             if ((NV_ATOMIC_READ(at->usage_count) =3D=3D 0) && (at->file =
=3D=3D NV_FILE_REFERENCE(file)))
             {
                 NV_ATOMIC_INC(at->usage_count);
-                up(&nvl->at_lock);
+                mutex_unlock(&nvl->at_lock);
                 if (at->pid =3D=3D os_get_current_process())
                     NV_PRINT_AT(NV_DBG_MEMINFO, at);
                 nv_free_pages(nv, at->num_pages,
@@ -2396,15 +2396,15 @@ int nv_kern_close(
                               NV_ALLOC_MAPPING_CONTIG(at->flags),
                               NV_ALLOC_MAPPING(at->flags),
                               (void *)at);
-                down(&nvl->at_lock);
+                mutex_lock(&nvl->at_lock);
                 next =3D nvl->alloc_queue; /* start over */
             }
             at =3D next;
         }
     }
-    up(&nvl->at_lock);
+    mutex_unlock(&nvl->at_lock);
=20
-    down(&nvl->ldata_lock);
+    mutex_lock(&nvl->ldata_lock);
     if (NV_ATOMIC_DEC_AND_TEST(nvl->usage_count))
     {
         if (NV_IS_GVI_DEVICE(nv))
@@ -2461,7 +2461,7 @@ int nv_kern_close(
         /* leave INIT flag alone so we don't reinit every time */
         nv->flags &=3D ~NV_FLAG_OPEN;
     }
-    up(&nvl->ldata_lock);
+    mutex_unlock(&nvl->ldata_lock);
=20
     if (NV_GET_FILE_PRIVATE(file) !=3D NULL)
     {
@@ -2580,7 +2580,7 @@ int nv_kern_mmap(
=20
     NV_PRINT_VMA(NV_DBG_MEMINFO, vma);
=20
-    down(&nvfp->sp_lock);
+    mutex_lock(&nvfp->sp_lock);
     sp =3D nvfp->sp;
=20
     NV_CHECK_PCI_CONFIG_SPACE(sp, nv, TRUE, TRUE, NV_MAY_SLEEP());
@@ -2676,7 +2676,7 @@ int nv_kern_mmap(
     {
         unsigned int i;
=20
-        down(&nvl->at_lock);
+        mutex_lock(&nvl->at_lock);
         at =3D nvl_find_alloc(nvl, NV_VMA_OFFSET(vma), NV_ALLOC_TYPE_AGP=
);
=20
         if (at =3D=3D NULL)
@@ -2688,7 +2688,7 @@ int nv_kern_mmap(
                     "NVRM: nv_kern_mmap: invalid offset: 0x%08x @ 0x%016=
llx (AGP)\n",
                     NV_VMA_SIZE(vma), NV_VMA_OFFSET(vma));
             }
-            up(&nvl->at_lock);
+            mutex_unlock(&nvl->at_lock);
             status =3D -EINVAL;
             goto done;
         }
@@ -2697,14 +2697,14 @@ int nv_kern_mmap(
                               NV_MEMORY_WRITECOMBINED,
                               NV_MEMORY_TYPE_AGP))
         {
-            up(&nvl->at_lock);
+            mutex_unlock(&nvl->at_lock);
             status =3D -ENXIO;
             goto done;
         }
=20
         NV_VMA_PRIVATE(vma) =3D at;
         NV_ATOMIC_INC(at->usage_count);
-        up(&nvl->at_lock);
+        mutex_unlock(&nvl->at_lock);
=20
         if (NV_IO_REMAP_PAGE_RANGE(vma->vm_start, NV_VMA_OFFSET(vma),
                     NV_VMA_SIZE(vma), vma->vm_page_prot))
@@ -2730,13 +2730,13 @@ int nv_kern_mmap(
         unsigned long start =3D 0;
         unsigned int i, j;
=20
-        down(&nvl->at_lock);
+        mutex_lock(&nvl->at_lock);
         at =3D nvl_find_alloc(nvl, NV_VMA_OFFSET(vma), NV_ALLOC_TYPE_PCI=
);
=20
         if (at =3D=3D NULL)
         {
             static int count =3D 0;
-            up(&nvl->at_lock);
+            mutex_unlock(&nvl->at_lock);
             if (count++ < NV_MAX_RECURRING_WARNING_MESSAGES)
             {
                 nv_printf(NV_DBG_ERRORS,
@@ -2756,7 +2756,7 @@ int nv_kern_mmap(
=20
         if (i =3D=3D at->num_pages) /* sanity check */
         {
-            up(&nvl->at_lock);
+            mutex_unlock(&nvl->at_lock);
             status =3D -EINVAL;
             goto done;
         }
@@ -2765,7 +2765,7 @@ int nv_kern_mmap(
         {
             nv_printf(NV_DBG_ERRORS,
                 "NVRM: requested mapping exceeds allocation's boundary!\=
n");
-            up(&nvl->at_lock);
+            mutex_unlock(&nvl->at_lock);
             status =3D -EINVAL;
             goto done;
         }
@@ -2774,14 +2774,14 @@ int nv_kern_mmap(
                               NV_ALLOC_MAPPING(at->flags),
                               NV_MEMORY_TYPE_SYSTEM))
         {
-            up(&nvl->at_lock);
+            mutex_unlock(&nvl->at_lock);
             status =3D -ENXIO;
             goto done;
         }
=20
         NV_VMA_PRIVATE(vma) =3D at;
         NV_ATOMIC_INC(at->usage_count);
-        up(&nvl->at_lock);
+        mutex_unlock(&nvl->at_lock);
=20
         nv_printf(NV_DBG_INFO,
             "NVRM: remapping %d system pages, index %d, for 'at' 0x%p\n"=
, pages, i, at);
@@ -2825,7 +2825,7 @@ int nv_kern_mmap(
     NV_VMA_FILE(vma) =3D NV_FILE_REFERENCE(file);
=20
 done:
-    up(&nvfp->sp_lock);
+    mutex_unlock(&nvfp->sp_lock);
     return status;
 }
 #endif /* NV_USER_MAP */
@@ -2904,7 +2904,7 @@ int nv_kern_ioctl(
     nv_printf(NV_DBG_INFO, "NVRM: ioctl(0x%x, 0x%x, 0x%x)\n",
         _IOC_NR(cmd), (unsigned int) i_arg, _IOC_SIZE(cmd));
=20
-    down(&nvfp->sp_lock);
+    mutex_lock(&nvfp->sp_lock);
     sp =3D nvfp->sp;
=20
     NV_CHECK_PCI_CONFIG_SPACE(sp, nv, TRUE, TRUE, NV_MAY_SLEEP());
@@ -3050,7 +3050,7 @@ int nv_kern_ioctl(
     }
=20
 done:
-    up(&nvfp->sp_lock);
+    mutex_unlock(&nvfp->sp_lock);
     if (arg_copy !=3D NULL)
     {
         if (copy_to_user(arg_ptr, arg_copy, arg_size))
@@ -3226,7 +3226,7 @@ int nv_kern_ctl_open(
=20
     nv_printf(NV_DBG_INFO, "NVRM: nv_kern_ctl_open\n");
=20
-    down(&nvl->ldata_lock);
+    mutex_lock(&nvl->ldata_lock);
=20
     /* save the nv away in file->private_data */
     nvfp->nvptr =3D nvl;
@@ -3246,7 +3246,7 @@ int nv_kern_ctl_open(
     }
=20
     NV_ATOMIC_INC(nvl->usage_count);
-    up(&nvl->ldata_lock);
+    mutex_unlock(&nvl->ldata_lock);
=20
     return 0;
 }
@@ -3268,7 +3268,7 @@ int nv_kern_ctl_close(
=20
     nv_printf(NV_DBG_INFO, "NVRM: nv_kern_ctl_close\n");
=20
-    down(&nvl->ldata_lock);
+    mutex_lock(&nvl->ldata_lock);
     if (NV_ATOMIC_DEC_AND_TEST(nvl->usage_count))
     {
         nv->flags &=3D ~NV_FLAG_OPEN;
@@ -3280,7 +3280,7 @@ int nv_kern_ctl_close(
                 "NVRM: failed to unregister from the ACPI subsystem!\n")=
;
         }
     }
-    up(&nvl->ldata_lock);
+    mutex_unlock(&nvl->ldata_lock);
=20
     rm_free_unused_clients(sp, nv, NV_FILE_REFERENCE(file));
=20
@@ -3748,7 +3748,7 @@ void* NV_API_CALL nv_alloc_kernel_mapping(
     nv_linux_state_t *nvl =3D NV_GET_NVL_FROM_NV_STATE(nv);
     NvU32 i, offset, page_idx=3D0;
=20
-    down(&nvl->at_lock);
+    mutex_lock(&nvl->at_lock);
     at =3D nvl_find_alloc(nvl, address, NV_ALLOC_TYPE_PCI);
     if (at !=3D NULL)
     {
@@ -3767,7 +3767,7 @@ void* NV_API_CALL nv_alloc_kernel_mapping(
=20
         if (i =3D=3D at->num_pages) /* not found */
         {
-            up(&nvl->at_lock);
+            mutex_unlock(&nvl->at_lock);
             return NULL;
         }
     }
@@ -3782,17 +3782,17 @@ void* NV_API_CALL nv_alloc_kernel_mapping(
=20
             if (at->page_table[i]->virt_addr =3D=3D 0)
             {
-                up(&nvl->at_lock);
+                mutex_unlock(&nvl->at_lock);
                 return NULL;
             }
         }
         else
         {
-            up(&nvl->at_lock);
+            mutex_unlock(&nvl->at_lock);
             return NULL; /* not found */
         }
     }
-    up(&nvl->at_lock);
+    mutex_unlock(&nvl->at_lock);
=20
     if (((size + offset) <=3D PAGE_SIZE) && !NV_ALLOC_MAPPING_GUEST(at->=
flags))
     {
@@ -4121,7 +4121,7 @@ RM_STATUS NV_API_CALL nv_free_pages(
         at->key_mapping, page_count);
=20
     /* only lock ldata while removing 'at' from the list */
-    down(&nvl->at_lock);
+    mutex_lock(&nvl->at_lock);
=20
     NV_PRINT_AT(NV_DBG_MEMINFO, at);
=20
@@ -4136,12 +4136,12 @@ RM_STATUS NV_API_CALL nv_free_pages(
      */
     if (!NV_ATOMIC_DEC_AND_TEST(at->usage_count))
     {
-        up(&nvl->at_lock);
+        mutex_unlock(&nvl->at_lock);
         return RM_OK;
     }
=20
     nvl_remove_alloc(nvl, at);
-    up(&nvl->at_lock);
+    mutex_unlock(&nvl->at_lock);
=20
     if (NV_ALLOC_MAPPING_GUEST(at->flags))
     {
--=20
1.7.1


--------------enig6EFF47AC2909CB958B917DAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org/

iEYEARECAAYFAk2sjYIACgkQitSsb3rl5xSQsQCeLY4LUsjyqd8yS/lw2L1SqAgY
dnUAoNSteRHIlOueEVelQEnzVB+o0k2s
=+DhP
-----END PGP SIGNATURE-----

--------------enig6EFF47AC2909CB958B917DAF--
