Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A814F129
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565498; cv=none; b=ZVmXwrsLZdWpqK8IoZ9MdlPwRUUzW2o6HEAIq5NkyWFxgXZ8hcKv+RZCxkxSglqMW9qOHP9XCguhMVfE7Bpcm/dDKSKB1YaRL9lm0Ti6ZgjXWKkkMgOaHTcSEUZ4QACijr6eNwjFkfCJ1H5ISvRM4cXluWYBEtlQN2PyKvgY6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565498; c=relaxed/simple;
	bh=Wyxz/v1fpmQ9v0VLh7S9PcvcK3/qX0raQnHtk1/kLvA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lvh+QvCpBar5v3v7Jxq4UX5rCxRdtOBOllYrTWaqY6oT5oaOLCKvG4R1yCfS/K0UZ+L3dAYvEMHSBmBI/LfvJAktIsIoeCiH7VGGhVZlcO+EOg2XU6KnJ1DP12mITua+ork61aoQgZlT1FLdlI0VN7iEKP/7ZkiRKKhZDz5eupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTJBuhcS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTJBuhcS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719565494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+lnBfwFlQL7WI2/kKn1a2QIMhRamoJuyOvbENdN9QD4=;
	b=WTJBuhcSRR4JHWdOJkvEi00oOXYc4cHK6OY/jhgl0TLed3fy+J3paMm5hTOLJFl4Vh7yzF
	J4scwbUUBXo8UlXfP6PpJ9Y8JWDs48ifzv9L8kUCn4mKSsqjH2MGhwyNb8ebNYAMfVpc9P
	BgxyP84BRPW8BICX9Ht9o+XSkTkX0h0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-DR-rWBrjO4eYZCIOhlo8wA-1; Fri,
 28 Jun 2024 05:04:52 -0400
X-MC-Unique: DR-rWBrjO4eYZCIOhlo8wA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94B0B1956080
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Jun 2024 09:04:51 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.194])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5F042195606B;
	Fri, 28 Jun 2024 09:04:50 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rteval: Add module for tuned state
Date: Fri, 28 Jun 2024 11:04:37 +0200
Message-ID: <20240628090437.191305-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

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
 rteval/sysinfo/tuned.py    | 180 +++++++++++++++++++++++++++++++++++++
 2 files changed, 184 insertions(+), 1 deletion(-)
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
index 0000000..e41bd4d
--- /dev/null
+++ b/rteval/sysinfo/tuned.py
@@ -0,0 +1,180 @@
+# -*- coding: utf-8 -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+#   Copyright 2024          Tomas Glozar <tglozar@redhat.com>
+#
+import libxml2
+import shutil
+import subprocess
+import sys
+
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
+                                stdout=subprocess.PIPE).stdout
+    except (OSError, subprocess.CalledProcessError):
+        return "unknown"
+    result = result.decode("utf-8")
+    if result.startswith("Verification succeeded"):
+        return "success"
+    elif result.startswith("Verification failed"):
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
+        with open(TUNED_LOG_PATH, "r") as file:
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
+    def __init__(self, logger=None):
+        self.__logger = logger
+        self.__present = False
+
+    def __log(self, logtype, msg):
+        if self.__logger:
+            self.__logger.log(logtype, msg)
+
+    def tuned_state_get(self):
+        """
+        Gets the state of tuned on the machine.
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

