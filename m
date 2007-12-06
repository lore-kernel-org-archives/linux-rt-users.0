From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH Latency Tracer] don't panic on failed bootmem alloc
Date: Wed, 05 Dec 2007 23:41:33 -0500
Message-ID: <1196916093.1645.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:35303 "EHLO
	ms-smtp-01.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbXLFEls (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 23:41:48 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Ingo,

This patch prevents a panic on a failed bootmem alloc in the
initialization of the tracer buffers.

Signed-off-by: Steven Rostedt <srostedt@redhat.com>

Index: linux-2.6-latency/kernel/latency_trace.c
===================================================================
--- linux-2.6-latency.orig/kernel/latency_trace.c
+++ linux-2.6-latency/kernel/latency_trace.c
@@ -2720,10 +2720,11 @@ void * __init tracer_alloc_bootmem(unsig
 {
 	void * ret;
 
-	ret =__alloc_bootmem(size, SMP_CACHE_BYTES, ARCH_LOW_ADDRESS_LIMIT);
+	ret =__alloc_bootmem_nopanic(size, SMP_CACHE_BYTES,
+				     ARCH_LOW_ADDRESS_LIMIT);
 	if (ret != NULL && ((unsigned long)ret) < ARCH_LOW_ADDRESS_LIMIT) {
 		free_bootmem(__pa(ret), size);
-		ret = __alloc_bootmem(size,
+		ret = __alloc_bootmem_nopanic(size,
 				SMP_CACHE_BYTES,
 				__pa(MAX_DMA_ADDRESS));
 	}
