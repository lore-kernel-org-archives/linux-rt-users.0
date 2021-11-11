Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B8BC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3556120D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbhKKUp0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhKKUpZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:25 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B551CC0613F5
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:35 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id u16so4861332qvk.4
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ywbKNOlYx0IPa2Vq8VrZeNiLpi2ef5xi2+Prr8Nzh/E=;
        b=ZUbxkkv2ZOAneeHa3R5Xd++ojNtsa/Ktl7DJH22EU4lE6z4Bm1OUhHx95J/+EMciyg
         P6MeGJ5pLSROS1Do8mZenZhb6iz6nx8LtCBX8iYYSJ+yGwN+lR128uz3G6pnJAm+ezF6
         JOLUTvoBQwg+ihhG0hFky7h4OjzQZerQHO3c97dwXB1g/hnptI7wMHwcec0Bn5udzwKR
         BO7PVj+KEQRjYd0vR6ozVmBJJ4tS30u9R/1uHs1XfTUo3mA+FB7TVLuaDRJdRTrQ9OYy
         IPyHV7DUO+ActCzjRqutuZVXHmCRe5y73LHotKiq+88vhSYYR14vCUWAP+eX/BUZO6nM
         sXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ywbKNOlYx0IPa2Vq8VrZeNiLpi2ef5xi2+Prr8Nzh/E=;
        b=3FbMA/5EaKh7P5w4+ypXyUj71QYX8XXhv9kK9ZEb414LbZPcgkgEaqjiebJiR6yrKH
         8ucppO9ad8dREQTNTD2roabEUS+Plue1fcFSu8HwLP4rrN3+Jtt1zU4gkBik5+8JM/R3
         3H4GscRSmpF7+2fq3OawDVyylVNTmphU+bWmI70M0dx1YORLvRibsz2rOczyS8yIoiyT
         or9Ysm4FYNkLprhmU0ujX7pO2XRneQnSfFN4olgpP9vJPv1RfY4O4F9Ik56X7S/bFYM9
         q9z6uWgj3iqXVAZm+dzaYzrFilIOMPv4uHm49hJnXktv6JQdMsIBT2dHPxqNQI57LO50
         4e8A==
X-Gm-Message-State: AOAM5321THoYTpTuRrDkeeYL20JWnUeADdaBnDjLA0lmlLiPHB0xaHFh
        zdyCcJBj7f0DyYQvk7IL4pEvQXWXyoo=
X-Google-Smtp-Source: ABdhPJx2WnA8KBjq9zQVRuLR6v7J4XbpgJXc+8ULZcYn1VShs/6FpCx4lOOtR/Il6KuTY9vPygDK1g==
X-Received: by 2002:a05:6214:2342:: with SMTP id hu2mr1858499qvb.9.1636663354549;
        Thu, 11 Nov 2021 12:42:34 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:34 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 11/17] rt-tests: hwlatdetect: Remove class Hwlat
Date:   Thu, 11 Nov 2021 15:42:01 -0500
Message-Id: <20211111204207.10167-11-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

hwlatdetect converted to using ftrace a long time ago.
Since we no longer need to load a kernel module, the class Hwlat can be
removed.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 61 +---------------------------------
 1 file changed, 1 insertion(+), 60 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index c07ddbb0e89e..ff8265ac39c5 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -380,6 +380,7 @@ class Tracer(Detector):
                     f.write("%s\n" % str(s))
                 print("report saved to %s (%d samples)" % (output, len(self.samples)))
 
+
     def display(self):
         for s in self.samples:
             s.display()
@@ -391,66 +392,6 @@ class Tracer(Detector):
             raise RuntimeError("Failed to unmount debugfs")
 
 
-#
-# Class to simplify running the hwlat kernel module
-#
-class Hwlat(Detector):
-    '''class to wrap access to hwlat debugfs files'''
-    def __init__(self):
-        super().__init__()
-        self.kmod = Kmod("hwlat_detector")
-        self.type = "kmodule"
-        self.kmod.load()
-
-    def get(self, field):
-        return int(self.debugfs.getval(os.path.join("hwlat_detector", field)))
-
-    def set(self, field, val):
-        if field == "enable" and val:
-            val = 1
-        self.debugfs.putval(os.path.join("hwlat_detector", field), str(val))
-
-    def get_sample(self):
-        return self.debugfs.getval("hwlat_detector/sample", nonblocking=True)
-
-    def detect(self):
-        self.samples = []
-        testend = time.time() + self.testduration
-        pollcnt = 0
-        self.start()
-        try:
-            while time.time() < testend:
-                pollcnt += 1
-                val = self.get_sample()
-                while val:
-                    val = val.strip()
-                    self.samples.append(val)
-                    if watch:
-                        print(val)
-                    val = self.get_sample()
-                time.sleep(0.1)
-        except KeyboardInterrupt as e:
-            print("interrupted")
-        self.stop()
-        return self.samples
-
-    def display(self):
-        for s in self.samples:
-            print(s)
-
-    def save(self, output=None):
-        if output:
-            with open(output, "w") as f:
-                for s in self.samples:
-                    f.write("%s\n" % str(s))
-                print("report saved to %s (%d samples)" % (output, len(self.samples)))
-
-    def cleanup(self):
-        if not self.kmod.unload():
-            raise RuntimeError("Failed to unload %s" % self.name)
-        if not self.debugfs.umount():
-            raise RuntimeError("Failed to unmount debugfs")
-
 def seconds(str):
     "convert input string to value in seconds"
     if str.isdigit():
-- 
2.31.1

