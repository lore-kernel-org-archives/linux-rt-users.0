Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D763617588
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Jul 2024 16:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721924133; cv=none; b=gfEdJ8tEse2V0V1nUCaWmBHZuz2oNs7/uvhUV42WBz9BiRC71kVw3HZ5j7/UzNizOt69bZCLdekrL0ak1KpQRWlR4hUFZgtspXZBCaMnD167pVHTPJMQGVWna2tihsBOEoVYaA/ZRLsVlVwkkQdRvylu7TnTZD2NWpwmoctIrXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721924133; c=relaxed/simple;
	bh=FqbMg3jrEOC0vibPNNAf4SR0DXcQYPq0GbtJENkBztk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0y1+viYH/rCyb5+MAyj0BRYjM7jElxiTy5IvcDIo7TY4YhsYEe6mYob8DJQeqhE/9UJKeWxfWdgFLvQ3dA/ZIBGsfKLz6V3U9F0V/BREk8HcBCWv00V5LY8P1EpR7D/tXg0urOcxHkwJOLSbz3wp9Yqoo2l/7SaT7/HrF515ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJgM8Eo7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJgM8Eo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721924130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BWjJHRsgAiKSPGqFB1WmYYRMMJz4kuMq97PTFgBcxkk=;
	b=fJgM8Eo7T2qwdh4bGgc17caYd5FCKdLZrAbzLLleXHHifbOzpwWhYv6tYEwlapOdLW7Xmr
	6oezVdEFDjM4PR/73Nr4w6TdWq9lFz8Db7Jt8Dqp+6zZRFFmt2tUw9gZV1Zsl/N8k8YGc1
	slurgJepffVaJSsbaUDfODm1fjoysAo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-HnzcKfogNIWcfpjYeE4FWQ-1; Thu,
 25 Jul 2024 12:15:24 -0400
X-MC-Unique: HnzcKfogNIWcfpjYeE4FWQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7BEC1955D4C
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Jul 2024 16:15:23 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.64.15])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A65ED3000194;
	Thu, 25 Jul 2024 16:15:22 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v5 2/2] rteval: run cyclictest using '--default-system' when setting idle states
Date: Thu, 25 Jul 2024 12:15:14 -0400
Message-ID: <20240725161514.1885152-2-ashelat@redhat.com>
In-Reply-To: <20240725161514.1885152-1-ashelat@redhat.com>
References: <20240725161514.1885152-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

When running cyclictest in rteval, cyclictest automatically disables
idle states. This means whenever the user sets the idle state of a cpu
list using '--idle-set' it is overridden by cyclictest.

To fix this, the variable 'usingCpupower' is appended to the parameter
dictionary that's passed to the Cyclictest measurement object which executes
cyclictest in rteval.

If '--idle-set' is specified when running rteval,
'usingCpupower' is set to true and the '--default-system' option is
appended to the cyclictest command, which will prevent cyclictest from
disabling cstates.

Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 rteval/__init__.py                       | 1 +
 rteval/modules/measurement/cyclictest.py | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index 4d3e0c23e5ab..8ded374d287e 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -119,6 +119,7 @@ class RtEval(rtevalReport):
                   'memsize':self._sysinfo.mem_get_size(),
                   'numanodes':self._sysinfo.mem_get_numa_nodes(),
                   'duration': float(self.__rtevcfg.duration),
+                  'usingCpupower': self.__rtevcfg.usingCpupower
                   }
 
         if self._loadmods:
diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
index a9f5b0c4fba7..fffc8fe27681 100644
--- a/rteval/modules/measurement/cyclictest.py
+++ b/rteval/modules/measurement/cyclictest.py
@@ -251,6 +251,9 @@ class Cyclictest(rtevalModulePrototype):
         self.__cmd.append(f'-t{self.__numcores}')
         self.__cmd.append(f'-a{self.__cpulist}')
 
+        if (self.__cfg.usingCpupower):
+            self.__cmd.append('--default-system')
+
         if 'threads' in self.__cfg and self.__cfg.threads:
             self.__cmd.append(f"-t{int(self.__cfg.threads)}")
 
-- 
2.45.2

