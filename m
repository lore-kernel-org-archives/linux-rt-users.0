Return-Path: <SRS0=koMT=DI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5431C4727E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Oct 2020 18:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7833F20878
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Oct 2020 18:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GSeHoepk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbgJASrc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Oct 2020 14:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44517 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729047AbgJASrb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Oct 2020 14:47:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601578050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A74w525Zeg3xx9WHLGSc4tGo1AFv8WB69yoQ0fuAJZE=;
        b=GSeHoepkonSQywJRuBAj/NduiPip0g81/JijMp+YMnwKfeYvIohb2W4+aG2prJVdd8rd/L
        svNIQBB2CqgGw8tWoiNBjADfEZGesmtr5AFuzrCpb9pSwU/sn/e5Ice8Red2SuO8EsrpOc
        NimNShWH9EqdcNpZQXrcaQmDEBSWtsY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-X8pkUGd1OTK9w2PtqbJmrA-1; Thu, 01 Oct 2020 14:47:29 -0400
X-MC-Unique: X8pkUGd1OTK9w2PtqbJmrA-1
Received: by mail-qt1-f199.google.com with SMTP id m13so4393773qtu.10
        for <linux-rt-users@vger.kernel.org>; Thu, 01 Oct 2020 11:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A74w525Zeg3xx9WHLGSc4tGo1AFv8WB69yoQ0fuAJZE=;
        b=XnmXaTLW3QMl4QcERJYXmHQ1ba+Oixwf9PvURkaqmm+QjX2oestnqQNX6SuJgnO59T
         xMbS/afnYXE9Kr3fPAJTJZPEFVNRf3T6mSdmjMJkOq+b12R4VZI6EoZxrYqhCxaA1RiA
         tvCUk3AV9pAXJq+Qcp6wZck48Z692gFlmrzU//imtLcYTo+AlxBsYkdk/OIsKTWB4Kk0
         KTSf9rgamosRt5A7ijq7ZAGvjaUpchiu+ln2sSyBVS+cNDOfLT15SAjTLa24EsbzgI4T
         WJSAZ1S0pfW09q6g0lGhdbfmXGHpHFvMj2bWkl6fNRToticSWXGzudRBw+zFN1pREZyg
         WNfQ==
X-Gm-Message-State: AOAM5320Xa2lCMcJI4CxQnXb0wrKRz92yYwC/MTo1FVQ5zEs4ubCJ5Lo
        vgQkhrw1+r4WUExKzReHw6CGqFqYt4cVJb+6q6ttZ16zaI47Z9cXfW9ntptFkjkXoATpDSnaX+w
        hU9+a7T1iuJd+Qu4nI59Zx6RRwH8=
X-Received: by 2002:a05:620a:1341:: with SMTP id c1mr8762629qkl.460.1601578048607;
        Thu, 01 Oct 2020 11:47:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysI1b4Qd4MRKJdxZIF7Lfq1nXU7l2JbminiwBOhZo0R+lettDzDWQfvWOsoNUxwPv0wGaKRA==
X-Received: by 2002:a05:620a:1341:: with SMTP id c1mr8762605qkl.460.1601578048340;
        Thu, 01 Oct 2020 11:47:28 -0700 (PDT)
Received: from xz-x1.redhat.com (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id p30sm7397121qtd.89.2020.10.01.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 11:47:27 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Clark Williams <williams@redhat.com>,
        Randy Witt <randy.e.witt@linux.intel.com>,
        John Kacur <jkacur@redhat.com>, peterx@redhat.com
Subject: [PATCH] rt-tests: oslat: Allow build for not supported archs
Date:   Thu,  1 Oct 2020 14:47:26 -0400
Message-Id: <20201001184726.82245-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Now rt-tests won't build for archs other than x86/i386/ppc64 after oslat is
merged.  Instead of failing the build, let's make it pass.  However, whenever
oslat is executed, instead of running the real program, dump an error message,
so that people can try to implement the frc() function for it when there's a
real need for the new arch.

Signed-off-by: Peter Xu <peterx@redhat.com>
---

Just in case this got lost - I'm posting as a formal patch.  Please feel free
to comment here directly.
---
 src/oslat/oslat.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index f1a82f2..a8b6155 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -69,7 +69,9 @@ static inline void frc(uint64_t *pval)
 	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
 }
 # else
-#  error Need frc() for this platform.
+#  define relax()          do { } while (0)
+#  define frc(x)
+#  define FRC_MISSING
 # endif
 #else
 # error Need to add support for this compiler.
@@ -810,6 +812,12 @@ int main(int argc, char *argv[])
 	int i, n_cores;
 	cpu_set_t cpu_set;
 
+#ifdef FRC_MISSING
+	printf("This architecture is not yet supported. "
+	       "Please implement frc() function first for %s.\n", argv[0]);
+	return 0;
+#endif
+
 	CPU_ZERO(&cpu_set);
 
 	g.app_name = argv[0];
-- 
2.26.2

