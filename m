From: Clark Williams <williams@redhat.com>
Subject: [PATCH] cyclictest: touch threadstacks on numa to pre-fault them
Date: Mon, 24 Apr 2017 12:05:15 -0500
Message-ID: <20170424170515.7051-1-williams@redhat.com>
Cc: Linux RT Users <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56322 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S975292AbdDXRFR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Apr 2017 13:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7239246D08C
        for <linux-rt-users@vger.kernel.org>; Mon, 24 Apr 2017 17:05:16 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On a numa system we allocate a stack from the closest NUMA node
for each measurement thread. We need to touch those stack pages
to prevent them faulting when first run. Not a big deal on a
system with just a few cores, but overhead adds up with 32+ cores.

Signed-off-by: Clark Williams <williams@redhat.com>
---
 src/cyclictest/cyclictest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 5e23fc58f602..49a81f168cdb 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2376,6 +2376,9 @@ int main(int argc, char **argv)
 			/*  allocate memory for a stack on appropriate node */
 			stack = rt_numa_numa_alloc_onnode(stksize, node, i);
 
+			/* touch the stack pages to pre-fault them in */
+			memset(stack, 0, stksize);
+
 			/* set the thread's stack */
 			if (pthread_attr_setstack(&attr, stack, stksize))
 				fatal("failed to set stack addr for thread %d to 0x%x\n",
-- 
2.9.3

