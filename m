Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA7E36D9EC
	for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 19:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777577534; cv=none; b=SRAOXxdaqP0Bwla/anGMzkdGAEh1qd//cdMGY/ULA4Xrj+O9shiNEPeuKpPwcd9zTxp8/ULbTO2j692fMmXqBVgYM+om/uyuGsD2kcL13WwdiElclc8X3+zDePZd5ek9kRBLbmF+la7/GGcU+Y6Pmv6gi/qIIFqT9VLmftQGtbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777577534; c=relaxed/simple;
	bh=zTupllgki5xysc9e5fqZ2k6OYNYdIAH3QPtciR1MrMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCICzH4ze4pOqZWro/pukadRRchM96xan9n295ZaLXXLdWPkBy7dk/B4Ao35G7Jku1R8nB+5ACxjLCZkdgCgcNS97DOKZ9ItT/XaE6TqptSUQTdXm2W25sZocWv+B1Qui8UbmNm3Et+RqyvjXGBTRUyHnNakz75ZiYR7UTKQb9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMe9zzQG; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMe9zzQG"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50faf8ed9c5so6203601cf.2
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Apr 2026 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777577531; x=1778182331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHMMcY2eIU7Tryx+/i0UgQIVs2XDcG7EYkYflJT2g4A=;
        b=XMe9zzQGa0EoxaQHGmO3zp/FLctWzA1IwZqWLHpBt3sgmjTgJ4cctVr3hCl0gFd1Qt
         wyKSFQ9j5LyiyIUjljxKY2ezrL4tLB/lGCClDTaEhYf88TRW7yRVYoif4QUAMQ3O/V0d
         5Cg0fTNr0a1mS2Da/RbG72cuWTZigz5vzTlTtQYu2B5XYazVEixwk6pCQRKaqThfq/iJ
         mp78oahBK+9a3npBmwPV7RUST8trYL6fbMZrEb3TDXtRjuITJmXInuWSZ/itfvyvTHPL
         1gWOGN7smhaV4DlFGF7kDa9TO3F/xqQvABreCaZJLNsq0AXlzN1M1F8hcorFHIgnsxNm
         puFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777577531; x=1778182331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHMMcY2eIU7Tryx+/i0UgQIVs2XDcG7EYkYflJT2g4A=;
        b=T3rt4EvdLQZg8gjRjLHmXULS2uiHBAbzXZvthhx/gizxiIyNdn8XCryeP7Xru+P2Rs
         VV/Spf0bFUATJ50RJff71TsdFisChCAWYEtfcbA3dTc7w8eTQ462wX8cwmzOkq/Tj9JT
         2cF6W0GSk+9oHeChldoHlVH3u8e7spO4RWUb9KYVfudrMXrZ60sSBl+H42OJTF/VZ8yh
         IJ2rNzWulsv5xGSJmTbUNwoeWSU57cRFpjgOcalk6Gyy0T08GV3NPIWPWgOEjK0bcGSW
         bbuqlhMFR+osx1pT+Y0a3HGl+TsXjX10CetRSVO6XSRDANh3YO2+QRyTXuQuIW0lDndt
         sJSg==
X-Gm-Message-State: AOJu0YzlA3fZOmDXZVKGDWqXdydRECAz+p5FVPZiZC+B2/wmFsDV99ck
	Md6XbeIob28WMd6nDCBIQz9B5H+ItEpIM57qpkA1rd0apH9E9ZhYdNExYyAtSg==
X-Gm-Gg: AeBDievYUHmoai/mfi2eweCfKHZEFIWCczWjqBWwEknXD3+IJnLVdhyxZ1td2nlp7iC
	E3nH7u2DWj2jE8abw2f9/pVtDm1l+lse9LENUWSDKDXifR0G0V+7G1hAT74nG5onvdJGRNn7dko
	BQD+itNtUC4y0WDave0OM/1orSxee2Ri+n+9idlDl9LBXDOmYYeIcoLIdLfVSNNRH4S8nWU1tIX
	VJZ62cZmKMIyr3qVj7XTsZeq8kXqyjTKt4sZoTXmIQuqNJ8reSlGZ8btMQv582nEUNBe8iY2HIh
	Kk8yfq+1XV5DTZXV/Ph/7ny/p/75b8ksbIlXXkYihb2ebBM8LOTtnkwB752q/BdrZX976/ZetuK
	z6QfFmsdICpPbaARKYlwcpRb2V4c5ub4VCKZ9hlX2gzmbWOYUFKw5qhEfuk/vzmkh6doBxHBBPB
	RSUIA6Y7L5NpWJ/Lky7gxJZYLcw6r6mYUrk/D9InjeCq1Lsy5hdDfxtndLFJjV2LJCSxiQieEvl
	psyQp65Ac4A3mutMkcsE83pJGY4BA==
X-Received: by 2002:ac8:5d45:0:b0:50d:97e8:939b with SMTP id d75a77b69052e-5102ade84ebmr60832801cf.36.1777577530701;
        Thu, 30 Apr 2026 12:32:10 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5103d1c6957sm4270391cf.2.2026.04.30.12.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:32:10 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 3/7] rteval: Reorganize command-line arguments into logical groups
Date: Thu, 30 Apr 2026 15:31:40 -0400
Message-ID: <20260430193144.354599-4-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430193144.354599-1-jkacur@redhat.com>
References: <20260430193144.354599-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize rteval-cmd arguments to improve code maintainability and
readability:

- Group arguments by function: Utility/Control, Execution Mode, CPU
  Configuration, Configuration & Path, Logging & Verbosity, Reporting,
  and Advanced/Special options
- Alphabetize arguments within each group by long option name
- Keep help output clean without category headers (users still see
  simple alphabetical list)

This reorganization makes the code easier to navigate and maintain while
keeping the user-facing help output simple and uncluttered.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd | 104 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 59 insertions(+), 45 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index eddbe9c97008..85adf2502d20 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -95,69 +95,83 @@ def parse_options(cfg, parser, cmdargs):
     # thus they are prefixed with 'rteval___'.
     # See rteval/rtevalConfig::UpdateFromOptionParser() method for more info
     #
+
+    # Utility/Control Options
+    parser.add_argument("--cleanup-cpusets", dest="rteval___cleanup_cpusets",
+                      action="store_true", default=False,
+                      help="remove any leftover rteval cpusets from previous runs and exit")
+    parser.add_argument("-V", "--version", dest="rteval___version",
+                      action='store_true', default=False,
+                      help='print rteval version and exit')
+
+    # Execution Mode Options
     parser.add_argument("-d", "--duration", dest="rteval___duration",
                       type=str, default=rtevcfg.duration, metavar="DURATION",
                       help=f"specify length of test run (default: {rtevcfg.duration})")
-    parser.add_argument("-v", "--verbose", dest="rteval___verbose",
-                      action="store_true", default=rtevcfg.verbose,
-                      help=f"turn on verbose prints (default: {rtevcfg.verbose})")
-    parser.add_argument("-q", "--quiet", dest="rteval___quiet",
-                      action="store_true", default=rtevcfg.quiet,
-                      help=f"turn on quiet mode (default: {rtevcfg.quiet})")
-    parser.add_argument("-w", "--workdir", dest="rteval___workdir",
-                      type=str, default=rtevcfg.workdir, metavar="DIRECTORY",
-                      help=f"top directory for rteval data (default: {rtevcfg.workdir})")
-    parser.add_argument("-l", "--loaddir", dest="rteval___srcdir",
-                      type=str, default=rtevcfg.srcdir, metavar="DIRECTORY",
-                      help=f"directory for load source tarballs (default: {rtevcfg.srcdir})")
-    parser.add_argument("-i", "--installdir", dest="rteval___installdir",
-                      type=str, default=rtevcfg.installdir, metavar="DIRECTORY",
-                      help=f"place to locate installed templates (default: {rtevcfg.installdir})")
+    parser.add_argument("--noload", dest="rteval___noload",
+                        action="store_true", default=False,
+                        help="only run the measurements (don't run loads)")
+    parser.add_argument("-O", "--onlyload", dest="rteval___onlyload",
+                      action='store_true', default=False,
+                      help="only run the loads (don't run measurement threads)")
+
+    # CPU Configuration Options
+    parser.add_argument("--cpusets", dest="rteval___cpusets",
+                      action="store_true", default=False,
+                      help="use cgroup v2 cpusets to isolate measurement, load, and housekeeping workloads")
     parser.add_argument("--housekeeping", dest="rteval___housekeeping",
                       type=str, default="", metavar="CPULIST",
                       help="isolated CPUs reserved for system tasks (not used by rteval)")
     parser.add_argument("--warn-non-isolated-core-sharing", dest="rteval___warn_non_isolated_core_sharing",
                       action="store_true", default=False,
                       help="warn about measurement and load CPUs sharing cores even when neither is isolated")
-    parser.add_argument("--cpusets", dest="rteval___cpusets",
-                      action="store_true", default=False,
-                      help="use cgroup v2 cpusets to isolate measurement, load, and housekeeping workloads")
-    parser.add_argument("--cleanup-cpusets", dest="rteval___cleanup_cpusets",
-                      action="store_true", default=False,
-                      help="remove any leftover rteval cpusets from previous runs and exit")
-    parser.add_argument("-s", "--sysreport", dest="rteval___sysreport",
-                      action="store_true", default=rtevcfg.sysreport,
-                      help=f'run sysreport to collect system data (default: {rtevcfg.sysreport})')
-    parser.add_argument("-D", '--debug', dest='rteval___debugging',
-                      action='store_true', default=rtevcfg.debugging,
-                      help=f'turn on debug prints (default: {rtevcfg.debugging})')
-    parser.add_argument("-Z", '--summarize', dest='rteval___summarize',
-                      nargs='+', default=None, metavar='XMLFILE',
-                      help='summarize one or more already existing XML reports')
-    parser.add_argument("-H", '--raw-histogram', dest='rteval___rawhistogram',
-                      nargs='+', default=None, metavar='XMLFILE',
-                      help='Generate raw histogram data for one or more already existing XML reports')
+
+    # Configuration & Path Options
     parser.add_argument("-f", "--inifile", dest="rteval___inifile",
                       type=str, default=None, metavar="FILE",
                       help="initialization file for configuring loads and behavior")
-    parser.add_argument("-a", "--annotate", dest="rteval___annotate",
-                      type=str, default=None, metavar="STRING",
-                      help="Add a little annotation which is stored in the report")
+    parser.add_argument("-i", "--installdir", dest="rteval___installdir",
+                      type=str, default=rtevcfg.installdir, metavar="DIRECTORY",
+                      help=f"place to locate installed templates (default: {rtevcfg.installdir})")
+    parser.add_argument("-l", "--loaddir", dest="rteval___srcdir",
+                      type=str, default=rtevcfg.srcdir, metavar="DIRECTORY",
+                      help=f"directory for load source tarballs (default: {rtevcfg.srcdir})")
+    parser.add_argument("-w", "--workdir", dest="rteval___workdir",
+                      type=str, default=rtevcfg.workdir, metavar="DIRECTORY",
+                      help=f"top directory for rteval data (default: {rtevcfg.workdir})")
+
+    # Logging & Verbosity Options
+    parser.add_argument("-D", '--debug', dest='rteval___debugging',
+                      action='store_true', default=rtevcfg.debugging,
+                      help=f'turn on debug prints (default: {rtevcfg.debugging})')
     parser.add_argument("-L", "--logging", dest="rteval___logging",
                       action='store_true', default=False,
                       help='log the output of the loads in the report directory')
-    parser.add_argument("-O", "--onlyload", dest="rteval___onlyload",
-                      action='store_true', default=False,
-                      help="only run the loads (don't run measurement threads)")
-    parser.add_argument("-V", "--version", dest="rteval___version",
-                      action='store_true', default=False,
-                      help='print rteval version and exit')
+    parser.add_argument("-q", "--quiet", dest="rteval___quiet",
+                      action="store_true", default=rtevcfg.quiet,
+                      help=f"turn on quiet mode (default: {rtevcfg.quiet})")
+    parser.add_argument("-v", "--verbose", dest="rteval___verbose",
+                      action="store_true", default=rtevcfg.verbose,
+                      help=f"turn on verbose prints (default: {rtevcfg.verbose})")
+
+    # Reporting Options
+    parser.add_argument("-a", "--annotate", dest="rteval___annotate",
+                      type=str, default=None, metavar="STRING",
+                      help="Add a little annotation which is stored in the report")
+    parser.add_argument("-H", '--raw-histogram', dest='rteval___rawhistogram',
+                      nargs='+', default=None, metavar='XMLFILE',
+                      help='Generate raw histogram data for one or more already existing XML reports')
+    parser.add_argument("-Z", '--summarize', dest='rteval___summarize',
+                      nargs='+', default=None, metavar='XMLFILE',
+                      help='summarize one or more already existing XML reports')
+    parser.add_argument("-s", "--sysreport", dest="rteval___sysreport",
+                      action="store_true", default=rtevcfg.sysreport,
+                      help=f'run sysreport to collect system data (default: {rtevcfg.sysreport})')
+
+    # Advanced/Special Options
     parser.add_argument("-S", "--source-download", nargs="?", dest="rteval___srcdownload",
                         type=str, default=None, const='', metavar="KERNEL_VERSION",
                         help='download a source kernel from kernel.org and exit')
-    parser.add_argument("--noload", dest="rteval___noload",
-                        action="store_true", default=False,
-                        help="only run the measurements (don't run loads)")
 
     cmd_opts = parser.parse_args(args=cmdargs)
 
-- 
2.54.0

