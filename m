Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3665C433FE
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Apr 2022 16:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354580AbiDSQYh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239383AbiDSQYd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Apr 2022 12:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABF0B39684
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650385309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dq2s4bgTjGwnDDHxC9z7hV73w6MWHPb9h0EePaDdIKU=;
        b=YaMjjqCMGLJkOnAbVKVp/CmOHIQ8J/C0ow5uOprmdSo8Dc0sdH2jLmeT2ahuzZYmE2EQGU
        CRvFqeGw4JKVXIEcCQoCzdok/nQehsFvmCCuLc+jRDl3Vq31cyN6zbQ7/saglou4n5ePVx
        zG0gUvWPJ0p4ntzONVa/Hc7eq88d4BA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-mdeSJkcgPPqxTtz9eoRDDw-1; Tue, 19 Apr 2022 12:21:48 -0400
X-MC-Unique: mdeSJkcgPPqxTtz9eoRDDw-1
Received: by mail-wm1-f70.google.com with SMTP id az19-20020a05600c601300b003914ac8efb8so1442683wmb.2
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:21:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dq2s4bgTjGwnDDHxC9z7hV73w6MWHPb9h0EePaDdIKU=;
        b=Clcoc+nSH3rLWwTuQgOmqHEMbouknusQbDe7p9SNGNTWeDy5TpdOa6LY53oPM2qJYf
         LYv7QMR8cJodF58NjfkQVR5RTjs85T/eteHpDU83SuxYaNb5AczxNSsceFF39wnbMw96
         3t3nCb0s0N724EUIkFBWWZuXno2/gniOPdGFRoQIHicCkCIFVYX5NqEgave9yfKVAL3v
         zQhdt1GPQj8OFKNW7hPqhq4IDoTDzOVwYrLhCXnc2jJ/z+NIaPF68mIHHmASUq6rkOaa
         DctesUiC0oc5jwd1PAs7hxwIS4dloqQfigMKypa2aXOqMDJiC78WINtp3K7qXxH8JbrE
         kz6w==
X-Gm-Message-State: AOAM53310Y7/JrZclizcMfSISM8u56DBbE9lkG6e0T0dGA1przFNJV6f
        sK1ld+371WiOaNCU1Ly7qn+DCSSo5vsWnElNNJ3cqnuAQis5IbiVig5K1JixNdpFH+7w6MA4SmD
        7XSeylHhKcRVXLIo901MDoRRBZ0Zpe1IgrS+liNY56y7TJXtHIbRatZUWSU++HWCJSK3F2H5Kko
        s0zzQ=
X-Received: by 2002:a1c:a185:0:b0:392:206d:209d with SMTP id k127-20020a1ca185000000b00392206d209dmr16526205wme.168.1650385307178;
        Tue, 19 Apr 2022 09:21:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzA8mgy3dlDfzY+4Vf/6FLDVq28ve++mN8rjXcAg0jhUaveXt/BSIYRH8IRcMDBWU0cYyvXiw==
X-Received: by 2002:a1c:a185:0:b0:392:206d:209d with SMTP id k127-20020a1ca185000000b00392206d209dmr16526186wme.168.1650385306930;
        Tue, 19 Apr 2022 09:21:46 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id j36-20020a05600c1c2400b0038ec526a0e3sm24505591wms.9.2022.04.19.09.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:21:46 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH] rteval: kcompile: Tweak default source tarball selection
Date:   Tue, 19 Apr 2022 17:21:42 +0100
Message-Id: <20220419162142.91470-1-vschneid@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Kcompile._WorkloadSetup() looks for a "tarball" and "tarfile" entry in
the CfgSection, but I couldn't find a single setter for thoses. The
only way for a user to specify a file is via --kcompile-source, which
doesn't seem to be actually used by the module.

As it stands, this method will look for a tarball matching the
hardcoded kernel_prefix.

Make Kcompile
- actually use --kcompile-source
- use the latest tarball in the loadsource if no source is specified.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
I'm not entirely sure about that one, I tried to dig up the git
history for uses of those "tarball" and "tarfile" options but didn't
really get anywhere, so maybe I'm completely wrong...
---
 rteval/modules/loads/kcompile.py | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 367f8dc..2747913 100644
--- a/rteval/modules/loads/kcompile.py
+++ b/rteval/modules/loads/kcompile.py
@@ -28,6 +28,7 @@ import sys
 import os
 import os.path
 import glob
+import re
 import subprocess
 from rteval.modules import rtevalRuntimeError
 from rteval.modules.loads import CommandLineLoad
@@ -35,7 +36,7 @@ from rteval.Log import Log
 from rteval.misc import expand_cpulist, compress_cpulist
 from rteval.systopology import SysTopology
 
-kernel_prefix = "linux-5.13"
+RE_KERNEL_TAR = re.compile(r"linux-(?P<maj>\d+)\.(?P<min>\d+).*\.tar.*")
 
 class KBuildJob:
     '''Class to manage a build job bound to a particular node'''
@@ -163,18 +164,27 @@ class Kcompile(CommandLineLoad):
             return
 
         # find our source tarball
-        if 'tarball' in self._cfg:
-            tarfile = os.path.join(self.srcdir, self._cfg.tarfile)
+        if self._cfg.source:
+            tarfile = os.path.join(self.srcdir, self._cfg.source)
             if not os.path.exists(tarfile):
                 raise rtevalRuntimeError(self, " tarfile %s does not exist!" % tarfile)
             self.source = tarfile
         else:
-            tarfiles = glob.glob(os.path.join(self.srcdir, "%s*" % kernel_prefix))
+            tarfiles = [f for f in os.listdir(self.srcdir)
+                        if RE_KERNEL_TAR.match(f)]
             if tarfiles:
-                self.source = tarfiles[0]
+                # Use (one of) the most recent kernels
+                def verkey(f):
+                    match = RE_KERNEL_TAR.match(f)
+                    return (match.group("maj"), match.group("min"))
+
+                tarfiles.sort(key=verkey)
+                self.source = tarfiles[-1]
             else:
                 raise rtevalRuntimeError(self, " no kernel tarballs found in %s" % self.srcdir)
 
+        kernel_prefix = re.search(r"linux-\d\.\d", self.source).group(0)
+
         # check for existing directory
         kdir = None
         names = os.listdir(self.builddir)
@@ -322,7 +332,7 @@ class Kcompile(CommandLineLoad):
 
 def ModuleParameters():
     return {"source":   {"descr": "Source tar ball",
-                         "default": "linux-5.13.2.tar.xz",
+                         "default": "",
                          "metavar": "TARBALL"},
             "jobspercore": {"descr": "Number of working threads per core",
                             "default": 2,
-- 
2.27.0

