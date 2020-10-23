Return-Path: <SRS0=2Uay=D6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB13C388F9
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 19:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8305420E65
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Oct 2020 19:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pKl/HzH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754346AbgJWTL6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Oct 2020 15:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754336AbgJWTL6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Oct 2020 15:11:58 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA72C0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 12:11:57 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h11so1233022qvq.7
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Oct 2020 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TIxLrUnTUCw113Y7o3USJFykdKlBl03BfF9ZKNSXmzk=;
        b=pKl/HzH2Z5Sr8Mr7zQBnJceoCtSaDClgmwnVvBr0MgxS1pHyabPW7BSuk2VFVzxhCF
         hlqGNkm3FIo6A2jx5FDsuy+3RVtMMOj0I+VLM7J/ht6AVXN+Bkxc5RdX65pJmjdemFyQ
         uEoMeuOE1IQI5nEo8HGvVvOwZMitz+WFx+FXoJDi+RSqRDZ1kX5H6Aklni5IHQ2snDa+
         074U5CAUBmVVSMMqZBeeQ6svdgEp8uwca2Sg9TsNxOx/CisC6nH5MU4UP6i4YNj/D4Ps
         RsUuAFZX3Rwr76sG3ZYkhQ2o8mbjigFhJEWYFx+oDA+vZQpN/sQ6FUb/niuRXuUeWJzN
         PcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TIxLrUnTUCw113Y7o3USJFykdKlBl03BfF9ZKNSXmzk=;
        b=taQHZhkaZwTSyjuAhf5oHZV49ww4Idu2oDDNjxhi3vnHU4UKKWBfwMk1QFopladf0g
         rqoXeleO6eWUtjgYPevsCqljJxbqiElfPYYbIBrZxWYcZllDQqUd53mMHC4jAWDDtDsx
         VsaDtj6HukDf+28/keHSMhLg8hq5yuAV5tu+N7mRVoPKysirQrDNPCfDlfTp7wgN/vZZ
         JGjVuPEqKbrexvEYWPZ/Nf1Z/hJNPDrjI0Kc6lxjsGgeNLsN2qFxfbf5DAhESSjpAiMT
         iEL25qw5xx78zZLvODvbnvcz9rBxzLi1hNPkAWRVrdw7Q9PKAtV06k0R7LpvYLq6U9iA
         QiSw==
X-Gm-Message-State: AOAM530zFB5YZ2a/gdiH0d/nuhIMWE6Ylpn5y9/L6zzfP1XEMV/Y/gx7
        ozRH6KOD3dMn1o/6asXrBG7iaI/z3J1bIA==
X-Google-Smtp-Source: ABdhPJyQRopq+UYiQuArHq0vcKqQf3kHWk4VAYIvdI6EqhSt44PmBKMaFhZ04GJC8xd2EmTR0ngpYw==
X-Received: by 2002:ad4:4105:: with SMTP id i5mr295545qvp.47.1603480316886;
        Fri, 23 Oct 2020 12:11:56 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id j10sm602566qtn.46.2020.10.23.12.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 12:11:55 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: queuelat: Remove unused variable 'index'
Date:   Fri, 23 Oct 2020 15:11:46 -0400
Message-Id: <20201023191146.14151-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Compiling queuelat reveals the unusued variable 'index'
removing it.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/queuelat/queuelat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index 661e48db88ac..fbe5239ee81e 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -587,7 +587,6 @@ int main(int argc, char **argv)
 	char *fvalue = NULL;
 	char *tvalue = NULL;
 	char *qvalue = NULL;
-	int index;
 
 	opterr = 0;
 
-- 
2.26.2

