Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D9A3E0097
	for <linux-rt-users@vger.kernel.org>; Wed,  3 Jun 2026 20:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780519804; cv=none; b=MDKJrwnYi50Qb83kYAUdvOSJV5nAz+14zQ2Lf7mlFPnG/DgMnxNt1QWbLhkXxyFVZ8VTutXMIc7LNLVCWz9YLdOpsA53qvW13tfdVQ6kk03dZjO4HT++ZWnXP7MrYpprMYxXarIAWxmkKxvBQ1qf2LZ9PhQwepdOKduyV1nf2mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780519804; c=relaxed/simple;
	bh=5j8LfrP3Zm6FL4q3UPQobMGvkIBXMOofEzLVSv5Y3ko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YQlwdCtwiS6UINUBR4Ozo99hN0LqwmCFe5MTxSHmg8LDLh+LZFNHeY/VeMCbmBxyoPgUz9yXPG3cWQeIzKrv4dKLoCYKapT8bW5fNyAvgtqqCvU8SnMmyWvJtevPq5qveCHLm1uDi/2mhq6IpU9j0IdP6M65kArZ8/31fS1PBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoVEZ2Sp; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoVEZ2Sp"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccf887de87so55081086d6.0
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Jun 2026 13:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780519801; x=1781124601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8R2LisIj4KtUYKXmRc9KnXcMF9fiCHeMUUwCPH+YJBg=;
        b=aoVEZ2SpsygtgXzMc+mvMSo21IYvWDKalUQ0ofeb4VSv5SxEfYq7MR1ybB/QhssmBR
         AtqBTqqTB7/udjEU5AmXHyVxg54NswcFdd9MpJknC4mCWmoO97+Oj/kpY/F5BPNh0R2I
         OA/OVrGU33gLE2oXDpKLtrqZz6P1+IVGc1BUY52eX2OinbAFq++tC4L/3fazEYjz/qdm
         x194NwrBQMSdo4BanAZeCFimBSAoMkzcmR8i2mKzzNtLGSW+0CUoMU/hcfvUWSO6oEzn
         NY6aXCkB3sNQMdnqRacbGStR3/askX5Q+PvuOoVHdOIqV1DqscYGcDkEioesLbKVkcZx
         nFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780519801; x=1781124601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R2LisIj4KtUYKXmRc9KnXcMF9fiCHeMUUwCPH+YJBg=;
        b=lIvhDsLqy2Y8w5pcJpXg0teD6WrRucqfWEn6jd5s9IzHu/w5CzjOuF8AO7rINQ9mvt
         4IH3xbXgXPl4yYZaQi067BHuIFJ2Mk1ohq3z6iosBa5OC9B9YIIbCOsfaJQR62C+Tzny
         joCtM3VQFnVQ6C6othasEjqqO7vOBCS+NtI22urKh4hph/q9wzbS8y8047NiJQVMOg6E
         Uw5qGdONTN9F5Z7Wb2k700fx+Qh+xc/k14l/xSg+f5Ti/qc6iPh//mH1BAysQJdNTasb
         bykrnkdDfUCAwdHGP017IvXXP/NswfaL0IROSDCl+t7TXWxI2Mv6/vd8KiKbHyl3y9TI
         pjlg==
X-Gm-Message-State: AOJu0YxLf3kgm3WeuqvE1pP1Vz1oXkqAMJTl/x1Afgq0rtx3pidBEcUz
	rQwwyMRVi8t2ryzv5O0BMqFYUVi/ALBUhBGzRqsnXYfPK+UoscnMiy54qo73JQ==
X-Gm-Gg: Acq92OGGNJNc8c5sHn/UTC6t9kGKgU6qx+OhdQtW8QlVnWu15Gbf2PYKfJhhkBmeB6Q
	q4/1Z2XxDSd2sJd1b+EbHjNRfsOoTqtGDzw2BGdPk+4gZyspaDuM05hIj3YClklZMt8VsquyWqy
	1X31125k8Jc6vpiQKQEZEzbfGaTbE2zKVfy1wtEaQLgNHn91m+Wdh5Urquwww0acKEbotQB0/OH
	IRFZKmiZ62552zHbm0iQxdA0tnbTcxX2X3vLLoEk+FSYWjxTYS5zVSQ0U1ue564d6we546T3Qq3
	I0Wks5RKgoDCTeZbOoInFd2VEOp9G45sE6GSvY2BLYgAXVLeDhVppuYFzy63IWrDQJ4K159oeUl
	2r2RPxY12kLwW2k4OT7fIV47vXGm9VERxjuWVuUSSbNWGEYb0gNFOARYom+ECkApj8NZ2CwoPtk
	K8zrGnKuPlOj+ofm5fSaE9fRDPnYCu9N5rOdIfw48tZ8K1w/9mu2DDH5fI2OcG4BSZZd+48ZoQy
	1A8oRYBAuwOppMex2QuPMKlllZ2AII3lMpU6/olHvMsxlXxEIaZouQi2eigwtgoHrWi4si+ijFO
	/BN6s0C7/tiEm1GtFSH3u+7duW028Q==
X-Received: by 2002:a05:6214:19ee:b0:8ce:9cbd:b0ce with SMTP id 6a1803df08f44-8cece02d7bamr80714956d6.34.1780519800820;
        Wed, 03 Jun 2026 13:50:00 -0700 (PDT)
Received: from Cumhall.redhat.com (bras-base-rdwyon0604w-grc-03-216-209-112-32.dsl.bell.ca. [216.209.112.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb94b5sm31742426d6.15.2026.06.03.13.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:50:00 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-rt-users@vger.kernel.org
Cc: williams@redhat.com
Subject: [PATCH 1/2] rteval: Modernize documentation
Date: Wed,  3 Jun 2026 16:49:52 -0400
Message-ID: <20260603204953.226473-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update and reorganize rteval documentation:

- Completely rewrite rteval.8 man page with current options and features
  - Add comprehensive sections for all measurement modules (cyclictest and timerlat)
  - Add all cpuset, load control, and configuration options
  - Include practical examples section
  - Update to reflect current rteval 3.10 functionality

- Update README with modern installation and dependency information
  - Add sysstat, rtla, and all build tool dependencies
  - Organize dependencies by category (measurement, load modules, utilities)
  - Use HTTPS URLs instead of deprecated git:// protocol
  - Update TESTING section with current test targets

- Rename doc/rteval.txt to doc/rteval-legacy.txt to indicate it's historical

- Delete doc/installing.txt as redundant with README

- Add SPDX-License-Identifier to all documentation files

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 README                                | 122 ++++++--
 doc/installing.txt                    |  23 --
 doc/{rteval.txt => rteval-legacy.txt} |   2 +
 doc/rteval.8                          | 398 +++++++++++++++++---------
 4 files changed, 367 insertions(+), 178 deletions(-)
 delete mode 100644 doc/installing.txt
 rename doc/{rteval.txt => rteval-legacy.txt} (99%)

diff --git a/README b/README
index cb2700e5a0fc..afaff25b65a3 100644
--- a/README
+++ b/README
@@ -1,42 +1,110 @@
+SPDX-License-Identifier: GPL-2.0-or-later
 
-Rteval is a python program written to evaluate the performance of a
+Rteval is a Python program written to evaluate the performance of a
 realtime Linux kernel on a particular hardware platform. The program
-unpacks source code for two loads: hackbench and a Linux kernel
-compile, then loops running hackbench and a parallel build of the
-Linux kernel. While the loads are running, the cyclictest program is
-run to measure realtime performance under load. When the specified run
-duration is met, the loads are stopped and cyclictest outputs measured
-timer latency values in histogram format, which is analyzed by
-rteval. Rteval then writes an XML file to disk with information about
-the system (gotten through DMI tables), the raw histogram data
-collected during the run and the statistical analysis of the run.
+runs measurement modules (cyclictest or timerlat) to measure scheduling
+and timer latency while simultaneously running system load modules
+(kernel compile, hackbench, stress-ng) to stress the system.
 
-The rteval source may be pulled from it's git tree on kernel.org:
-    git://git.kernel.org/pub/scm/utils/rteval/rteval.git
+When the specified run duration is met, rteval stops the loads and
+measurements, then writes an XML report to disk with information about
+the system (from DMI tables), raw measurement data, and statistical
+analysis including min/max latency, standard deviation, and histograms.
 
-Rteval requires the following packages to run:
+INSTALLATION
+============
+
+The rteval source may be pulled from its git tree on kernel.org:
+    https://git.kernel.org/pub/scm/utils/rteval/rteval.git
+
+Required Dependencies:
 
 Python >= 3.8
-    http://www.python.org/download/
+    https://www.python.org/download/
+
+python3-lxml
+    https://lxml.de/
+
+python3-libxml2
+    https://xmlsoft.org/
+
+sysstat
+    System performance monitoring tools (sar, iostat, mpstat)
+
+Measurement Module Requirements (choose one):
+
+For cyclictest measurement module:
+  rt-tests (realtime-tests package)
+    https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
+
+For timerlat measurement module (recommended):
+  rtla (part of Linux kernel tools)
+    Requires kernel 5.15+ with CONFIG_OSNOISE_TRACER enabled
+
+Load Module Requirements:
+
+For kcompile load module:
+  rteval-loads package (provides kernel source tarballs)
+    Or manually download kernel sources from https://www.kernel.org/
+
+  Build tools: gcc, binutils, gcc-c++, make, flex, bison, bc,
+               kernel-headers, openssl-devel, perl-interpreter,
+               elfutils-libelf-devel, xz, bzip2, tar, gzip
+
+For stress-ng load module (optional):
+  stress-ng
+    https://github.com/ColinIanKing/stress-ng
 
-python-lxml
-  http://lxml.de/
+System utilities:
+  numactl, dmidecode, procps-ng
 
-libxml2-python
-    http://xmlsoft.org/
+Installation:
 
-rt-tests
-    git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
+  $ git clone https://git.kernel.org/pub/scm/utils/rteval/rteval.git
+  $ cd rteval
+  $ sudo make install
 
-Rteval end-to-end tests additionally require the following packages:
+For rt-tests (if using cyclictest):
 
-Test::Harness
+  $ git clone https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
+  $ cd rt-tests
+  $ sudo make prefix=/usr install
+
+TESTING
+=======
+
+Rteval includes unit tests and end-to-end tests. End-to-end tests
+require:
+
+Test::Harness (Perl module)
     https://metacpan.org/pod/Test::Harness
 
-Clark Williams <williams@redhat.com> wrote rteval
+Run tests with:
+  $ make test          # Unit tests
+  $ make e2e-tests     # End-to-end tests (requires root)
+
+USAGE
+=====
+
+Basic usage (requires root):
+
+  $ sudo rteval -d 3600
+
+Run with timerlat measurement module:
+
+  $ sudo rteval -d 3600 --measurement-module timerlat
+
+See the man page for more options:
+
+  $ man rteval
+
+AUTHORS
+=======
+
+Clark Williams <williams at redhat dot com> wrote rteval.
 
-David Sommerseth <davids@redhat.com> wrote the XML-RPC and database
-    logic for handling rteval results.
+David Sommerseth wrote the XML-RPC and database logic for handling
+    rteval results.
 
-John Kacur <jkacur at redhat dot com> ported it to python-3.0
-    and has been developing and maintaining it since then.
+John Kacur <jkacur at redhat dot com> ported it to Python 3 and has
+    been developing and maintaining it since then.
diff --git a/doc/installing.txt b/doc/installing.txt
deleted file mode 100644
index 227249bbc9ed..000000000000
--- a/doc/installing.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-The rteval utility requires some external software libraries to run
-properly. These are:
-
-python-lxml
-  A python library to parse XML files and XSLT stylesheets
-  http://lxml.de/
-
-libxml2-python
-  A python library to parse XML files
-  http://xmlsoft.org/
-
-rt-tests
-  A collection of programs used to measure real-time behavior
-  git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
-
-
-$ git clone \
-  git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
-$ cd rt-tests && sudo make prefix=/usr install
-$ cd ../rteval
-$ sudo make install
-
-That should do it (I hope).
diff --git a/doc/rteval.txt b/doc/rteval-legacy.txt
similarity index 99%
rename from doc/rteval.txt
rename to doc/rteval-legacy.txt
index 95d501bb764e..65ee4887a91f 100644
--- a/doc/rteval.txt
+++ b/doc/rteval-legacy.txt
@@ -1,3 +1,5 @@
+SPDX-License-Identifier: GPL-2.0-or-later
+
 Evaluating Realtime Linux system performance with rteval
 Clark Williams <williams@redhat.com>
 --------------------------------------------------------
diff --git a/doc/rteval.8 b/doc/rteval.8
index 1981ac7b3913..370bad9eadc0 100644
--- a/doc/rteval.8
+++ b/doc/rteval.8
@@ -1,175 +1,317 @@
-.\"                                      Hey, EMACS: -*- nroff -*-
-.TH RTEVAL 8 "august  27, 2009"
-.\" Please adjust this date whenever revising the manpage.
+.\" rteval man page
+.\" SPDX-License-Identifier: GPL-2.0-or-later
+.\" Copyright (C) 2009-2026 Red Hat Inc.
 .\"
-.\" Some roff macros, for reference:
-.\" .nh        disable hyphenation
-.\" .hy        enable hyphenation
-.\" .ad l      left justify
-.\" .ad b      justify to both left and right margins
-.\" .nf        disable filling
-.\" .fi        enable filling
-.\" .br        insert line break
-.\" .sp <n>    insert n+1 empty lines
-.\" for manpage-specific macros, see man(7)
+.TH RTEVAL 8 "June 2026" "rteval 3.10" "System Administration"
 .SH NAME
 rteval \- evaluate latency performance of a realtime Linux system
 .SH SYNOPSIS
 .B rteval
-.RI "[ \-hvsLSDOZ ] [\-d " duration " ] [\-w " workdir " ] [\-l " loaddir " ] \
-[\-X " host " ]"
-
-.\" .SH DESCRIPTION
-.\" This manual page documents briefly the
-.\" .B rteval command.
-.\" .PP
-.\" \fI<whatever>\fP escape sequences to invode bold face and italics, respectively.
-.\" \fBcyclictest\fP is a program that...
-
-The rteval program is used to evaluate the realtime performance of a
-realtime Linux kernel on a particular hardware system. There is
-nothing that actually requires a realtime Linux kernel, but the
-latency measurements will usually be pretty bad on a stock Linux
-kernel.
-
+.RI [ OPTIONS ]
+.SH DESCRIPTION
+The
+.B rteval
+program is used to evaluate the realtime performance of a Linux kernel on a
+particular hardware system. It runs measurement modules (cyclictest or timerlat)
+to measure scheduling and timer latency while simultaneously running system load
+modules (kernel compile, hackbench, stress-ng) to stress the system.
+.PP
+The program runs for a specified duration (default 60 seconds, typically 12+ hours
+for production testing) and generates an XML report containing system information,
+raw measurement data, and statistical analysis including min/max latency, standard
+deviation, and histograms.
+.PP
+Results are stored in a timestamped directory (rteval-YYYYMMDD-N) containing the
+XML report and optional logs.
 
 .SH OPTIONS
-These programs follow the usual GNU command line syntax, with long
-options starting with two dashes ('\-\-').
-.br
-A summary of options is included below.
-.\" For a complete description, see the Info files.
+.SS General Options
 .TP
 .B \-h, \-\-help
-print a help message
-.TP
-.B -d, \-\-duration=DURATION
-Specify the length of the measurement run. DURATION is an integer with
-an optional suffix indicating the units:
-
-.br
-   s - seconds
-.br
-   m - minutes
-.br
-   h - hours
-.br
-   d - days
-.br
-for example to execute a ten minute run of rteval:
-.br
-     $ rteval \-\-duration=10m
+Display help message and exit.
 .TP
-.B \-v, \-\-verbose
-Increase the verbosity of output during the test run
+.B \-V, \-\-version
+Print rteval version and exit.
 .TP
-.B \-q, \-\-quiet
-Set rteval to run in quiet mode.
+.B \-d, \-\-duration \fIDURATION\fR
+Specify length of test run in seconds (default: 60.0). Can be specified as a
+floating point number (e.g., 1.5 for 90 seconds) or with time suffixes.
 .TP
-.B \-w WORKDIR, \-\-workdir=WORKDIR
-Tell rteval to change directory to WORKDIR before creating any
-subdirectories for report files. The default WORKDIR is the directory
-in which rteval was started.
+.B \-f, \-\-inifile \fIFILE\fR
+Initialization file for configuring loads and behavior.
 .TP
-.B \-l LOADDIR, \-\-loaddir=LOADDIR
-Tell rteval where to find the source for the loads
+.B \-w, \-\-workdir \fIDIRECTORY\fR
+Top directory for rteval data (default: current directory).
 .TP
-.B \-i INSTALLDIR, \-\-installdir=INSTALLDIR
-Tell rteval where to locate installed templates.
+.B \-i, \-\-installdir \fIDIRECTORY\fR
+Place to locate installed templates (default: /usr/share/rteval).
 .TP
-.B \-s, \-\-sysreport
-Have rteval run the sysreport utility after a run to gather
-information on the running system.
+.B \-l, \-\-loaddir \fIDIRECTORY\fR
+Directory for load source tarballs (default: ./loadsource).
+.TP
+.B \-a, \-\-annotate \fISTRING\fR
+Add an annotation string which is stored in the report.
 .TP
 .B \-D, \-\-debug
-Turn on debugging prints during run
+Turn on debug prints (default: False).
 .TP
-.B \-Z, \-\-summarize
-Have rteval summarize an existing report. This will not cause loads or
-meausurement utilities to be run.
+.B \-L, \-\-logging
+Log the output of measurement and load modules in the report directory.
 .TP
-.B \-H, \-\-raw-histogram
-Generate raw histogram data for an already existing XML report
+.B \-q, \-\-quiet
+Turn on quiet mode (default: False).
 .TP
-.B \-f INIFILE, \-\-inifile=INIFILE
-Initialization file for configuring loads and behavior
+.B \-v, \-\-verbose
+Turn on verbose prints (default: False).
 .TP
-.B \-a COMMENT, \-\-annotate=COMMENT
-Add a little annotation which is stored in the report
+.B \-s, \-\-sysreport
+Run sysreport to collect system data (default: False).
+
+.SS Load Control Options
 .TP
-.B \-L, \-\-logging
-Log the output of the loads in the report directory
+.B \-\-noload
+Only run the measurements (don't run load modules).
 .TP
 .B \-O, \-\-onlyload
-Only run the loads (don't run measurement threads)
+Only run the loads (don't run measurement threads).
 .TP
-.B \-V, \-\-version
-Print rteval version and exit.
+.B \-\-loads\-cpulist \fICPULIST\fR
+CPU list where load modules will run (e.g., 0-3,8-11).
+
+.SS CPU Isolation and Cpuset Options
 .TP
-.B \-S KERNEL_VERSION, \-\-source\-download=KERNEL_VERSION
-download a source kernel from kernel.org and exit
+.B \-\-cpusets
+Use cgroup v2 cpusets to isolate measurement and housekeeping workloads.
 .TP
-.B \-\-noload
-Only run the measurements (don't run loads)
+.B \-\-housekeeping \fICPULIST\fR
+Isolated CPUs reserved for system tasks (not used by rteval).
+.TP
+.B \-\-warn\-non\-isolated\-core\-sharing
+Warn about measurement and load CPUs sharing cores even when neither is isolated.
+.TP
+.B \-\-cleanup\-cpusets
+Remove any leftover rteval cpusets from previous runs and exit.
 
-.SH GROUP OPTIONS
+.SS Measurement Module Options
+.TP
+.B \-\-measurement\-module \fIMODULE\fR
+Select measurement module: cyclictest or timerlat (overrides config file).
 .TP
-.B \-\-loads\-cpulist=CPULIST
-List of CPUs where loads will run
+.B \-\-measurement\-cpulist \fICPULIST\fR
+CPU list where measurement modules will run.
 .TP
-.B \-\-measurement-cpulist=CPULIST
-List of CPUs where measurement application will run
+.B \-\-measurement\-run\-on\-isolcpus
+Include isolated CPUs in default cpulist.
 .TP
-.B \-\-measurement-run-on-isolcpus
-Include isolated CPUs in default cpulist
+.B \-\-measurement\-idle\-set \fIIDLESTATE\fR
+Idle state depth to set on CPUs running measurement modules.
 
+.SS Cyclictest Module Options
+.TP
+.B \-\-cyclictest\-interval \fIINTV_US\fR
+Base interval of the threads in microseconds (default: 100).
+.TP
+.B \-\-cyclictest\-buckets \fINUM\fR
+Histogram width (default: 3500).
+.TP
+.B \-\-cyclictest\-priority \fIPRIO\fR
+Run cyclictest with the given priority (default: 95).
+.TP
+.B \-\-cyclictest\-breaktrace \fIUSEC\fR
+Send a break trace command when latency > USEC.
+.TP
+.B \-\-cyclictest\-threshold \fIUSEC\fR
+Exit rteval if latency > USEC.
 
-.SH CYCLICTEST OPTIONS
-These are options that affect the execution behavior of the measurement and load modules.
+.SS Timerlat Module Options
+.TP
+.B \-\-timerlat\-interval \fIINTV_US\fR
+Base interval or period of threads in microseconds (default: 100).
 .TP
-.B \-\-cyclictest-priority=PRIORITY
-SCHED_FIFO priority for measurement threads (default: 95)
+.B \-\-timerlat\-priority \fIPRIO\fR
+Run rtla timerlat with this priority (default: 95).
 .TP
-.B \-\-cyclictest-interval=INTERVAL
-Measurement thread interval in microseconds (default: 100)
+.B \-\-timerlat\-buckets \fINUM\fR
+Number of histogram buckets (default: 3500).
 .TP
-.B \-\-cyclictest-buckets=NBUCKETS
-Number of 1 microsecond histogram buckets (default: 3500)
+.B \-\-timerlat\-stoptrace \fIUSEC\fR
+Stop trace if thread latency higher than USEC.
 .TP
-.B \-\-cyclictest-breaktrace=USEC
-Send a break trace command if latency exceeds the given number of microseconds.
+.B \-\-timerlat\-trace \fIFILE\fR
+File to save trace to.
+.TP
+.B \-\-timerlat\-dma_latency \fIUSEC\fR
+Set /dev/cpu_dma_latency to USEC (set to None to disable) (default: 0).
+
+.SS Hackbench Load Module Options
 .TP
-.B \-\-cyclictest-threshold=USEC
-Exit rteval if latency exceeds the given number of microseconds.
-.SH STRESS-NG OPTIONS
+.B \-\-hackbench\-jobspercore \fINUM\fR
+Number of working threads per CPU core (default: 5).
 .TP
-.B \-\-stressng-option=OPTION
-Pass in command line options for the stress-ng package.
+.B \-\-hackbench\-runlowmem \fITrue|False\fR
+Run hackbench on machines where low memory is detected.
+
+.SS Kcompile Load Module Options
+.TP
+.B \-\-kcompile\-source \fITARBALL\fR
+Source tar ball (default: linux-6.17.7.tar.xz).
+.TP
+.B \-\-kcompile\-jobspercore \fINUM\fR
+Number of working threads per core (default: 2).
+
+.SS Stress-ng Load Module Options
 .TP
-.B \-\-stressng-arg=ARG
-Pass in command line arguments for the stress-ng package.
+.B \-\-stressng\-option \fIOPTION\fR
+Stressor specific option.
 .TP
-.B \-\-stressng-timeout=T
+.B \-\-stressng\-arg \fIARG\fR
+Stressor specific arg.
+.TP
+.B \-\-stressng\-timeout \fIT\fR
 Timeout after T seconds.
 
+.SS Report Analysis Options
+.TP
+.B \-H, \-\-raw\-histogram \fIXMLFILE\fR [\fIXMLFILE\fR ...]
+Generate raw histogram data for one or more already existing XML reports.
+.TP
+.B \-Z, \-\-summarize \fIXMLFILE\fR [\fIXMLFILE\fR ...]
+Summarize one or more already existing XML reports.
+.TP
+.B \-S, \-\-source\-download [\fIKERNEL_VERSION\fR]
+Download a source kernel from kernel.org and exit.
+
+.SH EXAMPLES
+.SS Basic Usage
+Run a 60-second test with default settings (cyclictest measurement, kernel compile and hackbench loads):
+.PP
+.nf
+.RS
+sudo rteval
+.RE
+.fi
+
+.SS Long Duration Test
+Run a 12-hour test with timerlat measurement:
+.PP
+.nf
+.RS
+sudo rteval -d 43200 --measurement-module timerlat
+.RE
+.fi
+
+.SS Measurement Only
+Run timerlat measurement without any load modules:
+.PP
+.nf
+.RS
+sudo rteval -d 600 --measurement-module timerlat --noload
+.RE
+.fi
+
+.SS With Logging and Annotation
+Run with logging enabled and add an annotation to the report:
+.PP
+.nf
+.RS
+sudo rteval -d 3600 -L -a "Testing kernel 6.17.7"
+.RE
+.fi
+
+.SS CPU Isolation with Cpusets
+Run with cpusets to isolate measurement on cores 0-3, loads on cores 4-15, and reserve core 0 for housekeeping:
+.PP
+.nf
+.RS
+sudo rteval --cpusets --measurement-cpulist 1-3 \\
+       --loads-cpulist 4-15 --housekeeping 0
+.RE
+.fi
+
+.SS Custom Timerlat Configuration
+Run timerlat with custom interval and stop trace threshold:
+.PP
+.nf
+.RS
+sudo rteval -d 1800 --measurement-module timerlat \\
+       --timerlat-interval 1000 --timerlat-stoptrace 100
+.RE
+.fi
+
+.SS Analyze Existing Reports
+Summarize multiple existing XML reports:
+.PP
+.nf
+.RS
+rteval -Z rteval-20260601-1/summary.xml \\
+          rteval-20260602-1/summary.xml
+.RE
+.fi
+
 .SH FILES
-.BR rteval-YYYYMMDD-S
-This is a directory created by rteval to hold the summary.xml file as
-well as other files collected on the system. It is the current Year,
-Month, and Day, followed by a sequence number for multiple runs on the
-same day.
-
-.BR summary.xml
-This is an XML file that contains information about a test run and the
-host system upon which rteval was run.
-.BR dmesg
-This is the output of the dmesg(1) program immediately following
-system boot. It is copied from /var/log/dmesg.
+.TP
+.I rteval-YYYYMMDD-N/
+Report directory created for each run, containing:
+.RS
+.TP
+.I summary.xml
+XML report with system info, measurements, and statistics
+.TP
+.I logs/
+Directory containing measurement and load module logs (with -L option)
+.RE
+
+.SH MEASUREMENT MODULES
+.TP
+.B cyclictest
+Measures scheduling latency by running high-priority SCHED_FIFO threads that sleep
+for a specified interval and measure wakeup latency. This is the traditional measurement
+tool for realtime Linux testing.
+.TP
+.B timerlat
+Uses the rtla (Real-Time Linux Analysis) tool's timerlat tracer to measure timer latency.
+This is a more modern approach that leverages kernel tracing infrastructure and can provide
+more detailed analysis of latency sources.
+
+.SH LOAD MODULES
+.TP
+.B kcompile
+Performs parallel kernel compilation to create CPU and I/O load. Compiles with
+allmodconfig to maximize compilation work.
+.TP
+.B hackbench
+Scheduler stress test that creates pairs of threads exchanging data via pipes or
+sockets, exercising the kernel scheduler.
+.TP
+.B stress-ng
+Flexible stress testing tool with many stressor options for CPU, memory, I/O, and more.
+
+.SH NOTES
+.PP
+Root privileges are required to run rteval as it needs to set real-time scheduling
+priorities and access system resources.
+.PP
+For production testing, run for at least 12-24 hours to capture rare latency events.
+The default 60-second duration is only suitable for quick validation.
+.PP
+When using cpusets (--cpusets), ensure your kernel has cgroup v2 support and the
+cpuset controller is available.
+.PP
+The timerlat measurement module requires a kernel with rtla support (kernel 5.15+
+with CONFIG_OSNOISE_TRACER enabled).
 
 .SH SEE ALSO
-.BR cyclictest(8).
-.br
-.SH AUTHOR
-rteval was written by Clark Williams <williams@redhat.com>
+.BR cyclictest (8),
+.BR rtla (1),
+.BR rtla-timerlat (1),
+.BR stress-ng (1)
+
+.SH AUTHORS
+rteval was written by Clark Williams, David Sommerseth, and John Kacur.
+.PP
+This manual page was written for rteval 3.10 in June 2026.
+
+.SH REPORTING BUGS
+Report bugs to linux-rt-users@vger.kernel.org
 .PP
-XML-RPC and database code by David Sommerseth <davids@redhat.com>
+CC: John Kacur <jkacur at redhat.com>, Clark Williams <williams at redhat.com>
-- 
2.54.0

