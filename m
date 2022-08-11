Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B66CC19F2A
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Aug 2022 17:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiHKR0G (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Aug 2022 13:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiHKRZp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Aug 2022 13:25:45 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B393206E
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Aug 2022 10:25:43 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e69so15174724iof.5
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Aug 2022 10:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc;
        bh=ZLTGO3096CMOy1SbwFpCyR4PTBSnxXVhtAtY5AfJD9s=;
        b=d1eeF7S6wMlFDEOcgGO2Ay8+pRbqdNtHDLEBSIQDz8PLvu7DgwFry+hVJO23qu5Nkz
         yHhyHS6JpiBVQTbR2hEG6+V5sQ525HX1jkK92YWOki6dKNSkEVnkzJ8lRk3kFQ0ZL9qL
         xC5wnanDLwKffPTyr+VGtDWjTuYKsJrcdFQmivsxR2eyesijZmi4GXOcjfZfTpZebQpJ
         SUOZCp1lJWBeS0n0Xc40BUYKWuX6U/yWqLVCNyMC2hd0JhvELivPH21NCk33zgzNcSD2
         R9rfShiHrmlRtWOQ7Ooq7fowZzGSQPI6Pgr+Q7aWBkA3lxMGRgb3hfoikuwKbVkrYhli
         w2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc;
        bh=ZLTGO3096CMOy1SbwFpCyR4PTBSnxXVhtAtY5AfJD9s=;
        b=BGHjKfoEnIzqUKnJ5DgBLK08/nlbTTusruaSSTR7TNZd7bsWgiuqUCazeIWpb3v82U
         oic4dUiN4xGa0PWq1p1A7JCL339DFRoIE6QKBCwM8QZLBerphbgLYANbuxyXZr7J/RQF
         zhTRmlY8++DQM6amGC95oIoRGJwJGUiSt0WA6eI3uXbkKSmVGmQwFcc4l3w/R9pv39JK
         eTn4Cls0twS3ql3fhiB2RxeVbO+Y6+UJ0Bs4shXijc1ndDFdEw4O5B7UsGweOO+2w3pN
         eWaA/Ojv2EkTMOTyJQco8dnyV7fAgwX91UGo/iumRK+cHI0dx49WZQBAwYW4Gz2g7Xig
         Mqsg==
X-Gm-Message-State: ACgBeo22bI8EMl7AFdndKM1mjkf0BMlGwFyWSJ3MVIyJPpbsP7z0xqrp
        SA0pSe9y+0RgW196hy1x/KvsiczpdWE=
X-Google-Smtp-Source: AA6agR7Zsj6oAJvv4ncSnlqk3UtX2gpKiUrqTuHTIJBoPrqt7Qk8ZzdQROF0ytMg3RUZTXZ1nLXe+w==
X-Received: by 2002:a05:6638:dd1:b0:341:55c2:38b6 with SMTP id m17-20020a0566380dd100b0034155c238b6mr153797jaj.245.1660238743190;
        Thu, 11 Aug 2022 10:25:43 -0700 (PDT)
Received: from localhost.localdomain ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id g16-20020a05663810f000b003434de98f1asm25836jae.28.2022.08.11.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 10:25:42 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Manasi Godse <gmanasi13@gmail.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Move cpuinfo to systopology.py and delete misc.py
Date:   Thu, 11 Aug 2022 13:25:28 -0400
Message-Id: <20220811172528.572140-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Move the function cpuinfo() to systopology.py
  Since this is the last remaining use of misc
- Delete misc.py to prevent it from being used again.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/misc.py                           | 116 -----------------------
 rteval/modules/measurement/cyclictest.py |   2 +-
 rteval/systopology.py                    |  40 ++++++++
 3 files changed, 41 insertions(+), 117 deletions(-)
 delete mode 100755 rteval/misc.py

diff --git a/rteval/misc.py b/rteval/misc.py
deleted file mode 100755
index a7c515b0d293..000000000000
--- a/rteval/misc.py
+++ /dev/null
@@ -1,116 +0,0 @@
-#!/usr/bin/python3 -tt
-#
-# Copyright (C) 2015 Clark Williams <clark.williams@gmail.com>
-# Copyright (C) 2015 Red Hat, Inc.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; version 2 of the License.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-''' Functions for operating on a cpulists '''
-
-
-import os
-import glob
-
-# expand a string range into a list
-# don't error check against online cpus
-def expand_cpulist(cpulist):
-    '''expand a range string into an array of cpu numbers'''
-    result = []
-    for part in cpulist.split(','):
-        if '-' in part:
-            a, b = part.split('-')
-            a, b = int(a), int(b)
-            result.extend(list(range(a, b + 1)))
-        else:
-            a = int(part)
-            result.append(a)
-    return [str(i) for i in list(set(result))]
-
-def online_cpus():
-    ''' Collapse a list of cpu numbers into a string range '''
-    online_cpus = []
-    # Check for the online file with cpu1 since cpu0 can't always be offlined
-    if os.path.exists('/sys/devices/system/cpu/cpu1/online'):
-        for c in glob.glob('/sys/devices/system/cpu/cpu[0-9]*'):
-            num = str(c.replace('/sys/devices/system/cpu/cpu', ''))
-            # On some machine you can't turn off cpu0
-            if not os.path.exists(c + '/online') and num == "0":
-                online_cpus.append(num)
-            else:
-                with open(c + '/online') as f:
-                    is_online = f.read().rstrip('\n')
-                if is_online == "1":
-                    online_cpus.append(num)
-    else: # use the old heuristic
-        for c in glob.glob('/sys/devices/system/cpu/cpu[0-9]*'):
-            num = str(c.replace('/sys/devices/system/cpu/cpu', ''))
-            online_cpus.append(num)
-    return online_cpus
-
-def invert_cpulist(cpulist):
-    ''' return a list of online cpus not in cpulist '''
-    return [c for c in online_cpus() if c not in cpulist]
-
-def compress_cpulist(cpulist):
-    ''' return a string representation of cpulist '''
-    if isinstance(cpulist[0], int):
-        return ",".join(str(e) for e in cpulist)
-    return ",".join(cpulist)
-
-def cpuinfo():
-    ''' return a dictionary of cpu keys with various cpu information '''
-    core = -1
-    info = {}
-    with open('/proc/cpuinfo') as fp:
-        for l in fp:
-            l = l.strip()
-            if not l:
-                continue
-            # Split a maximum of one time. In case a model name has ':' in it
-            key, val = [i.strip() for i in l.split(':', 1)]
-            if key == 'processor':
-                core = val
-                info[core] = {}
-                continue
-            info[core][key] = val
-
-    for (core, pcdict) in info.items():
-        if not 'model name' in pcdict:
-            # On Arm CPU implementer is present
-            # Construct the model_name from the following fields
-            if 'CPU implementer' in pcdict:
-                model_name = [pcdict.get('CPU implementer')]
-                model_name.append(pcdict.get('CPU architecture'))
-                model_name.append(pcdict.get('CPU variant'))
-                model_name.append(pcdict.get('CPU part'))
-                model_name.append(pcdict.get('CPU revision'))
-
-                # If a list item is None, remove it
-                model_name = [name for name in model_name if name]
-
-                # Convert the model_name list into a string
-                model_name = " ".join(model_name)
-                pcdict['model name'] = model_name
-            else:
-                pcdict['model name'] = 'Unknown'
-
-    return info
-
-if __name__ == "__main__":
-
-    info = cpuinfo()
-    idx = sorted(info.keys())
-    for i in idx:
-        print("%s: %s" % (i, info[i]))
-
-    print("0: %s" % (info['0']['model name']))
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index e235b83b49f7..ace8db438c52 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -35,7 +35,7 @@ import math
 import libxml2
 from rteval.Log import Log
 from rteval.modules import rtevalModulePrototype
-from rteval.misc import cpuinfo
+from rteval.systopology import cpuinfo
 from rteval.systopology import CpuList, SysTopology, collapse_cpulist
 
 expand_cpulist = CpuList.expand_cpulist
diff --git a/rteval/systopology.py b/rteval/systopology.py
index 26332c30bb0e..c8f85c5837aa 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -54,6 +54,46 @@ def sysread(path, obj):
     with open(os.path.join(path, obj), "r") as fp:
         return fp.readline().strip()
 
+def cpuinfo():
+    ''' return a dictionary of cpu keys with various cpu information '''
+    core = -1
+    info = {}
+    with open('/proc/cpuinfo') as fp:
+        for l in fp:
+            l = l.strip()
+            if not l:
+                continue
+            # Split a maximum of one time. In case a model name has ':' in it
+            key, val = [i.strip() for i in l.split(':', 1)]
+            if key == 'processor':
+                core = val
+                info[core] = {}
+                continue
+            info[core][key] = val
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
+                model_name.append(pcdict.get('CPU revision'))
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
+    return info
+
+
 #
 # class to provide access to a list of cpus
 #
-- 
2.37.1

