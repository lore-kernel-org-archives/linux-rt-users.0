Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2898CC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 10:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF91260724
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 10:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343745AbhIHKD0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 06:03:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22831 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231734AbhIHKDZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 06:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631095338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrTflqN0fORNHKDf8XTf+r5BG53XgabiLAvWGZjLbBY=;
        b=Px9mWFPrkrQ3ttuJPp287gnx+MOi4ESYDAwM6nWnKsG481O3fa27i1E56yiFN3dvw+t7W8
        p2p4pG3gZvoze89zlw30dVq25e7arxbEWUiYdTH1A0CfQcdSNa1TcIUgs4BtgO1Jbkm+hU
        aeUDnD5o54SRcyE7CxXEGs8J5Iq2LlY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-b_NZnZDINuGVvolfcGuArA-1; Wed, 08 Sep 2021 06:02:17 -0400
X-MC-Unique: b_NZnZDINuGVvolfcGuArA-1
Received: by mail-wm1-f72.google.com with SMTP id 5-20020a1c00050000b02902e67111d9f0so730573wma.4
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Sep 2021 03:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UrTflqN0fORNHKDf8XTf+r5BG53XgabiLAvWGZjLbBY=;
        b=ky29du43gEavBCzlB0sHNG8jHyvFI9MXAB8C1kjmAqJbF0WiEDyxOKilToMuj44zIr
         kEWK9WEU5FldXuIoi2d2HzELxjjAvGXbtKWH96mK1IFjgaD7hoTyK5S0zSGC1SXs8F1J
         GSL6jl/RrDBBTzIKqdPM0LajhO+kj5vxajlVpxp92VRwPT5EJ7TrVhfatiwOXTk1HnZm
         gtMckQa/2j1x1ZKo+mJLjE+zQgs5XBmgqbiM2bLJ3Vj7NS2CmdGC7ed+cxeoVDktuYhv
         qUrIaxmYPTbsAWPoBOWupolN46gqDtn17KcZ4VWcOPWt7ypkf2C0xdBqpp2moFGtZtn0
         N7ag==
X-Gm-Message-State: AOAM533fBFaj2sLLSXGRj5YxgOrRkcDHtfxJ4VxpoT6uRlt54gTswjhr
        70/NzfSP4h0z+FH0Ac2bSog0zoCub/BJYbywwxoOFD2TLRPnAy1V68yaSR/yV8OQUGIGQBZOEOW
        /iXEQoY06yc/OYoPOohWjQARNTuVepdh+fWWtpn1qahTPE2DVnlgkgGtM/EnrjjfBT4z2JWaMVS
        4fJ14=
X-Received: by 2002:adf:914e:: with SMTP id j72mr3041075wrj.428.1631095335664;
        Wed, 08 Sep 2021 03:02:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2cFxDwhpdVThZhJ8OxGBd4CmaemXISum6VF/9go1p24C1bZSgGZ2bLHnlxgqawU48d9KbVA==
X-Received: by 2002:adf:914e:: with SMTP id j72mr3041062wrj.428.1631095335465;
        Wed, 08 Sep 2021 03:02:15 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3811:7600:8004:a383:c7c9:7f11])
        by smtp.gmail.com with ESMTPSA id k16sm1679963wrx.87.2021.09.08.03.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 03:02:14 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-rt-users@vger.kernel.org, peterx@redhat.com
Cc:     williams@redhat.com, jkacur@redhat.com, nsaenzju@redhat.com
Subject: [PATCH 2/3] oslat: Add aarch64 support
Date:   Wed,  8 Sep 2021 12:02:08 +0200
Message-Id: <20210908100209.118609-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210908100209.118609-1-nsaenzju@redhat.com>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The callbacks are based on Linux's implementation:
 - CNTVCT_EL0 provides direct access to the system virtual timer[1].
 - 'yield' serves as a CPU hint with similar semantics as x86's
   'pause'[2].

[1] See Linux's '__arch_get_hw_counter()' in arch/arm64/include/asm/vdso/gettimeofday.h
[2] See Linux's 1baa82f4803 ("arm64: Implement cpu_relax as yield").
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 src/oslat/oslat.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
index a4aa5f1..bd155a6 100644
--- a/src/oslat/oslat.c
+++ b/src/oslat/oslat.c
@@ -71,6 +71,19 @@ static inline void frc(uint64_t *pval)
 {
 	__asm__ __volatile__("mfspr %0, 268\n" : "=r" (*pval));
 }
+# elif defined(__aarch64__)
+#  define relax()          __asm__ __volatile("yield" : : : "memory")
+
+static inline void frc(uint64_t *pval)
+{
+
+	/*
+	 * This isb() is required to prevent that the counter value
+	 * is speculated.
+	 */
+	__asm__ __volatile__("isb; mrs %0, cntvct_el0" : "=r" (*pval));
+
+}
 # else
 #  define relax()          do { } while (0)
 #  define frc(x)
-- 
2.31.1

