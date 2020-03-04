Return-Path: <SRS0=qI7K=4V=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05348C3F2CE
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Mar 2020 21:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA71120716
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Mar 2020 21:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJISKoo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgCDVz7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Mar 2020 16:55:59 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:43729 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgCDVz7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Mar 2020 16:55:59 -0500
Received: by mail-qt1-f173.google.com with SMTP id v22so2606190qtp.10
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Mar 2020 13:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vVuMU8SfA5mJvUrPeqMAAIV5SF5dphrVuAFLAY5ZB4I=;
        b=QJISKoo56A7JykpM+1sgvxOT8T6MVXVOIr23O2lDLm+e6pk7Yiy6vS1XUX6nzvXtEV
         0l49L0iqrL9QXO2aFTMfdzKsnG15Qo10onK1sgUMAt3r8mqQo9TKu2VffJGo5YsGAYf+
         neotUDqQIOYMBHjn5rz8SVcqcJPHRnnpUGOVNEK+FhLCLLeCltntpbkVJQZYUI0Q/jmM
         YODWsE5/3KsNGc0NZxExK0fMaUAXzD/c0JmOJEgCh9i/RUCU5anHUeDUPSCz8Bh/KgbH
         1NpnzQmV2EddGzO7y4GWYPVfKEcDIzdVDs0fIVNqnz2NZc2a8BqDgljtkve/tfeU3cCz
         gOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=vVuMU8SfA5mJvUrPeqMAAIV5SF5dphrVuAFLAY5ZB4I=;
        b=NKyVAMBW5X1YXMSSxEd7VGbtsT17EFbQGnqhJB9YUJJMKQNw4lxY+LLXWMVqm8sppm
         1J3Af/ByATMD/Ad3ojmnLr/B4YZNrMlNzyxGc1J07QEAwfyq1UP4njbuaAxiKJW+cTN1
         UrPCVErxRrWQQLtghbu7xZ1hMC5PY8eVY0nfv6YCOe5OQ4CyZsM6THzEixPuzexhwFOX
         HgVKJQ8NJ6sc26JrXjFQq4SZbnyBQa6yUcPd0KBCfym6B8BL52Y2tY6gYg93IC+STAV2
         pvk3IkK7zXcDJ5Zxl9SwrexuOjczk9zCvcJJfmmEjgWk9b95U2ZauIZ84yxSi86vjp4u
         +Hmg==
X-Gm-Message-State: ANhLgQ3LICJUiqUtRIcxoCBkCx08WZxJvH6OonA66QZhd6DLMwxghSoq
        7Qvssp8QNEhwYAYn+CcrlfZUpr5TrmY=
X-Google-Smtp-Source: ADFU+vsWBQsBTkGwTEVNegS/bYJCoxVoRv5F6OCOZbcEpT0pCog40MFJlsbQcvh9J+f1Fa3L8FJYFA==
X-Received: by 2002:ac8:3027:: with SMTP id f36mr4293841qte.76.1583358958340;
        Wed, 04 Mar 2020 13:55:58 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id f5sm4899164qtq.72.2020.03.04.13.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 13:55:57 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/4] rt-tests: cyclictest: Remove HAVE_PARSE_CPUSTRING_ALL
Date:   Wed,  4 Mar 2020 16:55:45 -0500
Message-Id: <20200304215548.13079-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

We assume that numa_parse_cpustring_all() is available.
Older numa libs without it are no-longer supported

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile                 |  8 --------
 src/cyclictest/rt_numa.h | 10 ----------
 2 files changed, 18 deletions(-)

diff --git a/Makefile b/Makefile
index 1b37ba7216f2..186eccb1c882 100644
--- a/Makefile
+++ b/Makefile
@@ -85,17 +85,9 @@ ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
 NUMA 	:= 1
 endif
 
-# The default is to assume that you have numa_parse_cpustring_all
-# If you have an older version of libnuma that only has numa_parse_cpustring
-# then compile with
-# make HAVE_PARSE_CPUSTRING_ALL=0
-HAVE_PARSE_CPUSTRING_ALL?=1
 ifeq ($(NUMA),1)
 	CFLAGS += -DNUMA
 	NUMA_LIBS = -lnuma
-	ifeq ($(HAVE_PARSE_CPUSTRING_ALL),1)
-		CFLAGS += -DHAVE_PARSE_CPUSTRING_ALL
-	endif
 endif
 
 include src/arch/android/Makefile
diff --git a/src/cyclictest/rt_numa.h b/src/cyclictest/rt_numa.h
index 1f7c5a482150..466f0b68f801 100644
--- a/src/cyclictest/rt_numa.h
+++ b/src/cyclictest/rt_numa.h
@@ -78,17 +78,7 @@ static inline unsigned int rt_numa_bitmask_isbitset( const struct bitmask *mask,
 static inline struct bitmask* rt_numa_parse_cpustring(const char* s,
 	int max_cpus)
 {
-#ifdef HAVE_PARSE_CPUSTRING_ALL		/* Currently not defined anywhere.  No
-					   autotools build. */
 	return numa_parse_cpustring_all(s);
-#else
-	/* We really need numa_parse_cpustring_all(), so we can assign threads
-	 * to cores which are part of an isolcpus set, but early 2.x versions of
-	 * libnuma do not have this function.  A work around should be to run
-	 * your command with e.g. taskset -c 9-15 <command>
-	 */
-	return numa_parse_cpustring((char *)s);
-#endif
 }
 
 static inline void rt_bitmask_free(struct bitmask *mask)
-- 
2.20.1

