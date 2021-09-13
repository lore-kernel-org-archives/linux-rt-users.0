Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A6F7C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 08:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B93160E74
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 08:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237797AbhIMIHs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 04:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237648AbhIMIHs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 04:07:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1533C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 01:06:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v1so5266792plo.10
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 01:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uStvqBuFCYC+NF8LCX3rbzNoZPJ2yhAt/xDZ9c8lgn8=;
        b=WMVZRQj99ZIDQ7Mubip+90ybFhnj5NBKanP/T83AW3CJ8Kb2moILmete2GG+/qH5f3
         w/yOKV4OZj4iTEdGcmeKI+pwAX0h0LZDbMGnJ9WtVssMqMNKfAhBos/yid4P2cOg6dEQ
         fbvm1Akkl7BwK9JGltlgD9XGMoBcdtL/DQFqx+aX+qwXpGI2AFJrKFqJ8Mzae1ziZC5u
         AJmoR/XZ366TUArUBDgLayHspac8nNBtusZY5PQGma6WWM2kaPSKCbhK9GNOA5RQyBKa
         DHmDNUwQlHDylL2J/gIWZ9NIU9o4JAejW6pY2FZWeNdUklrG5Vuu7YSvudEq51U/gSSa
         TP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uStvqBuFCYC+NF8LCX3rbzNoZPJ2yhAt/xDZ9c8lgn8=;
        b=J+4q0ojt4Y8kNmDMzhcFNACFM3+Gl7FU0O/2+7TU06Ah3sCYzFslxvo+xg4SYEGGix
         2ObKyCjmJGsaM0Pqy8Dc8ingaO49fzZCew+IFFUtOpncxs6uLQnCcj9mjOcS16Itf/w4
         B45LZnFk/Z0sCesoMgn2hIGTMBqZmuNfLJmDH+iSuRSe4NDj9owWG2CIyclAsyAAfcx5
         iygjha8+j+o+gGwrxJ+0upuYE+d0R2tefeyk2agSwXwX5oRDScJ0VNWOdahn4jGnhRzG
         iSmghzZSHqxoZAuTCKlT+Q7KtbFjR4L97JVhbuBjsy+msKUlI5yaAb5Sb7tJV/YCmJdx
         jAkw==
X-Gm-Message-State: AOAM530hNMAA+bJVh0JrEw2zBirioSJRUyV10ApDg95DJWotNwTBMMIh
        9e9l5i1sPqqs/MwBiZfODp8=
X-Google-Smtp-Source: ABdhPJwKd0RowGpd1AQR4DihuP0CBRj5rPAj5d4Hvpkq2gA/Duuivn8lC3AFbVqEDX5Ywb7eNteciQ==
X-Received: by 2002:a17:90a:1c81:: with SMTP id t1mr11617580pjt.170.1631520392257;
        Mon, 13 Sep 2021 01:06:32 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id j20sm7251783pgb.2.2021.09.13.01.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 01:06:31 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: [PATCH v2] rteval: services.py: Fix incorrect detection of container environment
Date:   Mon, 13 Sep 2021 17:06:25 +0900
Message-Id: <20210913080625.2017964-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <d18a85b5-d591-a21b-c7fc-93655f7963c@redhat.com>
References: <d18a85b5-d591-a21b-c7fc-93655f7963c@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

rteval mistakenly detects that it is running inside a container even
though it is running directly on the host. On further investigation
this was found to be due to change in behaviour around byte strings
and strings when going from python2 to python3.

In python3 process output (stdout, stderr) for processes executed via
Popen() is retuned as byte strings and byte strings are not equivalent
to strings, i.e., b'' == '' is False.

Update all call sites for Popen() to include "text=True"
argument - this ensures that the process output is returned as a
string.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
v1 -> v2:
* Update Popen() calls to return strings for process output
---
 rteval/sysinfo/services.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/rteval/sysinfo/services.py b/rteval/sysinfo/services.py
index 06ff5ae9cd0c..283109b9b234 100644
--- a/rteval/sysinfo/services.py
+++ b/rteval/sysinfo/services.py
@@ -62,11 +62,11 @@ class SystemServices:
             if not [1 for p in reject if fnmatch.fnmatch(servicename, p)] \
                     and os.access(service, os.X_OK):
                 cmd = '%s -qs "\(^\|\W\)status)" %s' % (getcmdpath('grep'), service)
-                c = subprocess.Popen(cmd, shell=True)
+                c = subprocess.Popen(cmd, shell=True, text=True)
                 c.wait()
                 if c.returncode == 0:
                     cmd = ['env', '-i', 'LANG="%s"' % os.environ['LANG'], 'PATH="%s"' % os.environ['PATH'], 'TERM="%s"' % os.environ['TERM'], service, 'status']
-                    c = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+                    c = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
                     c.wait()
                     if c.returncode == 0 and (c.stdout.read() or c.stderr.read()):
                         ret_services[servicename] = 'running'
@@ -81,9 +81,9 @@ class SystemServices:
         ret_services = {}
         cmd = '%s list-unit-files -t service --no-legend' % getcmdpath('systemctl')
         self.__log(Log.DEBUG, "cmd: %s" % cmd)
-        c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
+        c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
         for p in c.stdout:
-            # p are lines like "servicename.service status"
+            # p are lines like b'servicename.service status'
             v = p.strip().split()
             ret_services[v[0].split('.')[0]] = v[1]
         return ret_services
@@ -91,7 +91,7 @@ class SystemServices:
 
     def services_get(self):
         cmd = [getcmdpath('ps'), '-ocomm=', '1']
-        c = subprocess.Popen(cmd, stdout=subprocess.PIPE)
+        c = subprocess.Popen(cmd, stdout=subprocess.PIPE, text=True)
         self.__init = c.stdout.read().strip()
         if self.__init == 'systemd':
             self.__log(Log.DEBUG, "Using systemd to get services status")
-- 
2.32.0

