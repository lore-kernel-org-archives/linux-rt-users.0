Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52138C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Jun 2022 16:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343680AbiFCQMl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Jun 2022 12:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241391AbiFCQMj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Jun 2022 12:12:39 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB5D5131B
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Jun 2022 09:12:35 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ea7so5861218qvb.12
        for <linux-rt-users@vger.kernel.org>; Fri, 03 Jun 2022 09:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xusc7CaWy4EXEaPn8FcYGHWAN3q0Pvb46rghq/RuOug=;
        b=ZyPIin4Qx0zEXxwNJp/3RYxygJUxBLbJ7Dh2g5cVp+w/xSJWjrE8nZNVP4QDi3cOEK
         CIwjOAAD3T8DtSOJX859P0ze1qa/G8plVWVIqqF9wRyiOqhb/IqVmZ8sF14rn6uvhoaS
         FzGbtya8tGUiHx+FCAQDSwPkPkhtT7W0HaapZWuQvfVXbt3MJ4BvAccapIP/JcjVDawH
         3K3YgTO1sZUR5gIuPPR29PqV74hzMkqHY4W6X5iZx0KvYnh/aG/+TpsbVuq+bya4y4qK
         SnrIC5kaS5mhA8JGr8VRkGskCnQl3zFFpmij/BpbxcDbC+0MItvBIIX7izlJViolZEG+
         xC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xusc7CaWy4EXEaPn8FcYGHWAN3q0Pvb46rghq/RuOug=;
        b=l7zlVs6ZoieA/wSc4QywO6mqWZCmvNvnRId1m9h/saPCJcm1hO9P2zYZTUpvDR0UhM
         N62czz98Bbt6urVJtY4uA/U+KD+ICbcWIHCxi9kdrIzVujNvqQtBVt4wF0qjSpBN0o+u
         UL8qUOGoYlH3bW4cwRdpl7fxswITR8y57oqYAck9ug4yS4R4RXDfn22t6lWAmvyOKg4K
         NWB/ELXwnTzkyV3YJ2jFbLk9aYDh7siCmhO5Hc+lKZeE65/RzjSGr+Esxg7YGc+IL4Wo
         IlNM3y0E4ScdfaSfBBTk0dfyf9f09gNwIWlc65K2RfIFDIbnMql/lqBittkuCJbYsXmR
         6CvQ==
X-Gm-Message-State: AOAM5309cks6UDZbfVfrn2g2f+Tt2+G/Zab+a+EL5kkz927ajIejN+O0
        vo69Xi+Tf+23S4wCKq5ZGHKzBQVjjwA=
X-Google-Smtp-Source: ABdhPJzeJpt85OJ0X9QCZCbGbiFODlWbc/BmwdW4V0oAguovvopbXEC5IFlm6Qh7BPp+HQInnK5joA==
X-Received: by 2002:a05:6214:2406:b0:464:41bb:3582 with SMTP id fv6-20020a056214240600b0046441bb3582mr7487319qvb.3.1654272754415;
        Fri, 03 Jun 2022 09:12:34 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id n12-20020a05622a11cc00b003022cdcd28bsm5234973qtk.2.2022.06.03.09.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 09:12:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 2/7] rteval: misc.py: Use "with" for resource allocation
Date:   Fri,  3 Jun 2022 12:12:19 -0400
Message-Id: <20220603161224.10947-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603161224.10947-1-jkacur@redhat.com>
References: <20220603161224.10947-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

- Use "with" for resource allocation.
- Add docstrings to the module and to functions

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/misc.py | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/rteval/misc.py b/rteval/misc.py
index 6fdb24261bec..a7c515b0d293 100755
--- a/rteval/misc.py
+++ b/rteval/misc.py
@@ -15,6 +15,7 @@
 # You should have received a copy of the GNU General Public License
 # along with this program; if not, write to the Free Software
 # Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+''' Functions for operating on a cpulists '''
 
 
 import os
@@ -36,6 +37,7 @@ def expand_cpulist(cpulist):
     return [str(i) for i in list(set(result))]
 
 def online_cpus():
+    ''' Collapse a list of cpu numbers into a string range '''
     online_cpus = []
     # Check for the online file with cpu1 since cpu0 can't always be offlined
     if os.path.exists('/sys/devices/system/cpu/cpu1/online'):
@@ -56,27 +58,31 @@ def online_cpus():
     return online_cpus
 
 def invert_cpulist(cpulist):
+    ''' return a list of online cpus not in cpulist '''
     return [c for c in online_cpus() if c not in cpulist]
 
 def compress_cpulist(cpulist):
+    ''' return a string representation of cpulist '''
     if isinstance(cpulist[0], int):
         return ",".join(str(e) for e in cpulist)
     return ",".join(cpulist)
 
 def cpuinfo():
+    ''' return a dictionary of cpu keys with various cpu information '''
     core = -1
     info = {}
-    for l in open('/proc/cpuinfo'):
-        l = l.strip()
-        if not l:
-            continue
-        # Split a maximum of one time. In case a model name has ':' in it
-        key, val = [i.strip() for i in l.split(':', 1)]
-        if key == 'processor':
-            core = val
-            info[core] = {}
-            continue
-        info[core][key] = val
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
 
     for (core, pcdict) in info.items():
         if not 'model name' in pcdict:
-- 
2.36.1

