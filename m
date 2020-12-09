Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA50C4167B
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 18:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181F323C91
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Dec 2020 18:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730294AbgLISbw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Dec 2020 13:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbgLISbw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Dec 2020 13:31:52 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D17C0613D6
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Dec 2020 10:31:12 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id f14so1648250qto.12
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Dec 2020 10:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TrL65DJWq6+pooL5AeWYhJfhOXAJBr52JULN6G/gtk0=;
        b=JCjfoeaV9NKxD5qPGAsY7bu0XX/5mI0cbev3+lAnGsKbtJmNxMItH5jXc/pTU53bGF
         VJmIYQxyEZChAtLPOzLi0iiKTV3r7mTKSaZhOfJWOCuekAojhrmGXOmsD9BabfPXHFXJ
         Uk5VAzyP7ZpobVNce08a/SuTEFlpI0AH/uXKiJas+Rt0eTmpsoRHaeRVwhOpUVoWVo+N
         KZJ00ty84/sTL2/fxZo0r/u+j4+wlb33rVBIWuf4RvMgIXq4GCGi8I4BIBPyS/EYcKnB
         +fOPQgvOMeU299McFvofJnbBf0dnflyUd3AIyrjVSFvWPjLMqopPa/Me195calaiPB5B
         +dRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TrL65DJWq6+pooL5AeWYhJfhOXAJBr52JULN6G/gtk0=;
        b=qpOqRYKwH63/hra5BGrOzz/CCUPbeHvOGOWT/H0gYRtgnAEPV8WPel+WHOhHvf7tWd
         BOFReaQ4gewjetu1/M5ZD8AQCLjTTAdm/+1gU6JdqR1rPp+FXxViH5N+6p82Aqo6Oqn4
         jv7fhKbIu7cCjm8G5IgE/yCpqGS+ccLVbUWAj3TPQKfVlNpiEkxkS061+6otcnMo0nGs
         g0g3cWke7qX69MKFC29PMe0OBXHNclldCRys8i952AIOiiLCXk/6nr/BIihu3EEACGk9
         r8aMPl8KZYFBF7WGuxaY8xOvUi7TrJYL3HLj3OK59CQVDiF6r/f7zowgsBb5bo3t73Br
         idLQ==
X-Gm-Message-State: AOAM530y72QEx2k/r0NPb4lr3+tTXkA4PywVQix1n0PHL+DFRJQUGqik
        ZILV/N8HGuOJ0WBB6gNzsZUJxWVmmYmY+w==
X-Google-Smtp-Source: ABdhPJzVkRrCULoJUM+9BgM8LmuqVCpQqSSdJFir3U1pqFtQXQ2/VGjqDUG6uy6KOJclGnA16rBjmw==
X-Received: by 2002:a05:622a:d1:: with SMTP id p17mr4629252qtw.233.1607538670858;
        Wed, 09 Dec 2020 10:31:10 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id k41sm1674840qtc.23.2020.12.09.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 10:31:10 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] rt-tests: queuelat: Remove get_cpuinfo_mhz.sh and old Makefile
Date:   Wed,  9 Dec 2020 13:30:59 -0500
Message-Id: <20201209183100.16836-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201209183100.16836-1-jkacur@redhat.com>
References: <20201209183100.16836-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The functionality in get_cpuinfo_mhz.sh has been incorporated into
determine_maximum_mpps.sh, so it can safely be removed.

The queuelat is built from the rt-tests suite Makefile, and the old
Makefile in the queuelat directory can be removed.

Signed-off-by: John Kacur <jkacur@redhat.com>

diff --git a/Makefile b/Makefile
index 3b38d21afb3a..d5b14991032d 100644
--- a/Makefile
+++ b/Makefile
@@ -209,7 +209,6 @@ rebuild:
 install: all install_manpages install_hwlatdetect install_get_cyclictest_snapshot
 	mkdir -p "$(DESTDIR)$(bindir)"
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
-	install src/queuelat/get_cpuinfo_mhz.sh "$(DESTDIR)$(bindir)"
 	install src/queuelat/determine_maximum_mpps.sh "${DESTDIR}${bindir}"
 
 .PHONY: install_hwlatdetect
diff --git a/src/queuelat/Makefile b/src/queuelat/Makefile
deleted file mode 100644
index b4d327829b17..000000000000
--- a/src/queuelat/Makefile
+++ /dev/null
@@ -1,9 +0,0 @@
-queuelat: queuelat.o
-	cc -o queuelat queuelat.o
-
-queuelat.o: queuelat.c
-	cc -c -Wall queuelat.c
-
-clean:
-	rm queuelat queuelat.o
-          
diff --git a/src/queuelat/get_cpuinfo_mhz.sh b/src/queuelat/get_cpuinfo_mhz.sh
deleted file mode 100755
index 14a2c12c478f..000000000000
--- a/src/queuelat/get_cpuinfo_mhz.sh
+++ /dev/null
@@ -1,7 +0,0 @@
-#!/bin/bash
-
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (C) 2018 Marcelo Tosatti <mtosatti@redhat.com>
-
-mhz=$(grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1)
-echo "$mhz"
-- 
2.26.2

