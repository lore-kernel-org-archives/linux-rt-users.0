Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865F0C43334
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jul 2022 13:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238662AbiGZNf7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiGZNf6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 09:35:58 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2475F9B
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:35:57 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n138so11197329iod.4
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cfhlg9Lq2i3mudeFhS2OSaqKAIQmpkqZdgdwSloH374=;
        b=dsQFXFuyCIcRaoJOafgkcIR1ZoaMuZLyhkZNiIh+1pXaZw8SCaxVLclWSHRKKwYr/l
         3n+OBvfE73YFEOuvBi+8D47X1wBYlHGvGIsoeEM6XU0gT1LjrRaCMJ+4rGlNQMOhE3BG
         wSsWbVQ/9eERpXvQyPS7qxpvJx5pz4kbkzZDBLYXmtFUlCrm2P5HK6yOTV/roWbU0YtT
         UzhwL8j/kTxr11oJgGfNwAprcZte/bIfHPYicSq4s0oD/DUEOp6iw+DbraHZOiDE168J
         eB/BF1PwcDa7psjpON0uIOg3NPi1jsdyRuw6DGeC8eVLi6tZHx9eRSiTWYdcfyMd9amm
         IySw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Cfhlg9Lq2i3mudeFhS2OSaqKAIQmpkqZdgdwSloH374=;
        b=2bvGcFLAsN2b2z2Nvmpbsj9g2iZNoS82xcja6j8WDun8q8bVoMgVgtT8e/e1KOekW9
         JJkNXt0U9k0UDob4PmO3md1FlnO6Yyw04S3i4qjJljwXlqiDN2ZgwNiuYTQ1sE28Vcii
         VljzqIcB0gipSYhzXgN74I5BN0yXQcFCJIdrAcsevxVr244o4cnK8JB8G4lcfUn4JFbw
         SUEGiLR01AZThIjAeLrhJ67ZoYrKr5vlD0uiXvyUdx53BA57nAGeXF0FxS+AEPP5nmQ+
         pAJQ+gXU+EPNtFTa0Pf3lSxAG9ZLFrBWeJlKXOGPDtfCJZUwQOpOTGDKyp79ebeIxqka
         jCdA==
X-Gm-Message-State: AJIora+oKf4fankwy3GPLoL8UOTH+Tx3KSmndoIeBTl+Zrh03kwaOYNN
        hQ4QmQKimrbE/pw81DzH8RSAwf9MBaI=
X-Google-Smtp-Source: AGRyM1sZWSxhDIKLdOk8r/b5ePa9CnLGbynirK4XketxV3A2lm/dE9/iEdkKg4pwoZI29BaH0QT5JA==
X-Received: by 2002:a05:6638:304b:b0:341:d6bc:7bd9 with SMTP id u11-20020a056638304b00b00341d6bc7bd9mr2427488jak.294.1658842556875;
        Tue, 26 Jul 2022 06:35:56 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id e42-20020a02212a000000b00339ceeec5edsm6617760jaa.12.2022.07.26.06.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:35:56 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/6] rteval: Create common  functions in CpuList and SysTopology
Date:   Tue, 26 Jul 2022 09:35:30 -0400
Message-Id: <20220726133535.10824-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220726133535.10824-1-jkacur@redhat.com>
References: <20220726133535.10824-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The purpose is to remove functions out of misc and use the ones in the
file systopolgy.py

- Add function collapse_cpulist(cpulist)  outside of the CpuList
  class
- Make methods longest_sequence and expand_cpulist accesible outside of
  their class
- Add function online_cpus(self) to class SysTopology
- Add function online_cpus_str(self) to class SysTopology
- Add function invert_cpulist(self, cpulist) to class SysTopology
- Convert strings to f-strings for better readability
- Add a few missing docstrings to methods / functions, module etc
- Add a few more tests to the unit test

TODO: CpuList is suited for use by SysTopology, but is not ideal for a
generic CpuList. A more generally usable CpuList should be created

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/systopology.py | 90 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 16 deletions(-)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index e852f86e450f..ce8d02cf7318 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -23,11 +23,32 @@
 #   including keys needed to generate an equivalently functional executable
 #   are deemed to be part of the source code.
 #
+""" Module for querying cpu cores and nodes """
 
 import os
 import os.path
 import glob
 
+# Utility version of collapse_cpulist that doesn't require a CpuList object
+def collapse_cpulist(cpulist):
+    """ Collapse a list of cpu numbers into a string range
+        of cpus (e.g. 0-5, 7, 9) """
+    if len(cpulist) == 0:
+        return ""
+    idx = CpuList.longest_sequence(cpulist)
+    if idx == 0:
+        seq = str(cpulist[0])
+    else:
+        if idx == 1:
+            seq = f"{cpulist[0]},{cpulist[idx]}"
+        else:
+            seq = f"{cpulist[0]}-{cpulist[idx]}"
+
+    rest = collapse_cpulist(cpulist[idx+1:])
+    if rest == "":
+        return seq
+    return ",".join((seq, rest))
+
 def sysread(path, obj):
     """ Helper function for reading system files """
     with open(os.path.join(path, obj), "r") as fp:
@@ -46,7 +67,7 @@ class CpuList:
         if isinstance(cpulist, list):
             self.cpulist = cpulist
         elif isinstance(cpulist, str):
-            self.cpulist = self.__expand_cpulist(cpulist)
+            self.cpulist = self.expand_cpulist(cpulist)
         self.cpulist = self.online_cpulist(self.cpulist)
         self.cpulist.sort()
 
@@ -67,7 +88,7 @@ class CpuList:
         return False
 
     @staticmethod
-    def __longest_sequence(cpulist):
+    def longest_sequence(cpulist):
         """ return index of last element of a sequence that steps by one """
         lim = len(cpulist)
         for idx, _ in enumerate(cpulist):
@@ -83,14 +104,14 @@ class CpuList:
         """
         if len(cpulist) == 0:
             return ""
-        idx = self.__longest_sequence(cpulist)
+        idx = self.longest_sequence(cpulist)
         if idx == 0:
             seq = str(cpulist[0])
         else:
             if idx == 1:
-                seq = "%d,%d" % (cpulist[0], cpulist[idx])
+                seq = f"{cpulist[0]},{cpulist[idx]}"
             else:
-                seq = "%d-%d" % (cpulist[0], cpulist[idx])
+                seq = f"{cpulist[0]}-{cpulist[idx]}"
 
         rest = self.__collapse_cpulist(cpulist[idx+1:])
         if rest == "":
@@ -98,7 +119,14 @@ class CpuList:
         return ",".join((seq, rest))
 
     @staticmethod
-    def __expand_cpulist(cpulist):
+    def compress_cpulist(cpulist):
+        """ return a string representation of cpulist """
+        if isinstance(cpulist[0], int):
+            return ",".join(str(e) for e in cpulist)
+        return ",".join(cpulist)
+
+    @staticmethod
+    def expand_cpulist(cpulist):
         """ expand a range string into an array of cpu numbers
         don't error check against online cpus
         """
@@ -124,8 +152,8 @@ class CpuList:
     def is_online(self, n):
         """ check whether cpu n is online """
         if n not in self.cpulist:
-            raise RuntimeError("invalid cpu number %d" % n)
-        path = os.path.join(CpuList.cpupath, 'cpu%d' % n)
+            raise RuntimeError(f"invalid cpu number {n}")
+        path = os.path.join(CpuList.cpupath, f'cpu{n}')
 
         # Some hardware doesn't allow cpu0 to be turned off
         if not os.path.exists(path + '/online') and n == 0:
@@ -240,8 +268,8 @@ class SysTopology:
         return len(list(self.nodes.keys()))
 
     def __str__(self):
-        s = "%d node system" % len(list(self.nodes.keys()))
-        s += " (%d cores per node)" % (len(self.nodes[list(self.nodes.keys())[0]]))
+        s = f"{len(list(self.nodes.keys()))} node system "
+        s += f"({(len(self.nodes[list(self.nodes.keys())[0]]))} cores per node)"
         return s
 
     def __contains__(self, node):
@@ -268,6 +296,7 @@ class SysTopology:
         return n
 
     def getinfo(self):
+        """ Initialize class Systopology """
         nodes = glob.glob(os.path.join(SysTopology.nodepath, 'node[0-9]*'))
         if nodes:
             nodes.sort()
@@ -278,27 +307,56 @@ class SysTopology:
             self.nodes[0] = SimNumaNode()
 
     def getnodes(self):
+        """ return a list of nodes """
         return list(self.nodes.keys())
 
     def getcpus(self, node):
+        """ return a dictionary of cpus keyed with the node """
         return self.nodes[node].getcpulist()
 
+    def online_cpus(self):
+        """ return a list of integers of all online cpus """
+        cpulist = []
+        for n in self.nodes:
+            cpulist += self.getcpus(n)
+        cpulist.sort()
+        return cpulist
+
+    def online_cpus_str(self):
+        """ return a list of strings of numbers of all online cpus """
+        cpulist = [str(cpu) for cpu in self.online_cpus()]
+        return cpulist
+
+    def invert_cpulist(self, cpulist):
+        """ return a list of online cpus not in cpulist """
+        return [c for c in self.online_cpus_str() if c not in cpulist]
 
 if __name__ == "__main__":
 
     def unit_test():
+        """ unit test, run python rteval/systopology.py """
         s = SysTopology()
         print(s)
-        print("number of nodes: %d" % len(s))
+        print(f"number of nodes: {len(s)}")
         for n in s:
-            print("node[%d]: %s" % (n.nodeid, n))
-        print("system has numa node 0: %s" % (0 in s))
-        print("system has numa node 2: %s" % (2 in s))
-        print("system has numa node 24: %s" % (24 in s))
+            print(f"node[{n.nodeid}]: {n}")
+        print(f"system has numa node 0: {0 in s}")
+        print(f"system has numa node 2: {2 in s}")
+        print(f"system has numa node 24: {24 in s}")
 
         cpus = {}
+        print(f"nodes = {s.getnodes()}")
         for node in s.getnodes():
             cpus[node] = s.getcpus(int(node))
-        print(f'cpus = {cpus}')
+            print(f'cpus = {cpus}')
+
+        onlcpus = s.online_cpus()
+        print(f'onlcpus = {onlcpus}')
+        onlcpus = collapse_cpulist(onlcpus)
+        print(f'onlcpus = {onlcpus}')
+
+        onlcpus_str = s.online_cpus_str()
+        print(f'onlcpus_str = {onlcpus_str}')
 
+        print(f"invert of [ 2, 4, 5 ] = {s.invert_cpulist([2, 3, 4])}")
     unit_test()
-- 
2.37.1

