Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA18EC4320E
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910B06103D
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Sep 2021 08:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbhIAIJ2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 04:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242930AbhIAIJ1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Sep 2021 04:09:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8A8C061760
        for <linux-rt-users@vger.kernel.org>; Wed,  1 Sep 2021 01:08:31 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e1so1009358plt.11
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Sep 2021 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZSIIwNIQw49vPH8yBUD7OMOm1KdPQEIhaPAstn4/1mQ=;
        b=p5j8KGXvXpHwMzodO037hBHR1l3vSr01shl1tBCIlqoV8Alhf/BPeBgYMUazbF9v/V
         zcuVfl9kM3g/3oDIPY+qcYgB8NsTDSXiAxZ+zSXQ+Iu/1N2XWC5cp31lj8qQ1AAWhBiN
         4rZMkf53o5Q+Bs2IUNpmWcJ5zXE9r9vwFaCR4Xr4/IoesCcYMj7HSbo8Rb3tI+DyaCM+
         XuIAjcAQoLkfVbbJ8kz5E5KEt7+CR551j4yLtV7ckW9WKfECC93nKOHpMQrjEP0mjUQ/
         0g8KUvMhqHutXHl0l+ro4KsznfgpjrlAj2aQ4ThuTpCKRXewYP73h3dZhU3w80hc08w6
         LThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZSIIwNIQw49vPH8yBUD7OMOm1KdPQEIhaPAstn4/1mQ=;
        b=KQ644dZa/oz9bGZRZyoAqPFaBS+qPY+sM890H6zlxmTduQKvANJQZsoRT9/iLrgELF
         EyBVFbDWcdbrGIMKHHJJsGQe7KJVVQjRVaX6f+kUOJssUNuQEtXTOziNWwB0xPR7mrQs
         Tfa1w9HqztgDgLka43jHYzppqyIeB9Mrdfoh3QZ21zUP6R+PbgWr8YR6JshipJw88waE
         1N5SXQsOEUzsqEDjLBtDCuAjFHsqAhPLLZKlckgQvQmA8J1W9OK+cySq26itrZjPDdr3
         Je2W9QZuZ3OAaggISp3M0FiJLPf4qrjKfgIDpq/2OVIiw1LvOrQIZirgYBB1E00f7rk4
         kYCg==
X-Gm-Message-State: AOAM532Nd/bu6Mya9nhRhq8/CQa9gm9POHC/2yKonFPfRfmClDaYZDkJ
        xA0VM34SHWB18MHHUs5Dvgo=
X-Google-Smtp-Source: ABdhPJymg2Ggn0xtyM5dgPbYOwsLu9Zw5kUSMlLIRC6H0Zlly3lCIK0MhBQcj1FA2PL8eMncZlfXbA==
X-Received: by 2002:a17:902:9a8e:b0:12d:cb3c:c4d7 with SMTP id w14-20020a1709029a8e00b0012dcb3cc4d7mr8554832plp.18.1630483710835;
        Wed, 01 Sep 2021 01:08:30 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id c15sm19671363pfl.181.2021.09.01.01.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 01:08:30 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     punit1.agrawal@toshiba.co.jp,
        Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: [PATCH 1/5] rteval: systopology.py: Add support for systems that don't have Numa
Date:   Wed,  1 Sep 2021 17:08:12 +0900
Message-Id: <20210901080816.721731-2-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210901080816.721731-1-punitagrawal@gmail.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com>
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
---
 rteval/systopology.py | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index c61ec1a58514..7ce9a8c4f707 100644
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
2.32.0

