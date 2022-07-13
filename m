Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8251C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Jul 2022 20:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiGMUZn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Jul 2022 16:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbiGMUZj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Jul 2022 16:25:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2706D31202
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Jul 2022 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657743936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F9ImB5LxPAtNVwx5XgHxZr7ZZ+NhePhmW4twNR1o+KY=;
        b=auPpOsqmXCUZ+rjkdtFOFe32BFeQNBaW99sfLmJAtjpTx4+2UEa6XP31D2VOE5YS3KITvV
        ODQbM7ZxBoU94yIL8AKKeeZh/CSUnsD8/4OGTa4w1zKTG3v7h+3tq5tEuE2CcDuVQx0Wit
        XH/bY5gwadA1f3MVdWUQGP9k4VrwRP4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-6YUWePDPNTazxvkDuZNMvw-1; Wed, 13 Jul 2022 16:25:34 -0400
X-MC-Unique: 6YUWePDPNTazxvkDuZNMvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 828F41C1394B
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Jul 2022 20:25:34 +0000 (UTC)
Received: from magodse.remote.csb (unknown [10.2.16.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D646241047E1;
        Wed, 13 Jul 2022 20:25:33 +0000 (UTC)
From:   Manasi Godse <magodse@redhat.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, lleshchi@redhat.com,
        kcarcia@redhat.com, magodse@redhat.com
Subject: [PATCH] rteval: Add option for downloading kernel
Date:   Wed, 13 Jul 2022 13:25:31 -0700
Message-Id: <20220713202531.398854-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Added an option -S, --source-download to download a kernel source
tarball from kernel.org to the appropriate loadsource directory.
Acceptable strings for the kernel version are 'linux-5.18.1.tar.xz;,
'linux-5.18.1.tar.gz', 'linux-5.18.1', '5.18.1', 'linux-5.19-rc5'.

Conditions have been added to check for default kernel packaged with
rteval-loads and backing up the tarball if it already exists. This
enhancement simplifies the  manual downloading of kernel to the loadsource
directory.

Signed-off-by: Manasi Godse <magodse@redhat.com>
---
 rteval-cmd             | 61 ++++++++++++++++++++++++++++++++++++++++++
 rteval/rtevalConfig.py |  1 +
 2 files changed, 62 insertions(+)

diff --git a/rteval-cmd b/rteval-cmd
index 4598ba514ddc..dcd06dc30ba4 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -37,8 +37,11 @@
 import sys
 import os
 import time
+import re
+import shutil
 import optparse
 import tempfile
+import requests
 import lxml.etree
 from rteval.Log import Log
 from rteval import RtEval, rtevalConfig
@@ -46,6 +49,7 @@ from rteval.modules.loads import LoadModules
 from rteval.modules.measurement import MeasurementModules
 from rteval.version import RTEVAL_VERSION
 from rteval.misc import invert_cpulist, compress_cpulist
+from rteval.modules.loads.kcompile import ModuleParameters
 
 def summarize(repfile, xslt):
     """ Summarize an already existing XML report """
@@ -158,6 +162,10 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_option("-V", "--version", dest="rteval___version",
                       action='store_true', default=False,
                       help='print rteval version and exit')
+    parser.add_option("-S", "--source-download", dest="rteval___srcdownload",
+                        type="string", default=None, metavar="KERNEL_VERSION",
+                        help='download a source kernel from kernel.org')
+
 
     if not cmdargs:
         cmdargs = ["--help"]
@@ -254,6 +262,59 @@ if __name__ == '__main__':
         measuremods.SetupModuleOptions(parser)
         cmd_args = parse_options(config, parser, sys.argv[1:])
 
+        # download kernel tarball
+        if rtevcfg.srcdownload:
+            logger.log(Log.DEBUG, f"Kernel Version to download = {rtevcfg.srcdownload}")
+
+            # handle a kernel version like linux-5.19-rc5
+            if 'rc' in rtevcfg.srcdownload:
+                kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\-[a-z]*\d{1,2}", rtevcfg.srcdownload).group(0)
+                url = "https://git.kernel.org/torvalds/t/"
+            else:
+                kernel_prefix = re.search(r"\d{1,2}\.\d{1,3}\.*\d{1,2}", rtevcfg.srcdownload).group(0)
+                major_version = re.search(r"\d{1,2}", kernel_prefix).group(0)
+                url = "https://kernel.org/pub/linux/kernel/v" + major_version + ".x/"
+
+
+            if rtevcfg.srcdownload.endswith(".gz") or 'rc' in rtevcfg.srcdownload:
+                rtevcfg.srcdownload = "linux-" + kernel_prefix + ".tar.gz"
+            else:
+                rtevcfg.srcdownload = "linux-" + kernel_prefix + ".tar.xz"
+            tarfl = os.path.join(rtevcfg.srcdir, rtevcfg.srcdownload)
+
+            # if default kernel packages with rteval-loads exists, do not download/overwrite
+            default_kernel_file = ModuleParameters().get('source').get('default')
+            if os.path.exists(tarfl):
+                if rtevcfg.srcdownload == default_kernel_file:
+                    sys.exit("Default kernel already exists, will not download")
+                prompt = input("Kernel already exists, download and overwrite anyways? (y/n)  ")
+                prompt = prompt.lower()
+                if prompt in ('no', 'n'):
+                    sys.exit("Exiting")
+                elif prompt in ('yes','y'):
+                    # backup the existing kernel in case it needs to be restored later
+                    shutil.move(tarfl, tarfl + ".bkup")
+                else:
+                    sys.exit("Invalid option. Exiting")
+
+            url = url + rtevcfg.srcdownload
+            print(f"Downloading kernel {url}")
+            downloaded_file = requests.get(url)
+            if downloaded_file.status_code != 200:
+                # restore the kernel file if it exists
+                if os.path.exists(tarfl + ".bkup"):
+                    shutil.move(tarfl + ".bkup", tarfl)
+                sys.exit(f"Could not download tar file {rtevcfg.srcdownload}, status code {downloaded_file.status_code}")
+            with open(tarfl, 'wb') as fd:
+                fd.write(downloaded_file.content)
+            logger.log(Log.DEBUG, f"Kernel source {rtevcfg.srcdownload} downloaded successfully")
+            logger.log(Log.DEBUG, f"Downloaded to directory location: {rtevcfg.srcdir}")
+            # download was successful, delete the backup file if it exists
+            if os.path.exists(tarfl + ".bkup"):
+                os.remove(tarfl + ".bkup")
+            sys.exit(0)
+
+
         # if we only specified one set of cpus (loads or measurement)
         # default the other to the inverse of the specified list
         ldcfg = config.GetSection('loads')
diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
index 56bbc9ee0de6..decd36ed18ab 100644
--- a/rteval/rtevalConfig.py
+++ b/rteval/rtevalConfig.py
@@ -97,6 +97,7 @@ default_config = {
         'xslt_histogram': default_config_search(['rteval_histogram_raw.xsl'], os.path.isfile),
         'report_interval': '600',
         'logging'    : False,
+        'srcdownload': None,
         }
     }
 
-- 
2.31.1

