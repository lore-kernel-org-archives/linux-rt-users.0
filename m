Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E627C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Apr 2022 16:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354474AbiDSQRq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354482AbiDSQRo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Apr 2022 12:17:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC62CB7F9
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650384900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aOdBf52A4yq3oIDmLPsLpVZzeAmgmmyrVQYlhaKxLdI=;
        b=Xlp+3Qfb8fecOCYagbN2JGWAadbmSeXIc1UspJbNFD4t/Ea8jfgadGyEamICPuJOZ1wiDM
        +YBkIcSvCNfLW0Fw2aadGrGCw9WdGRB/krKnbLXlKUsAuO5orT/7qsr8EKoDc9ySC0/I5L
        RLjtZpTkGrWEMrNK1gof6MToKPviaDY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-5ra9LXJaNrS-eNrsISTIIQ-1; Tue, 19 Apr 2022 12:14:59 -0400
X-MC-Unique: 5ra9LXJaNrS-eNrsISTIIQ-1
Received: by mail-wm1-f70.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso1550759wma.6
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aOdBf52A4yq3oIDmLPsLpVZzeAmgmmyrVQYlhaKxLdI=;
        b=W0+LuRosR9hFcuoH8YmqVuxksn8RBXbF6f26lDyYH4No16VvYKQVf3PLVpERJmoBDc
         q/SL/Qja5CMGdNB1gCPLErbTON2olRm3DvKOpIU3gAygXR+oiqOLRC7AnJyy9GUnkWTU
         9yjGeWQLZbNR9TpANyIjWqpAOit4Z0jNzn/GmjdWqbiQPRhwAZjpRRw1iAWfDtQqGRgK
         D48iJGtdpokgBxD5BcSIhUNSLbvHtOtMfY5miOnuDk8JJyJML4kYhgBhwbBivpZxv5CM
         eFmH6DyJaEAL0RGZDFW7qe+Rk4VkaSTW44vHeHLABwrcLiNM35izw9ifoe4KRE9SHlVB
         Rr6Q==
X-Gm-Message-State: AOAM531dIW145aICDlwZ+htNKiiNzqei5XpfPF9tzD+vridWWHWv/qf8
        4u6C4tNwuZXMqwwEvLwZTSSqvlTdDSkg0vgEHlQM1h68nCblVcbaJxN5upp2FMDN+Ur5WXsnDZx
        AS4tVnoRpLd4diCx1E/Ovt25N6mtlMaE5LfgGej5PHGoZ5TsXjxVqwsHRQD/++ropn2pyAOv7si
        1jd14=
X-Received: by 2002:a5d:5955:0:b0:207:8444:203b with SMTP id e21-20020a5d5955000000b002078444203bmr12227689wri.433.1650384898172;
        Tue, 19 Apr 2022 09:14:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpEZQaTWb0S+s9osED8NGL2BjD8O0xr+iG1nJT6DCnKqW5mlxwgxQIBHhTw6cgx4E7o6lXRg==
X-Received: by 2002:a5d:5955:0:b0:207:8444:203b with SMTP id e21-20020a5d5955000000b002078444203bmr12227672wri.433.1650384897947;
        Tue, 19 Apr 2022 09:14:57 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600018ad00b0020a87feadfcsm8682381wri.84.2022.04.19.09.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:14:57 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH 3/3] rteval: systopology: Slight CpuList.__expand_cpulist() cleanup
Date:   Tue, 19 Apr 2022 17:14:43 +0100
Message-Id: <20220419161443.89674-4-vschneid@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220419161443.89674-1-vschneid@redhat.com>
References: <20220419161443.89674-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This method currently aggregates CPUs into a list, then converts this to
set and then back to list. The aggregation can instead be done directly
into a set.

(as an offside, it would make more sense for CpuList to have its storage be
a set in the first place as duplicate CPU ids don't make sense for it, but
that's a separate discussion :-))

The integer conversion of the "a-b" pattern can also be condensed into a
single map() expression.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 rteval/systopology.py | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index b2da7bb..2a28f9c 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -102,20 +102,19 @@ class CpuList:
         """ expand a range string into an array of cpu numbers
         don't error check against online cpus
         """
-        result = []
-
         if not cpulist:
-            return result
+            return []
+
+        result = set()
 
         for part in cpulist.split(','):
             if '-' in part:
-                a, b = part.split('-')
-                a, b = int(a), int(b)
-                result.extend(list(range(a, b + 1)))
+                a, b = map(int, part.split('-'))
+                result |= set(range(a, b + 1))
             else:
                 a = int(part)
-                result.append(a)
-        return [int(i) for i in list(set(result))]
+                result |= {a}
+        return list(result)
 
     def getcpulist(self):
         """ return the list of cpus tracked """
-- 
2.27.0

