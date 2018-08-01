From: Mike Galbraith <efault@gmx.de>
Subject: Re: bisected - arm64 kvm unit test failures
Date: Wed, 01 Aug 2018 11:20:29 +0200
Message-ID: <1533115229.4735.43.camel@gmx.de>
References: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
         <1532768831.9882.71.camel@gmx.de> <1532847330.1618.8.camel@gmx.de>
         <1532864867.1618.32.camel@gmx.de> <1532967899.30205.62.camel@gmx.de>
         <1533061729.12487.26.camel@gmx.de> <867elay7he.wl-marc.zyngier@arm.com>
         <1533103345.4735.19.camel@gmx.de> <864lgey2ja.wl-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <864lgey2ja.wl-marc.zyngier@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2018-08-01 at 08:22 +0100, Marc Zyngier wrote:
> On Wed, 01 Aug 2018 07:02:25 +0100,
> Mike Galbraith <efault@gmx.de> wrote:
> > 
> > [1  <text/plain; ISO-8859-15 (7bit)>]
> > On Wed, 2018-08-01 at 06:35 +0100, Marc Zyngier wrote:
> > > 
> > > Is it something that is reproducible with the current mainline (non-RT)?
> > 
> > These waters are a bit muddy, it's config dependent.  I'm trying to
> > generate a reproducing !RT config for -rc7 as we speak.  If I build
> > openSUSE/master-default, it does NOT reproduce.  That with the bisect
> > config just finished building, and.... yup, it reproduced
> > (attached).
> 
> Thanks for that.

Cheers.  The dependency is THP, which is disabled in RT.

--- config.save	2018-05-18 17:59:44.729165480 +0200
+++ .config	2018-08-01 11:00:24.484148316 +0200
@@ -632,7 +632,10 @@ CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
 CONFIG_MEMORY_FAILURE=y
 # CONFIG_HWPOISON_INJECT is not set
-# CONFIG_TRANSPARENT_HUGEPAGE is not set
+CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
+# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
+CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
 CONFIG_CLEANCACHE=y
 CONFIG_FRONTSWAP=y
 CONFIG_CMA=y
@@ -4306,6 +4309,7 @@ CONFIG_RAS=y
 # CONFIG_ANDROID is not set
 # CONFIG_LIBNVDIMM is not set
 CONFIG_DAX=y
+# CONFIG_DEV_DAX is not set
 CONFIG_NVMEM=y
 # CONFIG_MTK_EFUSE is not set
 # CONFIG_QCOM_QFPROM is not set
@@ -5175,6 +5179,7 @@ CONFIG_DECOMPRESS_XZ=y
 CONFIG_DECOMPRESS_LZO=y
 CONFIG_DECOMPRESS_LZ4=y
 CONFIG_GENERIC_ALLOCATOR=y
+CONFIG_RADIX_TREE_MULTIORDER=y
 CONFIG_ASSOCIATIVE_ARRAY=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT_MAP=y
