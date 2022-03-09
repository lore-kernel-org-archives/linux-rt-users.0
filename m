Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39422C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Mar 2022 19:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbiCITVR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiCITVP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Mar 2022 14:21:15 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1BD13F08
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Mar 2022 11:20:15 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id r127so2572374qke.13
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Mar 2022 11:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W0lboncYjtQXWNplSLbMf6iFrIMBFKm1En98pMzzZgQ=;
        b=EWkqq8yY4c1jiZ9erqtIkEokYDItWt5CeU/q6bvRGuS+tH/LhC47LjQSou4r4w4tTq
         r6whLH2qr+sBLseK/K6McRonUWGXhFUehWOuWlgwQ+OcuTBhV5C6bZguWIXAA/BtH4k8
         sWROysv8whZywNooPcQxdi367ml+Pf3+ObTGK9fn62cJyK8EB8FXdq8QBf0ejTJtug31
         VpZ5RPtXeoTWjLZ4Ylo8XGtND8ULtdZV6NO3G3cKVKIJa6P4diC6ddC/sS6tAyzLYWJr
         9EtY4XtSNteNpvN+oB6bVusjCJv9r9Cozj8rc11faFEsGVOVUXSMTdOBITmIyRRW1y/i
         iaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=W0lboncYjtQXWNplSLbMf6iFrIMBFKm1En98pMzzZgQ=;
        b=uU4FPFpb/akyrLMsLpAHrz5RmM1ibx710hTQLke+M6LZTYy8kQAp9RUiJiWNO5PUwt
         dcLrr23a1HGz48/N4+tZ03VF7a3v4rWQyukLgu9/ZYVDUYRrD1pFi35O3ofP10DcPSbC
         +AgnYh3HTYpP8h3DB1N7oOIXVhMePSXZWTVHQ3yEnffQ2loomeI6T8i6VKxMU74XhojX
         ICJTMJUAwpH5gF4PkKi2UWHBMPK53rLAA1uo0TcSuGRWZiJtOuP8w+Y2SSms5DVKRajD
         kZZQSeIYXRbSXV9pXxB2O45aqquwUSkN6XLvUK+Z4xrKPJjtzbmoRYUXl3E0TfB+9Q4h
         Dumw==
X-Gm-Message-State: AOAM530V6jPUxk5x55OwWvHE1zC8MXVgqy7zsAMsfLd5snD7NRGuyb3q
        GyOHg71A5JpUdkYC/RuTJhI65u3snzE=
X-Google-Smtp-Source: ABdhPJweULf+Ic41XdOncExgPH+xcMaRCXn4yZ/zpBFLOxd/yDwcvZ9n21M3RJsY2SUx8HvbSKQj9Q==
X-Received: by 2002:a37:4117:0:b0:649:2b2e:d1d0 with SMTP id o23-20020a374117000000b006492b2ed1d0mr805466qka.668.1646853614897;
        Wed, 09 Mar 2022 11:20:14 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id t66-20020ae9df45000000b0064915aff85fsm1338687qkf.45.2022.03.09.11.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:20:14 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rteval: Fix Popen for python3.6 where text=True is not available
Date:   Wed,  9 Mar 2022 14:19:43 -0500
Message-Id: <20220309191944.382066-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix using text=True in Popen for python-3.6 by using
encoding='utf-8' instead

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/services.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rteval/sysinfo/services.py b/rteval/sysinfo/services.py
index e5de22efc342..c85980e19165 100644
--- a/rteval/sysinfo/services.py
+++ b/rteval/sysinfo/services.py
@@ -62,11 +62,11 @@ class SystemServices:
             if not [1 for p in reject if fnmatch.fnmatch(servicename, p)] \
                     and os.access(service, os.X_OK):
                 cmd = '%s -qs "\(^\|\W\)status)" %s' % (getcmdpath('grep'), service)
-                c = subprocess.Popen(cmd, shell=True, text=True)
+                c = subprocess.Popen(cmd, shell=True, encoding='utf-8')
                 c.wait()
                 if c.returncode == 0:
                     cmd = ['env', '-i', 'LANG="%s"' % os.environ['LANG'], 'PATH="%s"' % os.environ['PATH'], 'TERM="%s"' % os.environ['TERM'], service, 'status']
-                    c = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
+                    c = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf-8')
                     c.wait()
                     if c.returncode == 0 and (c.stdout.read() or c.stderr.read()):
                         ret_services[servicename] = 'running'
@@ -81,7 +81,7 @@ class SystemServices:
         ret_services = {}
         cmd = '%s list-unit-files -t service --no-legend' % getcmdpath('systemctl')
         self.__log(Log.DEBUG, "cmd: %s" % cmd)
-        c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
+        c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf-8')
         for p in c.stdout:
             # p are lines like b'servicename.service status'
             v = p.strip().split()
@@ -91,7 +91,7 @@ class SystemServices:
 
     def services_get(self):
         cmd = [getcmdpath('ps'), '-ocomm=', '1']
-        c = subprocess.Popen(cmd, stdout=subprocess.PIPE, text=True)
+        c = subprocess.Popen(cmd, stdout=subprocess.PIPE, encoding='utf-8')
         self.__init = c.stdout.read().strip()
         if self.__init == 'systemd':
             self.__log(Log.DEBUG, "Using systemd to get services status")
-- 
2.35.1

