From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 2/9] efi: Disable runtime services on RT
Date: Fri, 21 Dec 2018 09:21:14 -0600
Message-ID: <4b7dce66c503f20080605dc39b812056c51d4a23.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Cc: rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
In-Reply-To: <cover.1545347029.git.tom.zanussi@linux.intel.com>
References: <cover.1545347029.git.tom.zanussi@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

v3.18.129-rt111 rt-stable review patch.  If anyone has any objections,
please let me know.

------------------
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 55544e1d5eb0d7608e2b41452729649c8ea1607a ]

Based on meassurements the EFI functions get_variable /
get_next_variable take up to 2us which looks okay.
The functions get_time, set_time take around 10ms. Those 10ms are too
much. Even one ms would be too much.
Ard mentioned that SetVariable might even trigger larger latencies if
the firware will erase flash blocks on NOR.

The time-functions are used by efi-rtc and can be triggered during
runtimed (either via explicit read/write or ntp sync).

The variable write could be used by pstore.
These functions can be disabled without much of a loss. The poweroff /
reboot hooks may be provided by PSCI.

Disable EFI's runtime wrappers.

This was observed on "EFI v2.60 by SoftIron Overdrive 1000".

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>

 Conflicts:
	drivers/firmware/efi/efi.c
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index e47c522e1d8f..f2be407247e5 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -41,7 +41,7 @@ struct efi __read_mostly efi = {
 };
 EXPORT_SYMBOL(efi);
 
-static bool disable_runtime;
+static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT_BASE);
 static int __init setup_noefi(char *arg)
 {
 	disable_runtime = true;
-- 
2.14.1
