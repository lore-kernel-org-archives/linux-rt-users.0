Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F6FC433DB
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 08:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32E920727
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Jan 2021 08:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhA0IjK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Jan 2021 03:39:10 -0500
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:50956 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhA0Igw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Jan 2021 03:36:52 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 10R8YK5O003543; Wed, 27 Jan 2021 17:34:20 +0900
X-Iguazu-Qid: 2wGqhgW4xCYbBi0oNA
X-Iguazu-QSIG: v=2; s=0; t=1611736459; q=2wGqhgW4xCYbBi0oNA; m=H3BsT515XxOo2BvecGBWxkI0tkLAIB0EPrQAQarLNUo=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1113) id 10R8YJ9a028606;
        Wed, 27 Jan 2021 17:34:19 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 10R8YIXH009516;
        Wed, 27 Jan 2021 17:34:18 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 10R8YIYl012040;
        Wed, 27 Jan 2021 17:34:18 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     John Kacur <jkacur@redhat.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, dwagner@suse.de,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>,
        linux-rt-users@vger.kernel.org, binh1.tranhai@toshiba.co.jp,
        Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
Subject: [rteval PATCH] rteval: systopology.py: Add support for systems that don't have Numa
Date:   Wed, 27 Jan 2021 17:34:12 +0900
X-TSB-HOP: ON
Message-Id: <20210127083412.118047-1-punit1.agrawal@toshiba.co.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Certain systems such as Arm v7 do not have support for Numa nodes,
i.e., "/sys/devices/system/node*" does not exist. Instead of erroring
out in this situation, it would be better if rteval could use
alternate sources to get the system topology and memory information.

Introduce the notion of a fake Numa node (as a class) which is used
when no numa nodes are found on the system. Other than the
constructor, it provides the same interface as the existing NumaNode
class so existing users should work without any changes.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
Hi John,

Here's an attempt to work around the lack of Numa nodes on Arm v7 and
i386 kernels. The diffstat is smaller than I had expected and it
seemed to be behaving Ok in local testing.

Feedback welcome.

Thanks,
Punit

 rteval/systopology.py | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index c61ec1a..7ce9a8c 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -191,6 +191,31 @@ class NumaNode:
         """ return list of cpus for this node """
         return self.cpus.getcpulist()
 
+class FakeNumaNode(NumaNode):
+    """class representing a fake NUMA node. The fake NUMA node is used on
+    systems which don't have NUMA enabled (no
+    /sys/devices/system/node) such as Arm v7
+
+    """
+
+    cpupath = '/sys/devices/system/cpu'
+    mempath = '/proc/meminfo'
+
+    def __init__(self):
+        self.nodeid = 0
+        self.cpus = CpuList(sysread(FakeNumaNode.cpupath, "possible"))
+        self.getmeminfo()
+
+    def getmeminfo(self):
+        self.meminfo = {}
+        for l in open(FakeNumaNode.mempath, "r"):
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
@@ -238,12 +263,13 @@ class SysTopology:
 
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
+            self.nodes[0] = FakeNumaNode()
 
     def getnodes(self):
         return list(self.nodes.keys())
-- 
2.29.2

