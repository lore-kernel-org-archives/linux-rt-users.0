From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] Allow building with -DHAVE_PARSE_CPUSTRING_ALL
Date: Wed, 27 May 2015 23:06:42 +0200 (CEST)
Message-ID: <alpine.LFD.2.10.1505272304220.13094@riemann>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34914 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbE0VGz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 May 2015 17:06:55 -0400
Received: by wicmx19 with SMTP id mx19so125262350wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2015 14:06:54 -0700 (PDT)
Received: from [192.168.178.29] (ip1f136751.dynamic.kabel-deutschland.de. [31.19.103.81])
        by mx.google.com with ESMTPSA id k2sm898479wif.3.2015.05.27.14.06.52
        for <linux-rt-users@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2015 14:06:52 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From cc0901e72d3e1a916fc97909e7c0c73264b61438 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Wed, 27 May 2015 22:51:42 +0200
Subject: [PATCH] Allow building with -DHAVE_PARSE_CPUSTRING_ALL

This is a temporary solution until we have time to look into autotools
If you know that you are building on a system that has
numa_parse_cpustring_all()

Then you can type
make HAVE_PARSE_CPUSTRING_ALL=1
to define it.

If you omit that, then the default is the old behaviour that uses
numa_parse_cpustring((char *)s)

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 5d7f449cc026..4c260cf00697 100644
--- a/Makefile
+++ b/Makefile
@@ -22,14 +22,18 @@ srcdir	?= $(prefix)/src
 
 machinetype = $(shell $(CC) -dumpmachine | \
     sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
-ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
-NUMA 	:= 1
-endif
 
 CFLAGS ?= -Wall -Wno-nonnull
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=
 
+ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
+NUMA 	:= 1
+ifdef HAVE_PARSE_CPUSTRING_ALL
+	CFLAGS += -DHAVE_PARSE_CPUSTRING_ALL
+endif
+endif
+
 PYLIB  := $(shell python -c 'import distutils.sysconfig;  print distutils.sysconfig.get_python_lib()')
 
 ifndef DEBUG
-- 
1.8.3.1

