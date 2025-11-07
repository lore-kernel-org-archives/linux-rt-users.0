Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B913F33B6CF
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540044; cv=none; b=gVxBmF4Qu7MiuPZ+wjPEBzRafFjkoBUx6SFdU8gANHiDaZ+ms+6uQI7GkwRaxqVNvLN4lIRAFrIKhdI+WMdQMBUDTmMxvelc7N/Zq29K5HqVdV92YS1+l/34W3mmuErb1IT1/+Bpft2uvtZ/EIGFwqEQS0I5ms+hKJyn72sWfck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540044; c=relaxed/simple;
	bh=9r+QDEV2hxgiQOzUsqwm/2k5zlGN1g9uDfmaWkrFZF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8z0Yl+uD/RKfqHL27JvPwApPbC+DW/l3FFCZUwTXNO2iLIoi9sr/3KgTsAdnOcgawKLhvxpZCVazmi1kzdX9y20SvwDXdZtSSXkm1QODZy0rDz3p0wrBZVJkn3nsmpLXd7CKkkhf2XAPcDYVK+PqEpe8zYRa5Ek3yMnG5yQFsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRaBqR6w; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRaBqR6w"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8a3eac7ca30so74300385a.2
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540040; x=1763144840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3geg2KN4mkG/sxnlQKf2jvI6PetSKEcyTdp1jeeF2vs=;
        b=eRaBqR6w06Sao4s8FU6yW9vsToyVpEQE+OgTxXJMpbe0sn9yMLdbpK3E/olrvl2O3/
         oWp91ue6QyhuOsBn7NPkoJ2mTTaFQcne4A9n7yQkC8rpXd4kcwavihnXdM6wostCx257
         tMzT2N2g2wCCNk/+WiU5XBELmh8hppAxNA/GIa7ZHEHiDrv8UT1NzM0a7Eelwz4X5H7C
         xz4QODpRlRYpQDsj7an1ZYSeRtcnIZOlkugkeEzrYOEz2paRLGLZ8QId5X/Hbw2CK6uo
         6Nw75X/TbusdUo/VThxhVMi3Gvkzkd1lDF9QNbjPLACVUVqYy4yK7YQ1hdvuD11bxOgp
         F7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540040; x=1763144840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3geg2KN4mkG/sxnlQKf2jvI6PetSKEcyTdp1jeeF2vs=;
        b=khV2QCRl/XfLtD4s9+XwhG+4260s6hnczpqo3ymDL79sgYaDaIDkz6mZfTfd4GOe6D
         faKdU3BJaTJgx6UQZdgLOKSg/1klirjC4XvziJneklVE9yxt3ZvhskPQPU5/OOWHHsBk
         DeIjxa+xPLBhEI7VIUv3a54zQnCbyHpN+VAwCS++VG9A7VoSE+/AE6OIuju62LKlu8ki
         ES1+FQHW+6SOQMKtfjy2RYnARymdjVRmoKPtrLhfHtI+r35M42/3ZI4GkzHA80oNXFZT
         /x1kXUAbwTKEeVHY0pExSSgOsGc2s/Zk5Enn/3rH46xX0GD4svWagc5PLLMR9eHd2yHr
         8gnA==
X-Gm-Message-State: AOJu0YzNKM0bQ5eG/rhG2YXSTbOKZ3DXLXXpTxdTshTUzi8H3iM5kvmm
	dimYO3ovGDOx8fwVpLXoq6vUNsiOUdj+V8D++WnS2LyP4QisKaAHP1RPSi37kr9b
X-Gm-Gg: ASbGncs2WhXE5hPsqp+QOg92P7/ScXZ1Vp40h5WLOIAK1bWfMeNggFqgVgFjhoEqjLy
	0PrHMfr1CqRbvk5a7k8sM3a7w+zEUVw2Weo+LJsvZcceVHCPdahAqWHrRkwu0S9T2RR0A2m9bZO
	tdJ+qlsEGZicHAi1HKIcpiH8sZ3/tpgwmijxK1SyA7rg1nNIkOdf2pPu4EO/Vgf41OKayfkjcul
	UoCdGcMDqUYhQQgD0V7Io6WBign1i6lyk+KyBik+6ts7cNzzKDl5ud7DZ3UaKtIkziN8PjLUM8+
	uHY2w7gUxSPLdy2Ax/5PLxk3O7FmZXYE91n1avYost54Jn+iBtxMa00eG6f8ixCJH1DbFQlpKZO
	eYj4hzQNQIr4XxysbJDm3yqqCarZ2cdMPXOi38C1IerNWXbQ+6NjU6mr72cOKOSw=
X-Google-Smtp-Source: AGHT+IErEZ6zaQqwkhRK7rDYBj7Oh6pDocKOZmMbJD9PRSCgo2qRICGbsMcZuHk1cHHcS8yyQsci+g==
X-Received: by 2002:a05:620a:4887:b0:89e:72fa:ba7f with SMTP id af79cd13be357-8b257f5158dmr31660485a.46.1762540040316;
        Fri, 07 Nov 2025 10:27:20 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:19 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 11/12] rteval: Add --measurement-module command-line argument
Date: Fri,  7 Nov 2025 13:26:34 -0500
Message-ID: <20251107182645.19545-12-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107182645.19545-1-jkacur@redhat.com>
References: <20251107182645.19545-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new command-line argument to select between cyclictest and
timerlat measurement modules, overriding the config file setting.

The argument is part of the "Group Options for measurement modules"
in the argument parser, making it consistent with other measurement
options like --measurement-cpulist and --measurement-run-on-isolcpus.

Usage:
  rteval --measurement-module cyclictest
  rteval --measurement-module timerlat

Implementation details:
- Added --measurement-module to measurement argument group in
  rteval/modules/__init__.py (SetupModuleOptions)
- Added early argument parsing in rteval-cmd to apply the override
  before modules are loaded
- The selected module is enabled while the other is disabled
- Fixed module loading to handle None values when modules are disabled

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                             | 18 ++++++++++++++++++
 rteval/modules/__init__.py             |  7 +++++++
 rteval/modules/measurement/__init__.py |  2 +-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/rteval-cmd b/rteval-cmd
index 00873ce1196b..855934e42192 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -223,6 +223,24 @@ if __name__ == '__main__':
                 'cyclictest' : 'module',
                 'sysstat' : 'module'})
 
+        # Check for --measurement-module argument early to override config file
+        measurement_parser = argparse.ArgumentParser(add_help=False)
+        measurement_parser.add_argument('--measurement-module', dest='measurement_module',
+                                        type=str, choices=['cyclictest', 'timerlat'])
+        early_args, _ = measurement_parser.parse_known_args()
+
+        if early_args.measurement_module:
+            # Override measurement config based on command-line argument
+            msrcfg = config.GetSection('measurement')
+            # Disable both cyclictest and timerlat first
+            if 'cyclictest' in msrcfg:
+                msrcfg.cyclictest = None
+            if 'timerlat' in msrcfg:
+                msrcfg.timerlat = None
+            # Enable the selected measurement module
+            setattr(msrcfg, early_args.measurement_module, 'module')
+            logger.log(Log.INFO, f"Using measurement module: {early_args.measurement_module} (from command line)")
+
         # Prepare log levels before loading modules, not to have unwanted log messages
         # Use a minimal parser to extract logging-related flags early
         rtevcfg = config.GetSection('rteval')
diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index d60877783670..7e5916c52965 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -303,6 +303,13 @@ reference from the first import"""
                                   metavar='IDLESTATE',
                                   default=None,
                                   help='Idle state depth to set on cpus running measurement modules')
+            grparser.add_argument('--measurement-module',
+                                  dest='measurement___measurement_module',
+                                  type=str,
+                                  choices=['cyclictest', 'timerlat'],
+                                  metavar='MODULE',
+                                  default=None,
+                                  help='Select measurement module: cyclictest or timerlat (overrides config file)')
 
         for (modname, mod) in list(self.__modsloaded.items()):
             opts = mod.ModuleParameters()
diff --git a/rteval/modules/measurement/__init__.py b/rteval/modules/measurement/__init__.py
index 44708ce0b035..e09dca683dbf 100644
--- a/rteval/modules/measurement/__init__.py
+++ b/rteval/modules/measurement/__init__.py
@@ -24,7 +24,7 @@ class MeasurementModules(RtEvalModules):
         for m in modcfg:
             # hope to eventually have different kinds but module is only on
             # for now (jcw)
-            if m[1].lower() == 'module':
+            if m[1] and m[1].lower() == 'module':
                 self._LoadModule(m[0])
 
     def SetupModuleOptions(self, parser):
-- 
2.51.1

