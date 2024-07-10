Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBBC195FCE
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Jul 2024 19:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720641036; cv=none; b=IudcGgBayDRyW7rKFDH8TgnwaP4wVzimBNo2uipoEj5t1oH3EOg9gUov6AS726n97Oxr5FzuEFxIqE0wrRNSKC/xZ8z5aw/viuujsqvgRO3LY1wWcd6JIz0D4IF/C19IvSx9zLrq9vmlGytdXo8NSLbI6NeEeUxIoXjZpY+BuaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720641036; c=relaxed/simple;
	bh=G37dZT/syFzHnnjQumPIGDIXD4+7fxYq4r1CNum+oZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CjDYa0W99d8k1Kfg93qy8mITTJgCkS4T0pZTzMMx5X6JyRLvtx3QXt1yQbrGun/g9iSW5gaaJTP2X9JvmSzPg4sYnPO9PkIdLwRocf2C8M1nNrTcY4YznYXUpTkRmImjbbj3Vi5xlCtf+/jlUz1qWPVMXeEpMBXII1OJNBUcqDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLav0Hzf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLav0Hzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720641033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O3RyYCFqXlyZJ5XgOJb31UuIvi6iX5ukAL8b02Mm3KA=;
	b=HLav0HzfzgbZ5qbesZm1mk36vYFYxeLQkBeBPc99UUOYU92nJrQfebK7N8YkE6mhkR/SL0
	17P1IKQJKf0NOP3EtzqUeGGZNvroyFjkRUnTwaSnogX7YJ40dAVtrKqwDW+B/dzBrc75nS
	XqvbKd0Q8QekYtbz16GD7APA3n025NU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-auXb457hP32RqSY_VtQzeA-1; Wed,
 10 Jul 2024 15:50:30 -0400
X-MC-Unique: auXb457hP32RqSY_VtQzeA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 106A4196CE01
	for <linux-rt-users@vger.kernel.org>; Wed, 10 Jul 2024 19:50:30 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.64.33])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA6D31955E85;
	Wed, 10 Jul 2024 19:50:28 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH] tuna: add options to get idle state info
Date: Wed, 10 Jul 2024 15:49:40 -0400
Message-ID: <20240710194939.20971-2-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Added a function in cpupower.py to get idle state info by executing
cpupower, and added an option in tuna to run that function from the
cstate subcommand.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tuna-cmd.py      | 12 +++++++++---
 tuna/cpupower.py | 16 +++++++++++-----
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tuna-cmd.py b/tuna-cmd.py
index c6ef8bae09a3..b6f94182241f 100755
--- a/tuna-cmd.py
+++ b/tuna-cmd.py
@@ -118,6 +118,8 @@ def gen_parser():
             "priority": dict(default=(None, None), metavar="POLICY:RTPRIO", type=tuna.get_policy_and_rtprio, help="Set thread scheduler tunables: POLICY and RTPRIO"),
             "background": dict(action='store_true', help="Run command as background task"),
             "cstate": dict(dest='cstate', metavar='CSTATE', help='Set cpus in IDLE-LIST to a specific cstate'),
+            "info": dict(dest='info', default=False, action='store_true',
+                          help='Display information about available CPU idle states.'),
          }
 
     parser = HelpMessageParser(description="tuna - Application Tuning Program")
@@ -223,6 +225,7 @@ def gen_parser():
 
     cstate.add_argument('-c', '--cpus', **MODS['cpus'])
     cstate.add_argument('-i', '--cstate', **MODS['cstate'])
+    cstate.add_argument('--info', **MODS['info'])
 
     what_is.add_argument('thread_list', **POS['thread_list'])
 
@@ -671,9 +674,12 @@ def main():
             print("Valid log levels: NOTSET, DEBUG, INFO, WARNING, ERROR")
             print("Log levels may be specified numerically (0-4)\n")
 
-    if args.cstate:
-        cpupower_controller = cpupower.Cpupower(str(args.cpu_list).strip('[]').replace(' ', ''), args.cstate)
-        cpupower_controller.enable_idle_state()
+    if args.command == 'cstate':
+        if args.info:
+            cpupower.Cpupower.get_idle_info()
+        elif args.cstate:
+            cpupower_controller = cpupower.Cpupower(str(args.cpu_list).strip('[]').replace(' ', ''), args.cstate)
+            cpupower_controller.enable_idle_state()
 
     if 'irq_list' in vars(args):
         ps = procfs.pidstats()
diff --git a/tuna/cpupower.py b/tuna/cpupower.py
index abbbe0448a8a..da869420eb6f 100644
--- a/tuna/cpupower.py
+++ b/tuna/cpupower.py
@@ -58,6 +58,9 @@ class Cpupower:
                 f.close()
         print('Idle state configuration restored')
 
+    def get_idle_info():
+        subprocess.call(['cpupower', 'idle-info'])
+
 
 if __name__ == '__main__':
     parser = argparse.ArgumentParser()
@@ -65,15 +68,18 @@ if __name__ == '__main__':
                         help='List of cpus to perform cpupower-idle-set operation on.')
     parser.add_argument('-s', '--cstate', default='',
                         help='Specify cstate to enable/disable')
+    parser.add_argument('--info', default=False, action='store_true', help='Get idle state information')
     
     args = parser.parse_args()
     print(args)
     cpulist = args.cpu_list
     cstate = args.cstate
-    cpupower = Cpupower(cpulist, cstate)
-
-    cpupower.enable_idle_state()
-    time.sleep(10)
-    cpupower.restore_cstate()
+    if (cstate):
+        cpupower = Cpupower(cpulist, cstate)
+        cpupower.enable_idle_state()
+        time.sleep(10)
+        cpupower.restore_cstate()
+    elif (args.info):
+        Cpupower.get_idle_info()
 
 
-- 
2.45.2

