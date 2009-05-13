From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] ARM: __builtin_return_address works with argument 0
Date: Wed, 13 May 2009 11:00:13 +0200
Message-ID: <1242205213-27452-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-kernel@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44494 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758065AbZEMJAR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 May 2009 05:00:17 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This saves the function overhead for CALLER_ADDRESS0.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
Hi Thomas,

this applies to .29.3-rt12.  Feel free to squash this into
arm-tracing-updates.patch.

Best regards
Uwe

 arch/arm/include/asm/ftrace.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/ftrace.h b/arch/arm/include/asm/ftrac=
e.h
index 900fc19..f7e8bac 100644
--- a/arch/arm/include/asm/ftrace.h
+++ b/arch/arm/include/asm/ftrace.h
@@ -15,7 +15,7 @@ extern void mcount(void);
 void *return_address(unsigned int);
=20
 #define HAVE_ARCH_CALLER_ADDR
-#define CALLER_ADDR0 ((unsigned long)return_address(0))
+#define CALLER_ADDR0 ((unsigned long)__builtin_return_address(0))
 #define CALLER_ADDR1 ((unsigned long)return_address(1))
 #define CALLER_ADDR2 ((unsigned long)return_address(2))
 #define CALLER_ADDR3 ((unsigned long)return_address(3))
--=20
1.6.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
