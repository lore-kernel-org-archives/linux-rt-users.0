Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA3DC43219
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 14:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D241B6115A
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 14:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348382AbhIIO1O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348113AbhIIO1K (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 10:27:10 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1057DC00668E
        for <linux-rt-users@vger.kernel.org>; Thu,  9 Sep 2021 06:03:34 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id r21so1273422qtw.11
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SUzgKjeanlGoA38GGK7XEQCJewPtQhN7SZ0sI8vDRC0=;
        b=qVjChd8tkke5oIGgzA5WhnsMoxhqkKK+e5ulf2f9e62AN4dKhHa5Og4HNoWxvbNbB9
         OZw0qX61bBSfDjDw1x4FpJk9+slEQwY0r3vcNrzF6KnrtfAJL9aiQvbz02hp8NaFsKx3
         PJcY8LGQT+ryOxsFY0Gt56tZtxoHhwc+3cKI70AQGEYaHpfa08WqzAg+tTuLnPxMDXaE
         XdWid/p19wePB+EigDWz9+l5ia32j9uR8Wt0q5BE+WYKjnbOeK1YBck7rMq00TigMIlX
         JtCicZJxfzB3tYh8PmphqGzKLmxMQeiuu3HYqkkF9P/HwYPFvO2j1b6twhMIJ22O5xVq
         k25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SUzgKjeanlGoA38GGK7XEQCJewPtQhN7SZ0sI8vDRC0=;
        b=iR/nuspXl9On1Cldb5/Z3Ogsn5zt3qPoatx6PFsI309CLffDMbFNNSulX1NNUSfHEE
         Q94ryf5AwrgO7yyp62DbZhHGLEQ9obg0+LPzyshGFuV4IUEmfMt6Nn9JiAHEczt66XfY
         Gp1FBOM3j8ieJH/+RkwXtdZw3KqE/hPmfJ+O9WjxKeU+7wrj4yLOzGbEMU59BWfptZkP
         w9cEZCGIgC4xbz3enmbcLTf6bBxronElW6N+vjT0/7M8PMDSJ8Ex7axPzSCnW7S/NuXM
         qhKmepa0/lG5nulKJpNnBo0uuv5zzI+SMiLgC4MtYakwEohnOv/3Rj5x/cLwMVGitFWJ
         vo5Q==
X-Gm-Message-State: AOAM532yIKiW73LZcivvWQ9sJHl3aEEk3AH+E/N5w5LIF33yE4NZrIZC
        +G2FJfur8YU+7ISAxpBD9i0USOy7Mcw=
X-Google-Smtp-Source: ABdhPJwkjqb0a4tvqDiDZA1zIM6wwDS3N4pOYNbQz82CPBIyqMA2rtXM5eAvrxUtT3z//D06/Rs2hA==
X-Received: by 2002:a05:622a:2d1:: with SMTP id a17mr2624642qtx.236.1631192613130;
        Thu, 09 Sep 2021 06:03:33 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id c4sm1284097qkf.122.2021.09.09.06.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 06:03:32 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 3/3] rteval: systopology.py: Add support for systems that don't have Numa
Date:   Thu,  9 Sep 2021 09:03:14 -0400
Message-Id: <20210909130314.6109-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210909130314.6109-1-jkacur@redhat.com>
References: <20210909130314.6109-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Certain systems such as Arm v7 do not have support for Numa nodes,
i.e., "/sys/devices/system/node*" does not exist. Instead of erroring
out in this situation, it would be better if rteval could use
alternate sources to get the system topology and memory information.

Introduce the notion of a fake Numa node (as a class) which is used
when no numa nodes are found on the system. Other than the
constructor, it provides the same interface as the existing NumaNode
class so existing users should work without any changes.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
- Renamed Fake to Sim for simulated
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/systopology.py | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index c61ec1a58514..3c996048f8c1 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -191,6 +191,30 @@ class NumaNode:
         """ return list of cpus for this node """
         return self.cpus.getcpulist()
 
+class SimNumaNode(NumaNode):
+    """class representing a simulated NUMA node.
+    For systems which don't have NUMA enabled (no
+    /sys/devices/system/node) such as Arm v7
+    """
+
+    cpupath = '/sys/devices/system/cpu'
+    mempath = '/proc/meminfo'
+
+    def __init__(self):
+        self.nodeid = 0
+        self.cpus = CpuList(sysread(SimNumaNode.cpupath, "possible"))
+        self.getmeminfo()
+
+    def getmeminfo(self):
+        self.meminfo = {}
+        for l in open(SimNumaNode.mempath, "r"):
+            elements = l.split()
+            key = elements[0][0:-1]
+            val = int(elements[1])
+            if len(elements) == 3 and elements[2] == "kB":
+                val *= 1024
+            self.meminfo[key] = val
+
 #
 # Class to abstract the system topology of numa nodes and cpus
 #
@@ -238,12 +262,13 @@ class SysTopology:
 
     def getinfo(self):
         nodes = glob.glob(os.path.join(SysTopology.nodepath, 'node[0-9]*'))
-        if not nodes:
-            raise RuntimeError("No valid nodes found in %s!" % SysTopology.nodepath)
-        nodes.sort()
-        for n in nodes:
-            node = int(os.path.basename(n)[4:])
-            self.nodes[node] = NumaNode(n)
+        if nodes:
+            nodes.sort()
+            for n in nodes:
+                node = int(os.path.basename(n)[4:])
+                self.nodes[node] = NumaNode(n)
+        else:
+            self.nodes[0] = SimNumaNode()
 
     def getnodes(self):
         return list(self.nodes.keys())
-- 
2.31.1

