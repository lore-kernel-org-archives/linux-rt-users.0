From: John Kacur <jkacur@redhat.com>
Subject: Makefile: Only call cc -dumpmachine once in the makefile
Date: Tue, 6 Oct 2015 09:07:49 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510060906500.14006@riemann>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:36969 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbbJFHHw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Oct 2015 03:07:52 -0400
Received: by wicfx3 with SMTP id fx3so144881474wic.0
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Oct 2015 00:07:51 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

>From 1054004fbb3cb913717f5729f916e9cb1201505c Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Mon, 5 Oct 2015 22:37:46 +0200
Subject: [PATCH 1/2] Makefile: Only call cc -dumpmachine once in the makefile

- Store the result of cc -dumpmachine in the dumpmachine variable
- Use makefile parsing to obtain the ostype
- Use shell and sed functions to obtain the machinetype
- Turn on the bionic functionality if the ostype=android

Signed-off-by: John Kacur <jkacur@redhat.com>
Tested-by: Henrik Austad <haustad@cisco.com>
---
 Makefile | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 6ce2ecc7fc30..4c4a06e1fc6e 100644
--- a/Makefile
+++ b/Makefile
@@ -40,8 +40,13 @@ else
 endif
 
 # We make some gueses on how to compile rt-tests based on the machine type
-# These can often be overridden
-machinetype = $(shell $(CC) -dumpmachine | \
+# and the ostype. These can often be overridden.
+dumpmachine = $(shell $(CC) -dumpmachine)
+
+# The ostype is typically something like linux or android
+ostype=$(lastword $(subst -, ,$(dumpmachine)))
+
+machinetype = $(shell echo $(dumpmachine)| \
     sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
 
 # The default is to assume you have libnuma installed, which is fine to do
@@ -70,8 +75,7 @@ endif
 # - pthread_[gs]etaffinity
 #
 # Typically see something like "aarch64-linux-android"
