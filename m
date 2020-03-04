Return-Path: <SRS0=qI7K=4V=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BF2C3F2CE
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Mar 2020 21:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E101F20716
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Mar 2020 21:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eN1I7xkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388422AbgCDV4C (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:56:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43156 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCDV4C (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Mar 2020 16:56:02 -0500
Received: by mail-qt1-f193.google.com with SMTP id v22so2606218qtp.10
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Mar 2020 13:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b43QogsS9kdbLJ2eqbuzmiK0NZtjtA6Q4q+Rwo4wjk=;
        b=eN1I7xkXDxR5sBRMfyXOYNN3ksa/K7He5YzRtpRk/vi1w+iPtTvQFEwy76YAR55723
         jmIfLkVRVn9iPFS/1FS9wb9mbxKT+X/3XRh49ZJoxPEZ1A12DcSkwTySCeeAXoqqaATX
         zbYgJxOSmtAaBtIV5O0fjgl/Zk1hYrK50SqOqNEqPxb0DkBDhveajZ+He9g1Suf9SN9l
         ody4lKthUyzmjHxJnWsU+/+ATBKNYCu/jSiG4HZcVD7Df1nQuIB3OccYuEujTEhl7yYg
         QddofA7f/Y7+HluWuFol5s8rYIo++moNuyM1CbjD8BUFqx0uxFz6q2IXNyQYdiRSxihd
         OVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9b43QogsS9kdbLJ2eqbuzmiK0NZtjtA6Q4q+Rwo4wjk=;
        b=fyWP5NgMX1SeLFwOgCY2LmvdG0+X+aLKoBiNnGr/rDt8w4Y2ue5TLb/WHmdOrE92EO
         c8Iw6fn0+7qGlhiHFZyTWFY5WY2bBBZ5+EWVdja+lyKADplQrdveGSdU9jmMRDbyyOl7
         l5WkhX2gwSsF9paUAmXVO7JOMJT9DjhtaCd0AeG/56hKdUy7dByElSbxkmRvlcL/Zahe
         haZegh4lhDzh/L6Srg2IKlTcIzUJwssrvOXiiNDrPcI6IoHqxOsN+fLoBRClfxwHrGKi
         bry0sq96wvzdfqJpGDka4rlLxry5YTmug4U9gVB3i67tdHkJP2bpgd8xPNEUfdMAj6wq
         SISw==
X-Gm-Message-State: ANhLgQ2MTyoK1QvCDTUkngkiBZ4SEx2f6ja/7iHJ0QLJ4whKu+NdqYPn
        ZFXkh7clTSALXEzm1UJu4NgQ3XQz2XY=
X-Google-Smtp-Source: ADFU+vtPwQ8M2iEpjJIrSuP2V0bPkOOQv2cA5C0QeUZviYuoC2SmpBVtSa52/wqk8o+jzqQc+IyZRA==
X-Received: by 2002:ac8:73c7:: with SMTP id v7mr4415631qtp.269.1583358959191;
        Wed, 04 Mar 2020 13:55:59 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id f5sm4899164qtq.72.2020.03.04.13.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:55:58 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/4] rt-tests: cyclictest: Remove support for compiling without NUMA
Date:   Wed,  4 Mar 2020 16:55:46 -0500
Message-Id: <20200304215548.13079-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200304215548.13079-1-jkacur@redhat.com>
References: <20200304215548.13079-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We announced way back in 2015 that compiling without the NUMA libs was
no-longer supported, but we left the bits in there for you to do it
anyway.

Since this is not supported, and is broken now anyway, let's remove the
cruft.

Of course running on non-NUMA machines should still work fine.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                 | 17 +++-------
 src/cyclictest/rt_numa.h | 67 ----------------------------------------
 2 files changed, 4 insertions(+), 80 deletions(-)

diff --git a/Makefile b/Makefile
index 186eccb1c882..1475007d7bb4 100644
--- a/Makefile
+++ b/Makefile
@@ -76,19 +76,10 @@ ostype := $(lastword $(subst -, ,$(dumpmachine)))
 machinetype := $(shell echo $(dumpmachine)| \
     sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
 
-# The default is to assume you have libnuma installed, which is fine to do
-# even on non-numa machines. If you don't want to install the numa libs, for
-# example, they might not be available in an embedded environment, then
-# compile with
-# make NUMA=0
-ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
-NUMA 	:= 1
-endif
-
-ifeq ($(NUMA),1)
-	CFLAGS += -DNUMA
-	NUMA_LIBS = -lnuma
-endif
+# You have to have libnuma installed, which is fine to do even if you are
+# running on non-numa machines
+CFLAGS += -DNUMA
+NUMA_LIBS = -lnuma
 
 include src/arch/android/Makefile
 
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 466f0b68f801..46690941e0a6 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -1,8 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * A numa library for cyclictest.
- * The functions here are designed to work whether cyclictest has been
- * compiled with numa support or not.
  *
  * (C) 2010 John Kacur <jkacur@redhat.com>
  * (C) 2010 Clark Williams <williams@redhat.com>
@@ -17,7 +15,6 @@
 
 static int numa = 0;
 
-#ifdef NUMA
 #include <numa.h>
 
 static void *
@@ -86,70 +83,6 @@ static inline void rt_bitmask_free(struct bitmask *mask)
 	numa_bitmask_free(mask);
 }
 
-
-#else /* ! NUMA */
-
-struct bitmask {
-    unsigned long size; /* number of bits in the map */
-    unsigned long *maskp;
-};
-#define BITS_PER_LONG    (8*sizeof(long))
-
-static inline void *threadalloc(size_t size, int n) { return malloc(size); }
-static inline void threadfree(void *ptr, size_t s, int n) { free(ptr); }
-static inline void rt_numa_set_numa_run_on_node(int n, int c) { }
-static inline int rt_numa_numa_node_of_cpu(int cpu) { return -1; }
-static void *rt_numa_numa_alloc_onnode(size_t s, int n, int c) { return NULL; }
-
-/*
- * Map legacy CPU affinity behavior onto bit mask infrastructure
- */
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
-			mask->maskp = calloc(nlongs, sizeof(unsigned long));
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
-#endif	/* NUMA */
-
-/*
- * Any behavioral differences above are transparent to these functions
- */
-
 /** Returns number of bits set in mask. */
 static inline unsigned int rt_numa_bitmask_count(const struct bitmask *mask)
 {
-- 
2.20.1

