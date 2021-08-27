Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F6EC43214
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B37760EFE
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Aug 2021 22:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbhH0WD4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhH0WDy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Aug 2021 18:03:54 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E9AC0617A8
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:05 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id p17so495067qvo.8
        for <linux-rt-users@vger.kernel.org>; Fri, 27 Aug 2021 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hp4ZZsw1Noa8/9+Tc8sctppvmPKGnVsDrkiRA1Bywsk=;
        b=BA7nXAxD6V9T0I/5B9wovVxH1CG78VbczlAcwCVAZMGfnxYtXA3w6nyRwuo8HxpSFz
         UCUm2LUlU5WrKY+AkRDcmOgFT1G5dNIOw6okmNZGaB4uAqNRumgmwCRX+Av5i4TTg4pS
         +NJJQ+Ro4jbPYBkI1BIncuYoAxiCIZi4Vi9CzN4cBZcVN8FM3uq3+Q0EMj8YLZPx5iHO
         SLiUzeqgXS1SVijzrtEp+qTe2865ZD92jGlUlK7lzVKUnUnH2dvTgx0sol4nxd3vmH8O
         aAPGh1bcS/EJusMtsiy7cMILQ3vsnwIm6e44nrkalnXe5bWXJ/wqYh56GSprxnYnj86s
         zjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Hp4ZZsw1Noa8/9+Tc8sctppvmPKGnVsDrkiRA1Bywsk=;
        b=Of8kNZHmlEeayeSgeZyiG8EpXOiTXSrH+VTniozfjukvsQT3AtQ1XJtESQ82EgheYE
         Fo2IDZY24y7xDTgvU98l2pKO3iwvRpDYWYGm3PHN2TqUotjeCGYWaaKpYcGwuQDmZsFr
         QlkgTMj+rC+izfTvx88KXUIyYgMUID0auHfmOolstq285ewzlX7mVKIqgZDJQgNB3Opq
         hQZM0cyU+rktqzHe2UY37wit2aSpeAHVDamFS92fsq2hcoyZdmkTm1P6YJXzsBhA33Ox
         GuepWnpoH7ODP7Eqz3IjxCXF/z2L/SFDMpLZJGBoLlgHdn0yJj/2GE2D08cQAgtF6uZ6
         F8lA==
X-Gm-Message-State: AOAM5322h5DqWcKJit23R+ANAcwIDdptL+kE+KW5K1BxsjvL5+jLLZ87
        u40vleq2vLf8QyPL6HVvwVPZx3UNIyG8xA==
X-Google-Smtp-Source: ABdhPJzvVQu5ZAoT7KLHUsFW3QCoUjCnWhupJh6Fyk9hQSXWvT39VbGv8pdjmFOTdedndDuI/sItAQ==
X-Received: by 2002:a0c:fe6a:: with SMTP id b10mr11925750qvv.6.1630101784555;
        Fri, 27 Aug 2021 15:03:04 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id t64sm5659209qkd.71.2021.08.27.15.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 15:03:04 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 5/8] rt-tests: pip_stress: Add missing paramater in error message
Date:   Fri, 27 Aug 2021 18:02:41 -0400
Message-Id: <20210827220244.24210-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210827220244.24210-1-jkacur@redhat.com>
References: <20210827220244.24210-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add missing string __func__ in error message

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pip_stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
index 8b91578f9ab8..c6d2bae05035 100644
--- a/src/pi_tests/pip_stress.c
+++ b/src/pi_tests/pip_stress.c
@@ -254,7 +254,7 @@ long process_shared_mutex_available(void)
 	res = sysconf(_SC_THREAD_PROCESS_SHARED);
 	if (res == -1) {
 		int err = errno;	/* save the error number */
-		err_msg("%s: sysconf(_SC_THREAD_PROCESS_SHARED): ");
+		err_msg("%s: sysconf(_SC_THREAD_PROCESS_SHARED): ", __func__);
 		err_exit(err, NULL);
 	}
 #else
-- 
2.31.1

