Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCA1C433F5
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 15:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D0A61076
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 15:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbhILPrM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhILPrL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Sep 2021 11:47:11 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472CDC061574
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 08:45:57 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b14so6158797qtb.0
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 08:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TxmDavi5YWZwRENomUVh+Bbg/8pl12ax5VAI1ruWtDY=;
        b=OY6CCXaujkflATK7obmlLrBec4wCll3DYwHbAiF0KgcE84PZ44L1JYF0HNU+nagUHo
         cbnHIefXHUGFQZJhdbXnJZzTNDR6Okqzzv4DZtYSZF80ukOKCGwY3dh23NMP5MAimDUo
         6DNm6ZPzX17HSok1nN+RHsVV8JXvCUJRbfS4bLJVtIjiM9dzqu9hrtPge+6591REuqUt
         bXjSELjh/kZI5EtxYCgaNuTQXBpZWAE3Es3BBA+OBKpXClr/j/i7Z0GGUW9moJY2Xs4Q
         8nN9KTfx0BhGT7WSG6iLf+Bp5VYbrmXtlSX6noJgzJv4gd2l8vRs0HWAq9qfgik/UceW
         Y6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=TxmDavi5YWZwRENomUVh+Bbg/8pl12ax5VAI1ruWtDY=;
        b=apfeL/ni2Q0wwWvEr8Ty43B7gL5nJdMBcBEdHNnHMdzjST7dVimyGt4Hde7+Y4FvjG
         sNsCa9ZZT0OOJw/3ISgOjEoXIu3f3cFpWpY34Lja9nsF2laN05xP5OSaEpDSwY0Y5EDE
         DOlW+a6E9hczZqdBrxv48BkDbsXc2/1KG/QcMam7D1LZv5BjQaikNLfW3SxT/AuGO3T3
         B2vhW9jYen+ncelK2kPRqyxoHQmwagryfCOGt9U+JZtRbeQk9cr2WQviHoFGjWkCbHg0
         dGaKIjnJ8oJHO+EO/Hi7khM6Ji0AmTGWwpV6NkTSI1HdK84HMFhyFLoMycHNPnhxpoQu
         PB4w==
X-Gm-Message-State: AOAM5338WV1XNiWDoz+ElHHjGGkAqqmi4QoEjk7f+/F2Nu7jJdbK6U4L
        DYpzRCAYF6nPNXMZwoH83Q4=
X-Google-Smtp-Source: ABdhPJzB0nTL746KfQiLbQPmNT9QzuByESPiRyP3xlAPefdg/s54u+2+M9zTRlR+Mt02DvT7NKBZ0Q==
X-Received: by 2002:a05:622a:4d4:: with SMTP id q20mr6148134qtx.271.1631461556413;
        Sun, 12 Sep 2021 08:45:56 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id m16sm3268971qka.84.2021.09.12.08.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 08:45:56 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     Clark Williams <williams@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        John Kacur <jkacur@redhat.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH 2/5 V2] rteval: Construct a 'model name' on architectures that don't have one
Date:   Sun, 12 Sep 2021 11:45:38 -0400
Message-Id: <20210912154538.255217-1-jkacur@redhat.com>
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
index 0dd361ff19fd..c1d2a972430d 100644
--- a/rteval/misc.py
+++ b/rteval/misc.py
@@ -77,6 +77,27 @@ def cpuinfo():
             info[core] = {}
             continue
         info[core][key] = val
+
+    for (core, pcdict) in info.items():
+        if not 'model name' in pcdict:
+            # On Arm CPU implementer is present
+            # Construct the model_name from the following fields
+            if 'CPU implementer' in pcdict:
+                model_name = [pcdict.get('CPU implementer')]
+                model_name.append(pcdict.get('CPU architecture'))
+                model_name.append(pcdict.get('CPU variant'))
+                model_name.append(pcdict.get('CPU part'))
+                model_name.append(pcdict.get('CPU revision', ''))
+
+                # If a list item is None, remove it
+                model_name = [name for name in model_name if name]
+
+                # Convert the model_name list into a string
+                model_name = " ".join(model_name)
+                pcdict['model name'] = model_name
+            else:
+                pcdict['model name'] = 'Unknown'
+
     return info
 
 if __name__ == "__main__":
-- 
2.31.1

