Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82A2C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 May 2022 11:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiECLE7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 May 2022 07:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbiECLE6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 May 2022 07:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 45A9B33374
        for <linux-rt-users@vger.kernel.org>; Tue,  3 May 2022 04:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651575684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/lTwwTJYUxv7hq+wkERiUGLcAlFyLTkxumcT8c68uOQ=;
        b=LhNDvcEUE9+fpPbW6JsNBVELRLSfxyKFU5Ayb304zFg2w1bUcnzz+WYDJTQlaIVaWXiOC2
        FmX5Hgm4kkUxYZG6ZWcWCL+XPIq4LcKfGvJ9bR1ejyPNVa8K4aDkOnRsia5YC7g6kxtAc4
        mNP6O8p9AghdAVsillINCQny/wgx9xQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-IvhRWGsWNQqH4M6m12jaYg-1; Tue, 03 May 2022 07:01:23 -0400
X-MC-Unique: IvhRWGsWNQqH4M6m12jaYg-1
Received: by mail-wr1-f70.google.com with SMTP id w11-20020adf8bcb000000b0020c550ba8d7so2646651wra.1
        for <linux-rt-users@vger.kernel.org>; Tue, 03 May 2022 04:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/lTwwTJYUxv7hq+wkERiUGLcAlFyLTkxumcT8c68uOQ=;
        b=xmwCAU23jYggXPhYK4sA6OS/HTbEG/xFjE43xQSF4f7AKtYl5m9N984i8lnnR2CCi5
         7LHKhWSlfkyO2/PbD++8s+OISaATDP8vTd4KwXds3HsbjLNz8cyaVS7EMNvCwZv0LTt6
         24IUGSN5a4BycR2DdSjk1YsAdl4p2Av3Q1etXsirYKzoOKxpdKU7m7oV7J2V0NjAz05x
         Ncl0P/U9DfKbscLUn4TRXGotecdhfpVxhnFGHU4y46keMcP1ChEx9G02xjvlbW1SVBEE
         ri8CVblA1tahN2SM03AYqXAuCvu8ikeFMlB44FYQauPxLmet4PAaBO30Us8wKT6bVNdw
         87kw==
X-Gm-Message-State: AOAM533+sWWQwKQOFCdie/wnQQmTD8DuHLX1mDgYHT4l7r66llnPQwwP
        CTpF3g5R/Mdol+9ioFonBAiaTvhubJxsb00u8bKv2r8+3cdYiyaVZHATJ7+hYHE7Fg5XIRwrGJ8
        OyH+jaeTG5MGZ0v4nhi1v63pzXahYa/AKANi9GcFx2tZriTErBWV+CzTuNtUYiOBjYTOp2hiuhw
        nkysk=
X-Received: by 2002:a5d:4acb:0:b0:20c:6146:1308 with SMTP id y11-20020a5d4acb000000b0020c61461308mr7480688wrs.655.1651575681842;
        Tue, 03 May 2022 04:01:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQbjXiO7fIex3lCvr43zPdRu0xHNOb3NVyEwEHPbESXukn3sSQ/krSL2DdnEDph2OPhQro3g==
X-Received: by 2002:a5d:4acb:0:b0:20c:6146:1308 with SMTP id y11-20020a5d4acb000000b0020c61461308mr7480673wrs.655.1651575681554;
        Tue, 03 May 2022 04:01:21 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id e13-20020adf9bcd000000b0020c5253d8basm9186094wrc.6.2022.05.03.04.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 04:01:21 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH] rteval: kcompile: Fix source tarball argument handling
Date:   Tue,  3 May 2022 12:01:06 +0100
Message-Id: <20220503110106.40564-1-vschneid@redhat.com>
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

Make Kcompile actually use --kcompile-source.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 rteval/modules/loads/kcompile.py | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/rteval/modules/loads/kcompile.py b/rteval/modules/loads/kcompile.py
index 367f8dc..023b9d6 100644
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
+DEFAULT_KERNEL_PREFIX = "linux-5.13"
 
 class KBuildJob:
     '''Class to manage a build job bound to a particular node'''
@@ -163,17 +164,19 @@ class Kcompile(CommandLineLoad):
             return
 
         # find our source tarball
-        if 'tarball' in self._cfg:
-            tarfile = os.path.join(self.srcdir, self._cfg.tarfile)
+        if self._cfg.source:
+            tarfile = os.path.join(self.srcdir, self._cfg.source)
             if not os.path.exists(tarfile):
                 raise rtevalRuntimeError(self, " tarfile %s does not exist!" % tarfile)
             self.source = tarfile
+            kernel_prefix = re.search(r"linux-\d\.\d", self.source).group(0)
         else:
-            tarfiles = glob.glob(os.path.join(self.srcdir, "%s*" % kernel_prefix))
+            tarfiles = glob.glob(os.path.join(self.srcdir, "%s*" % DEFAULT_KERNEL_PREFIX))
             if tarfiles:
                 self.source = tarfiles[0]
             else:
                 raise rtevalRuntimeError(self, " no kernel tarballs found in %s" % self.srcdir)
+            kernel_prefix = DEFAULT_KERNEL_PREFIX
 
         # check for existing directory
         kdir = None
-- 
2.27.0

