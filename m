From: Josh Triplett <josht@linux.vnet.ibm.com>
Subject: [-rt PATCH] i386: Mark nmi_show_regs static
Date: Fri, 20 Jul 2007 11:51:40 -0700
Message-ID: <1184957501.2630.20.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:41483 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763346AbXGTSvX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Jul 2007 14:51:23 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Nothing outside of arch/i386/kernel/nmi.c uses nmi_show_regs, so mark it
static.

Eliminates a sparse warning introduced in -rt:
warning: symbol 'nmi_show_regs' was not declared. Should it be static?

Signed-off-by: Josh Triplett <josh@kernel.org>
---
 arch/i386/kernel/nmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/i386/kernel/nmi.c b/arch/i386/kernel/nmi.c
index 2a1e3c1..8155d1a 100644
--- a/arch/i386/kernel/nmi.c
+++ b/arch/i386/kernel/nmi.c
@@ -324,7 +324,7 @@ EXPORT_SYMBOL(touch_nmi_watchdog);
 
 extern void die_nmi(struct pt_regs *, const char *msg);
 
-int nmi_show_regs[NR_CPUS];
+static int nmi_show_regs[NR_CPUS];
 
 void nmi_show_all_regs(void)
 {
-- 
1.5.2.1
