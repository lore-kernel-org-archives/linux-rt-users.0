From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RT 20/24] Revert "arm64/xen: Make XEN depend on !RT"
Date: Fri, 07 Sep 2018 16:59:17 -0400
Message-ID: <20180907205933.069261270@goodmis.org>
References: <20180907205857.262840394@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, Iain Hunter <drhunter95@gmail.com>
To: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

4.14.63-rt41-rc2 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit c0a308b58829bd4066bce841fe49e8277a0cb32b ]

Iain Hunter reported that there are no problems with it so there is no
reason to keep it disabled.

Reported-by: Iain Hunter <drhunter95@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6ccd878c32c2..ebc261c8620b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -792,7 +792,7 @@ config XEN_DOM0
 
 config XEN
 	bool "Xen guest support on ARM64"
-	depends on ARM64 && OF && !PREEMPT_RT_FULL
+	depends on ARM64 && OF
 	select SWIOTLB_XEN
 	select PARAVIRT
 	help
-- 
2.18.0
