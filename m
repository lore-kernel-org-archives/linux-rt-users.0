Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F31CAAF
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721806677; cv=none; b=kNy5orQNWmcYRq/5bxrvhL1rq6//otRPW4uX/T3fvQGXyx7npKwccT5fGL7GG6kzdNZA1fQRR2Rddn4VcOTuaeBP0DKOCrHCSeM4VnLFseHgNVAWtuSexaMOEgfRdwDJ/hrfqn2v1YkeK2XgIeb9bYFiySkb2HVJouNucQ11Oyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721806677; c=relaxed/simple;
	bh=wO83+BMLcOl7utq0+Q1HAgoh/2V6OJxNa4wWPXhVNQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QDkFBKj+u5QBdlE88IZWjdRXcKxZe9eNQtIbkkz7L2YW85PRSkFFpMLzq2kdvnLPX4cRrbfTcAZnk6q1StpEAgK7osWAbvtjVh/jHp951yjeh6XyK/5ptJpEt+Ktk9Gfze2wGLDPlJ97FMwsEb7mc77KKBBqkByr02BTKaMP1TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diWwS+L7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="diWwS+L7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721806673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y/RV3yzRBJQRzALmCzWAnMKHwcni4UATe4jEeisJgik=;
	b=diWwS+L7iBvMc4jertfN48NBE5gEFpOVMx9AKONjT8DmzZ3PTdw/IV15++cADl34HmY9ha
	4iUZKNdtLebR7nK+aCHqp8ESBn7GSfyLibDNkIJjLK5kqUdo8oj8bxkAY6YKwiBmONev30
	l0AVPcv5rb7xQ5gawm1DTxFhpB685hs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-Ma5tHodANr6iVElaf6jIgQ-1; Wed,
 24 Jul 2024 03:37:51 -0400
X-MC-Unique: Ma5tHodANr6iVElaf6jIgQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C1C471955D4F
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 07:37:50 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.175])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 11D373000192;
	Wed, 24 Jul 2024 07:37:48 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2] rteval: Add module for tuned state
Date: Wed, 24 Jul 2024 09:37:42 +0200
Message-ID: <20240724073742.58006-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Tomas Glozar <tglozar@redhat.com>

Add a sysinfo module for collecting the tuned state. Three properties
are collected:
- whether tuned is present
- what the active tuned profile is
- whether tuned profile verification passes

In case of a failed verification, the tuned log is also collected.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/sysinfo/__init__.py |   5 +-
 rteval/sysinfo/tuned.py    | 191 +++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 1 deletion(-)
 create mode 100644 rteval/sysinfo/tuned.py

diff --git a/rteval/sysinfo/__init__.py b/rteval/sysinfo/__init__.py
index 09af52e..4b7b03c 100644
--- a/rteval/sysinfo/__init__.py
+++ b/rteval/sysinfo/__init__.py
@@ -15,10 +15,11 @@ from rteval.sysinfo.memory import MemoryInfo
 from rteval.sysinfo.osinfo import OSInfo
 from rteval.sysinfo.newnet import NetworkInfo
 from rteval.sysinfo.cmdline import cmdlineInfo
+from rteval.sysinfo.tuned import TunedInfo
 from rteval.sysinfo import dmi
 
 class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
-                 MemoryInfo, OSInfo, NetworkInfo, cmdlineInfo):
+                 MemoryInfo, OSInfo, NetworkInfo, cmdlineInfo, TunedInfo):
     def __init__(self, config, logger=None):
         self.__logger = logger
         KernelInfo.__init__(self, logger=logger)
@@ -28,6 +29,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
         OSInfo.__init__(self, logger=logger)
         cmdlineInfo.__init__(self, logger=logger)
         NetworkInfo.__init__(self, logger=logger)
+        TunedInfo.__init__(self, logger=logger)
 
         # Parse initial DMI decoding errors
         self.ProcessWarnings()
@@ -49,6 +51,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
         report_n.addChild(MemoryInfo.MakeReport(self))
         report_n.addChild(dmi.DMIinfo.MakeReport(self))
         report_n.addChild(cmdlineInfo.MakeReport(self))
+        report_n.addChild(TunedInfo.MakeReport(self))
 
         return report_n
 
diff --git a/rteval/sysinfo/tuned.py b/rteval/sysinfo/tuned.py
new file mode 100644
index 0000000..063fcbf
--- /dev/null
+++ b/rteval/sysinfo/tuned.py
@@ -0,0 +1,191 @@
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   Copyright 2024          Tomas Glozar <tglozar@redhat.com>
+#
+"""tuned sysinfo module"""
+import shutil
+import subprocess
+import sys
+import libxml2
+from rteval.Log import Log
+
+TUNED_ADM = "tuned-adm"
+TUNED_LOG_PATH = "/var/log/tuned/tuned.log"
+TUNED_VERIFY_START_LINE = "INFO     tuned.daemon.daemon: verifying " \
+                          "profile(s): realtime"
+
+
+def tuned_present():
+    """
+    Checks if tuned is present on the system
+    :return: True if tuned is present, False otherwise
+    """
+    return shutil.which(TUNED_ADM) is not None
+
+
+def tuned_active_profile():
+    """
+    Gets tuned active profile.
+    :return: Tuned profile (as a string) or "unknown"
+    """
+    try:
+        result = subprocess.check_output([TUNED_ADM, "active"])
+    except (OSError, subprocess.CalledProcessError):
+        return "unknown"
+    result = result.decode("utf-8")
+    split_result = result.split(": ")
+    if len(split_result) < 2:
+        return "unknown"
+    return split_result[1].strip()
+
+
+def tuned_verify():
+    """
+    Verifies if tuned profile is applied properly
+    :return: "success", "failure" or "unknown"
+    """
+    try:
+        result = subprocess.run([TUNED_ADM, "verify"],
+                                stdout=subprocess.PIPE, check=False).stdout
+    except (OSError, subprocess.CalledProcessError):
+        return "unknown"
+    result = result.decode("utf-8")
+    if result.startswith("Verification succeeded"):
+        return "success"
+    if result.startswith("Verification failed"):
+        return "failure"
+    return "unknown"
+
+
+def tuned_get_log():
+    """
+    Read entries related to last profile verification from tuned log
+    :return: List of strings containing the entires, or None if no
+    verification is found in the log
+    """
+    try:
+        with open(TUNED_LOG_PATH, "r", encoding="utf-8") as file:
+            lines = file.readlines()
+            # Find start of last verification
+            start = None
+            for i in reversed(range(len(lines))):
+                if TUNED_VERIFY_START_LINE in lines[i]:
+                    start = i
+                    break
+            if start is None:
+                return None
+            return lines[start:]
+    except OSError:
+        return None
+
+
+class TunedInfo:
+    """
+    Gather information about tuned and make an XML report.
+    Collected information:
+    - whether tuned is present
+    - which tuned profile is active
+    - whether the tuned profile is applied correctly
+    - if not applied correctly, collect relevant info from log
+    """
+    def __init__(self, logger=None):
+        self.__logger = logger
+
+    def __log(self, logtype, msg):
+        if self.__logger:
+            self.__logger.log(logtype, msg)
+
+    def tuned_state_get(self):
+        """
+        Gets the state of tuned on the machine
+        :return: A dictionary describing the tuned state
+        """
+        result = {
+            "present": tuned_present()
+        }
+        if not result["present"]:
+            self.__log(Log.DEBUG, "tuned-adm not found; skipping tuned "
+                                  "sysinfo collection")
+            return result
+        result["active_profile"] = tuned_active_profile()
+        if result["active_profile"] == "unknown":
+            self.__log(Log.DEBUG, "could not retrieve tuned active profile")
+            return result
+        result["verified"] = tuned_verify()
+        if result["verified"] == "unknown":
+            self.__log(Log.DEBUG, "could not verify tuned state")
+        if result["verified"] == "failure":
+            # Include log to see cause to failure
+            result["verification_log"] = tuned_get_log()
+
+        return result
+
+    def MakeReport(self):
+        """
+        Create XML report
+        :return: libxml2 node containing the report
+        """
+        tuned = self.tuned_state_get()
+
+        rep_n = libxml2.newNode("Tuned")
+        rep_n.newProp("present", str(int(tuned["present"])))
+        for key, value in tuned.items():
+            if key == "present":
+                continue
+            child = libxml2.newNode(key)
+            if key == "verification_log":
+                if value is None:
+                    self.__log(Log.WARN, "could not get verification log")
+                    continue
+                for line in value:
+                    # <date> <time> <log-level>    <message>
+                    line = line.split(" ", 3)
+                    if len(line) != 4:
+                        continue
+                    line_child = libxml2.newNode("entry")
+                    line_child.newProp("date", line[0])
+                    line_child.newProp("time", line[1])
+                    line_child.newProp("level", line[2])
+                    line_child.setContent(line[3].strip())
+                    child.addChild(line_child)
+            else:
+                child.setContent(value)
+            rep_n.addChild(child)
+
+        return rep_n
+
+
+def unit_test(rootdir):
+    try:
+        # Helper function tests
+        result = tuned_present()
+        print("tuned present:", result)
+        assert isinstance(result, bool), "__tuned_present() should return bool"
+        result = tuned_active_profile()
+        print("tuned active profile:", result)
+        assert isinstance(result, str), "__tuned_active_profile() should " \
+                                        "return string"
+        result = tuned_verify()
+        print("tuned verification state:", result)
+        assert isinstance(result, str), "__tuned_verify() should return string"
+        result = tuned_get_log()
+        assert isinstance(result, list) or result is None, \
+            "__tuned_get_log() should return list or None"
+
+        # Class tests
+        tuned = TunedInfo()
+        result = tuned.tuned_state_get()
+        print(result)
+        assert isinstance(result, dict), "TunedInfo.tuned_state_get() " \
+                                         "should return dict"
+        tuned.MakeReport()
+
+        return 0
+    except Exception as err:
+        print(f"** EXCEPTION: {str(err)}")
+        return 1
+
+
+if __name__ == '__main__':
+    sys.exit(unit_test(None))
-- 
2.45.1

