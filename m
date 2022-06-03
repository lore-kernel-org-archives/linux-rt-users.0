Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E142ACCA47C
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Jun 2022 16:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343677AbiFCQMp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343675AbiFCQMk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Jun 2022 12:12:40 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F702458D
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Jun 2022 09:12:38 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id hh4so5932520qtb.10
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Jun 2022 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/aWJuzVYe3qDTmxu38CCqQJ4X0BWQjcreVq6YRaA4u8=;
        b=BPnEckFT1P482lO8Bibtg7tkP2SKFsGCobgjKjBEnuI+NvOfYYbcRVqZSWlUWw9a42
         2T52kyDdKyuk6FFkPlG5AdpOY3oEOqRfzmRvqJhcsnlDo62Sxv7lQft7RDq9AqSwMyhC
         WLL0ib/WYWA+8jG1jMt7+QtVQ/044HOvhgLEWw0WTuLLY6Sct5QKLnHJxsnKsSrootZR
         45OmOck9I4ofIitztfuHE3c8in/5qjWYw1ibzOYSUZuALaWfZ/HmsICsl4R9piDbaDDH
         BqJepx0rrtGybiyo1iLaoRAOK8/IJ8cIPGIlX5jgs3xHPKEqAgg+0YicgAQDPovMnn0Q
         juVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/aWJuzVYe3qDTmxu38CCqQJ4X0BWQjcreVq6YRaA4u8=;
        b=3WVh0EDtiN6PDWbWil10u+TlNyeMfC2t1eZR++ZYgTSgFj9Pk2bm83VrePYIlkAO+g
         ELTsIuSbZfYJUIkmKyefmpYIU0zedBq2dgoTxab+aB7dAVgb00f3sVXh/L6hLv8PH2uL
         jRvPgjtABwex/MaHOSI81akZ16GI5+1x4rCGQLPGuf0w+UJWFWdmIB7SuiFpQJ4b1Ki0
         AzSFYDg/5Ik0cjBrMrccw63z6hWp2g4cXVv6Vws0xonOSf1o58GQJQWD1WuPjeE666vn
         9a/huwT4HaVBuakN8p6ouCqd9433BduGNZp/yWpXY0UUdACnwjTH2+POxyDLOFpHXVW4
         G5jw==
X-Gm-Message-State: AOAM533jgKC5qR0Gkxyf0WCo3aDxf76NgfeqRRWJoikqgmoQLfBP0/1z
        vtNBOoaCdlUP/pFiG2I9g6uMlAsCFGg=
X-Google-Smtp-Source: ABdhPJx3i5X4cVSsjJaIMMs79814kudHeX7jDvU5DzZflYncxvnbyLAntromGegLVlAQ6XX2F3U6UA==
X-Received: by 2002:ac8:5802:0:b0:300:8490:b2a with SMTP id g2-20020ac85802000000b0030084900b2amr8245464qtg.128.1654272757373;
        Fri, 03 Jun 2022 09:12:37 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id n12-20020a05622a11cc00b003022cdcd28bsm5234973qtk.2.2022.06.03.09.12.36
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
Subject: [PATCH 5/7] rteval: systopology.py: Use "with" for resource allocation
Date:   Fri,  3 Jun 2022 12:12:22 -0400
Message-Id: <20220603161224.10947-5-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603161224.10947-1-jkacur@redhat.com>
References: <20220603161224.10947-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Use "with" with open

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/systopology.py | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index b2da7bba7de0..e852f86e450f 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -180,13 +180,14 @@ class NumaNode:
     def getmeminfo(self):
         """ read info about memory attached to this node """
         self.meminfo = {}
-        for l in open(os.path.join(self.path, "meminfo"), "r"):
-            elements = l.split()
-            key = elements[2][0:-1]
-            val = int(elements[3])
-            if len(elements) == 5 and elements[4] == "kB":
-                val *= 1024
-            self.meminfo[key] = val
+        with open(os.path.join(self.path, "meminfo"), "r") as fp:
+            for l in fp:
+                elements = l.split()
+                key = elements[2][0:-1]
+                val = int(elements[3])
+                if len(elements) == 5 and elements[4] == "kB":
+                    val *= 1024
+                self.meminfo[key] = val
 
     def getcpustr(self):
         """ return list of cpus for this node as a string """
@@ -212,13 +213,14 @@ class SimNumaNode(NumaNode):
 
     def getmeminfo(self):
         self.meminfo = {}
-        for l in open(SimNumaNode.mempath, "r"):
-            elements = l.split()
-            key = elements[0][0:-1]
-            val = int(elements[1])
-            if len(elements) == 3 and elements[2] == "kB":
-                val *= 1024
-            self.meminfo[key] = val
+        with open(SimNumaNode.mempath, "r") as fp:
+            for l in fp:
+                elements = l.split()
+                key = elements[0][0:-1]
+                val = int(elements[1])
+                if len(elements) == 3 and elements[2] == "kB":
+                    val *= 1024
+                self.meminfo[key] = val
 
 #
 # Class to abstract the system topology of numa nodes and cpus
-- 
2.36.1

