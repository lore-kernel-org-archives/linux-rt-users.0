Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dAhvFObX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02DC1707
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Nov 2023 01:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701250626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nSzN0n4NvaAC5OOT+G7H4n9lFYoJ27EXhzbfapESRbw=;
	b=dAhvFObX3YL+C0AbsLX+gRNJbGAvo6i5ih6eRVBapYkMhdlN61Ol2wXr3v4zMekT6jnDhL
	dd+TjK6ZtJZ0KJx2LSlAuTC2BVwqWh0TJiX9p6cjNOeqMTmCpBzsTE3gZGfABjFPPUEPcV
	t2ax5PF5nQtczmxdix4eCz5IuWnFfuo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Pa8DNG9dPzujuz95uv6Yng-1; Wed, 29 Nov 2023 04:37:05 -0500
X-MC-Unique: Pa8DNG9dPzujuz95uv6Yng-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C6CA3881C80
	for <linux-rt-users@vger.kernel.org>; Wed, 29 Nov 2023 09:37:04 +0000 (UTC)
Received: from fedora.brq.redhat.com (unknown [10.43.17.244])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3BB9440C6EB9;
	Wed, 29 Nov 2023 09:37:04 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 2/4] rteval: Minor improvements to CpuList class
Date: Wed, 29 Nov 2023 10:34:55 +0100
Message-ID: <20231129093457.17984-3-tglozar@redhat.com>
In-Reply-To: <20231129093457.17984-1-tglozar@redhat.com>
References: <20231129093457.17984-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

From: Tomas Glozar <tglozar@redhat.com>

- Remove unnecessary if-else from online_file_exists
- Use cpupath in online_file_exists
- Check for cpu0 instead of cpu1 in online_file_exists
- In is_online, remove check for n in cpuset and make it static
- Mark also the remaining methods static since they do not rely on
any fields of the class

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/systopology.py | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index ea8e242..60ac8e8 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -82,12 +82,17 @@ class CpuList:
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
+        # Note: some machines do not have cpu0/online so we check cpu1/online.
+        # In the case of machines with a single CPU, there is no cpu1, but
+        # that is not a problem, since a single CPU cannot be offline
+        return os.path.exists(os.path.join(CpuList.cpupath, "cpu1/online"))
 
     @staticmethod
     def isolated_file_exists():
@@ -147,14 +152,9 @@ class CpuList:
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
@@ -163,16 +163,17 @@ class CpuList:
 
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
2.39.3

