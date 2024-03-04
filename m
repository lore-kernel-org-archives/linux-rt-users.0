Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE25225A6
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547976; cv=none; b=mo3FE0sGLia28+/Ef+2iRqF/QbHLAG/qy/BQ+hUsuksIQMVe9gYhzJBJvdI/Ji0j/MolGiJuOv1WVimLC9ZFkIdR4EKoghz5gAzgp4PIkAqdCV7xND78VaPPygMYFBxBg11RBfdpZ8SKzhGc5i7qY1qEoa+k+PIDR0qc2vJZP30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547976; c=relaxed/simple;
	bh=L4X1pGjfV0yclSFXz3We+/65i4snXLjxxYRDlXw1LMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWnMjm8weu5bC5zScJ032QovrHoH6HIA2BZeVpW9kvYHH3NO+xdOMCxoKa/zPla7V6TwyPpJ673Fr3Oc1kHWwfqmJyGNFsAhJykG4ExeAGRFp6WIIer85GO3F0yCrdc3bGvjDsmyiJo/baZ1HtqirstqgTlIoKcxsD09Sn0gh88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KIFECEGl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIFECEGl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709547973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iUZTwGKy2BSX+2KHmtfgmrKnfl8kGfRZqySzYBhAh1I=;
	b=KIFECEGlBL9AQpW1JngDXUGajt085GFmfxIdeNLYlWJFGPVdy64YCRXjkZAUu5mOI54vWb
	Qf200b+mppDHxNZ+mRUXbUW1+Q4A5QZrRbJ4XSKxDS1JNgpNhGO+WEO5K/vQ/fNYpk3Wi7
	E+9gSazU+fdJT4lYduW3fFfhKd3akQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-c0tlzfseOxem7CgXMlOGuw-1; Mon, 04 Mar 2024 05:26:11 -0500
X-MC-Unique: c0tlzfseOxem7CgXMlOGuw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4263A811E79
	for <linux-rt-users@vger.kernel.org>; Mon,  4 Mar 2024 10:26:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 06A962166B36;
	Mon,  4 Mar 2024 10:26:09 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] rteval: Implement initial dmidecode support
Date: Mon,  4 Mar 2024 11:26:03 +0100
Message-ID: <20240304102603.89558-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

From: Tomas Glozar <tglozar@redhat.com>

Previously rteval used python-dmidecode to gather DMI data from a
system. Since python-dmidecode is without a maintainer, its support was
removed in d142f0d2 ("rteval: Disable use of python-dmidecode").

Add get_dmidecode_xml() function into rteval/sysinfo/dmi.py that does
simple parsing of dmidecode command-line tool output without any
structure changes and include it into the rteval report.

Notes:
- ProcessWarnings() in rteval.sysinfo.dmi was reworked into a class
  method of DMIinfo and to use the class's __log field as logger. It
  now also does not ignore warnings that appear when running rteval as
  non-root, since that is no longer supported. Additionally,
  a duplicate call in rteval-cmd was removed.
- rteval/rteval_dmi.xsl XSLT template was left untouched and is
  currectly not used. In a future commit, it is expected to be rewritten
  to transform the XML format outputted by get_dmidecode_xml() into the
  same format that was used with python-dmidecode.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval-cmd                 |   2 -
 rteval/sysinfo/__init__.py |   2 +-
 rteval/sysinfo/dmi.py      | 178 ++++++++++++++++++++++++-------------
 3 files changed, 118 insertions(+), 64 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index a5e8746..018a414 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -268,8 +268,6 @@ if __name__ == '__main__':
                 | (rtevcfg.debugging and Log.DEBUG)
         logger.SetLogVerbosity(loglev)
 
-        dmi.ProcessWarnings(logger=logger)
-
         # Load modules
         loadmods = LoadModules(config, logger=logger)
         measuremods = MeasurementModules(config, logger=logger)
diff --git a/rteval/sysinfo/__init__.py b/rteval/sysinfo/__init__.py
index d3f9efb..09af52e 100644
--- a/rteval/sysinfo/__init__.py
+++ b/rteval/sysinfo/__init__.py
@@ -30,7 +30,7 @@ class SystemInfo(KernelInfo, SystemServices, dmi.DMIinfo, CPUtopology,
         NetworkInfo.__init__(self, logger=logger)
 
         # Parse initial DMI decoding errors
-        dmi.ProcessWarnings(logger=logger)
+        self.ProcessWarnings()
 
         # Parse CPU info
         CPUtopology._parse(self)
diff --git a/rteval/sysinfo/dmi.py b/rteval/sysinfo/dmi.py
index c01a0ee..f1aab9f 100644
--- a/rteval/sysinfo/dmi.py
+++ b/rteval/sysinfo/dmi.py
@@ -3,6 +3,7 @@
 #   Copyright 2009 - 2013   Clark Williams <williams@redhat.com>
 #   Copyright 2009 - 2013   David Sommerseth <davids@redhat.com>
 #   Copyright 2022          John Kacur <jkacur@redhat.com>
+#   Copyright 2024          Tomas Glozar <tglozar@redhat.com>
 #
 """ dmi.py class to wrap DMI Table Information """
 
@@ -10,65 +11,125 @@ import sys
 import os
 import libxml2
 import lxml.etree
+import shutil
+import re
+from subprocess import Popen, PIPE, SubprocessError
 from rteval.Log import Log
 from rteval import xmlout
 from rteval import rtevalConfig
 
-try:
-    # import dmidecode
-    dmidecode_avail = False
-except ModuleNotFoundError:
-    dmidecode_avail = False
-
-def set_dmidecode_avail(val):
-    """ Used to set global variable dmidecode_avail from a function """
-    global dmidecode_avail
-    dmidecode_avail = val
-
-def ProcessWarnings(logger=None):
-    """ Process Warnings from dmidecode """
-
-    if not dmidecode_avail:
-        return
-
-    if not hasattr(dmidecode, 'get_warnings'):
-        return
-
-    warnings = dmidecode.get_warnings()
-    if warnings is None:
-        return
-
-    ignore1  = '/dev/mem: Permission denied'
-    ignore2 = 'No SMBIOS nor DMI entry point found, sorry.'
-    ignore3 = 'Failed to open memory buffer (/dev/mem): Permission denied'
-    ignore = (ignore1, ignore2, ignore3)
-    for warnline in warnings.split('\n'):
-        # Ignore these warnings, as they are "valid" if not running as root
-        if warnline in ignore:
-            continue
 
-        # All other warnings will be printed
-        if len(warnline) > 0:
-            logger.log(Log.DEBUG, f"** DMI WARNING ** {warnline}")
-            set_dmidecode_avail(False)
+def get_dmidecode_xml(dmidecode_executable):
+    """
+    Transform human-readable dmidecode output into machine-processable XML format
+    :param dmidecode_executable: Path to dmidecode tool executable
+    :return: Tuple of values with resulting XML and dmidecode warnings
+    """
+    proc = Popen(dmidecode_executable, text=True, stdout=PIPE, stderr=PIPE)
+    outs, errs = proc.communicate()
+    parts = outs.split("\n\n")
+    if len(parts) < 2:
+        raise RuntimeError("Parsing dmidecode output failed")
+    header = parts[0]
+    handles = parts[1:]
+    root = lxml.etree.Element("dmidecode")
+    # Parse dmidecode output header
+    # Note: Only supports SMBIOS data currently
+    regex = re.compile(r"# dmidecode (\d+\.\d+)\n"
+                       r"Getting SMBIOS data from sysfs\.\n"
+                       r"SMBIOS ((?:\d+\.)+\d+) present\.\n"
+                       r"(?:(\d+) structures occupying (\d+) bytes\.\n)?"
+                       r"Table at (0x[0-9A-Fa-f]+)\.", re.MULTILINE)
+    match = re.match(regex, header)
+    if match is None:
+        raise RuntimeError("Parsing dmidecode output failed")
+    root.attrib["dmidecodeversion"] = match.group(1)
+    root.attrib["smbiosversion"] = match.group(2)
+    if match.group(3) is not None:
+        root.attrib["structures"] = match.group(3)
+    if match.group(4) is not None:
+        root.attrib["size"] = match.group(4)
+    root.attrib["address"] = match.group(5)
+
+    # Generate element per handle in dmidecode output
+    for handle_text in handles:
+        if not handle_text:
+            # Empty line
+            continue
 
-    dmidecode.clear_warnings()
+        handle = lxml.etree.Element("Handle")
+        lines = handle_text.splitlines()
+        # Parse handle header
+        if len(lines) < 2:
+            raise RuntimeError("Parsing dmidecode handle failed")
+        header, name, content = lines[0], lines[1], lines[2:]
+        match = re.match(r"Handle (0x[0-9A-Fa-f]{4}), "
+                         r"DMI type (\d+), (\d+) bytes", header)
+        if match is None:
+            raise RuntimeError("Parsing dmidecode handle failed")
+        handle.attrib["address"] = match.group(1)
+        handle.attrib["type"] = match.group(2)
+        handle.attrib["bytes"] = match.group(3)
+        handle.attrib["name"] = name
+
+        # Parse all fields in handle and create an element for each
+        list_field = None
+        for index, line in enumerate(content):
+            line = content[index]
+            if line.rfind("\t") > 0:
+                # We are inside a list field, add value to it
+                value = lxml.etree.Element("Value")
+                value.text = line.strip()
+                list_field.append(value)
+                continue
+            line = line.lstrip().split(":", 1)
+            if len(line) != 2:
+                raise RuntimeError("Parsing dmidecode field failed")
+            if not line[1] or (index + 1 < len(content) and
+                               content[index + 1].rfind("\t") > 0):
+                # No characters after : or next line is inside list field
+                # means a list field
+                # Note: there are list fields which specify a number of
+                # items, for example "Installable Languages", so merely
+                # checking for no characters after : is not enough
+                list_field = lxml.etree.Element("List")
+                list_field.attrib["Name"] = line[0].strip()
+                handle.append(list_field)
+            else:
+                # Regular field
+                field = lxml.etree.Element("Field")
+                field.attrib["Name"] = line[0].strip()
+                field.text = line[1].strip()
+                handle.append(field)
+
+        root.append(handle)
+
+    return root, errs
 
 
 class DMIinfo:
-    '''class used to obtain DMI info via python-dmidecode'''
+    '''class used to obtain DMI info via dmidecode'''
 
     def __init__(self, logger=None):
         self.__version = '0.6'
         self._log = logger
 
-        if not dmidecode_avail:
-            logger.log(Log.DEBUG, "DMI info unavailable, ignoring DMI tables")
+        dmidecode_executable = shutil.which("dmidecode")
+        if dmidecode_executable is None:
+            logger.log(Log.DEBUG, "DMI info unavailable,"
+                                  " ignoring DMI tables")
             self.__fake = True
             return
 
         self.__fake = False
-        self.__dmixml = dmidecode.dmidecodeXML()
+        try:
+            self.__dmixml, self.__warnings = get_dmidecode_xml(
+                dmidecode_executable)
+        except (RuntimeError, OSError, SubprocessError) as error:
+            logger.log(Log.DEBUG, "DMI info unavailable: {};"
+                                  " ignoring DMI tables".format(str(error)))
+            self.__fake = True
+            return
 
         self.__xsltparser = self.__load_xslt('rteval_dmi.xsl')
 
@@ -88,30 +149,25 @@ class DMIinfo:
 
         raise RuntimeError(f'Could not locate XSLT template for DMI data ({fname})')
 
+    def ProcessWarnings(self):
+        """Prints out warnings from dmidecode into log if there were any"""
+        if self.__fake or self._log is None:
+            return
+        for warnline in self.__warnings.split('\n'):
+            if len(warnline) > 0:
+                self._log.log(Log.DEBUG, f"** DMI WARNING ** {warnline}")
+
     def MakeReport(self):
         """ Add DMI information to final report """
-        rep_n = libxml2.newNode("DMIinfo")
-        rep_n.newProp("version", self.__version)
         if self.__fake:
+            rep_n = libxml2.newNode("DMIinfo")
+            rep_n.newProp("version", self.__version)
             rep_n.addContent("No DMI tables available")
             rep_n.newProp("not_available", "1")
-        else:
-            self.__dmixml.SetResultType(dmidecode.DMIXML_DOC)
-            try:
-                dmiqry = xmlout.convert_libxml2_to_lxml_doc(self.__dmixml.QuerySection('all'))
-            except Exception as ex1:
-                self._log.log(Log.DEBUG, f'** EXCEPTION {str(ex1)}, will query BIOS only')
-                try:
-                    # If we can't query 'all', at least query 'bios'
-                    dmiqry = xmlout.convert_libxml2_to_lxml_doc(self.__dmixml.QuerySection('bios'))
-                except Exception as ex2:
-                    rep_n.addContent("No DMI tables available")
-                    rep_n.newProp("not_available", "1")
-                    self._log.log(Log.DEBUG, f'** EXCEPTION {str(ex2)}, dmi info will not be reported')
-                    return rep_n
-            resdoc = self.__xsltparser(dmiqry)
-            dmi_n = xmlout.convert_lxml_to_libxml2_nodes(resdoc.getroot())
-            rep_n.addChild(dmi_n)
+            return rep_n
+        rep_n = xmlout.convert_lxml_to_libxml2_nodes(self.__dmixml)
+        rep_n.setName("DMIinfo")
+        rep_n.newProp("version", self.__version)
         return rep_n
 
 def unit_test(rootdir):
@@ -130,12 +186,12 @@ def unit_test(rootdir):
         log = Log()
         log.SetLogVerbosity(Log.DEBUG|Log.INFO)
 
-        ProcessWarnings(logger=log)
         if os.getuid() != 0:
             print("** ERROR **  Must be root to run this unit_test()")
             return 1
 
         d = DMIinfo(logger=log)
+        d.ProcessWarnings()
         dx = d.MakeReport()
         x = libxml2.newDoc("1.0")
         x.setRootElement(dx)
-- 
2.44.0

