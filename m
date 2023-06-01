Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2FBC7EE2E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbjFAU2x (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbjFAU2v (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4AF197
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIeTBMkR8JhU5vah/ui8Jku9ZedIAO0g44XbS7QFzeA=;
        b=PqZjWbnkPWjSBeJZeu3xwKMLqSPB2ZDTBeO7UsxyAHClctb2jBwQBDg4O8ZaZpZ9kvKULw
        bnZ+ofIyneamkwLk/KsHPS5O9R5NwiAo0hYm4N/V0+O2PXYvT/aM19fVgmQsYx7sx1Y+OH
        hO08NEoRHFUphyhz5CHh9FB5TpYjGqk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-oUDfVq7OOFqsa4woApV4TQ-1; Thu, 01 Jun 2023 16:28:00 -0400
X-MC-Unique: oUDfVq7OOFqsa4woApV4TQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43A643813F20
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:28:00 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 253ACC154D9;
        Thu,  1 Jun 2023 20:28:00 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 07/10] rteval: Use f-strings in services.py
Date:   Thu,  1 Jun 2023 16:27:33 -0400
Message-Id: <20230601202734.813515-8-ashelat@redhat.com>
In-Reply-To: <20230601202734.813515-1-ashelat@redhat.com>
References: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use f-strings in services.py

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/sysinfo/services.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rteval/sysinfo/services.py b/rteval/sysinfo/services.py
index c85980e19165..a87b4abeea76 100644
--- a/rteval/sysinfo/services.py
+++ b/rteval/sysinfo/services.py
@@ -55,17 +55,17 @@ class SystemServices:
                 break
         if not servicesdir:
             raise RuntimeError("No services dir (init.d) found on your system")
-        self.__log(Log.DEBUG, "Services located in %s, going through each service file to check status" % servicesdir)
+        self.__log(Log.DEBUG, f"Services located in {servicesdir}, going through each service file to check status")
         ret_services = {}
         for service in glob.glob(os.path.join(servicesdir, '*')):
             servicename = os.path.basename(service)
             if not [1 for p in reject if fnmatch.fnmatch(servicename, p)] \
                     and os.access(service, os.X_OK):
-                cmd = '%s -qs "\(^\|\W\)status)" %s' % (getcmdpath('grep'), service)
+                cmd = f'{getcmdpath("grep")} -qs "\(^\|\W\)status)" {service}'
                 c = subprocess.Popen(cmd, shell=True, encoding='utf-8')
                 c.wait()
                 if c.returncode == 0:
-                    cmd = ['env', '-i', 'LANG="%s"' % os.environ['LANG'], 'PATH="%s"' % os.environ['PATH'], 'TERM="%s"' % os.environ['TERM'], service, 'status']
+                    cmd = ['env', '-i', f'LANG="{os.environ["LANG"]}"', f'PATH="{os.environ["PATH"]}"', f'TERM="{os.environ["TERM"]}"', service, 'status']
                     c = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf-8')
                     c.wait()
                     if c.returncode == 0 and (c.stdout.read() or c.stderr.read()):
@@ -79,8 +79,8 @@ class SystemServices:
 
     def __get_services_systemd(self):
         ret_services = {}
-        cmd = '%s list-unit-files -t service --no-legend' % getcmdpath('systemctl')
-        self.__log(Log.DEBUG, "cmd: %s" % cmd)
+        cmd = f'{getcmdpath("systemctl")} list-unit-files -t service --no-legend'
+        self.__log(Log.DEBUG, f"cmd: {cmd}")
         c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, encoding='utf-8')
         for p in c.stdout:
             # p are lines like b'servicename.service status'
@@ -133,7 +133,7 @@ def unit_test(rootdir):
 
         return 0
     except Exception as err:
-        print("** EXCEPTION: %s" % str(err))
+        print(f"** EXCEPTION: {str(err)}")
         return 1
 
 
-- 
2.31.1

