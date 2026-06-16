Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4153472777
	for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627453; cv=none; b=mmXYhYwB9FUCB1HLpzaiOOjRmlMLjAKGL2cQWh5xXqnQ5599oRmqNn/nXaR0aD3diskqRvdzCSmRajHJNl0CkdfRYEVAp6mJlOFX+Js9dAcrt9E1QZQtJYPVDl1SvFosCZkPbF+GJjkf3oorDK+057+VelBmzOjXPTsGxPpLvW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627453; c=relaxed/simple;
	bh=ZwWtboJqn3ImA/wupzz4h9dwzwuemz+qNHzO7H4UEW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYjJT4VUemyoQeWdqvqB/hKbyFJlVSEILZ0U54UDJsQTGISQA9SNaUhZM0H6eCwI4LihyI8a4q8w/4SbqX/cza04xk6COzB/hJqTP3P4jHasCopN3Yl7qc/Fr9d3LAHN+WLNoH/vv9b3VFB7riMLqS3aqxEke14kFSocFR3nGlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTYOzps7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTYOzps7"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-516d0db9372so39705241cf.2
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Jun 2026 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781627451; x=1782232251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPSgfRNYpq8ajsEqytQ4c5F/eSIu1raP4rcsKzo+JNo=;
        b=LTYOzps7acCuP0+H29PvRbk78gInwS6y8Ex5YWmJV8BbYd9kk9BoBJZp84MiGBBbFd
         DrQcbXfiV60/yiLJP7TbL9Q+ibazlHhwTG6lRs14KtxXDBaYi4E8dNn8EceqMsN9O4gE
         2TsYEVSp/2pdwmFv5wS9BXRU+cDBuF+9/VeGiCwTSOLbo7NbXCImAnismmqiFwKFpPTN
         5gYOdRoi/Snvb+zMdTxTCI85abwYzbt54GswwbJ70dKQ9rkSg24uTHJIntJDoGp+Fl3J
         tjiNgzXqOMi9eFS1h4U7LqbLTdhisAc3n7ZY8xQwug7l4AhV+xCXftubliTrd+hYMnIA
         grAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781627451; x=1782232251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPSgfRNYpq8ajsEqytQ4c5F/eSIu1raP4rcsKzo+JNo=;
        b=bsjJQldWdVqO5/31cGiLbI1KhcFqKoep5yoDTHpmx4VLPBK0/X/Tculb9Ob45q1WZ8
         WswHtF2j/+TRHatlFI+B2tIixz86sa7jJF+zqQ/CcqFbNstyX8feWeIZi9TtE7sPoPtp
         P7Jl7Opl+VC1jmjAO9x+ZAjXFgNcMTuCYaT8MeA0hpwLw+y3g6pukIVvzxzhtvaRMjKp
         1nmdj3qKqOgbduaLCIgvYOtO7W0LiM75r2vNXa4C5lxG3vrRoIUynOdSgLiLxO4KBYuO
         ZBsWXZCPM3zHqg6XByky0NuKlxImYIOBuyHknl/cSKL5CQ4SCJjawSac2K9M+kyhvgbx
         JMQg==
X-Gm-Message-State: AOJu0YwMaKFGk/KnICbt2mHM1yHY8rNVnlcDHfX4lVMjJlt+Q+sG2vjb
	e/m3czFACoy7dmICiCifjGqgWt0JoOhHmi7QUhuy2+aQ4qG3UyZ6PERroKshDQ==
X-Gm-Gg: Acq92OFWnWIIa4ZpQYOj+2jDqDQl3RDu9XjCs6WPjp+hs+b/L/cJV//8lzDiEGm/RLw
	ExjK24Yjb645/fmStOXye2N2kclv1UKjffMAMYx1XjCycCFk63IXIxL3uERghIgye/VyFG4wLFH
	QqXBRkwNkeLWSaTQNeHNQv1yFv5Z/WV04RWPJyQSsm/5mV/L0JANws8z5izkjK6vTQaZ3t1mpr1
	+h024YEqTQeUdVizQx+TgMgUAgN+28q8RTELs3dVXqFn8TSZHQ4995LsB7MF3WrSyw7XX+Dsi1R
	TSWXWPTNf111NDpc5JoV/ZOohmULk3tkXoTvrVF1RaxmUDj+xAPtxWbEKMMBv8snPMJTwBuvBy7
	hDUbNeD4zI4lAB2w8hJJ6VWIxIB2WNuE3zndg4mSJ6Hk4P40EolGfiXwPKFZ1yswWZyKnT0t81u
	IoK0gCbDjYxZBiXkT8J4J7dlXLIDuca/vz4z0W6DMUq9DqN9fX36S56HH/dwTRCQL9SJP/Wo0MY
	HRyB5490oG7hk+/J3vMUnpNoNM/sw==
X-Received: by 2002:a05:622a:7acd:b0:50d:7c18:c66e with SMTP id d75a77b69052e-519a8dd8166mr3031761cf.13.1781627450692;
        Tue, 16 Jun 2026 09:30:50 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb815976sm143761731cf.25.2026.06.16.09.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:30:49 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>,
	Chris White <chwhite@redhat.com>
Subject: [PATCH 2/3] rteval: Add container detection and warning
Date: Tue, 16 Jun 2026 12:30:14 -0400
Message-ID: <20260616163024.233604-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616163024.233604-1-jkacur@redhat.com>
References: <20260616163024.233604-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detect when rteval is running inside a container and warn the user.
Container environments are unlikely to get the same real-time latency
performance results as bare metal. In addition, depending on how the
container is configured, not everything will work as expected.

The warning appears during rteval startup, is recorded in the log, and
container status is included in the XML report and summary output.

Container detection checks:
- /.dockerenv file presence
- /proc/1/cgroup for docker/lxc/kubepods/libpod
- container environment variable
- KUBERNETES_SERVICE_HOST environment variable
- systemd-detect-virt -c output

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                       |  5 +++++
 rteval/rteval_text.xsl           |  4 ++++
 rteval/sysinfo/__init__.py       |  5 ++++-
 rteval/sysinfo/containercheck.py | 24 ++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/rteval-cmd b/rteval-cmd
index c48c3d89b82e..82531e915833 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -34,6 +34,7 @@ from rteval.version import RTEVAL_VERSION
 from rteval.systopology import SysTopology, parse_cpulist_from_config, validate_housekeeping_cpus, validate_core_sharing
 from rteval.modules.loads.kcompile import ModuleParameters
 from rteval.cpulist_utils import CpuList, is_relative, collapse_cpulist
+from rteval.sysinfo import containercheck
 
 def summarize(repfile, xslt):
     """ Summarize an already existing XML report """
@@ -339,6 +340,10 @@ if __name__ == '__main__':
             if hasattr(msrcfg, 'timerlat'):
                 msrcfg.timerlat = None
 
+        # Check if running in a container and warn the user
+        if containercheck.is_container():
+            logger.log(Log.WARN, "rteval is running in a container")
+
         if rtevcfg.noload:
             if rtevcfg.onlyload:
                 # Make up your mind!
diff --git a/rteval/rteval_text.xsl b/rteval/rteval_text.xsl
index 54dc7d2f9a07..da7084289f87 100644
--- a/rteval/rteval_text.xsl
+++ b/rteval/rteval_text.xsl
@@ -122,6 +122,10 @@
     <xsl:value-of select="SystemInfo/uname/baseos|uname/baseos"/>
     <xsl:text>&#10;</xsl:text>
 
+    <xsl:if test="SystemInfo/ContainerInfo/container = 'true'">
+      <xsl:text>   Container:    Running in a container&#10;</xsl:text>
+    </xsl:if>
+
     <xsl:text>   Architecture: </xsl:text>
     <xsl:value-of select="SystemInfo/uname/arch|uname/arch"/>
     <xsl:text>&#10;</xsl:text>
diff --git a/rteval/sysinfo/__init__.py b/rteval/sysinfo/__init__.py
index 56a0c57b2cbc..f23ee5d54958 100644
--- a/rteval/sysinfo/__init__.py
+++ b/rteval/sysinfo/__init__.py
@@ -16,10 +16,11 @@ from rteval.sysinfo.osinfo import OSInfo
 from rteval.sysinfo.newnet import NetworkInfo
 from rteval.sysinfo.cmdline import cmdlineInfo
 from rteval.sysinfo.tuned import TunedInfo
+from rteval.sysinfo.containercheck import ContainerInfo
 from rteval.sysinfo import dmi
 
 class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
-                 MemoryInfo, OSInfo, NetworkInfo, cmdlineInfo, TunedInfo):
+                 MemoryInfo, OSInfo, NetworkInfo, cmdlineInfo, TunedInfo, ContainerInfo):
     def __init__(self, config, logger=None):
         self.__logger = logger
         KernelInfo.__init__(self, logger=logger)
@@ -30,6 +31,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
         cmdlineInfo.__init__(self, logger=logger)
         NetworkInfo.__init__(self, logger=logger)
         TunedInfo.__init__(self, logger=logger)
+        ContainerInfo.__init__(self, logger=logger)
 
         # Parse initial DMI decoding errors
         self.ProcessWarnings()
@@ -55,6 +57,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
         report_n.addChild(dmi.DMIinfo.MakeReport(self))
         report_n.addChild(cmdlineInfo.MakeReport(self))
         report_n.addChild(TunedInfo.MakeReport(self))
+        report_n.addChild(ContainerInfo.MakeReport(self))
 
         return report_n
 
diff --git a/rteval/sysinfo/containercheck.py b/rteval/sysinfo/containercheck.py
index c558ee05dd8c..12d7d1fce3c9 100644
--- a/rteval/sysinfo/containercheck.py
+++ b/rteval/sysinfo/containercheck.py
@@ -8,6 +8,8 @@
 import os
 import re
 import subprocess
+import libxml2
+from rteval.Log import Log
 
 
 def is_container():
@@ -54,6 +56,28 @@ def is_container():
     return False
 
 
+class ContainerInfo:
+    """Class for collecting container information for XML report"""
+    def __init__(self, logger=None):
+        self.__logger = logger
+
+    def __log(self, logtype, msg):
+        if self.__logger:
+            self.__logger.log(logtype, msg)
+
+    def MakeReport(self):
+        """Generate XML report node for container status"""
+        rep_n = libxml2.newNode("ContainerInfo")
+        container_n = libxml2.newNode("container")
+
+        in_container = is_container()
+        container_n.addContent("true" if in_container else "false")
+        self.__log(Log.DEBUG, f"Container detection: {in_container}")
+        rep_n.addChild(container_n)
+
+        return rep_n
+
+
 def unit_test(rootdir):
     """Simple test of container detection"""
     result = is_container()
-- 
2.54.0

