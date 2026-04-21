Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8281C364EB1
	for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796017; cv=none; b=A6Hhs7LrRJeQmuuiPFNGW5rOPlKwOGFeCsKLHeskYbhp4goChQeCkId+47hu0kXqwdIJfU5tGaMf5d9GX+yIoek6jOBFfPhdLsh2m7gc6a7Qlor23eaJcKcEZQxv0KpBVX56O81kvqeJZmXSfYZEmocpM0A+TV4pbJ4b8KTgep8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796017; c=relaxed/simple;
	bh=Rm7LgPmCLKClpmgBs1QR2SqlcgQgCIdlgJNKZzW+I00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pW0/OS8w+tgQFwkqUcYHDy84fycAZTLuoBdhAjPqQx0l0JBRLf6Z36L+Nq+fTUwzNx6NCaNa3Uua0Mez+uJ4CrT7G6GjL6/+1eIqe9v235ND4UeagbSRXiyeW1MuWIN4fFMR71bQ02kMOcpXxnruGcVffL9vsx0+TQEH4YpLkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBV/iGp1; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBV/iGp1"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cfc2d1fdbfso333396085a.3
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Apr 2026 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776796003; x=1777400803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23/+ihUkCAzvBfxF7gEb4x/3MLs8Hs1eElLGHiib5/U=;
        b=dBV/iGp15dHF/3OdHpue6RRh9ch232jPoO5/J/+DX8vKlbmONH6hrKlNQXDAPkXmQz
         pyTYoAEQHL5/JQX2BZ4df6kw++8R0YfX7ve2HxfVG+hEjYk0dfkhbWp7ctGW0isE3jvZ
         n0bVw0z4VkV0Wb9DTTop8gZqKnR9kNnppKSiy98iBrTm1mV3XrsW8YBecYj6+dhMy4PQ
         kfUAX95oVbq4I/ueuryMx130op+3+4epxSDLyw2iool9xndxn9XvZYPZI4AQhZrlWe5R
         bttlOwLOhH5/uH2/X1EGrPqIfG+wB9gPJ86kpQfZNtayZa7yVjnpo+ZDKb3BYzOLrkih
         uAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776796003; x=1777400803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23/+ihUkCAzvBfxF7gEb4x/3MLs8Hs1eElLGHiib5/U=;
        b=Np3M5lV7bYJ+B3QoyBL5dt1XrV/9//g/25oybl9IbY51Xekpx3qdD+8AqelgXsNw04
         xdHZzt+fCPryLKjRDJqUYMO7HsT5FpjB3x87sVBeL0HZAiRfhpgnEmz48FMl8n+/ERRN
         Gf3EqXZCTp5P5EuX4mCIoKJxlneCBbU/t+Ti706oKwwLmZUh8rm0Tr5bGh++d0DQ8ved
         PLWLqVumCug0ogfeFrms1J4TDEKXjLdp7G6ufkedR2xdPFMcJBTpLSV+p5yneH8a6fuv
         rnBnsy/atYmqExGf6vRS0Pcsd+5FqV1jQPI9KYc9JheA3NDj77GI7v0d4GaHIlQhWWjS
         fzqQ==
X-Gm-Message-State: AOJu0Yw5RP8IqQ0gqinyA0WX8qLWI/tJ0xNr1FTmFt6BBVFlEoDUVV+k
	KqcoJ1aaN8XJl55IKlWYpPnTQvzg17L3vp33fWsOxVE5CXB8ufWv7cic/3lXaQ==
X-Gm-Gg: AeBDiesUEhf7ec9IioZZ5rS02QLKjAaxGqHD9BEuvXaI6daePLS/5QeKj04QrUocY85
	6kRrn1mAFIZ1cWQhYCEm27PKDwTuPKq97VkXVzOvF0sO9ZyHJKL02vopk0Z0LpIhFiyXkHdOC86
	kekWNuuN28VzeOvZXOYfQsTCXuY6+giqCilXAcZ9UIPEWH3l+oNQfzLe138g4Uce+e0zq+y9A/o
	xm7BX3M3hOXKuOJDy2V8f6fg6YeUsgZLmLRxoRkpm8QcaTUpTxr3H45yBLeFRYGQegEXwql6R1t
	tmrfB4ZQkOqGFJabHOzs8uOd0moPI7n1oUK3dkOCQnfTAzLfZn/V1heLMRHZ2wPsNt7zWLrDkJ4
	iU7XTF0vIFhKGmUf+MIzytgPHJ1JCU5bTArc6sQ2tHkXcvbh+d/IbvpLb3aK9UPofQOKXZtuWjY
	35ad1oTY2k/oooFVQNOx51UazpEwLttG9SGI6/tLzu15Li7oVUGbnx5dsXwvGZUKbrWhagLTW5r
	w9AJq69lUVmUzUjojGW3B/GMqawHmbWUa9IhALiKwurwODeRVT9pKl0/vQyuRRA4+G14X9x8VJ0
	ReBxeldMnBz2XF7e5uo=
X-Received: by 2002:a05:620a:40c1:b0:8c6:d309:f9c0 with SMTP id af79cd13be357-8e78f72ff79mr2518607985a.8.1776796003073;
        Tue, 21 Apr 2026 11:26:43 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d64caf37sm1112713685a.11.2026.04.21.11.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 11:26:41 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 7/7] rteval: Include --warn-non-isolated-core-sharing warnings in XML report
Date: Tue, 21 Apr 2026 14:26:18 -0400
Message-ID: <20260421182618.261347-8-jkacur@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421182618.261347-1-jkacur@redhat.com>
References: <20260421182618.261347-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the add_core_sharing_warnings() method to accept the warn_non_isolated
parameter and pass it through to validate_core_sharing(). This ensures that
warnings generated by the --warn-non-isolated-core-sharing flag are included
in the XML report's CoreSharingWarnings section.

Previously, the flag only affected console warnings. Now the warnings are
also preserved in the XML report and will appear in text reports generated
with -Z option, since the XSLT stylesheet already displays any warnings
found in the CoreSharingWarnings section.

Changes:
- rteval/sysinfo/cputopology.py: Add warn_non_isolated parameter to
  add_core_sharing_warnings() and pass it to validate_core_sharing()
- rteval-cmd: Pass cmd_opts.rteval___warn_non_isolated_core_sharing to
  add_core_sharing_warnings() when adding warnings to XML

This completes the --warn-non-isolated-core-sharing feature by ensuring
warnings appear in console output, XML reports, and text summaries.

Assisted-by: Claude Sonnet 4.5 <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd                    | 3 ++-
 rteval/sysinfo/cputopology.py | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 3180e1a7857a..f730d3177290 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -494,7 +494,8 @@ if __name__ == '__main__':
         rteval = RtEval(config, loadmods, measuremods, logger)
 
         # Add core sharing warnings to the XML report now that CPU lists are finalized
-        rteval._sysinfo.add_core_sharing_warnings(housekeeping_cpus, msrcfg_cpus, ldcfg_cpus)
+        rteval._sysinfo.add_core_sharing_warnings(housekeeping_cpus, msrcfg_cpus, ldcfg_cpus,
+                                                  cmd_opts.rteval___warn_non_isolated_core_sharing)
 
         rteval.Prepare(rtevcfg.onlyload)
 
diff --git a/rteval/sysinfo/cputopology.py b/rteval/sysinfo/cputopology.py
index a21c19179f28..f650eca8db8d 100644
--- a/rteval/sysinfo/cputopology.py
+++ b/rteval/sysinfo/cputopology.py
@@ -94,7 +94,7 @@ class CPUtopology:
         return self.__cputop_n
 
 
-    def add_core_sharing_warnings(self, housekeeping_cpus, measurement_cpus, load_cpus):
+    def add_core_sharing_warnings(self, housekeeping_cpus, measurement_cpus, load_cpus, warn_non_isolated=False):
         """
         Add core sharing warnings to the CPUtopology XML node.
         Should be called after CPU lists are finalized.
@@ -102,6 +102,7 @@ class CPUtopology:
         :param housekeeping_cpus: List of housekeeping CPU integers
         :param measurement_cpus: List of measurement CPU integers
         :param load_cpus: List of load CPU integers
+        :param warn_non_isolated: If True, also warn about measurement vs load sharing even when neither is isolated
         """
         if self.__cputop_n is None:
             return
@@ -118,7 +119,8 @@ class CPUtopology:
         warnings = validate_core_sharing(
             housekeeping_cpus or [],
             measurement_cpus or [],
-            load_cpus or []
+            load_cpus or [],
+            warn_non_isolated
         )
 
         # Add warnings to XML if any were found
-- 
2.53.0

