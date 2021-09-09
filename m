Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E7FC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 14:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB97461131
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 14:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbhIIO2r (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242964AbhIIO2e (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 10:28:34 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD42EC02259A
        for <linux-rt-users@vger.kernel.org>; Thu,  9 Sep 2021 06:10:13 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s15so1295008qta.10
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 06:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cy5cNItwmntYRpJx6yz3gUfHCK7aLxoU7JFaj7E7K4w=;
        b=L/QBym4TbrZIOXmT/4RduQPYCDUB7OxAVflOWsL2vyLU2fdxQwe60z3whR/P6SA/79
         B0Ok7uaim6cVKOKLCkfTBDe+ysBXin73w0r1ACuznzIzMLd8eRVLxWx+W8hKnueIFdqd
         vMot/zN0W2/HfNiWlcLb29rFshGJ5noQaZ32mkgW/wiaXOqJiZDmQLquYyq+vv/SlBqc
         PZ18B+ozPTRh6wH5Otk1mYz41bdNocKnVHEUpUbpHfpLNxUOEgEKrigY2XxlJTlNhmNy
         GY89H2kh8gjr7i4zE12MOUiFdXJzvOsDPWMwU8If9azY5kc3WKc373uMl5zqGfYli/QG
         81pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Cy5cNItwmntYRpJx6yz3gUfHCK7aLxoU7JFaj7E7K4w=;
        b=hcMLpb0SRZzIobAfjYWXstrAOOlML8nwccFHy2hEHK2WVgBU8UpE7UwEXUpXqeXWv+
         bvijJsKEc66eZrtPr9hyt11538VDh5HWZUJDU4L3LzSEnywY7YisQCmE/MJm9T6YNoTv
         weE2LvYoRzuC1FtT9Yv/r6aOXbj4MGLmltYOnWzqUoQEJnYp3NmIc93/KLXv/ZRCkAZP
         ScNkMf/R3awtX9n7XA2dJx3FPKRbTp0R62Tg1U9mWShhIFgtKf/UV2S9hH04uTmKUtEA
         fH1yXrIxjOOVWojNCrEC0pgsRH/tSerkFcYVAKcTMMI0qixA9T5M7Ds+4QQ7tuoRvDYA
         3DdA==
X-Gm-Message-State: AOAM530Cd2Hkn/Ks9I5m6Rsb8QUf7pIzze3OIOoQZYHy9ZmaFRWH8TjL
        fcBmboDbzvc5Tr5PzynWqwkikJ+jhUs=
X-Google-Smtp-Source: ABdhPJx/jhHks6TxQUEfPFBl2nXPO8+8cx2VQZ9Jt+yPjdsxUDO8azkzYc3sFUufy7DtnipW8ph6LQ==
X-Received: by 2002:ac8:5911:: with SMTP id 17mr2660247qty.104.1631193012702;
        Thu, 09 Sep 2021 06:10:12 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id n11sm1263034qkk.17.2021.09.09.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:10:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Cc:     John Kacur <jkacur@redhat.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH 2/3] rteval: Construct a 'model name' on architectures that don't have one
Date:   Thu,  9 Sep 2021 09:10:03 -0400
Message-Id: <20210909131003.6397-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is based on an idea from Punit Agrawal <punit1.agrawal@toshiba.co.jp>

On architectures that lack 'model name' in /proc/cpuinfo
create 'model name' Unknown when creating the per core dictionaries
in cpuinfo

For arm, we can construct the 'model name' from the
'CPU implementer'
'CPU architecture'
'CPU variant'
'CPU part'
'CPU revision'

Suggested-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/misc.py | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/rteval/misc.py b/rteval/misc.py
index 0dd361ff19fd..016fc7c4b494 100644
--- a/rteval/misc.py
+++ b/rteval/misc.py
@@ -77,6 +77,27 @@ def cpuinfo():
             info[core] = {}
             continue
         info[core][key] = val
+
+    for (core, dict) in info.items():
+        if not 'model name' in dict:
+            # On Arm CPU implementer is present
+            # Construct the model_name from the following fields
+            if 'CPU implementer' in dict:
+                model_name = [dict.get('CPU implementer')]
+                model_name.append(dict.get('CPU architecture'))
+                model_name.append(dict.get('CPU variant'))
+                model_name.append(dict.get('CPU part'))
+                model_name.append(dict.get('CPU revision', ''))
+
+                # If a list item is None, remove it
+                model_name = [name for name in model_name if name]
+
+                # Convert the model_name list into a string
+                model_name = " ".join(model_name)
+                info[core]['model name'] = model_name
+            else:
+                info[core]['model name'] = 'Unknown'
+
     return info
 
 if __name__ == "__main__":
-- 
2.31.1

