Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAFD19D890
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Jul 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924752; cv=none; b=LQpZja8j/finl0XgB+bmx45HkPPpG7EGNcoXC9lKw81YExmYOJh/jFO+wFUhah37EzonwdA2ogai8BXPkbg/jm5YI6AFKova0DLW1YIfbVO5thFsKG3squ4jg2aoi+U5eTj3wOtygWxWSfSIqOgmYr0it18PwBURy1IbX1DG7WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924752; c=relaxed/simple;
	bh=B4xgtQlcRKYnr8/ocu9U8XMk4RpQ2oxFuCB/PxMNVgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjFfGsK87QCMHYzBp6hpPopX9nRwxKg9zRgHrCOjHiv9xh4KIClVaPo8ZLX3pu4tCDNj7upZ3hQAQ2ZcA0Oz33hkrJF1e7JKJsRqbdUqjSdgLpeSfOwV3ApIc/7fmAdJ+1BfXEiTHRNcq+D+O6nJmuqGbOkznkzB/HwLck8sCGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtgAHkM2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtgAHkM2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721924749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dUuNQMfLZguj2UmunTIREvsEdozp0VZwJCr6oj8hI+A=;
	b=FtgAHkM2d0fjEzgKcu7ZBdZaq1glGhpl4aSiz1U4wdC30biRJPpB4sioKjjni4bfiyqzBj
	aksjOWjliDzaYlFNc6j+WGxe5h+/tBACTU7CmL/cvjH93GV3GwDSOqc1snatVFEPQ0Naxt
	YB7kGIpn+GnmhK6+IKxIrNDqxf8DN6g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-OidgoSY7O-yl4DfJk6LPKA-1; Thu,
 25 Jul 2024 12:25:48 -0400
X-MC-Unique: OidgoSY7O-yl4DfJk6LPKA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0958195609E
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Jul 2024 16:25:46 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.64.15])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9259B195605A;
	Thu, 25 Jul 2024 16:25:45 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v4] tuna: add options to get idle state info
Date: Thu, 25 Jul 2024 12:25:31 -0400
Message-ID: <20240725162532.1890461-2-ashelat@redhat.com>
In-Reply-To: <20240725162532.1890461-1-ashelat@redhat.com>
References: <20240725162532.1890461-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Added a function in cpupower.py to get idle state info by executing
cpupower, and added an option in tuna to run that function from the
cstate subcommand.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 tuna-cmd.py      | 12 +++++++++---
 tuna/cpupower.py | 18 ++++++++++++------
 2 files changed, 21 insertions(+), 9 deletions(-)

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
index ecb82536d404..0aa9243b7838 100644
--- a/tuna/cpupower.py
+++ b/tuna/cpupower.py
@@ -59,6 +59,9 @@ class Cpupower:
                 f.close()
         print('Idle state configuration restored')
 
+    def get_idle_info():
+        subprocess.call(['cpupower', 'idle-info'])
+
 
 if __name__ == '__main__':
     parser = argparse.ArgumentParser()
@@ -66,15 +69,18 @@ if __name__ == '__main__':
                         help='List of cpus to perform cpupower-idle-set operation on.')
     parser.add_argument('-s', '--cstate', default='',
                         help='Specify cstate to enable/disable')
-
+    parser.add_argument('--info', default=False, action='store_true', help='Get idle state information')
+
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

