Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD51CCA47E
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Jun 2022 16:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343679AbiFCQMq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343681AbiFCQMo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Jun 2022 12:12:44 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4CF51321
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Jun 2022 09:12:40 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id hf10so5944264qtb.7
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Jun 2022 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAuyq01gEJicW8kHsVE1DlDa7X2Ma8pHmz09RMBBqUU=;
        b=UrqPuG3yMRNS2xuFbKmqLlV3Lt4cslG3p1aXGDB5au0RXS9cgoxPpSwWg48aiQxbcP
         mgyTEt/xTCM7PY/5Obfmi1hgAfPuenbmL0x1cqaZWxSIsxoOvRK+L2lpgnRlmKO2p/2u
         drY32S5yg2OS4qfvlXGLt2432NEHC2kVt9tDZQJN/UjkXCDkGcnKm6bsK87db0ns3X+7
         bx+zs2CaUX9TRItsMRxTcE40zRogWR4J2D5ctNgoMsyQjXq7IPsB46/zPBETFU8USm/x
         HcdRLmwygKh1fEFTPoSg7Ru9E8luoyTW4ZS+5dCcM0XdhJZNagyDaWofJ3ZLUWcShcHV
         QpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HAuyq01gEJicW8kHsVE1DlDa7X2Ma8pHmz09RMBBqUU=;
        b=wVz5FpBxFi1ByE5KN2XbusYikhJ6bOa4uQ6RztVBorPfS6UKnMYPjI6tb43Tn2M5yy
         NqE5GghZd0fPuJaeUFKq2R3a5Lf3aSvu4ga+xJHDD236IzOYcoH4xNqnwZAdQDVBg8jP
         q3liMYewUSuL9jUuQjlUXobuq7+9pwd+RwlUltw82Kr0hv5rbHZgrI6VN2dyIl0Y2l1X
         jsxjXKXe2VCQvCpWGouOKqB2ANaagrxiVz/dq91wQmNUpBtOdyKGmqfQQo/kwgymvsfx
         uxP86ooFDafqYd0IGho9aRkGkt5WYJxmAiB3j4xwTFLYTMyb0N6rDOySAbC4zHjFFBZ+
         bGNQ==
X-Gm-Message-State: AOAM531kHuWQkeAdaYUn02ZLUjrewDIMMrhmdFQFuCOcH7zLbgTm5MDM
        XHzJXhsrMGbkvFzh1nlUwph+anRyyVc=
X-Google-Smtp-Source: ABdhPJwZnrzc4MDHko9zwfCc6qADKi5oN2MHgtczrSQkiaWbxS/5jMeuQLMjND/5GPf0r1bsgGJoQA==
X-Received: by 2002:a05:622a:108:b0:2fc:7ed3:a158 with SMTP id u8-20020a05622a010800b002fc7ed3a158mr8094471qtw.597.1654272759313;
        Fri, 03 Jun 2022 09:12:39 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id n12-20020a05622a11cc00b003022cdcd28bsm5234973qtk.2.2022.06.03.09.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 09:12:38 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 7/7] rteval: stressng: The stressng option should not be a string
Date:   Fri,  3 Jun 2022 12:12:24 -0400
Message-Id: <20220603161224.10947-7-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603161224.10947-1-jkacur@redhat.com>
References: <20220603161224.10947-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When rteval passes stressng a timeout option, it should not be
stringified.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/loads/stressng.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index d0772ce77662..fe97189d3816 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -54,7 +54,8 @@ class Stressng(CommandLineLoad):
         if self.cfg.arg is not None:
             self.args.append(self.cfg.arg)
         if self.cfg.timeout is not None:
-            self.args.append('--timeout %s' % str(self.cfg.timeout))
+            self.args.append('--timeout')
+            self.args.append(self.cfg.timeout)
 
         systop = SysTopology()
         # get the number of nodes
-- 
2.36.1

