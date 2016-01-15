From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 8/9] drivers/cpuidle: coupled: fix warning cpuidle_coupled_lock
Date: Fri, 15 Jan 2016 20:21:12 +0100
Message-ID: <1452885673-30891-9-git-send-email-anders.roxell@linaro.org>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-rt-users@vger.kernel.org, khilman@kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: bigeasy@linutronix.de
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35612 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbcAOT1I (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Jan 2016 14:27:08 -0500
Received: by mail-lf0-f43.google.com with SMTP id c192so288989946lfe.2
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Jan 2016 11:27:07 -0800 (PST)
In-Reply-To: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Used multi_v7_defconfig+PREEMPT_RT_FULL=y and this caused a compilation
warning without this fix:
../drivers/cpuidle/coupled.c:122:21: warning: 'cpuidle_coupled_lock'
defined but not used [-Wunused-variable]

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/cpuidle/coupled.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 344058f..d5657d5 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -119,7 +119,6 @@ struct cpuidle_coupled {
 
 #define CPUIDLE_COUPLED_NOT_IDLE	(-1)
 
-static DEFINE_MUTEX(cpuidle_coupled_lock);
 static DEFINE_PER_CPU(struct call_single_data, cpuidle_coupled_poke_cb);
 
 /*
-- 
2.1.4

