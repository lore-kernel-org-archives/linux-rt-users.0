Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J9Zunexl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA14D10C8
	for <linux-rt-users@vger.kernel.org>; Wed, 22 Nov 2023 23:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700724287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+OQWiNOSOsRiMZpHTn6Y5voAWXpBJQA1RtypuqtjKk=;
	b=J9Zunexldwt8XNEI2tvMkq9o4+EmI7frKIhVkKMkjtWyS/lPd/hyLPBUJoxuJ31B6n1Xy6
	HodBJe6WNm5Q/xCtn5J1iqovWd923oE1JjC1NGWjh1z1d5wLjM60Ebufb3aVbtjCdf3Owl
	sXXpkXZ5bDO0eLym41uB1snm+P+WqK0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-ULhN87YTPsWrMDxfRvBxeQ-1; Thu, 23 Nov 2023 02:24:45 -0500
X-MC-Unique: ULhN87YTPsWrMDxfRvBxeQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4BF2D101A52D
	for <linux-rt-users@vger.kernel.org>; Thu, 23 Nov 2023 07:24:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A8E0D2166B26;
	Thu, 23 Nov 2023 07:24:44 +0000 (UTC)
From: tglozar@redhat.com
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH v2 2/3] rteval: Minor improvements to CpuList class
Date: Thu, 23 Nov 2023 08:24:35 +0100
Message-ID: <20231123072436.270267-3-tglozar@redhat.com>
In-Reply-To: <20231123072436.270267-1-tglozar@redhat.com>
References: <20231123072436.270267-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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

