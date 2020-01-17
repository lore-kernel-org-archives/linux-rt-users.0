Return-Path: <SRS0=Gh4n=3G=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79D8C33CB6
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Jan 2020 17:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B502467D
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Jan 2020 17:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbgAQRmU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Jan 2020 12:42:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbgAQRlc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Jan 2020 12:41:32 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58CEB20842;
        Fri, 17 Jan 2020 17:41:32 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1isVch-000QYz-94; Fri, 17 Jan 2020 12:41:31 -0500
Message-Id: <20200117174131.158849136@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 17 Jan 2020 12:41:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 25/32] Revert "cpufreq: drop K8s driver from beeing selected"
References: <20200117174111.282847363@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.19.94-rt39-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit d64b599394a1bf4ecbe7093e03b88cfbbb77d5f8 ]

Borislav Petkov tried to reproduce the crash on his K8 without any luck.

Allow to enable the driver since it looks like the bug was fixed in the
meantime.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 drivers/cpufreq/Kconfig.x86 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index bb4a6160d0f7..35f71825b7f3 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -125,7 +125,7 @@ config X86_POWERNOW_K7_ACPI
 
 config X86_POWERNOW_K8
 	tristate "AMD Opteron/Athlon64 PowerNow!"
-	depends on ACPI && ACPI_PROCESSOR && X86_ACPI_CPUFREQ && !PREEMPT_RT_BASE
+	depends on ACPI && ACPI_PROCESSOR && X86_ACPI_CPUFREQ
 	help
 	  This adds the CPUFreq driver for K8/early Opteron/Athlon64 processors.
 	  Support for K10 and newer processors is now in acpi-cpufreq.
-- 
2.24.1


