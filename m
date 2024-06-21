Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F3784A2F
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936669; cv=none; b=OkCvYhCpCI+PGUWJ2spUS5Y9QmUDSATFUMUdcsppy5IL0Vt2TdExb5lzyLl9iYWJ7B4ZAUdzYvygNPmJwNrdGZ+ineU4HutMB31VAYfBbgOJU4lpdt7ISA5JCceSuPYTofee9YPzmuhBm8nKZ4cY3UvSuFGC6FchdSzZ/AmQC/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936669; c=relaxed/simple;
	bh=rnQ8d55E4nRkj9VaLYTtBaKsZdZlGIxeYqizhAJqQjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qHINLQgT8ezdBq1wPWqeFZntdntnZJdNED/wQV8rahIMHLJ21I5udT2NVca/cw/KZRNFyAXwkPedOYkrc6+9q9HFnL1eU3GRVwiGihoggHAQanXZF4QhChdoC2FAc3xbv1RulOKKQfupsmHVlimO7biT1gxkjD0SastWzsGxC5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gZrn2uCt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gZrn2uCt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718936666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p+x9fcL9dIpnIkj8cwuPDSdHV30EDf0t11I71DgIxtc=;
	b=gZrn2uCt9+ldtGAxnQZd/XDRG2lwa7cnCtnzMqsfQYPKFT297V3tSH4w22HMHpfJz3CAxn
	9KdWrB7i9czxio+sgNRUXHDzaP12IwIvm7GF65Q0Tao68ZS9Q4jYg7xJlkLQ5SxR2M5QdE
	QGvJMcpXLXhWdJvovKBMzsbzHVcY290=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-81GrI_X0MDGDerJTU8VnkA-1; Thu,
 20 Jun 2024 22:24:24 -0400
X-MC-Unique: 81GrI_X0MDGDerJTU8VnkA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDC27195608E
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 02:24:23 +0000 (UTC)
Received: from p1g2.hsd1.mn.comcast.net (unknown [10.2.16.179])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 889851956048;
	Fri, 21 Jun 2024 02:24:22 +0000 (UTC)
From: Crystal Wood <crwood@redhat.com>
To: John Kacur <jkacur@redhat.com>,
	Clark Williams <williams@redhat.com>
Cc: linux-rt-users@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 3/4] rteval: RtEvalModules: Remove unused methods
Date: Thu, 20 Jun 2024 21:24:16 -0500
Message-ID: <20240621022417.2086751-4-crwood@redhat.com>
In-Reply-To: <20240621022417.2086751-1-crwood@redhat.com>
References: <20240621022417.2086751-1-crwood@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

With measurement profiles gone, remove methods that no longer have any
users.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
 rteval/modules/__init__.py | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 0c0ce7202f77..de1ddc4628c1 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -333,36 +333,11 @@ returned when a ModuleContainer object is iterated over"""
         self.__modobjects[modname] = modobj
 
 
-    def ExportModule(self, modname, modroot=None):
-        "Export module info, used to transfer an imported module to another ModuleContainer"
-        if modroot is None:
-            modroot = self.__modules_root
-
-        mod = f"{modroot}.{modname}"
-        return (mod, self.__modsloaded[mod])
-
-
-    def ImportModule(self, module):
-        "Imports an exported module from another ModuleContainer"
-        (modname, moduleimp) = module
-        self.__modsloaded[modname] = moduleimp
-
-
     def ModulesLoaded(self):
         "Returns number of registered module objects"
         return len(self.__modobjects)
 
 
-    def GetModulesList(self):
-        "Returns a list of module names"
-        return list(self.__modobjects.keys())
-
-
-    def GetNamedModuleObject(self, modname):
-        "Looks up a named module and returns its registered module object"
-        return self.__modobjects[modname]
-
-
     def __iter__(self):
         "Initiates the iterating process"
 
@@ -406,10 +381,6 @@ class RtEvalModules:
     # Export some of the internal module container methods
     # Primarily to have better control of the module containers
     # iteration API
-    def _ImportModule(self, module):
-        "Imports a module exported by ModuleContainer::ExportModule()"
-        return self.__modules.ImportModule(module)
-
     def _InstantiateModule(self, modname, modcfg, modroot=None):
         "Imports a module and returns an instantiated object from the module"
         return self.__modules.InstantiateModule(modname, modcfg, modroot)
@@ -426,17 +397,9 @@ class RtEvalModules:
         "Returns number of imported modules"
         return self.__modules.ModulesLoaded()
 
-    def GetModulesList(self):
-        "Returns a list of module names"
-        return self.__modules.GetModulesList()
-
     def SetupModuleOptions(self, parser):
         "Sets up argparse based argument groups for the loaded modules"
         return self.__modules.SetupModuleOptions(parser, self._cfg)
-
-    def GetNamedModuleObject(self, modname):
-        "Returns a list of module names"
-        return self.__modules.GetNamedModuleObject(modname)
     # End of exports
 
 
-- 
2.45.1

