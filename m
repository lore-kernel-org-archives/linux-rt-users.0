Return-Path: <SRS0=UEZv=XT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32182C432C1
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 17:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D5C020872
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Sep 2019 17:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjQFc31Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395427AbfIXRn5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:43:57 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33853 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732249AbfIXRn5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Sep 2019 13:43:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id q203so2668648qke.1
        for <linux-rt-users@vger.kernel.org>; Tue, 24 Sep 2019 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bmQmTOMWHWDaTVchoIgskHB3GFF7Xf4jgOFSEusavxU=;
        b=mjQFc31QM5UoBuum7RDlOvyzQtOufYY+tUs8C2GT4B+ZPFLhBcv6VW6aS2QupL1FqN
         Bc87T8WMqElT5mAlqL4eK9Tv5M/JUCztpPIjN5r5KnRYKEBzhgtX7LPp0R15TW33lMKI
         OZvmFC2LhggCPGIKgyjaiT6Pr+vchOgnA3pLThSOKjulQ7oX3HMVnOAkCSD/WzhXuKRQ
         i5kc8KH7sZ2g3Q8mWigEA4W8sSaNvEH4F9YBWrihzIvPcMr/xmrccwy9y3UE0X6tFWyM
         8zKR6kxEEKpLwBt1Ei0MIXtZhneNklI8hEYdbxUgi7nM3mEQ+3Vt0gFlHNcO6SyDB2/T
         Nmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bmQmTOMWHWDaTVchoIgskHB3GFF7Xf4jgOFSEusavxU=;
        b=S/z/gybeXLDyceUpsuqML1PIZpRuVM2mJc8BIiddvTLnggcZMarqjrc3Oza/e1HVSD
         oa+tfzkxOGyxrhxkrpviNdrTj/GZkbIKzE4AeMhrXVCS9f9rUW+cd4cXA+Np/gxddPoi
         7Bg6EZWb3BJIr7pStqmS1HxSHQ9tY9iWjMVb/djAuiqSh1Cldv0loOKeirQYQz1MAAvH
         o+/n1pogxVsU332F0AShY10DptXrTzRiFr1fCnsKvsBEcVTCAYMf0mxBwC0uCCMIygwO
         ctZGyrFhCBLzJ0PsGs6HCkhYc0/KtvBMt4VvqlwUyDh4erEok4VRKOTC/n97n9kZQVoW
         zJcQ==
X-Gm-Message-State: APjAAAWYYhFo9giqpBYXoyoosaVi0pVWW39lUcAzkhsDfvBYaEIozCYM
        WZWoLE8fo17Om7w2jwr6GafYesc2daM=
X-Google-Smtp-Source: APXvYqw8dvDu30qeiCouGsAF9dtWJFML7bu/gyr15BRYYadrts/TXDe8AMjgqvycYWamLysL3I4yjw==
X-Received: by 2002:a37:a446:: with SMTP id n67mr3655394qke.132.1569347036231;
        Tue, 24 Sep 2019 10:43:56 -0700 (PDT)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id l3sm1406768qtc.33.2019.09.24.10.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 10:43:55 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Siewior <bigeasy@linutronix.de>
Subject: [PATCH] rt-tests: cyclictest: Just use LIBNUMA_API_VERSION
Date:   Tue, 24 Sep 2019 19:43:44 +0200
Message-Id: <20190924174344.7453-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This removes support for LIBNUMA_API_VERSION 1.

You can still build without numa support by doing
make NUMA=0

You can also build with numa and run on machines without numa support.

Suggested-by: Sebastian Siewior <bigeasy@linutronix.de>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/cyclictest/rt_numa.h | 98 +---------------------------------------
 1 file changed, 1 insertion(+), 97 deletions(-)

diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 7adeb3c01324..983502d34c94 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -1,16 +1,7 @@
 /*
  * A numa library for cyclictest.
  * The functions here are designed to work whether cyclictest has been
- * compiled with numa support or not, and whether the user uses the --numa
- * option or not.
- * They should also work correctly with older versions of the numactl lib
- * such as the one found on RHEL5, or with the newer version 2 and above.
- *
- * The difference in behavior hinges on whether LIBNUMA_API_VERSION >= 2,
- * in which case we will employ the bitmask affinity behavior -or-
- * either LIBNUMA_API_VERSION < 2 or NUMA support is missing altogether,
- * in which case we retain the older affinity behavior which can either
- * specify a single CPU core or else use all cores.
+ * compiled with numa support or not.
  *
  * (C) 2010 John Kacur <jkacur@redhat.com>
  * (C) 2010 Clark Williams <williams@redhat.com>
@@ -28,10 +19,6 @@ static int numa = 0;
 #ifdef NUMA
 #include <numa.h>
 
-#ifndef LIBNUMA_API_VERSION
-#define LIBNUMA_API_VERSION 2
-#endif
-
 static void *
 threadalloc(size_t size, int node)
 {
@@ -69,8 +56,6 @@ static void *rt_numa_numa_alloc_onnode(size_t size, int node, int cpu)
 	return stack;
 }
 
-#if LIBNUMA_API_VERSION >= 2
-
 /*
  * Use new bit mask CPU affinity behavior
  */
@@ -110,87 +95,6 @@ static inline void rt_bitmask_free(struct bitmask *mask)
 	numa_bitmask_free(mask);
 }
 
-#else	/* LIBNUMA_API_VERSION == 1 */
-
-struct bitmask {
-	unsigned long size; /* number of bits in the map */
-	unsigned long *maskp;
-};
-#define BITS_PER_LONG	(8*sizeof(long))
-
-/*
- * Map legacy CPU affinity behavior onto bit mask infrastructure
- */
-static int rt_numa_numa_node_of_cpu(int cpu)
-{
-	unsigned char cpumask[256];
-	int node, idx, bit;
-	int max_node, max_cpus;
-
-	max_node = numa_max_node();
-	max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
-
-	if (cpu > max_cpus) {
-		errno = EINVAL;
-		return -1;
-	}
-
-	/* calculate bitmask index and relative bit position of cpu */
-	idx = cpu / 8;
-	bit = cpu % 8;
-
-	for (node = 0; node <= max_node; node++) {
-		if (numa_node_to_cpus(node, (void *) cpumask, sizeof(cpumask)))
-			return -1;
-
-		if (cpumask[idx] & (1<<bit))
-			return node;
-	}
-	errno = EINVAL;
-	return -1;
-}
-
-static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
-	unsigned long i)
-{
-	long bit = mask->maskp[i/BITS_PER_LONG] & (1<<(i % BITS_PER_LONG));
-	return (bit != 0);
-}
-
-static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
-	int max_cpus)
-{
-	int cpu;
-	struct bitmask *mask = NULL;
-	cpu = atoi(s);
-	if (0 <= cpu && cpu < max_cpus) {
-		mask = malloc(sizeof(*mask));
-		if (mask) {
-			/* Round up to integral number of longs to contain
-			 * max_cpus bits */
-			int nlongs = (max_cpus+BITS_PER_LONG-1)/BITS_PER_LONG;
-
-			mask->maskp = calloc(nlongs, sizeof(long));
-			if (mask->maskp) {
-				mask->maskp[cpu/BITS_PER_LONG] |=
-					(1UL << (cpu % BITS_PER_LONG));
-				mask->size = max_cpus;
-			} else {
-				free(mask);
-				mask = NULL;
-			}
-		}
-	}
-	return mask;
-}
-
-static inline void rt_bitmask_free(struct bitmask *mask)
-{
-	free(mask->maskp);
-	free(mask);
-}
-
-#endif	/* LIBNUMA_API_VERSION */
 
 #else /* ! NUMA */
 
-- 
2.20.1

