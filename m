From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/6] [ARM] msm: include linux/cache.h in proc_comm.c
Date: Fri,  7 Aug 2009 22:42:38 +0200
Message-ID: <1249677761-19470-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090807203939.GA19374@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Russell King <linux@arm.linux.org.uk>,
	Brian Swetland <swetland@google.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933900AbZHGUmx@vger.kernel.org>
In-Reply-To: <20090807203939.GA19374@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This fixes a a build failure for 2.6.31-rc4-rt1 (ARCH=3Darm,
msm_defconfig):

  CC      arch/arm/mach-msm/proc_comm.o
/ptx/work/octopus/WORK_2_A/ukl/gsrc/linux-2.6/arch/arm/mach-msm/proc_co=
mm.c:43: error: expected '=3D', ',', ';', 'asm' or '__attribute__' befo=
re '__cacheline_aligned_in_smp'
/ptx/work/octopus/WORK_2_A/ukl/gsrc/linux-2.6/arch/arm/mach-msm/proc_co=
mm.c: In function 'msm_proc_comm':
/ptx/work/octopus/WORK_2_A/ukl/gsrc/linux-2.6/arch/arm/mach-msm/proc_co=
mm.c:76: error: 'proc_comm_lock' undeclared (first use in this function=
)
/ptx/work/octopus/WORK_2_A/ukl/gsrc/linux-2.6/arch/arm/mach-msm/proc_co=
mm.c:76: error: (Each undeclared identifier is reported only once
/ptx/work/octopus/WORK_2_A/ukl/gsrc/linux-2.6/arch/arm/mach-msm/proc_co=
mm.c:76: error: for each function it appears in.)

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Brian Swetland <swetland@google.com>
---
 arch/arm/mach-msm/proc_comm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/proc_comm.c b/arch/arm/mach-msm/proc_com=
m.c
index 915ee70..e825c36 100644
--- a/arch/arm/mach-msm/proc_comm.c
+++ b/arch/arm/mach-msm/proc_comm.c
@@ -14,6 +14,7 @@
  *
  */
=20
+#include <linux/cache.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 #include <linux/io.h>
--=20
1.6.3.3
