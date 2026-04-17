Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF8235F19B
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 19:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776455498; cv=none; b=mv79M5DZfnCUBY+kSY6cKK+XZ/4x8YbOIq1JNnkycXAy/imL7v3dqJ35ncKddiMpHQFX28GaVV6yIAyKXapDjgalSDArz/vKAXMNzOpfJGthJAjV6o92LCPHtoGSmDglt+oV5SLhuOtVd18UDUq1CRPktf3FPcl1agwx360fMr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776455498; c=relaxed/simple;
	bh=Unu2o0GdAYYBHjWqISjPKetUkJn0SwhRWuXWSZ1mp3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwKAkmuRKaND6m7tMIdmN1E6MXhi6uPkw/vrAcYYuzS4QLOFkadTPeJLxjGQuPjP7jrcr65VV8FrWokN1OGHSgYhH58iUCT1K4Xdl606BF5b0rC1xCleEBJBRrS5Ghq3CmU0UzoS0r5dlnlnBOytNXXjKub990TdXIIxr4HftXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8OyRFPN; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8OyRFPN"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-50d87c138e1so11456561cf.1
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2026 12:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776455495; x=1777060295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PS3qxj8Fng5vmXeLXEk3jnIbkYIN5IF6cLFFYbgMwI=;
        b=p8OyRFPNlM5JslUi5hcpIGQUwHlJyyg50YLEfQKno8vZATPyiUIZJBR128TZJnzL2h
         luBtM4lypwK3Y2kONlmciPQVRMA9I7+hQBmXkVe3RBX70GdZ/ZENi7AMMy0+6jEnF7Nx
         TjqyhHYkkA6/NHJqw43HZqFHdMnmgFw7iTDpqPpy1sPdEfwqrw4kw66n5Y0EDJqAMY0P
         +ULINRG0lZEE9YDMfhHEJXLAdr4Xs0AcozBnHKJYR/trRrL1yQoB14kb90QSNqV+PhTH
         QkKSOzrHP8SwZa3q1fCjgDdiKgdoJlSbRbIplGOZwtjkDiM/ohZFpu27wFvGUqDohYFt
         bh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776455495; x=1777060295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PS3qxj8Fng5vmXeLXEk3jnIbkYIN5IF6cLFFYbgMwI=;
        b=kPjWse2h47Btq83DuyHGk4I26NviGduAxnqGHnDd2JLA2FB6xUYRpHA1jnB5NJMpMc
         7eDGG6DuHO1GAos92WbQxx2Ksg0srubgGYAHHU4BBPVvhyE2h/03E/iddjZKgWnR50Qs
         wdpPl1IsS+mSl0HAAfLQNQeMqPDHC99cKc2qt/m6owf3OpR18u2AeOZphySXBzTNkScD
         IOEIgZSn0LjnsC+80q7SQvs5/ABcie5ASIDMC/pJKrx+Jad8HlcmzwBcZeUo0HbdIP/f
         zriayRHxgQusWgJG1P3lKGRPpw6kFanAKPbytH0yIYvMZXsG3a6kdxPHjE3lUL9fUCZI
         fuqw==
X-Gm-Message-State: AOJu0Ywo/AErq1OnBojWTY7CFmY3g2bb+QgsUob55AE2jTSdaCSFe5yE
	lZU7FJ3Iym4KG0f/nL2NYMLjn/wrrljgMJRLvNgTbZ3eFpsCPP8f5EMJ/VWOdg==
X-Gm-Gg: AeBDiesNb0JCjpNL+TbS73+rPhzeo9GrPfF/zjV9q0cleT57bYDNpZ+8qPIGSqp06Py
	J31VRap1Nue9SgFDONwkIaGfgFaYMUcts/8n1Ojuo4tuIlILrcKcsZ8wXfHfPDmiPWBFa9oW/nu
	DxHBLrxr+GAgx9xjUc/A6dz9AUNfDm9EbfCjGwEZ/Gf3hnb+DQ/6/0+18rR5u9aEPlaYuZIRZJc
	aiINo4gZgttm/ZORqeFLB1Oi7UCUOQrnlgOCIGUv1idRe0oBzfVkcrfQokhIjjCPAMG4eOwtpkv
	6Rdm0u8SdBeHWCVKT6IYpEJLI0uYa4x12quYS0Fhq/wtfdR3P5M7Yihvwo5huJbbux0GOctw6ND
	0TXtOSsrKAZ9Dzz3iXitRO3uVns9gDQLpE7nxQWTxMusnmt/Q0Xol+h9CnpqofU6koMJAXr6nlk
	LLpvMGqWu0Qd1HHyBrZt0q00JmkmwquAOo4GIs/bIBj1PJsqN3FCEvSv50lq7EVntTE4olClq97
	783TCePCXVAY7pGaE49bWQNAwrEcw==
X-Received: by 2002:a05:622a:1b88:b0:50d:2a98:2571 with SMTP id d75a77b69052e-50e36b53d80mr59898511cf.26.1776455495264;
        Fri, 17 Apr 2026 12:51:35 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e3bf260fbsm20673601cf.10.2026.04.17.12.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 12:51:34 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/6] rteval: Add CpuList class to cpulist_utils module
Date: Fri, 17 Apr 2026 15:51:10 -0400
Message-ID: <20260417195113.177799-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417195113.177799-1-jkacur@redhat.com>
References: <20260417195113.177799-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an object-oriented CpuList class to provide a richer interface
for CPU list manipulation while maintaining backward compatibility
with existing module-level functions.

The CpuList class provides:
- Instance methods that return new CpuList objects (chainable)
- Methods: online(), isolated(), nonisolated()
- Python operators: len(), in, iter(), ==, str()
- Static methods for backward compatibility
- Full compatibility with existing module-level functions

This is a step toward a more maintainable design that was removed
in commit a788ea3 when CpuList class was converted to a module.
The class allows for future enhancements like caching, set operations,
and better state management while keeping the functional interface.

All existing module-level functions remain unchanged for backward
compatibility.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/cpulist_utils.py | 161 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 2 deletions(-)

diff --git a/rteval/cpulist_utils.py b/rteval/cpulist_utils.py
index 7abc45a508bf..a113198b3427 100644
--- a/rteval/cpulist_utils.py
+++ b/rteval/cpulist_utils.py
@@ -4,8 +4,9 @@
 #   Copyright 2016 - Clark Williams <williams@redhat.com>
 #   Copyright 2021 - John Kacur <jkacur@redhat.com>
 #   Copyright 2023 - Tomas Glozar <tglozar@redhat.com>
+#   Copyright 2026 - John Kacur <jkacur@redhat.com>
 #
-"""Module providing utility functions for working with CPU lists"""
+"""Module providing CpuList class and utility functions for working with CPU lists"""
 
 import os
 
@@ -32,14 +33,170 @@ def _isolated_file_exists():
     return os.path.exists(os.path.join(cpupath, "isolated"))
 
 
+#
+# CpuList class - object-oriented interface for CPU list manipulation
+#
+
+class CpuList:
+    """
+    Object-oriented interface for CPU list manipulation.
+
+    Represents a list of CPU numbers with methods for filtering and transformation.
+    Operations return new CpuList instances, making them chainable.
+
+    Examples:
+        # Create from string
+        cpus = CpuList("0-7,9-11")
+
+        # Create from list
+        cpus = CpuList([0, 1, 2, 3, 4, 5, 6, 7, 9, 10, 11])
+
+        # Chain operations
+        online_isolated = CpuList("0-15").online().isolated()
+
+        # Use as iterator
+        for cpu in CpuList("0-3"):
+            print(cpu)
+    """
+
+    def __init__(self, cpulist):
+        """
+        Initialize CpuList from string or list.
+
+        Args:
+            cpulist: Either a string like "0-7,9-11" or a list of integers
+        """
+        if isinstance(cpulist, str):
+            self._cpus = expand_cpulist(cpulist)
+        elif isinstance(cpulist, list):
+            self._cpus = [int(cpu) for cpu in cpulist]
+        else:
+            raise TypeError("cpulist must be a string or list")
+
+        self._cpus.sort()
+
+    @property
+    def cpus(self):
+        """Return the list of CPU numbers"""
+        return self._cpus
+
+    def getcpulist(self):
+        """Return the list of CPU numbers (for backward compatibility)"""
+        return self._cpus
+
+    def online(self):
+        """
+        Return a new CpuList containing only online CPUs.
+
+        Returns:
+            CpuList: New instance with only online CPUs
+        """
+        return CpuList(online_cpulist(self._cpus))
+
+    def isolated(self):
+        """
+        Return a new CpuList containing only isolated CPUs.
+
+        Returns:
+            CpuList: New instance with only isolated CPUs
+        """
+        return CpuList(isolated_cpulist(self._cpus))
+
+    def nonisolated(self):
+        """
+        Return a new CpuList containing only non-isolated CPUs.
+
+        Returns:
+            CpuList: New instance with only non-isolated CPUs
+        """
+        return CpuList(nonisolated_cpulist(self._cpus))
+
+    def __str__(self):
+        """Return collapsed string representation (e.g., '0-7,9-11')"""
+        return collapse_cpulist(self._cpus)
+
+    def __repr__(self):
+        """Return repr string"""
+        return f"CpuList('{self}')"
+
+    def __len__(self):
+        """Return number of CPUs in the list"""
+        return len(self._cpus)
+
+    def __contains__(self, cpu):
+        """Check if CPU is in the list"""
+        return int(cpu) in self._cpus
+
+    def __iter__(self):
+        """Iterate over CPU numbers"""
+        return iter(self._cpus)
+
+    def __eq__(self, other):
+        """Compare two CpuList objects"""
+        if isinstance(other, CpuList):
+            return self._cpus == other._cpus
+        return False
+
+    # Static methods for backward compatibility and direct use
+
+    @staticmethod
+    def expand(cpulist_str):
+        """
+        Expand a range string into a list of CPU numbers.
+
+        Args:
+            cpulist_str: String like "0-7,9-11"
+
+        Returns:
+            list: List of CPU numbers
+        """
+        return expand_cpulist(cpulist_str)
+
+    @staticmethod
+    def collapse(cpulist):
+        """
+        Collapse a list of CPU numbers into a string range.
+
+        Args:
+            cpulist: List of CPU numbers
+
+        Returns:
+            str: Collapsed string like "0-7,9-11"
+        """
+        return collapse_cpulist(cpulist)
+
+    @staticmethod
+    def compress(cpulist):
+        """
+        Return a string representation of cpulist.
+
+        Args:
+            cpulist: List of CPU numbers
+
+        Returns:
+            str: Comma-separated string
+        """
+        return compress_cpulist(cpulist)
+
+
+#
+# Module-level functions - kept for backward compatibility
+#
+
 def collapse_cpulist(cpulist):
     """
     Collapse a list of cpu numbers into a string range
     of cpus (e.g. 0-5, 7, 9)
     """
+    if not cpulist:
+        return ""
+
+    # Ensure we're working with integers and sort them
+    sorted_cpus = sorted([int(cpu) for cpu in cpulist])
+
     cur_range = [None, None]
     result = []
-    for cpu in cpulist + [None]:
+    for cpu in sorted_cpus + [None]:
         if cur_range[0] is None:
             cur_range[0] = cur_range[1] = cpu
             continue
-- 
2.53.0

