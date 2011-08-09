From: Darren Hart <dvhart@linux.intel.com>
Subject: [PATCH][RT] fix KM_TYPE_NR undeclared in sched.h on 32 bit x86
Date: Mon, 08 Aug 2011 21:08:31 -0700
Message-ID: <4E40B2BF.3030608@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: lkml <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:36643 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab1HIEIe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Aug 2011 00:08:34 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Patch peter_zijlstra-re-_3_0-rt4.patch causes 32 bit compilations to fa=
il with:
sched.h:1592:17: error: =91KM_TYPE_NR=92 undeclared here (not in a func=
tion)

Including asm/kmap_types in sched.h resolves the issue.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Bruce Ashfield <bruce.ashfield@windriver.com>
---
 include/linux/sched.h |    1 +
 1 file changed, 1 insertion(+)

Index: linux-3.0-rt/include/linux/sched.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-3.0-rt.orig/include/linux/sched.h
+++ linux-3.0-rt/include/linux/sched.h
@@ -63,6 +63,7 @@ struct sched_param {
 #include <linux/nodemask.h>
 #include <linux/mm_types.h>
=20
+#include <asm/kmap_types.h>
 #include <asm/system.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
--=20
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
