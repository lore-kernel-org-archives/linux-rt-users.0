Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EA516A95F
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848366; cv=none; b=CG2xFQIbV/HCq4PaGwx67aYMy6HgwPZ5WrxumiMhfAQtoVTpSONZZOTELmNM83dTQyqSAhfv0u7tywEC4Es9Lgg4b2wsSesxSwc/o144bON/zGS120FrVScRS683xw6HEXPbIcchVJ+R99m6gBj7/QWzdOLO2M4fyO6JrXwND4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848366; c=relaxed/simple;
	bh=tuV262BfJ2LtQ1niOvqh1GwzFByzjlpnDH13rMauQ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4sC4dIWKi0awcgi3qQpS5FdMKQYN2WyxNCWya1mjWFZLDskMXjwfTFE17GvFMMJSBsukA4Km1GuKCH9aGzbZJpDQNfWOhVwXwLspiyCcvUCf0hLTIGwKzOdagKlHRCuKB2zIPCfKuYYcghyqGuMTBlXbTkmcyU8rGX2VYdalyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hy94wjPd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hy94wjPd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721848363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UEFlL+6b4fJS4xNiCPaaktj7FVbtY9jiBqkrg3P8fhg=;
	b=Hy94wjPdTZl9qBKIzhwG7OtExyeKpOx4ObXz+aVXbqkOgMRXlPnyj0uRJ7Doq+NOWB1P6f
	EAk98Eqs7w7X5gsiYzVzDQukAK/g6sqcq7zaq5Y39QjLNOfHZXQ71d7VtwThx4x4p/0UbW
	anpNISGuXZg/S/QMKHGXwrp1MjsgWNY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-Zg9r5ZgSNJ2qrXVI1fc26g-1; Wed,
 24 Jul 2024 15:12:42 -0400
X-MC-Unique: Zg9r5ZgSNJ2qrXVI1fc26g-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 456361955D42
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Jul 2024 19:12:41 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.33.33])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC22B3000194;
	Wed, 24 Jul 2024 19:12:39 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v4] rteval: run cyclictest using '--default-system' when setting idle states
Date: Wed, 24 Jul 2024 15:12:25 -0400
Message-ID: <20240724191225.1722773-2-ashelat@redhat.com>
In-Reply-To: <20240724191225.1722773-1-ashelat@redhat.com>
References: <20240724191225.1722773-1-ashelat@redhat.com>
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
 rteval/__init__.py                       | 3 ++-
 rteval/modules/measurement/cyclictest.py | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/rteval/__init__.py b/rteval/__init__.py
index 226d14f80f48..b042102f4553 100644
--- a/rteval/__init__.py
+++ b/rteval/__init__.py
@@ -124,7 +124,8 @@ class RtEval(rtevalReport):
                       'memsize':self._sysinfo.mem_get_size(),
                       'numanodes':self._sysinfo.mem_get_numa_nodes(),
                       'duration': float(self.__rtevcfg.duration),
-                      }
+                      'usingCpupower': self.__rtevcfg.usingCpupower
+                  }
             self._loadmods.Setup(params)
 
         self.__logger.log(Log.INFO, "Preparing measurement modules")
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

