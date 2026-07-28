Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC13B39B944
	for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258388; cv=none; b=jCuOQyLPKMBOwY0CdcNqg3skBk+6Shg1kZkx9qslbjgZr1HVRh0daPcfoQ0HxC7LaHjQlBC06VyBactchDbiKE6wjFDlzWAkQqpT7hVmuL/xC/EagcHvlFPHYOxzN+j8efyRRUi9omqObEf0eARxikBO4yq3V+JS82tv8Q7Rcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258388; c=relaxed/simple;
	bh=6H4amsAC45o/hPBXc/pRQMXVrw3G9FAoo7V8y/ElwHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OI9oOEgGc8E053ogHhvXVqCWPkGyil88UieHN9vkvd0h0ageW2T4m2chOtuVW7CPnioRgnhHq59VE1nIJjV1bOLNeJdJCmHPJrlKUNoUU2hcZDPvHA6cpQuECh7S0J0wGHGSnxRL+s5ebXKts2SXB0WagWJg5F8fxl2XnLdftLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KO200ROw; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO200ROw"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90004d2f7b7so276156d6.1
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jul 2026 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785258386; x=1785863186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r3rCfpSaa85tPcMzABTD49dmrnyOWresgxQr7DObYDQ=;
        b=KO200ROw7UwGCVOEkspzGXRsz5xoVh9PYcSek6SWXxDnp7PXj+L6wtCuO8j30BO6dC
         GrDIUdEZeTbzEls1aKy8nf/66PlhgDsq3Nug9i0n2XhLcXeSreTpfAT53ne0Czs686cG
         ycEBZyx4a3f+lKlRw1K8SHSTfS4swQmjcsWJjJCD5oUmCd9iY89DYtCl6/XDiyCoDF9I
         wXY26/ajR2YwadSjForySgjIsqUNXQ8aOQUu8/UpWGiVgmiBGXFELKfkytO/epaNd8pG
         ePHTWWcmSi5cx/9d9U2uizaYNHrnxEH/L9kNM18Mhei4FrVkcRN5oskj4rY5/sA42Y8d
         lSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785258386; x=1785863186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r3rCfpSaa85tPcMzABTD49dmrnyOWresgxQr7DObYDQ=;
        b=Ho7xBbHCtktE3U5rZtlimR6Rjhw1Q8DhJq15biiXYYGDwaxCMvEyqqFN56A0Mth2rM
         vfB1Lu4qQ6zTApkovv5AqlbEN0jg3Tvp3UVfXY8zHwHdfaU/p9T9PJujvnAq7j3DkjU5
         GtsZBRqCQOrwwwLZXZugsyK+xgl9hCFEgsshDSEKCiC44h4VwWjxNW2heQ1z5+jmIWbh
         KoTWKPGSq4D5ovlAoILLISCh3jp0PYKuR8CIe6hfA4FpizxVI1FN9SFU3IbbEjstgYEW
         b/wTSRmieNjLi+iozPG+g1uRJcaflbrLLpOyoKXVfi+6wYh5ndzd/8XHVpcJGe88cXj0
         ceNA==
X-Gm-Message-State: AOJu0YzNQjVpoif3eOiq0P82Pl3uCk7/N9PJ9J7VrYPEasgjQbo8pSgt
	3IOVcFkDpZAx99d+RXM/dqFazRMfzQ/WxtyXjovdTExJB/0O/Kere7EyruOshw==
X-Gm-Gg: AR+sD12w7xQ6nbJD40tM6OlzhO1rnIASRaQL7B/4MGIfr3c3S3AvjcgyR+ul/WfoOoR
	gzo+aF3oloT/hQKUrthk9CLC0dOupKx3i87tp1Vus+0w/0Lod77x4dQi5lJAYX5ghwuzbaulsnv
	OcBqoeAT0J3zfNTMUUNbShzdcUWGsbsNDqX9xAUYHO8a5JRLSnrhSbtL1dGO++EQN4MjgAslK6A
	4+YRIGmE62U5dO2XEBCjpGWF7Zh5CJeAaQMnKxRpfIl7gCptdyx1+X08lTwzvuaoo/TUFIPGQ3j
	hIhhg9xaPJujjZ2N0sLK5ttUSuKXfC+wU8RbJQsYpclv/RZScMRfGufUN4Y6TaaPyO/31oO3ean
	0UFbhXlCObvkkZgnevgC4hPHhrYj3F4kZ9W0fTtRh/5xHK79cbTmfibnSSr7txxqI9fSIxW22RU
	GR1MiUAO0oNTswdu7pWVrBJDSdf6X8WDfKLJLwhQvGiCqMiY0XAM9PiFNAN6RT0yhXthN6
X-Received: by 2002:ad4:5f45:0:b0:8e9:f5de:d618 with SMTP id 6a1803df08f44-90817354b3amr31998906d6.55.1785258385653;
        Tue, 28 Jul 2026 10:06:25 -0700 (PDT)
Received: from Cumhall.redhat.com ([174.95.68.136])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd3aac2sm3229676d6.30.2026.07.28.10.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:06:25 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: Clark Williams <williams@redhat.com>
Subject: [PATCH 3/5] tuna: Update man page for cpuset save/apply and recent changes
Date: Tue, 28 Jul 2026 13:06:05 -0400
Message-ID: <20260728170607.176811-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728170607.176811-1-jkacur@redhat.com>
References: <20260728170607.176811-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update documentation to reflect recent cpuset enhancements:

- Add cpuset save and apply subcommands to the command list
- Document cpuset save with context-aware default paths
- Document cpuset apply with verbose option
- Update cpuset destroy to accept multiple names
- Fix housekeeping cpuset default: partition=member (was partition=isolated)
- Update isolate example to clarify partition types
- Add usage examples for save/apply commands

The context-aware paths are documented: ./cpuset-profile.yaml for
development (tuna-cmd.py) and /etc/tuna/cpuset-profile.yaml for
production (tuna).

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 docs/tuna.8 | 52 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/docs/tuna.8 b/docs/tuna.8
index 8d43c3ac73c8..7920ddfa7232 100644
--- a/docs/tuna.8
+++ b/docs/tuna.8
@@ -64,7 +64,7 @@ optional arguments:
                         partition=isolated)
   --cpuset-housekeeping [NAME] CPU-LIST
                         Create housekeeping cpuset: [NAME] CPU-LIST (default name:
-                        tuna_housekeeping, partition=isolated)
+                        tuna_housekeeping, partition=member)
 .TP
 \fBtuna include\fR
 usage: tuna-cmd.py include [-h] (-c CPU-LIST | -S CPU-SOCKET-LIST | -N)
@@ -288,12 +288,12 @@ optional arguments:
   -K, --no_kthreads     Operations will not affect kernel threads
 .TP
 \fB tuna cpuset\fR
-usage: tuna-cmd.py cpuset [-h] {create,list,destroy,move,show,status,modify}
+usage: tuna-cmd.py cpuset [-h] {create,list,destroy,move,show,status,modify,save,apply}
 
 Manage CPU sets (cgroup v2). Cpusets provide fine-grained control over which CPUs processes can run on, with NUMA-aware memory node assignment and kernel-enforced isolation.
 
 subcommands:
-  {create,list,destroy,move,show,status,modify}
+  {create,list,destroy,move,show,status,modify,save,apply}
 
 .B tuna cpuset create
 usage: tuna-cmd.py cpuset create [-h] -c CPU-LIST [-n NAME] [-i]
@@ -327,13 +327,14 @@ optional arguments:
   --no-recursive        Only search top-level cpusets
 
 .B tuna cpuset destroy
-usage: tuna-cmd.py cpuset destroy [-h] [NAME] [-p PATTERN] [-f]
+usage: tuna-cmd.py cpuset destroy [-h] [-p PATTERN] [-f]
                                   [--include-empty] [--no-recursive]
+                                  [NAME ...]
 
-Destroy cpuset(s). Use either NAME or --pattern, not both.
+Destroy cpuset(s)
 
 positional arguments:
-  NAME                  Cpuset name to destroy (use this OR --pattern)
+  NAME                  Cpuset name(s) to destroy (one or more, OR use --pattern)
 
 optional arguments:
   -h, --help            show this help message and exit
@@ -404,6 +405,33 @@ optional arguments:
   --isolated            Set CPU partition to isolated
   --no-isolated         Set CPU partition to member (not isolated)
 
+.B tuna cpuset save
+usage: tuna-cmd.py cpuset save [-h] [filename]
+
+Save cpuset configuration to YAML profile
+
+positional arguments:
+  filename    Output YAML file. Default path depends on execution context:
+              ./cpuset-profile.yaml when running from development (tuna-cmd.py)
+              /etc/tuna/cpuset-profile.yaml when running from production (tuna)
+
+optional arguments:
+  -h, --help  show this help message and exit
+
+.B tuna cpuset apply
+usage: tuna-cmd.py cpuset apply [-h] [-v] [filename]
+
+Apply cpuset configuration from YAML profile
+
+positional arguments:
+  filename       Input YAML file. Default path depends on execution context:
+                 ./cpuset-profile.yaml when running from development (tuna-cmd.py)
+                 /etc/tuna/cpuset-profile.yaml when running from production (tuna)
+
+optional arguments:
+  -h, --help     show this help message and exit
+  -v, --verbose  Print detailed progress messages
+
 .IP \fIModifiers\fR
 .TP
 \fB\-c\fR, \fB\-\-cpus\fR=\fICPU\-LIST\fR
@@ -444,7 +472,7 @@ Isolate CPUs using cpusets (more powerful than traditional affinity):
 .TP
 .B tuna isolate -c 4-7 --cpuset my_isolated --cpuset-housekeeping my_hk 0-3
 
-Isolate CPUs 4-7 by creating 'my_isolated' cpuset with kernel-enforced exclusivity, and move all existing processes to 'my_hk' cpuset on CPUs 0-3. Both cpusets use partition=isolated for kernel enforcement.
+Isolate CPUs 4-7 by creating 'my_isolated' cpuset with kernel-enforced exclusivity (partition=isolated), and move all existing processes to 'my_hk' cpuset on CPUs 0-3 (partition=member).
 
 .TP
 .B tuna move --cpuset rt_workload -t 'kworker/*'
@@ -465,3 +493,13 @@ Add CPUs 6-7 to the rt_workload cpuset without disrupting running processes.
 .B tuna cpuset status
 
 Display system-wide overview of all cpusets with statistics.
+
+.TP
+.B tuna cpuset save /etc/tuna/my-rt-config.yaml
+
+Save current cpuset configuration to a YAML profile. When running the installed version (tuna), the default path is /etc/tuna/cpuset-profile.yaml. When running from development (tuna-cmd.py), it defaults to ./cpuset-profile.yaml in the current directory.
+
+.TP
+.B tuna cpuset apply /etc/tuna/my-rt-config.yaml
+
+Apply a previously saved cpuset configuration from a YAML profile. This recreates all cpusets defined in the profile with their CPU assignments, memory nodes, and partition settings.
-- 
2.55.0

