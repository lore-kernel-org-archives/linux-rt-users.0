From: Glenn Elliott <gelliott@cs.unc.edu>
Subject: Re: nvidia bug or RT bug?
Date: Wed, 6 Jun 2012 00:03:53 +0000 (UTC)
Message-ID: <loom.20120606T015743-749@post.gmane.org>
References: <CAOcfFMwkXC1Ozs3+QhKUU18JY4KDzNaxAuLq34r+PQOCipSFSg@mail.gmail.com> <loom.20120606T011822-880@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:50595 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062Ab2FFAEG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jun 2012 20:04:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Sc3jH-0007L2-Po
	for linux-rt-users@vger.kernel.org; Wed, 06 Jun 2012 02:04:03 +0200
Received: from searspoint.nvidia.com ([216.228.112.21])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Jun 2012 02:04:03 +0200
Received: from gelliott by searspoint.nvidia.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Wed, 06 Jun 2012 02:04:03 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Glenn Elliott <gelliott <at> cs.unc.edu> writes:

> 
> jordan <triplesquarednine <at> gmail.com> writes:
> 
> > I've been using linux-rt-3.0 series, which has been very stable using
> > the nvidia proprietary drivers (pretty much flawlessly, actually). I
> > had used rt-3.0 with nvidia all the way upto nvidia version 290.35. I
> > never experienced any problems relating to nvidia, at all... But
> > external/other reasons, recently I have upgraded to rt-3.2 which also
> > seems to be working quite well. At the same time, i also upgraded my
> > nvidia driver to the latest available driver, which is 302.07 (beta).
> 
> I've used the 270 drivers with an older version of PREEMPT_RT.  However,
> I had to modify the GPL layer code to make the compilation/install go
> through.  Did you have to do the same?
> 
> In the GPL layer (which you can extract from the *.run driver package),
> I had to  edit kernel/nv-linux.h and update the NV_SPIN_*LOCK() to call
> raw_spin_*lock().  (Using raw spin locks seemed like the only safe thing
> to do, given the closed-source nature of the driver.)
> 
> I haven't looked at the 290 GPL layer, so I don't know if this
> spinlock edit is still necessarily.
> 
> Another interesting edit is to enable MSI interrupts.
> In kernel/nv-reg.h, change the line 
> "NV_DEFINE_REG_ENTRY(__NV_ENABLE_MSI, 0);"
> to
> "NV_DEFINE_REG_ENTRY(__NV_ENABLE_MSI, 1);"
> 
> After your edits, simply do "make module; make install" from within the
> kernel  directory to install the custom driver to the currently running
> kernel (you'll probably want to run the full installer first to pick up
> the various shared libraries and X configurations).
> 
> I've found that the GPL layer code changes rarely, so I believe there
> is a good chance that these edits will still be valid.
> 
> -Glenn


Here is a patch carried forward for 302.06.03 (the beta driver I
downloaded with CUDA 5.0 preview a few weeks ago).  They were
the same for the 270 driver.  This has worked for me; maybe it will
work for you.

diff -rupN NVIDIA-Linux-x86_64-302.06.03/kernel/nv-linux.h \
NVIDIA-Linux-x86_64-302.06.03.rawspin.msi/kernel/nv-linux.h
--- NVIDIA-Linux-x86_64-302.06.03/kernel/nv-linux.h	2012-05-03 \
21:19:21.000000000 -0400
+++ NVIDIA-Linux-x86_64-302.06.03.rawspin.msi/kernel/nv-linux.h	2012-06-05 
19:44:01.642339831 -0400
@@ -291,28 +291,15 @@ extern int nv_pat_mode;
 #endif
 #endif
 
-#if defined(CONFIG_PREEMPT_RT)
-typedef atomic_spinlock_t         nv_spinlock_t;
-#define NV_SPIN_LOCK_INIT(lock)   atomic_spin_lock_init(lock)
-#define NV_SPIN_LOCK_IRQ(lock)    atomic_spin_lock_irq(lock)
-#define NV_SPIN_UNLOCK_IRQ(lock)  atomic_spin_unlock_irq(lock)
-#define NV_SPIN_LOCK_IRQSAVE(lock,flags) atomic_spin_lock_irqsave(lock,flags)
-#define NV_SPIN_UNLOCK_IRQRESTORE(lock,flags) \
-  atomic_spin_unlock_irqrestore(lock,flags)
-#define NV_SPIN_LOCK(lock)        atomic_spin_lock(lock)
-#define NV_SPIN_UNLOCK(lock)      atomic_spin_unlock(lock)
-#define NV_SPIN_UNLOCK_WAIT(lock) atomic_spin_unlock_wait(lock)
-#else
-typedef spinlock_t                nv_spinlock_t;
-#define NV_SPIN_LOCK_INIT(lock)   spin_lock_init(lock)
-#define NV_SPIN_LOCK_IRQ(lock)    spin_lock_irq(lock)
-#define NV_SPIN_UNLOCK_IRQ(lock)  spin_unlock_irq(lock)
-#define NV_SPIN_LOCK_IRQSAVE(lock,flags) spin_lock_irqsave(lock,flags)
-#define NV_SPIN_UNLOCK_IRQRESTORE(lock,flags) 
spin_unlock_irqrestore(lock,flags)
-#define NV_SPIN_LOCK(lock)        spin_lock(lock)
-#define NV_SPIN_UNLOCK(lock)      spin_unlock(lock)
-#define NV_SPIN_UNLOCK_WAIT(lock) spin_unlock_wait(lock)
-#endif
+typedef raw_spinlock_t                nv_spinlock_t;
+#define NV_SPIN_LOCK_INIT(lock)   raw_spin_lock_init(lock)
+#define NV_SPIN_LOCK_IRQ(lock)    raw_spin_lock_irq(lock)
+#define NV_SPIN_UNLOCK_IRQ(lock)  raw_spin_unlock_irq(lock)
+#define NV_SPIN_LOCK_IRQSAVE(lock,flags) raw_spin_lock_irqsave(lock,flags)
+#define NV_SPIN_UNLOCK_IRQRESTORE(lock,flags) 
raw_spin_unlock_irqrestore(lock,flags)
+#define NV_SPIN_LOCK(lock)        raw_spin_lock(lock)
+#define NV_SPIN_UNLOCK(lock)      raw_spin_unlock(lock)
+#define NV_SPIN_UNLOCK_WAIT(lock) raw_spin_unlock_wait(lock)
 
 #if defined(NVCPU_X86)
 #ifndef write_cr4
@@ -954,9 +941,6 @@ static inline int nv_execute_on_all_cpus
     return ret;
 }
 
-#if defined(CONFIG_PREEMPT_RT)
-#define NV_INIT_MUTEX(mutex) semaphore_init(mutex)
-#else
 #if !defined(__SEMAPHORE_INITIALIZER) && 
defined(__COMPAT_SEMAPHORE_INITIALIZER)
 #define __SEMAPHORE_INITIALIZER __COMPAT_SEMAPHORE_INITIALIZER
 #endif
@@ -966,7 +950,6 @@ static inline int nv_execute_on_all_cpus
             __SEMAPHORE_INITIALIZER(*(mutex), 1);  \
         *(mutex) = __mutex;                        \
     }
-#endif
 
 #if defined (KERNEL_2_4)
 #  define NV_IS_SUSER()                 suser()
diff -rupN NVIDIA-Linux-x86_64-302.06.03/kernel/nv-reg.h \
NVIDIA-Linux-x86_64-302.06.03.rawspin.msi/kernel/nv-reg.h
--- NVIDIA-Linux-x86_64-302.06.03/kernel/nv-reg.h	2012-05-03 \
21:19:21.000000000 -0400
+++ NVIDIA-Linux-x86_64-302.06.03.rawspin.msi/kernel/nv-reg.h	2012-06-05 \ 
19:41:47.338336880 -0400
@@ -607,7 +607,7 @@ NV_DEFINE_REG_ENTRY(__NV_INITIALIZE_SYST
 NV_DEFINE_REG_ENTRY(__NV_USE_VBIOS, 1);
 NV_DEFINE_REG_ENTRY(__NV_RM_EDGE_INTR_CHECK, 1);
 NV_DEFINE_REG_ENTRY(__NV_USE_PAGE_ATTRIBUTE_TABLE, ~0);
-NV_DEFINE_REG_ENTRY(__NV_ENABLE_MSI, 0);
+NV_DEFINE_REG_ENTRY(__NV_ENABLE_MSI, 1);
 NV_DEFINE_REG_ENTRY(__NV_MAP_REGISTERS_EARLY, 0);
 NV_DEFINE_REG_ENTRY(__NV_REGISTER_FOR_ACPI_EVENTS, 1);


I am a little uncertain about my removal of "NV_INIT_MUTEX(mutex)
semaphore_init(mutex)".  I can't remember what my rational was.

