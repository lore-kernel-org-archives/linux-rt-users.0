Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFEC14A61A
	for <linux-rt-users@vger.kernel.org>; Sun, 18 Aug 2024 19:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724010155; cv=none; b=MmV29SGubOOaIFVAk4PLk6tQBi1LjKpy/m6vOqTY3RZG19WmFC+6GVcaRekELijqsKtUrqBSW32U2QAvjbnrdovXA9mim0/hGU5MIJ27jEbAEbBYNcGN1GEnkHdzUmNtCOxc4buGJ0xCXqnyNthhTCTOSLcqihYB15HQd7SbcF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724010155; c=relaxed/simple;
	bh=+ttm6tIO3g+/9PoaSHQDzq0EfYe9FL+8zgcHG5c931Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nUTfWOsmTrirzn2c/MmWhIcTCGD502P/KIhjqwpt9wdbkLBMd1QWvlburzlBSqZEOD7gatCjXnmaHr1jKbKFYADsW6iIdvCgVWicb5Ji76zQN/Nz7PIs7wcRKvkuS//6pgsQGZvYwG02c1EiPCO3An8+VDtjr6NEGmRa2a7jUvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRhlGvky; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRhlGvky"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e0e6cbec8caso3603518276.1
        for <linux-rt-users@vger.kernel.org>; Sun, 18 Aug 2024 12:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724010151; x=1724614951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9wJKDnXFAkvyB+aFUXCK3mdSQRdx7/6Aa4O5IBcLKD0=;
        b=KRhlGvkyqREzHxbxc0BCM8xoaFCKdO3NVfSnrFMvFnvRwuUQ+GiBd24HvKumDlXkFN
         AybZsrH/IgeiOvnj8dLKIcGZMN105itsD90surLZEUxmV+KOyO3Bsirl984WNfKsWf0R
         mEZqe8mOb9bTFQXbLj+Vndd+KJGxN6n9D7VoJ80dRPXehckam+oKiyPTu5aITq7KLDGd
         iFJSS886nLJAkQNnWH7a+CJWf8qEDz+DNZEM92G5cGEgaDa0adcPvfjhc6LBkxHBZQ5m
         GaIKMIn1qlq/NSn2IeyEiXj5+s+w/mg/r00OK/us05+30G7DqJqP88b+vV6QQi2OQnMX
         +Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724010151; x=1724614951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9wJKDnXFAkvyB+aFUXCK3mdSQRdx7/6Aa4O5IBcLKD0=;
        b=lkYHgpg1sXMhJ2oiCly2as9t0UxNSwRlpq9vwIAmY3Z/luFVo9i2bHVnU1TcdkAFSm
         pnbGm5WSEN15rCk/1Kbs/TVT2xRu88veQijf04rHl8eb7Lu+yyA65cpWKsFwCGjwOjUz
         7zfc3wYcrckJjMYX08xm/qsjs+22e1/hzbhScxh1kYDnWWeaF6yexaTHJkj5wM6pxuTv
         H4uxEVBCAat0yRWYpUNaMpoIomvAl3cGr+RZ/taQS1M6VcJnqtj+MWbo+yJmGBVcEsFW
         1yqzKzptEeKy4fRTYqtBKMXz6vJHllpFUxpJiE5tcKn6VltZqn8GgY/4sl4sAV7GsRBi
         MRIw==
X-Gm-Message-State: AOJu0YyHWn869HRqiEEGuzI4cNR4UAo3r4Y6fqixHmx0HgI7qis2a8+S
	bKxgsx1Y+u8PSYHUBw1U6gN+tXCsovAuTAuZ3otBDHteYiz+FAUTlMuchw==
X-Google-Smtp-Source: AGHT+IHAx+df29v/4E7DKx3PykQOXGMiUvuFnIlxXqU+nCGPtQXp8KktXNzjECjeXu+ESGSvpOFAOw==
X-Received: by 2002:a05:6902:2587:b0:e11:7d05:562b with SMTP id 3f1490d57ef6-e1180e6c6a3mr8157382276.3.1724010150879;
        Sun, 18 Aug 2024 12:42:30 -0700 (PDT)
Received: from localhost.localdomain ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5f4fsm36909566d6.84.2024.08.18.12.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 12:42:30 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: RT <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Chris White <chwhite@redhat.com>,
	Anubhav Shelat <sanubhav1000@gmail.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/3] rteval: restore all load module options
Date: Sun, 18 Aug 2024 15:42:14 -0400
Message-ID: <20240818194216.299176-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240818194216.299176-1-jkacur@redhat.com>
References: <20240818194216.299176-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 56c7cf63942d  rteval: Allow arguments specific to module group

intended to allow group options to the overall measurement modules without
applying to the load modules. It inadvertently disabled options for most
load modules such as hackbench and kcompile.

This patch reworks the overall group mechanism a little bit to restore
these menus.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/modules/__init__.py             | 22 +++++++++++++++++-----
 rteval/modules/measurement/__init__.py | 12 +-----------
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index acd6330788e2..eb29db86ce7a 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -280,10 +280,24 @@ reference from the first import"""
 
         grparser = parser.add_argument_group(f"Group Options for {self.__modtype} modules")
         grparser.add_argument(f'--{self.__modtype}-cpulist',
-                            dest=f'{self.__modtype}___cpulist', action='store', default="",
+                            dest=f'{self.__modtype}___cpulist', action='store',
+                            default="",
                             help=f'CPU list where {self.__modtype} modules will run',
                             metavar='CPULIST')
 
+        # Set up options for measurement modules only
+        if self.__modtype == 'measurement':
+            grparser.add_argument(f'--{self.__modtype}-run-on-isolcpus',
+                                  dest = f'{self.__modtype}___run_on_isolcpus',
+                                  action = "store_true",
+                                  default = config.GetSection("measurement").setdefault("run-on-isolcpus", "false").lower() == "true",
+                                  help = "Include isolated CPUs in default cpulist")
+            grparser.add_argument('--idle-set',
+                                  dest='measurement___idlestate',
+                                  metavar='IDLESTATE',
+                                  default=None,
+                                  help='Idle state depth to set on cpus running measurement modules')
+
         for (modname, mod) in list(self.__modsloaded.items()):
             opts = mod.ModuleParameters()
             if len(opts) == 0:
@@ -296,7 +310,7 @@ reference from the first import"""
                 # Ignore if a section is not found
                 cfg = None
 
-            modgrparser = parser.add_argument_group(f"Options for the {shortmod} module")
+            grparser = parser.add_argument_group(f"Options for the {shortmod} module")
             for (o, s) in list(opts.items()):
                 descr = 'descr' in s and s['descr'] or ""
                 metavar = 'metavar' in s and s['metavar'] or None
@@ -311,7 +325,7 @@ reference from the first import"""
                     default = 'default' in s and s['default'] or None
 
 
-                modgrparser.add_argument(f'--{shortmod}-{o}',
+                grparser.add_argument(f'--{shortmod}-{o}',
                                          dest=f"{shortmod}___{o}",
                                          action='store',
                                          help='%s%s' % (descr,
@@ -319,8 +333,6 @@ reference from the first import"""
                                          default=default,
                                          metavar=metavar)
 
-            return grparser
-
 
     def InstantiateModule(self, modname, modcfg, modroot=None):
         """Imports a module and instantiates an object from the modules create() function.
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 9314d1cb6bbc..44708ce0b035 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -29,17 +29,7 @@ class MeasurementModules(RtEvalModules):
 
     def SetupModuleOptions(self, parser):
         "Sets up all the measurement modules' parameters for the option parser"
-        grparser = super().SetupModuleOptions(parser)
-
-        # Set up options specific for measurement module group
-        grparser.add_argument("--measurement-run-on-isolcpus",
-                              dest="measurement___run_on_isolcpus",
-                              action="store_true",
-                              default=self._cfg.GetSection("measurement").setdefault("run-on-isolcpus", "false").lower()
-                                      == "true",
-                              help="Include isolated CPUs in default cpulist")
-        grparser.add_argument('--idle-set', dest='measurement___idlestate', metavar='IDLESTATE',
-                        default=None, help='Idle state depth to set on cpus running measurement modules')
+        super().SetupModuleOptions(parser)
 
 
     def Setup(self, modparams):
-- 
2.46.0

