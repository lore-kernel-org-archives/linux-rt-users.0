Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD0136327
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Aug 2024 15:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613606; cv=none; b=tXd1S6JIjFYtQ/3mpuwufu0rCY08o63eP+ULWwwCnDoBx5PV5SZFOuWlSy4I27+ytge084I4ZNRd0+rspsIzQmR3/TY2/GPCq8N+bagNNikeTyTBKd4+kN9A1kZeX58GOu8/2rm5BTRQTnhgdYu3yBts8/mAXMFNFXLQym+l53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613606; c=relaxed/simple;
	bh=62l623iV4Bc2bJEJqAHzcstJN24Xv+9p1ASydS9cgxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hL/2euaHyr6cHTYez9zN3ZyVKqiQm1T23UjqlqlVfOgYsop2wN26QyO4Qsf02PNoFdiGy3b3K7l7TyJCdh5MMIe12JqsCuBdMPyTu/nIlTeMbQJ2AL5jnYotLocnuI93/h3+MtEjB9WidMMk4mMObfXVG/QIvnf4uUdZ04AmCRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9SzmIPA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9SzmIPA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722613603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fUh5CyjanJV45KC/P0BrNGSuz7mZ+JFkJSh4LIc8+U8=;
	b=Q9SzmIPAQB2wVxhp7x/0DudZYYU7oBnmjtudpqY16voTWWoVB7aQnWa6P8YeQ0X0sQJMRB
	Zufx/cQVtcXqCEQj7y9vnDI2uYATXzVizhDLcz0FMd8ywX0wMkPwXJYqI3oOba42UKN8S5
	wJ3hiiq4AQ6QiWxWoyE2+XUlui8JHJc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-vfmMcSiWOJKJXNXpWLX4JQ-1; Fri,
 02 Aug 2024 11:46:42 -0400
X-MC-Unique: vfmMcSiWOJKJXNXpWLX4JQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38E7E1944A98
	for <linux-rt-users@vger.kernel.org>; Fri,  2 Aug 2024 15:46:41 +0000 (UTC)
Received: from ashelat-na.remote.csb (unknown [10.22.64.241])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 243FB1955D4A;
	Fri,  2 Aug 2024 15:46:40 +0000 (UTC)
From: Anubhav Shelat <ashelat@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: jkacur@redhat.com,
	kcarcia@redhat.com,
	Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v6 2/2] rteval: run cyclictest using '--default-system' when setting idle states
Date: Fri,  2 Aug 2024 11:46:36 -0400
Message-ID: <20240802154636.1240064-2-ashelat@redhat.com>
In-Reply-To: <20240802154636.1240064-1-ashelat@redhat.com>
References: <20240802154636.1240064-1-ashelat@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
 rteval-cmd                               | 4 ++++
 rteval/__init__.py                       | 1 +
 rteval/modules/measurement/cyclictest.py | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/rteval-cmd b/rteval-cmd
index 6e7d8f5d99cb..542d08fc67f0 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -266,6 +266,10 @@ if __name__ == '__main__':
                 | (rtevcfg.debugging and Log.DEBUG)
         logger.SetLogVerbosity(loglev)
 
+        # check if cpupower is being used
+        if sys.argv.count('--idle-set') > 0:
+            rtevcfg.update({'usingCpupower': True})
+
         # Load modules
         loadmods = LoadModules(config, logger=logger)
         measuremods = MeasurementModules(config, logger=logger)
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
index d919058e927f..2e8f6f1870ed 100644
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

