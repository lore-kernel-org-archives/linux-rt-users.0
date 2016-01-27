From: Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] drivers/cpuidle: coupled: remove unused define cpuidle_coupled_lock
Date: Wed, 27 Jan 2016 20:26:54 +0100
Message-ID: <1453922814-3173-1-git-send-email-anders.roxell@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

This was found with the -RT patch enabled, but the fix should apply to
non-RT also.

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
