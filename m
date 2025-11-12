Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7803F21D3E8
	for <linux-rt-users@vger.kernel.org>; Wed, 12 Nov 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969732; cv=none; b=uar9/EEXQfQuly934CJ60jRm0nNj5NAmEaHr20kfQsr9ALKvprTQYneIvvbLKePSw3FkpuwjBvCTGWbNUM/YKdEIYoL0FrsjO3FSSex0Et89gmILhh1CvxgqZU0+kNxJYmnH5jOUm2JUNiXT1ya8Ks7J28JaeWV8KibbVm+UfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969732; c=relaxed/simple;
	bh=+MAzbTsTnt57wq5Olighe6mvSb1vFUZ7UYOq+pcv30E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVa/TJm/usDJZrd2mEkC4bGmy7x/0A8sAtY6Ep+jq/Zl7qUMnBTfYYr4ejKXrpYIFA33BQDSZnYsDJpIJGySINWGnHVnyfFUnXbMP5wslmeQx5OiNbASjiSjOi+E9dFmJEyxXz9rfCaVHv6VUz5nCwEid2RB/WSLS1WeKQmOeQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSTKjbVG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSTKjbVG"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8b272a4ca78so155511385a.1
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Nov 2025 09:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762969728; x=1763574528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+Mwc+YGplprlFDPJV/wUjejpyAMh5hlsp5sGhJFtnjc=;
        b=mSTKjbVGQW84JE4VEPTx6TLyk4NzzDWp+On26xxgkRoiW4MI+MPiQnwuW2Jz+bamuf
         dLRjjAfUH2Db711Nz6VxUVQeN1n5KRYVW18FXbXPICW26TwFjbmnXhJfmM0OhPiWlQXI
         T6ZKN0TykBdhdA0FtIGUECt4VZ0c9k79E75jvOSd3CW3ZMLY9i3HVKShZzc813aHFnYA
         7G3pW8UKYNwsYwBWhKsjcqwY29wnVMDpZfT0pa/Xr4yZdzUgHykDwikNHpdmg5TSpvrX
         0l78PwtH80W8IYApm316NtHmEHmecv5ueESZeK/XbHWfzhJf6X51q57hh1mgD3XToNhc
         KQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762969728; x=1763574528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Mwc+YGplprlFDPJV/wUjejpyAMh5hlsp5sGhJFtnjc=;
        b=man5W4gh8QOiH3aMkQkh4Zk27SW/9OUOgFqzi3SoZX72k2vTpUecV/gE93YgDKy++h
         7xjhJb4nXL2cCU/j3V+lRRWH4MUbOrGW4Ws0QhEClc4xrq9XeJx36/PlFULQCwJTmPnC
         P+9xUy+YsAW8ZmY41MXOcRPqxOnyHNccV+hwNHHtBtDmbEtMddZ3OODWSg8R3v1rQNiK
         wzCAs/Ga9XlHlbCRLUY7Errxv2LlmTIVh/K7LLmYMK0ga2bz7MsXNtkxAQ6RDzLo3H2t
         5LRH8Ok1hJMpbGEMwOnSGUKk7h3c+Nbbg6jbLowCv0JcFCGks5T97NcMnagjhAD2FqA5
         zEFA==
X-Gm-Message-State: AOJu0Ywn6slZWBDdxUVdmqylZi8+B8Njp2RKJDj8M3T0nXR+WNzVtiPS
	jP/ICnnArAeAxsr4PmUYFgY/QzKanvKzH02IIs3PDFrBDOWld1USr4L2jcnkuxfh
X-Gm-Gg: ASbGncuj4X1cD51HfwHEpUYwHTuh9IhXx0FBiJ3Vnr2mZfMI91Z8MIfyZiGvRwaoKLk
	taGvS/cjHVfAiGeJD0/3zm6E+OWwwgiuWekDcec9kpxGfKaBAhmZI43JV4+gX9mcUxNbvnuEbKj
	jypg++7jR2gNjr1KfDq4oUvgZnJZ+0nSTFjj6KJ9HBcTOOeW3O13rALV7A7aH/7IhC9pnr+Eda0
	cXci82X9H3yQgY2Y4+D4HCooi6EQLue+VK8mRI9Bksc7jbY21FBk16bEvsUwKvYOIYl3sTFL0J8
	hmHwb+5d6b5NnT67A+I09X7U40qXtuyhHvtQYc50DeVZMGnAkUzFHs556o87go/VwJ2i0SYUZ96
	2uyZjA8PBhJ34hEDxDQCyVtKOBWCAuf/h5gh6L4xiqIENLiC+IJzaS2HF3GVncVc=
X-Google-Smtp-Source: AGHT+IHT30OIGL0lRoejcqQdT8QCY4ZkhL4mQ/FZBHH7SsrSkgz4SqL7SFLBMebCyju7YNvJqfP5sA==
X-Received: by 2002:a05:620a:178a:b0:84a:5f9d:a30c with SMTP id af79cd13be357-8b29b7df49dmr530110585a.63.1762969728585;
        Wed, 12 Nov 2025 09:48:48 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a9e3f09sm233619285a.36.2025.11.12.09.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 09:48:48 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 1/2] rteval: Show both cyclictest and timerlat options in help menu
Date: Wed, 12 Nov 2025 12:48:34 -0500
Message-ID: <20251112174835.188210-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, running './rteval-cmd -h' would only show options for one
measurement module (either cyclictest or timerlat), depending on which
was selected. This made it difficult for users to discover all available
options.

This commit modifies the module loading logic to:

1. Load both cyclictest and timerlat modules for help generation,
   ensuring all options are visible in the help menu

2. Determine which module should actually run based on:
   - Command-line argument (--measurement-module) takes precedence
   - Config file setting if no command-line override
   - Default to timerlat if neither is specified

3. After help is generated and arguments are parsed, disable the
   non-selected measurement module so only the chosen one runs

Additionally, changed the default measurement module from cyclictest
to timerlat when no config file exists.

Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd | 56 ++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 855934e42192..45d9f3a58a11 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -220,7 +220,7 @@ if __name__ == '__main__':
 
         if not config.HasSection('measurement'):
             config.AppendConfig('measurement', {
-                'cyclictest' : 'module',
+                'timerlat' : 'module',
                 'sysstat' : 'module'})
 
         # Check for --measurement-module argument early to override config file
@@ -229,17 +229,35 @@ if __name__ == '__main__':
                                         type=str, choices=['cyclictest', 'timerlat'])
         early_args, _ = measurement_parser.parse_known_args()
 
+        # For help generation, we want to load both cyclictest and timerlat modules
+        # so users can see all available options regardless of which one is selected
+        msrcfg = config.GetSection('measurement')
+
+        # Determine which module should actually run before we load both for help
+        selected_measurement_module = None
         if early_args.measurement_module:
-            # Override measurement config based on command-line argument
-            msrcfg = config.GetSection('measurement')
-            # Disable both cyclictest and timerlat first
-            if 'cyclictest' in msrcfg:
-                msrcfg.cyclictest = None
-            if 'timerlat' in msrcfg:
-                msrcfg.timerlat = None
-            # Enable the selected measurement module
-            setattr(msrcfg, early_args.measurement_module, 'module')
-            logger.log(Log.INFO, f"Using measurement module: {early_args.measurement_module} (from command line)")
+            # Command-line argument takes precedence
+            selected_measurement_module = early_args.measurement_module
+            logger.log(Log.INFO, f"Using measurement module: {selected_measurement_module} (from command line)")
+        else:
+            # Check config file to see what's configured
+            cyclictest_in_config = hasattr(msrcfg, 'cyclictest') and msrcfg.cyclictest == 'module'
+            timerlat_in_config = hasattr(msrcfg, 'timerlat') and msrcfg.timerlat == 'module'
+
+            if cyclictest_in_config and not timerlat_in_config:
+                selected_measurement_module = 'cyclictest'
+            elif timerlat_in_config and not cyclictest_in_config:
+                selected_measurement_module = 'timerlat'
+            elif cyclictest_in_config and timerlat_in_config:
+                # Both in config - prefer timerlat as default
+                selected_measurement_module = 'timerlat'
+            else:
+                # Neither in config - default to timerlat
+                selected_measurement_module = 'timerlat'
+
+        # Now ensure both modules are loaded for option display
+        msrcfg.cyclictest = 'module'
+        msrcfg.timerlat = 'module'
 
         # Prepare log levels before loading modules, not to have unwanted log messages
         # Use a minimal parser to extract logging-related flags early
@@ -267,7 +285,7 @@ if __name__ == '__main__':
         if early_args.idle_set:
             rtevcfg.update({'usingCpupower': True})
 
-        # Load modules
+        # Load modules (both cyclictest and timerlat are loaded for help display)
         loadmods = LoadModules(config, logger=logger)
         measuremods = MeasurementModules(config, logger=logger)
 
@@ -277,6 +295,20 @@ if __name__ == '__main__':
         measuremods.SetupModuleOptions(parser)
         cmd_opts = parse_options(config, parser, sys.argv[1:])
 
+        # After parsing options, disable the measurement module that won't be used
+        # This must be done after option parsing so both modules' options appear in help
+        msrcfg = config.GetSection('measurement')
+        if hasattr(cmd_opts, 'measurement___measurement_module') and cmd_opts.measurement___measurement_module:
+            selected_measurement_module = cmd_opts.measurement___measurement_module
+
+        # Disable the non-selected measurement module
+        if selected_measurement_module == 'timerlat':
+            if hasattr(msrcfg, 'cyclictest'):
+                msrcfg.cyclictest = None
+        elif selected_measurement_module == 'cyclictest':
+            if hasattr(msrcfg, 'timerlat'):
+                msrcfg.timerlat = None
+
         if rtevcfg.noload:
             if rtevcfg.onlyload:
                 # Make up your mind!
-- 
2.51.1

