From: Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] 3.18.29-rt30
Date: Tue, 29 Mar 2016 19:11:32 -0400
Message-ID: <20160329191132.497ef15f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Dear RT Folks,

I'm pleased to announce the 3.18.29-rt30 stable release.

Note, 3.18.29-rt29 was also released that only included the stable
update. But -rt30 is released because the last pull of changes to
3.18-rt included a change that was also reverted in upstream. This
release includes both the stable update and that revert.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v3.18-rt
  Head SHA1: 18303cd31e84f06eb780dd58ea213e4a515609fc


Or to build 3.18.29-rt30 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.29.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.29-rt30.patch.xz



You can also build from 3.18.29-rt29 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.29-rt29-rt30.patch.xz



Enjoy,

-- Steve


Changes from v3.18.29-rt29:

---

Steven Rostedt (Red Hat) (1):
      Linux 3.18.29-rt30

Thomas Gleixner (1):
      Revert d04ea10ba1ea mmc: sdhci: don't provide hard irq handler

----
 drivers/mmc/host/sdhci.c | 32 +++++---------------------------
 localversion-rt          |  2 +-
 2 files changed, 6 insertions(+), 28 deletions(-)
---------------------------
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9411f8b0cd11..9109287e47ac 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2565,31 +2565,6 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 	return isr ? IRQ_HANDLED : IRQ_NONE;
 }
 
-#ifdef CONFIG_PREEMPT_RT_BASE
-static irqreturn_t sdhci_rt_irq(int irq, void *dev_id)
-{
-	irqreturn_t ret;
-
-	local_bh_disable();
-	ret = sdhci_irq(irq, dev_id);
-	local_bh_enable();
-	if (ret == IRQ_WAKE_THREAD)
-		ret = sdhci_thread_irq(irq, dev_id);
-	return ret;
-}
-#endif
-
-static int sdhci_req_irq(struct sdhci_host *host)
-{
-#ifdef CONFIG_PREEMPT_RT_BASE
-	return request_threaded_irq(host->irq, NULL, sdhci_rt_irq,
-				    IRQF_SHARED, mmc_hostname(host->mmc), host);
-#else
-	return request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
-				    IRQF_SHARED, mmc_hostname(host->mmc), host);
-#endif
-}
-
 /*****************************************************************************\
  *                                                                           *
  * Suspend/resume                                                            *
@@ -2657,7 +2632,9 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret = sdhci_req_irq(host);
+		ret = request_threaded_irq(host->irq, sdhci_irq,
+					   sdhci_thread_irq, IRQF_SHARED,
+					   mmc_hostname(host->mmc), host);
 		if (ret)
 			return ret;
 	} else {
@@ -3276,7 +3253,8 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	sdhci_init(host, 0);
 
-	ret = sdhci_req_irq(host);
+	ret = request_threaded_irq(host->irq, sdhci_irq, sdhci_thread_irq,
+				   IRQF_SHARED,	mmc_hostname(mmc), host);
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
diff --git a/localversion-rt b/localversion-rt
index 90290c642ed5..b72862e06be4 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt29
+-rt30
