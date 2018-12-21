From: Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 1/9] efi: Allow efi=runtime
Date: Fri, 21 Dec 2018 09:21:13 -0600
Message-ID: <25f3709f40dc290bd5702feecb762dbd96ce6744.1545347029.git.tom.zanussi@linux.intel.com>
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

[ Upstream commit 71bef7da4112ed2677d4f10a58202a5a4638fb90 ]

In case the option "efi=noruntime" is default at built-time, the user
could overwrite its sate by `efi=runtime' and allow it again.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/firmware/efi/efi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 297066df6946..e47c522e1d8f 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -59,6 +59,9 @@ static int __init parse_efi_cmdline(char *str)
 	if (parse_option_str(str, "noruntime"))
 		disable_runtime = true;
 
+	if (parse_option_str(str, "runtime"))
+		disable_runtime = false;
+
 	return 0;
 }
 early_param("efi", parse_efi_cmdline);
-- 
2.14.1
