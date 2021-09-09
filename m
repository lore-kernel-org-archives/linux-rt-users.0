Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8101C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CB56113A
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 14:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348324AbhIIO1O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348194AbhIIO1K (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 10:27:10 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBECC128ECA
        for <linux-rt-users@vger.kernel.org>; Thu,  9 Sep 2021 06:03:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id s15so1274635qta.10
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWl94QSKz2aynWdb1XpxzC4nz4IQ7jS0yxXcsSGyoE4=;
        b=QoJggSxtNqYOwPjPY6b8KWRrF4t48RkvAajRf+g8JfZR8vp32I3yxEHOTSv+RVuOIA
         cfEEplm8dUtXddaTfZaRZPVPLt0TIkPosNo9NN1NzPB7vLt8v1I06Mjvyd7iGlJUH/Ls
         0PW7YPMnUa16zDw2RNiAIqJGEiJvZOrYV55leBdNCOlgvDVv68hAuhllP/XTMMClmbSB
         Fhy5GPGnXpO/6lHnTZoodWoUjrTf5bAgSzT2+c43dHfHCVXs8g7vKdPKrLBS8nFEe+TD
         OM/GYePSenqwSIjVI4Y1vF8zh7xTPjNovSqpLWlmBWruWsGKM7DmtBVItWgZo5azIdkF
         8b8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WWl94QSKz2aynWdb1XpxzC4nz4IQ7jS0yxXcsSGyoE4=;
        b=XB9vqt9gKAKtoHEGIlmsc5KqpdunODGRawUq/HpxC2thvNTuwsIcTWlGsdZfJUugtJ
         EMTxB4LV56UW0pVlvvrZxMj/5R3PKmI9wUc+5bul26nydx1eU7/3wX0aRvWSO2jZgPQn
         mTb5xMT8EMjfkVnGposBNk8u+LApsusm7ov2HqS5itPETAc2RvR0fpzRCmdlquYNlBmf
         NYY9oqu+Z06Tt8Nr/znsbiQ6GIpdBM4jMBrQrkcUZwM50m/2cUiPq8s04uc6apZuyfqI
         3NMXn27Fxc/92z3R7U2mxGMcc/JszyFcoFC0cR2BUN1gLveE9ReEVqa42U2Cf2twEFxV
         z5pg==
X-Gm-Message-State: AOAM530gGjrTeuu9ub5oToiZXH7JAa4UWDYt4EZFOZUks+S1kTeTUFDA
        DjFbdzBHZcKQUtpvESbY1suSg9tOdk8=
X-Google-Smtp-Source: ABdhPJykevoCbeMQW59dnxC3SLMMUei9wGnLvWll4DoiW9ekInjRizhf5LBDQ4Xp43lHetiSXZQkTw==
X-Received: by 2002:ac8:7c5:: with SMTP id m5mr2714424qth.180.1631192611841;
        Thu, 09 Sep 2021 06:03:31 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id c4sm1284097qkf.122.2021.09.09.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:03:31 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Cc:     root <root@hpe-apollo-cn99xx-15-vm-19.khw4.lab.eng.bos.redhat.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/3] rteval: Construct a 'model name' on architectures that don't have one
Date:   Thu,  9 Sep 2021 09:03:13 -0400
Message-Id: <20210909130314.6109-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210909130314.6109-1-jkacur@redhat.com>
References: <20210909130314.6109-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: root <root@hpe-apollo-cn99xx-15-vm-19.khw4.lab.eng.bos.redhat.com>

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

