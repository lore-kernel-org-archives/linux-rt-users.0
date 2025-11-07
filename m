Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CE7339B56
	for <linux-rt-users@vger.kernel.org>; Fri,  7 Nov 2025 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540040; cv=none; b=V7UcWhJt/0kDvrcyRZc2VW4Y7/4G/lRq1WeAlyJft1k53ip5USJxWiqat2aTk49Hl+DC5MofVjslZb3lSNYtMCl/Eqts0gjTPm70VLc5L8+5RFTZdiu5gDZGOfzpXgddiH5g6rZ+H+vjhZ+NaYIMsm10ZZvX+fN3W2VNs2K05Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540040; c=relaxed/simple;
	bh=4gLLHvHBs2Lo9EG6wyfu5J8ByfYbDawWJNiCr9mcHwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dirUfkBXUjJpKohnYldg0uOo5IIdqVcpo2OIqIIWViYD4Yps57els+igu7lqMp0cO2VaqVsou953lSyQuKdrqDIYadTlNuazypAzds/GNIRBz94AgU2YDuQzmi2PhN/9KibdnkfKbeOkzlXiut4iNsxtSTTjQiAaSVtcnxOuGfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dROiyRjI; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dROiyRjI"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8b0eddecb0bso110497485a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Nov 2025 10:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762540037; x=1763144837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3CpaWvDUFkcdSs5Kh36QTKCUi5Z1myMH0oY6IcW71w=;
        b=dROiyRjI4Xw+k5Cua6ZB8ZMtdDIUVS+8ZaeOY4DoLPBbg9mQRwoVyx59G+CBb+OYxc
         4TS3cvuMb32a9KQEm/qq1R+muMrxU4tcDF0prkQggu9E827ovw6/qiTOhlASO9pVsKNA
         3EYBsqSuod/pl3ifwzeY+xtynrxVs7CZv69+ie9m9aCejebaO1ydXdhocs36IcLdEADs
         FaHk6NaDBWjnYP6dn599VqsnJw+vnAAx0swg3RKhEumTs2NrnLW/muOx/hBafXofowll
         fNrIYt4wEkWxl+1H+ULHdpzJPufRRmsJGi1Vhtv04CMo7VOyzsCTIbX0zAkB+oKmE7un
         5ZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762540037; x=1763144837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3CpaWvDUFkcdSs5Kh36QTKCUi5Z1myMH0oY6IcW71w=;
        b=qugP4IbocHLjGBDGSfyaNnKcfL/rkyaRlzuTepBfQBYdkpzuwoNjBLU+PXR5XC4PRU
         v8M+K/uBWTF46NdXdkA3HYe8BgtLrjdU6qqbRCja6A6E1asu3Lu+fwGMsPuwtAZxPUnK
         JjjOKg52GykHHtJmoDeeVkBcpLC6K7G+UDQYycwNM1zw9v2WRSA6aXQzL34kpzB3H7N8
         T2V6Ktkw9M4Yo6R+j+fgH73RaujXSnUzUHYmZXbwMJmkAinoEit6Nzh3TW/Mhmv1UMS3
         epBHG4DcOuzpjvGNs0RzhoiZ3iCvCTqLHbSpFFfya9n6oqYwUmOVPsQ9nEfvhVZbxDWk
         42Bg==
X-Gm-Message-State: AOJu0Yze8l19CBVXN6RsYu3a6pbm3X6kE+iFYC/P1lp7jGVh1urEh1Lt
	f6dvyFnwzKg6StULyhY1tnkwtimSSMcjcbX8zOKqQZtrzCHVS6lpEpVNiBa753qh
X-Gm-Gg: ASbGnctdHss48WoeqJFEvwN5/7Yb6JubiqXi27Ty20RQvKxnqfChGGeNpb+Z0QpItZ8
	QVmWNi1T9bKluXLf57/WKBkp8FpLSNn/cLmLp7DAEejwNTdRHAfK+aveC/dfN7KfJ168Deh4+Ya
	ZDcuwusmq6F9xoHvCnW9VtxQQFGjNfHlu7/2GLYn8p5SNd0Zny6Wh/f+wB82fUn811Dn4m3kIkK
	7t8UzGZVlF2AdEvMyLAxJSwCZ5Zg0D/wtC9bWIVgq/tG5nB58y00J0qevr6Bam09KB3kdqZxEj5
	2k7M9MY8IyUnMoXdHpzFASgaGXjxi9AnwI8wh3Zp5VggHFtH0OvzsJRszPP46QK3l7Ps1tTliYY
	sViHe4/gjjgdP+RX7GeR7jmoEQcAD1zsdabm6QJSuWQnE6ksekBSYAf5bOz5JrpXicqOetmCtwg
	==
X-Google-Smtp-Source: AGHT+IHRr+0wQUdQ33BX5bwK5xWD2GQMUUrC2BNuPhy6f0zQjcXkR9yprnwssgBpUBWeSyw72CRjLQ==
X-Received: by 2002:a05:620a:29d5:b0:892:234a:2b2b with SMTP id af79cd13be357-8b257732bd9mr60949085a.12.1762540037321;
        Fri, 07 Nov 2025 10:27:17 -0800 (PST)
Received: from fionn ([174.88.40.44])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b235828514sm452141085a.53.2025.11.07.10.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 10:27:16 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Cc: Clark Williams <williams@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Claude <noreply@anthropic.com>
Subject: [PATCH 09/12] rteval: Improve argparse implementation and remove manual sys.argv parsing
Date: Fri,  7 Nov 2025 13:26:32 -0500
Message-ID: <20251107182645.19545-10-jkacur@redhat.com>
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

This commit modernizes the argument parsing by using argparse properly
and eliminating fragile manual sys.argv manipulation.

Key improvements:

1. Use nargs='+' for -Z/--summarize and -H/--raw-histogram options
   - These now properly accept one or more XML files as arguments
   - Removed complex manual argument splitting logic (lines 158-174)
   - Help text now correctly shows: -Z XMLFILE [XMLFILE ...]

2. Use nargs='?' with const='' for -S/--source-download option
   - Simplified handling of optional kernel version argument
   - Removed manual sys.argv.count() checks (line 179)
   - Default value provided when flag is present without argument

3. Use parse_known_args() for early argument detection
   - Config file (-f) detection now uses proper argparse
   - Logging flags (-v/-D/-q) detection now uses proper argparse
   - Removed all manual sys.argv indexing and counting

4. Return cmd_opts instead of cmd_args from parse_options()
   - File arguments now directly accessible via cmd_opts attributes
   - Clearer separation between options and file arguments

5. Improved error handling
   - argparse provides better error messages for malformed arguments
   - Supports both -Z file1 file2 and --summarize=file1 formats

This eliminates 40+ lines of fragile manual parsing code and makes
the argument handling more robust and maintainable.

Co-Authored-By: Claude <noreply@anthropic.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval-cmd | 93 +++++++++++++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 54 deletions(-)

diff --git a/rteval-cmd b/rteval-cmd
index 8fd37b98b069..00873ce1196b 100755
--- a/rteval-cmd
+++ b/rteval-cmd
@@ -124,11 +124,11 @@ def parse_options(cfg, parser, cmdargs):
                       action='store_true', default=rtevcfg.debugging,
                       help=f'turn on debug prints (default: {rtevcfg.debugging})')
     parser.add_argument("-Z", '--summarize', dest='rteval___summarize',
-                      action='store_true', default=False,
-                      help='summarize an already existing XML report')
+                      nargs='+', default=None, metavar='XMLFILE',
+                      help='summarize one or more already existing XML reports')
     parser.add_argument("-H", '--raw-histogram', dest='rteval___rawhistogram',
-                      action='store_true', default=False,
-                      help='Generate raw histogram data for an already existing XML report')
+                      nargs='+', default=None, metavar='XMLFILE',
+                      help='Generate raw histogram data for one or more already existing XML reports')
     parser.add_argument("-f", "--inifile", dest="rteval___inifile",
                       type=str, default=None, metavar="FILE",
                       help="initialization file for configuring loads and behavior")
@@ -144,43 +144,19 @@ def parse_options(cfg, parser, cmdargs):
     parser.add_argument("-V", "--version", dest="rteval___version",
                       action='store_true', default=False,
                       help='print rteval version and exit')
-    parser.add_argument("-S", "--source-download", nargs="*", dest="rteval___srcdownload",
-                        type=str, default=None, metavar="KERNEL_VERSION",
+    parser.add_argument("-S", "--source-download", nargs="?", dest="rteval___srcdownload",
+                        type=str, default=None, const='', metavar="KERNEL_VERSION",
                         help='download a source kernel from kernel.org and exit')
     parser.add_argument("--noload", dest="rteval___noload",
                         action="store_true", default=False,
                         help="only run the measurements (don't run loads)")
 
-
-    if not cmdargs:
-        cmdargs = ["--help"]
-
-    # if -Z/--summarize is specified, add the files to be summarized to cmd_args, and add -Z to cmd_opts
-    cmd_args = []
-    if (sys.argv.count('-Z')+sys.argv.count('--summarize')) > 0:
-        try:
-            ind = cmdargs.index('-Z')
-        except ValueError:
-            ind = cmdargs.index('--summarize')
-        cmd_args = cmdargs[ind+1:]
-        cmdargs = cmdargs[:ind+1]
-    # if -H/--raw-histogram is specified, add the files to be summarized to cmd_args, and add -H to cmd_opts
-    elif (sys.argv.count('-H')+sys.argv.count('--raw-histogram')) > 0:
-        try:
-            ind = cmdargs.index('-H')
-        except ValueError:
-            ind = cmdargs.index('--raw-histogram')
-        cmd_args = cmdargs[ind+1:]
-        cmdargs = cmdargs[:ind+1]
-
     cmd_opts = parser.parse_args(args=cmdargs)
 
     # if no kernel version was provided for --source-download, set version to default
-    if (sys.argv.count('-S')+sys.argv.count('--source-download')) > 0:
-        if cmd_opts.rteval___srcdownload == []:
+    if cmd_opts.rteval___srcdownload is not None:
+        if cmd_opts.rteval___srcdownload == '':
             cmd_opts.rteval___srcdownload = ModuleParameters()["source"]["default"].replace(".tar.xz", "")
-        else:
-            cmd_opts.rteval___srcdownload = cmd_opts.rteval___srcdownload[0]
 
     if cmd_opts.rteval___version:
         print(f"rteval version {RTEVAL_VERSION}")
@@ -205,7 +181,7 @@ def parse_options(cfg, parser, cmdargs):
     # Update the config object with the parsed arguments
     cfg.UpdateFromOptionParser(cmd_opts)
 
-    return cmd_args
+    return cmd_opts
 
 if __name__ == '__main__':
     from rteval.sysinfo import dmi
@@ -225,13 +201,14 @@ if __name__ == '__main__':
 
         # Before really parsing options, see if we have been given a config file in the args
         # and load it - just so that default values are according to the config file
-        try:
-            cfgfile = sys.argv[sys.argv.index('-f')+1]
-            config.Load(cfgfile)
-        except IndexError:
-            # Missing file argument
-            raise RuntimeError('The -f option requires a file name to the configuration file')
-        except ValueError:
+        # Use a minimal parser to extract just the -f option
+        config_parser = argparse.ArgumentParser(add_help=False)
+        config_parser.add_argument('-f', '--inifile', dest='inifile')
+        early_args, _ = config_parser.parse_known_args()
+
+        if early_args.inifile:
+            config.Load(early_args.inifile)
+        else:
             # No configuration file given, load defaults
             config.Load()
 
@@ -247,20 +224,29 @@ if __name__ == '__main__':
                 'sysstat' : 'module'})
 
         # Prepare log levels before loading modules, not to have unwanted log messages
+        # Use a minimal parser to extract logging-related flags early
         rtevcfg = config.GetSection('rteval')
-        if (sys.argv.count('-v')+sys.argv.count('--verbose')) > 0:
+        log_parser = argparse.ArgumentParser(add_help=False)
+        log_parser.add_argument('-v', '--verbose', action='store_true')
+        log_parser.add_argument('-D', '--debug', action='store_true')
+        log_parser.add_argument('-q', '--quiet', action='store_true')
+        log_parser.add_argument('--idle-set', action='store_true')
+        early_args, _ = log_parser.parse_known_args()
+
+        if early_args.verbose:
             rtevcfg.verbose = True
-        if (sys.argv.count('-D')+sys.argv.count('--debug')) > 0:
+        if early_args.debug:
             rtevcfg.debugging = True
-        if (sys.argv.count('-q')+sys.argv.count('--quiet')) > 0:
+        if early_args.quiet:
             rtevcfg.quiet = True
+
         loglev = (not rtevcfg.quiet and (Log.ERR | Log.WARN)) \
                 | (rtevcfg.verbose and Log.INFO) \
                 | (rtevcfg.debugging and Log.DEBUG)
         logger.SetLogVerbosity(loglev)
 
         # check if cpupower is being used
-        if sys.argv.count('--idle-set') > 0:
+        if early_args.idle_set:
             rtevcfg.update({'usingCpupower': True})
 
         # Load modules
@@ -271,7 +257,7 @@ if __name__ == '__main__':
         parser = argparse.ArgumentParser()
         loadmods.SetupModuleOptions(parser)
         measuremods.SetupModuleOptions(parser)
-        cmd_args = parse_options(config, parser, sys.argv[1:])
+        cmd_opts = parse_options(config, parser, sys.argv[1:])
 
         if rtevcfg.noload:
             if rtevcfg.onlyload:
@@ -371,16 +357,15 @@ if __name__ == '__main__':
         logger.log(Log.DEBUG, f"workdir: {rtevcfg.workdir}")
 
         # if --summarize was specified then just parse the XML, print it and exit
-        if rtevcfg.summarize or rtevcfg.rawhistogram:
-            if len(cmd_args) < 1:
-                raise RuntimeError("Must specify at least one XML file with --summarize!")
-
-            for x in cmd_args:
-                if rtevcfg.summarize:
-                    summarize(x, rtevcfg.xslt_report)
-                elif rtevcfg.rawhistogram:
-                    summarize(x, rtevcfg.xslt_histogram)
+        if cmd_opts.rteval___summarize:
+            for xmlfile in cmd_opts.rteval___summarize:
+                summarize(xmlfile, rtevcfg.xslt_report)
+            sys.exit(0)
 
+        # if --raw-histogram was specified then just parse the XML, print it and exit
+        if cmd_opts.rteval___rawhistogram:
+            for xmlfile in cmd_opts.rteval___rawhistogram:
+                summarize(xmlfile, rtevcfg.xslt_histogram)
             sys.exit(0)
 
         if os.getuid() != 0:
-- 
2.51.1

