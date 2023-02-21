Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9023C64EC4
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Feb 2023 19:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjBUT7U (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Feb 2023 14:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjBUT7O (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Feb 2023 14:59:14 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A2303CF
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 11:59:09 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id k20so2244845qtj.5
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 11:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1yFFmjsuxmcfkd8iqXP86Q5Z7r+yaaCZCdZFp2Nys0=;
        b=NkgprnGteLGc/YtngKeuSDUhJz9nsWAFDq0jiCt9JOsL8jAccHHNO49zOS+8pZ9lJS
         6EOLPKRqstKxhjAmab9bkAHlM2HXoywyCdD+IipxtF+E9zfqwzc/rDE26viqStqNVjo5
         vx98P+UiI6N27G7Htdjqx1yurq+EL7imjhahh1htgUmHUxnLEVmpvqkPRFsshe3v/ZlQ
         GoKvPue8hos1cZLd+Jfe6Ih5FR0gKWhU/YNpXNnEyQaAtzqlvhwcG4S3IkBLcVNlqI9w
         M6ztSUCcVgUXWZGebQ8jWh0hNDcyY38uwxnO4kyGUG19wq43uno5HPLRlKZl1S06P1Z2
         cUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G1yFFmjsuxmcfkd8iqXP86Q5Z7r+yaaCZCdZFp2Nys0=;
        b=OsexMy43yDOWgT5lKgRwesgul3YXHQcl2ZCqpiGvtoQe3yHmf3ng5DWx+/CQCSb4EP
         7GtdiWAkGV2608PMAjvg0mSyTKBkmO/e201sKhjQtyMUa4wPc6Acu/BzjQ+a1nFMnhiu
         7xVfcGfmbsIk+mTYu9eFMWCWe4TYPL582lpRJMsH25fOBqic2aNT2P5pz6A084gnR729
         S2Rex5y0ooLemLNEcSG8ZC9gccf/Xv0TrtCO8twteu9VydXBrYT2QVyGJdfvd0ew16A6
         X229L4fqMpWHsVDvkn0xebZkl02zFtPDiMsTDHJAgOzhC4H+VKzLWVSQhYblksB1w6kC
         Ud+w==
X-Gm-Message-State: AO0yUKXk4fceyX3sTMKmlro7hgcgFtaOrxOFN2ZIEwghPqHjrgD5zK2q
        jxrdOKh1sXzKFlILHwXfzK0s/oaxv5M=
X-Google-Smtp-Source: AK7set+JHGqh5v4a8gxGzI9dOE8dmPKh+6GKICiERJvQ7jylHvdPkXj8utni3le8noileAKC9JrHAg==
X-Received: by 2002:a05:622a:11cc:b0:3bd:15d4:ff65 with SMTP id n12-20020a05622a11cc00b003bd15d4ff65mr8592872qtk.40.1677009548048;
        Tue, 21 Feb 2023 11:59:08 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id r21-20020a37a815000000b00742301f1bfbsm758934qke.45.2023.02.21.11.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:59:07 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 13/14] rteval: setup: Remove distutils and clean-ups
Date:   Tue, 21 Feb 2023 14:58:27 -0500
Message-Id: <20230221195828.17919-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221195828.17919-1-jkacur@redhat.com>
References: <20230221195828.17919-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Replace deprecated distutils with sysconfig and setuptools
Clean-up a few other things in the file at the same time, such as the
incorrect outdated git url.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 setup.py | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/setup.py b/setup.py
index 9a76ffbf89be..bcf7330553d4 100644
--- a/setup.py
+++ b/setup.py
@@ -1,12 +1,18 @@
 #!/usr/bin/python3
-from distutils.sysconfig import get_python_lib
-from distutils.core import setup
-from os.path import isfile, join
-import glob, os, shutil, gzip
+""" install rteval """
+import sysconfig
+from os.path import relpath
+import os
+import shutil
+import gzip
+from setuptools import setup
 
 
 # Get PYTHONLIB with no prefix so --prefix installs work.
-PYTHONLIB = join(get_python_lib(standard_lib=1, prefix=''), 'site-packages')
+SCHEME = 'rpm_prefix'
+if SCHEME not in sysconfig.get_scheme_names():
+    SCHEME = 'posix_prefix'
+PYTHONLIB = relpath(sysconfig.get_path('platlib', SCHEME), '/usr')
 
 # Tiny hack to make rteval-cmd become a rteval when building/installing the package
 try:
@@ -28,19 +34,18 @@ from dist import RTEVAL_VERSION
 
 # Compress the man page, so distutil will only care for the compressed file
 mangz = gzip.GzipFile('dist/rteval.8.gz', 'w', 9)
-man = open('doc/rteval.8', 'rb')
-mangz.writelines(man)
-man.close()
+with open('doc/rteval.8', 'rb') as man:
+    mangz.writelines(man)
 mangz.close()
 
 
-# Do the distutils stuff
+# Do the setup stuff
 setup(name="rteval",
       version = RTEVAL_VERSION,
       description = "Evaluate system performance for Realtime",
       author = "Clark Williams, David Sommerseth",
       author_email = "williams@redhat.com, davids@redhat.com",
-      url = "https://git.kernel.org/?p=linux/kernel/git/clrkwllms/rteval.git;a=summary",
+      url = "https://git.kernel.org/pub/scm/utils/rteval/rteval.git",
       license = "GPLv2",
       long_description =
 """\
@@ -79,8 +84,6 @@ mean, variance and standard deviation) and a report is generated.
 os.unlink('dist/rteval')
 os.unlink('dist/rteval.8.gz')
 os.unlink('dist/__init__.py')
-# TODO FIX THIS, or at least find out why it was there
-#os.unlink('dist/__init__.pyc')
 
 if distcreated:
     try:
-- 
2.39.1

