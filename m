Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A151C43334
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Jun 2022 16:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343661AbiFCQMp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343670AbiFCQMl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Jun 2022 12:12:41 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB295132D
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Jun 2022 09:12:39 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id 2so5976055qtw.0
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Jun 2022 09:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9k0mMemLrP5rNiq07wr/uvfB+u7bQdlKBfH17TMLQPw=;
        b=KxPGBdVTdcjHFrJse6pCqJP3R1LGZ3/txFgcsY1RvJrWZjXnohAv7W5S5qeKco4Kd6
         cpQJCTMMW/6OF5HfNzFIPMBnl5T0r1i/+RSkPKfqQAd+bB4KqweALJaIweh5l9I8NKKH
         9gw6t9bEJhyrv1zp7utnBKMU42duoVIYtZChlniiaeuvU7Orq2AmHcNZNEjK1uk1mFxl
         /jBz5XwZjX9+Dyrpt6l2rXaNH0/f84Fm9mCGljwUywtOPdWRA0zgvpNnoIUsumsSciHA
         hox5WGT0HSAcyKOuioEqbbw0KPcV5ZOkATcoLzB7FXkuOIwnymlJUzcuvDV85aCmm34N
         p72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9k0mMemLrP5rNiq07wr/uvfB+u7bQdlKBfH17TMLQPw=;
        b=yvodgOkub5+Qyno0FIyDZr8c0ATwKZOU5KskwzCaIGHiNoBJY0xYc6knvu/CZFXoaG
         x+s7uql28c8sZDvqSRNPWzQH7FeBz4wx5OxBZvyd6wr5Jr23JnBhl6S8f4pVtJva4A5v
         2mv8zAfCSpaKmPY34f6fIw1DI5tvrxXxGdWPpNMV23o6GogUHtig5R4yM6ex2Cu9qsGr
         rB8/1yeR0Mx2+Cr23aRobNN2iSOCQQ5AI/cYcdV/7gkg9xNgBlhMw+eGbwdbi2NBBtue
         k6owBV27As15INjx0nnr2CSR0+M0gxmlPl4akAt+8KLSAyQSHmQ2+bWYKpjqPNpmVB7i
         xDwQ==
X-Gm-Message-State: AOAM533aeNXsuhZtCJBTSx/yvV1de/HPoyHLcEMvahZM9lQeWHz3TRqF
        199wpwdLZooeU8Cp2ULhwh7USUBOrNU=
X-Google-Smtp-Source: ABdhPJxDVLqhnHLe4mD82clzhVqxAcWz2jyo5QFOKMuJxXGbmFYXFBGhwUFJl0Q1bsV626Sbh5G+0Q==
X-Received: by 2002:a05:622a:54f:b0:2f3:d566:e22c with SMTP id m15-20020a05622a054f00b002f3d566e22cmr8123550qtx.466.1654272758287;
        Fri, 03 Jun 2022 09:12:38 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id n12-20020a05622a11cc00b003022cdcd28bsm5234973qtk.2.2022.06.03.09.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 09:12:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/7] rteval: kcompile: Fix regular expression to match kernel prefix
Date:   Fri,  3 Jun 2022 12:12:23 -0400
Message-Id: <20220603161224.10947-6-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603161224.10947-1-jkacur@redhat.com>
References: <20220603161224.10947-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

If the user specifies a kernel to compile as a load other than the
default kernel, the kernel prefix is obtained with a regular expression.

Currently the regular expression does not accomodate two digit numbers
in the kernel version.
Fix that regular expression to accomodate different kernel versions,
with room to grow for the future.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/kcompile.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 2701a0dcba91..3d9b882d8810 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -169,7 +169,7 @@ class Kcompile(CommandLineLoad):
             if not os.path.exists(tarfile):
                 raise rtevalRuntimeError(self, " tarfile %s does not exist!" % tarfile)
             self.source = tarfile
-            kernel_prefix = re.search(r"linux-\d\.\d", self.source).group(0)
+            kernel_prefix = re.search(r"linux-\d{1,2}\.\d{1,3}", self.source).group(0)
         else:
             tarfiles = glob.glob(os.path.join(self.srcdir, "%s*" % DEFAULT_KERNEL_PREFIX))
             if tarfiles:
@@ -177,6 +177,7 @@ class Kcompile(CommandLineLoad):
             else:
                 raise rtevalRuntimeError(self, " no kernel tarballs found in %s" % self.srcdir)
             kernel_prefix = DEFAULT_KERNEL_PREFIX
+        self._log(Log.DEBUG, f"kernel_prefix = {kernel_prefix}")
 
         # check for existing directory
         kdir = None
-- 
2.36.1

