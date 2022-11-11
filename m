Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B4EC4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Nov 2022 19:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbiKKTxh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiKKTxg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2022 14:53:36 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A3E2D7
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:35 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id e15so3274690qts.1
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PFhY1mbdwozhDA+cmgvRco1GaP64Zi7cV1ytk4G1F2Y=;
        b=VedKw04i1a0S08yD6FrcxNRArqdr2LnCGdPiwUmYIjYJUILJ/OpaHTWD5sTeB4orra
         Tn+zYkKrnBvJ1uNYXJAiMsC/tku8ipldj4YGgLHaF8TXRPEAwX9+yVum5dX/0uM2HzC+
         8Ib9sKiXHib6WMfNc843pHP+TKqnr/ygXQZBNe0ruUJDYOKBNIyjEy6XwMrWJ3cxnpsh
         stztyBqM0L2NjSitnCAnIMthX/1H+oT0d0Kr+tVm6PMimICoaZbfqf2KQnCdsGcR0DXV
         YKUth4flWiHT6tNCeb3FCHp3siodc7NwNBU5sqTRi/epvdFN7tk7bCKrmdxaHQvxn/tt
         YGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFhY1mbdwozhDA+cmgvRco1GaP64Zi7cV1ytk4G1F2Y=;
        b=cgq5Cejz9BPiukZYfCEGDq1vGZE5HNMVOw2ITlDbPCER+zOUMjYQdupozujvzkGVwa
         SicRdrGaaOAexiump5XFzLKNIC9oWZb2WZSM5dYE7L3VSUbWCHCyOaw+rkG1Rl8SqF1U
         iGgr4qQT+TlHHapWKL9E9+gn3byJiow1T8MZSwscTGbA4sChVMBTEsanYmAV65NjGg83
         X+iLM8ta1rml2VK0Kti8+NBDwS9kjn+rAfIDL+pTLfrXzXEcXuzCFX6geKz/cUdNlmDg
         hdJdvFnvB+xUWo+Ntjz3LSPWhBn/v1tnCDoEpYWb/KTfh3N21MgeZPPYxRTzq3RO8eAP
         ZLWQ==
X-Gm-Message-State: ANoB5pliYaV+EXsq35xc+itdgi2l2mRWxWWGG+d1vvLE51BlG/HlYlQP
        KQtkBqL51ZNMNzGqXYVcj+WslAqXR9c=
X-Google-Smtp-Source: AA0mqf7QO6yyIMVsF/kzPmwGmThjd13OsyC9UfzDBX2jLsy/14OnySGkYREM22RGM4nte6G+NOZT/w==
X-Received: by 2002:a05:622a:4806:b0:3a4:f140:f707 with SMTP id fb6-20020a05622a480600b003a4f140f707mr2812746qtb.317.1668196413874;
        Fri, 11 Nov 2022 11:53:33 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id i17-20020ac85c11000000b00397e97baa96sm1794332qti.0.2022.11.11.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:53:32 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/8] rt-tests: Remove arbitrary num of threads limits
Date:   Fri, 11 Nov 2022 14:53:16 -0500
Message-Id: <20221111195323.27402-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove the arbitrary limit to the number of threads in pmqtest,
ptsematest, sigwaittest and svsematest.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pmqtest/pmqtest.c         | 2 +-
 src/ptsematest/ptsematest.c   | 2 +-
 src/sigwaittest/sigwaittest.c | 2 +-
 src/svsematest/svsematest.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
index 6ad0a92ffb5c..9e142787d8b4 100644
--- a/src/pmqtest/pmqtest.c
+++ b/src/pmqtest/pmqtest.c
@@ -393,7 +393,7 @@ static void process_options(int argc, char *argv[])
 		}
 	}
 
-	if (num_threads < 0 || num_threads > 255)
+	if (num_threads < 0)
 		error = 1;
 
 	if (priority < 0 || priority > 99)
diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
index e000c3017081..a9d6c69b6449 100644
--- a/src/ptsematest/ptsematest.c
+++ b/src/ptsematest/ptsematest.c
@@ -299,7 +299,7 @@ static void process_options(int argc, char *argv[])
 		}
 	}
 
-	if (num_threads < 0 || num_threads > 255)
+	if (num_threads < 0)
 		error = 1;
 
 	if (priority < 0 || priority > 99)
diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
index d0d79df940de..728176a0b385 100644
--- a/src/sigwaittest/sigwaittest.c
+++ b/src/sigwaittest/sigwaittest.c
@@ -369,7 +369,7 @@ static void process_options(int argc, char *argv[])
 		if (duration < 0)
 			error = 1;
 
-		if (num_threads < 1 || num_threads > 255)
+		if (num_threads < 1)
 			error = 1;
 
 		if (priority < 0 || priority > 99)
diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
index 22ea7bcb7374..243b13738b19 100644
--- a/src/svsematest/svsematest.c
+++ b/src/svsematest/svsematest.c
@@ -398,7 +398,7 @@ static void process_options(int argc, char *argv[])
 		if (duration < 0)
 			error = 0;
 
-		if (num_threads < 1 || num_threads > 255)
+		if (num_threads < 1)
 			error = 1;
 
 		if (priority < 0 || priority > 99)
-- 
2.38.1

