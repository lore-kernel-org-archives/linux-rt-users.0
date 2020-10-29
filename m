Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC611C2D0A3
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7ED2076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dv1hVxRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgJ2RlT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgJ2RlS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FD3C0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:18 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id m14so2328137qtc.12
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vyiOcB0HGNB5FSr4TLnhCJwcM6DAA7n3zmrU+bwhFAI=;
        b=Dv1hVxRHuGQz4DFgie/JDbasMNrf13TYMcrD2suXNuHWKEPC4ooMjUKKFMD49tGtzS
         dLhY9jnc7Nrl9UnwHkHLCIMiyhF9C6q6TxTXndmjr0t1P8ZCZDOjww3vurncKff5VAC7
         Lbz0k1DM+uCeAyu3Cv0Nh5aoaLvlKvpNmzu8UUOL0h1PraFOtSuGuwxrrKOMqF7w+GWm
         heoDRorZrodIFx5mhJCJmsmLQlz5iMIqUAHm3GWGuGWHWLpcYpobMalk3BsVRpocnVoI
         VLlYhMh49pAZKS7Di7AyJHkfAZKA9+oynRY2Gqm99SlrROPKNrAERmEL4N1FfCM7B7FB
         QTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=vyiOcB0HGNB5FSr4TLnhCJwcM6DAA7n3zmrU+bwhFAI=;
        b=mA+9FSfukFSYv2iXgUVLrVqunft/IIF2By5gykq4yWReCYgHGGsSEzo6HgjlxF+NMa
         bJVbYKKbpA+5hRkkhRhE0nCzbUHdzKhVW2Zjzh3Tr/IPNwt8ugrLIoPwffo276RgCBmV
         Xp4I7l9kMepcEtNC+aruOup86de+Fdj8IgStp9SFJPJh4sdnIcqJS+HgqCH1b+olfQ5T
         plqOL2/VzyR1xRJw1Zx9qjUBdukvtbyFSDlOzZmGGXsOMwvOgPjoy++s9lwBg1c4e5VL
         cMIoviqHx1y29o1pIAMTLndmjyp12TyV0ChEzx6MxNwtWsQ6+rzHW4QRfNLn3ckAkuqm
         E5GA==
X-Gm-Message-State: AOAM53110oRDLHL+PfpzrSVfP4WtW+F6oaDK3grLnajf1qJ0a7irA23h
        iTE3ZR+lhPKtXXoSELCpF7OODE/AItAdAA==
X-Google-Smtp-Source: ABdhPJyWlAJrB1RWnQyfyd0hcXYSunhSgae4O8nArmg/qGcmSPS3lASdB2ElhlP1ya5jCkZkgz1GcA==
X-Received: by 2002:ac8:7951:: with SMTP id r17mr4705710qtt.271.1603993277311;
        Thu, 29 Oct 2020 10:41:17 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:16 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 05/16] rt-tests: pi_stress.c: Change unsigned to unsigned int
Date:   Thu, 29 Oct 2020 13:40:46 -0400
Message-Id: <20201029174057.20033-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Change unsigned to unsigned int as suggested by checkpatch

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_stress.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
index 84da241098af..538d12c975aa 100644
--- a/src/pi_tests/pi_stress.c
+++ b/src/pi_tests/pi_stress.c
@@ -211,8 +211,8 @@ unsigned long total_inversions(void);
 void banner(void);
 void summary(void);
 void wait_for_termination(void);
-int barrier_init(pthread_barrier_t * b, const pthread_barrierattr_t * attr,
-		 unsigned count, const char *name);
+int barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
+		 unsigned int count, const char *name);
 void setup_sched_attr(struct sched_attr *attr, int policy, int prio);
 void setup_sched_config(int policy);
 
@@ -1422,8 +1422,8 @@ void summary(void)
 }
 
 int
-barrier_init(pthread_barrier_t * b, const pthread_barrierattr_t * attr,
-	     unsigned count, const char *name)
+barrier_init(pthread_barrier_t *b, const pthread_barrierattr_t *attr,
+	     unsigned int count, const char *name)
 {
 	int status;
 
-- 
2.26.2

