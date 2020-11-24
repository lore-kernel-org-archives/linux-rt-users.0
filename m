Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA388C63798
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Nov 2020 14:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523142100A
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Nov 2020 14:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DVuJTz7Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y5rReRqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389110AbgKXObe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:31:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43796 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389017AbgKXObd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Nov 2020 09:31:33 -0500
Date:   Tue, 24 Nov 2020 15:31:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606228290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=slmi/gCy0F1kst4xh7w6cb31xf6xlyZEmUC7j5VLPjk=;
        b=DVuJTz7Z8+ndQgPM5DJ6MeCLVzNY5Dbf3+KKnA2LhLSJOu8ryv55XtrGIqiDBOSkvr2E/J
        Kza2LThPJ4K+MqL+TF/Y1lc7W6DCBx63c980mOsKcL2rq9kPXGvJZcAFrndSE9XMlEXmI8
        VCu+2yqF3+9YDyBhuAfsSkVFkAEOybUqcYbyFKArEMQExlLT4y4JWAq22kd255Uy7jXB4Z
        7zj8JZ/sYY8c23f9QKNupxWlRhH5Nw7LCOB/nqZoi27KigGwFsUpjQsvlYzYZJ5U7KWN8E
        QW2F6HTHSAfLTjnECfYKh5i095xYVcZbgkGx9jPlh0wQiKVXzBj4L+Dx/apDZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606228290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=slmi/gCy0F1kst4xh7w6cb31xf6xlyZEmUC7j5VLPjk=;
        b=Y5rReRqc4pJOYzY6KVDBCGrvqkWdMbrKBsCIEkCNKZ73u4vQTbf4v7m4R49T+SDNFivVAH
        AkD67HJrw628xuDg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.10-rc5-rt10
Message-ID: <20201124143129.hexio5jg4za3u3si@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.10-rc5-rt10 patch set. 

Changes since v5.10-rc5-rt9:

  - A patch from upstream addressing migrate disable related issue
    reported by Oleksandr Natalenko. Patch by Peter Zijlstra.

  - A patch from upstream addressing migrate disable related issue
    reported by Qian Cai. Patch by Valentin Schneider.

  - A workaround for a build failure when IMX clock drivers are built as
    modules.

Known issues
     - It has been pointed out that due to changes to the printk code the
       internal buffer representation changed. This is only an issue if tools
       like `crash' are used to extract the printk buffer from a kernel memory
       image.

The delta patch against v5.10-rc5-rt9 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/incr/patch-5.10-rc5-rt9-rt10.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.10-rc5-rt10

The RT patch against v5.10-rc5 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10-rc5-rt10.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patches-5.10-rc5-rt10.tar.xz

Sebastian

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index dd6a737d060b4..b8bf9460c91d7 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -26,9 +26,9 @@ obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
 obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
-obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
-clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o
-clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
+obj-$(CONFIG_MXC_CLK_SCU)	+= clk-imx-scu.o
+clk-imx-scu-y			:= clk-scu.o clk-lpcg-scu.o
+obj-$(CONFIG_CLK_IMX8QXP)	+= clk-imx8qxp.o clk-imx8qxp-lpcg.o
 
 obj-$(CONFIG_CLK_IMX1)   += clk-imx1.o
 obj-$(CONFIG_CLK_IMX25)  += clk-imx25.o
diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index 1f0e44f921aee..336dce43da82d 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -115,3 +115,4 @@ struct clk_hw *imx_clk_lpcg_scu(const char *name, const char *parent_name,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(imx_clk_lpcg_scu);
diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index b8b2072742a56..026a33606ae53 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -9,6 +9,7 @@
 #include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/module.h>
 
 #include "clk-scu.h"
 
@@ -132,6 +133,7 @@ int imx_clk_scu_init(void)
 {
 	return imx_scu_get_handle(&ccm_ipc_handle);
 }
+EXPORT_SYMBOL_GPL(imx_clk_scu_init);
 
 /*
  * clk_scu_recalc_rate - Get clock rate for a SCU clock
@@ -387,3 +389,5 @@ struct clk_hw *__imx_clk_scu(const char *name, const char * const *parents,
 
 	return hw;
 }
+EXPORT_SYMBOL_GPL(__imx_clk_scu);
+MODULE_LICENSE("GPL");
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ec2d786ae8ea..b7d43ac654dce 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1982,7 +1982,7 @@ static int migration_cpu_stop(void *data)
 			 * and we should be valid again. Nothing to do.
 			 */
 			if (!pending) {
-				WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
+				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
 				goto out;
 			}
 
@@ -1994,7 +1994,7 @@ static int migration_cpu_stop(void *data)
 		else
 			p->wake_cpu = dest_cpu;
 
-	} else if (dest_cpu < 0) {
+	} else if (dest_cpu < 0 || pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
 		 * preempt_enable() and scheduling the stopper task. At that
@@ -2004,13 +2004,24 @@ static int migration_cpu_stop(void *data)
 		 * more likely.
 		 */
 
+		/*
+		 * The task moved before the stopper got to run. We're holding
+		 * ->pi_lock, so the allowed mask is stable - if it got
+		 * somewhere allowed, we're done.
+		 */
+		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
+			p->migration_pending = NULL;
+			complete = true;
+			goto out;
+		}
+
 		/*
 		 * When this was migrate_enable() but we no longer have an
 		 * @pending, a concurrent SCA 'fixed' things and we should be
 		 * valid again. Nothing to do.
 		 */
 		if (!pending) {
-			WARN_ON_ONCE(!is_cpu_allowed(p, cpu_of(rq)));
+			WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
 			goto out;
 		}
 
diff --git a/localversion-rt b/localversion-rt
index 22746d6390a42..d79dde624aaac 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt9
+-rt10
