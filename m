Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50E23E488
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Nov 2023 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgDt1Ac3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C193B13A
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Nov 2023 04:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699964304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+OQWiNOSOsRiMZpHTn6Y5voAWXpBJQA1RtypuqtjKk=;
	b=cgDt1Ac3JRqdIazKyNmMm8ge1G/HSp3Ys2LOK9sTSEyIFVUTFEir/UnvPMBa2XvEPF2hKi
	0XgltQg6nub64UwZsQXZPFaLVpjB+VPMv9zYh2klPJZPLf3Y3Wd0lIqdDjsEjKuza9MpKC
	RMxLjBmkK06ehwDpatEiPtu0fWVe+a4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-nb7gosDcNtmsbiNAOQWYzw-1; Tue,
 14 Nov 2023 07:18:22 -0500
X-MC-Unique: nb7gosDcNtmsbiNAOQWYzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68D81380673F
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Nov 2023 12:18:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.142])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C5310143;
	Tue, 14 Nov 2023 12:18:21 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/3] rteval: Minor improvements to CpuList class
Date: Tue, 14 Nov 2023 13:18:07 +0100
Message-ID: <20231114121808.154654-3-tglozar@redhat.com>
In-Reply-To: <20231114121808.154654-1-tglozar@redhat.com>
References: <20231114121808.154654-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

From: Tomas Glozar <tglozar@redhat.com>

- Remove unnecessary if-else from online_file_exists
- Use cpupath in online_file_exists
- Check for cpu0 instead of cpu1 in online_file_exists
- In is_online, remove check for n in cpuset and make it static
- Mark also the remaining methods static since they do not rely on
any fields of the class

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/systopology.py | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index ea8e242..97d3dc4 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -82,12 +82,14 @@ class CpuList:
     def __len__(self):
         return len(self.cpulist)
 
+    def getcpulist(self):
+        """ return the list of cpus tracked """
+        return self.cpulist
+
     @staticmethod
     def online_file_exists():
         """ Check whether machine / kernel is configured with online file """
-        if os.path.exists('/sys/devices/system/cpu/cpu1/online'):
-            return True
-        return False
+        return os.path.exists(os.path.join(CpuList.cpupath, "cpu0/online"))
 
     @staticmethod
     def isolated_file_exists():
@@ -147,14 +149,9 @@ class CpuList:
                 result.append(a)
         return [int(i) for i in list(set(result))]
 
-    def getcpulist(self):
-        """ return the list of cpus tracked """
-        return self.cpulist
-
-    def is_online(self, n):
+    @staticmethod
+    def is_online(n):
         """ check whether cpu n is online """
-        if n not in self.cpulist:
-            raise RuntimeError(f"invalid cpu number {n}")
         path = os.path.join(CpuList.cpupath, f'cpu{n}')
 
         # Some hardware doesn't allow cpu0 to be turned off
@@ -163,16 +160,17 @@ class CpuList:
 
         return sysread(path, "online") == "1"
 
-    def online_cpulist(self, cpulist):
+    @staticmethod
+    def online_cpulist(cpulist):
         """ Given a cpulist, return a cpulist of online cpus """
         # This only works if the sys online files exist
-        if not self.online_file_exists():
+        if not CpuList.online_file_exists():
             return cpulist
         newlist = []
         for cpu in cpulist:
-            if not self.online_file_exists() and cpu == '0':
+            if not CpuList.online_file_exists() and cpu == '0':
                 newlist.append(cpu)
-            elif self.is_online(int(cpu)):
+            elif CpuList.is_online(int(cpu)):
                 newlist.append(cpu)
         return newlist
 
-- 
2.41.0

