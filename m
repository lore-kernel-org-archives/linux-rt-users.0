Return-Path: <SRS0=fTCY=UN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB50C31E4B
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 13:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE5320850
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Jun 2019 13:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHMM9CqH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfFNNGS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:06:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35540 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFNNGS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Jun 2019 09:06:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so2491887wrv.2
        for <linux-rt-users@vger.kernel.org>; Fri, 14 Jun 2019 06:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bs8LX9zf6NOKkal6w5Cv9TruFNjJFVlhNVCCI2kMZFE=;
        b=RHMM9CqHTNHBPOVEvwkTmMjAhtcHwBeL4DEG/Bi/94eUbdQ3PjUrzoFI3CK3eiNnU3
         gQlN+WZP3JiB7kcAMkOooE/RIZaVJ5+vNQd+CHQSwn3WI5n8uYIQycS800F2/1CCTaMp
         d5BMejPbV5UHjZr/8/pcrZrTgn6Pqb4WktBDhqyaUwmI42EW1hAzH1OxcGehizHCGeAQ
         WruZoPkpNMMdCOIFyfYQN7sZWH7/FUGVohwzRMiBIPD9D5LA7P2De3YKGrDo9yF1vRsN
         GU3+ytMv097EjCPYNxJGOLZkrzBPz7fWE7PRUSH4+Z5Sa5w/FQFeKe6O1WwrK1pLEIot
         raDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=bs8LX9zf6NOKkal6w5Cv9TruFNjJFVlhNVCCI2kMZFE=;
        b=YNsYeUIg0+/nhcyEah03f1bYkWvVKZ88JG6f2Vv/hLAvwlSeDb0u2Ha7gUzT0hjh9h
         fdrTIn+yxd/1J74gSR36SwKZpFhRaczCn2RL+v0eD00JLn66Ik0cdjc5r6MgZRoQuj9V
         aLjTpvX4rCqt/m2CTP5O18kVkwi6hmN/rSFf22uzPslMluncYS9Vc8f/2k+bebYoclDH
         zLPbt7eQ3uFDGWMgnF28DA2Xtm68Db519dvjoxM9x+vZt9Cq+oHkciNaGbLxl2barOYO
         Y3GvQ2McifxNhz7OXcdX99Rz+9tYbEV96BaBIgCK20MgC1M3g/2gswkbzTNDIOpFQ4/3
         6wQw==
X-Gm-Message-State: APjAAAVQ7JWXgKnl17cJXBioFrQ+cDeFsnO26QlmDEukt/HgZ/hGGJ7m
        H1tExwFmQkkZhdsiR+CvHDU=
X-Google-Smtp-Source: APXvYqxVEYID4TuWaq9GxwatXYLMO9SAWvaej/SFjgSnlNRQpPE7xqhAJ4execTK8Okbx7nL8efBdA==
X-Received: by 2002:adf:df91:: with SMTP id z17mr58553013wrl.336.1560517576383;
        Fri, 14 Jun 2019 06:06:16 -0700 (PDT)
Received: from planxty.redhat.com (ip4d14ff42.dynamic.kabel-deutschland.de. [77.20.255.66])
        by smtp.gmail.com with ESMTPSA id 67sm3178684wmd.38.2019.06.14.06.06.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 06:06:15 -0700 (PDT)
From:   John Kacur <jkacur@redhat.com>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: ssdd: Add a simple manpage for ssdd
Date:   Fri, 14 Jun 2019 15:06:06 +0200
Message-Id: <20190614130606.13829-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add a simple manpage to rt-tests for ssdd, and modify the manpage to
install it

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile        |  1 +
 src/ssdd/ssdd.8 | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 src/ssdd/ssdd.8

diff --git a/Makefile b/Makefile
index ea80923918f7..0258fe9b6dfd 100644
--- a/Makefile
+++ b/Makefile
@@ -194,6 +194,7 @@ install: all install_hwlatdetect
 	gzip -c src/pi_tests/pip_stress.8 >"$(DESTDIR)$(mandir)/man8/pip_stress.8.gz"
 	gzip -c src/queuelat/queuelat.8 >"$(DESTDIR)$(mandir)/man8/queuelat.8.gz"
 	gzip -c src/sched_deadline/deadline_test.8 >"$(DESTDIR)$(mandir)/man8/deadline_test.8.gz"
+	gzip -c src/ssdd/ssdd.8 >"$(DESTDIR)$(mandir)/man8/ssdd.8.gz"
 
 .PHONY: install_hwlatdetect
 install_hwlatdetect: hwlatdetect
diff --git a/src/ssdd/ssdd.8 b/src/ssdd/ssdd.8
new file mode 100644
index 000000000000..44638489f0d1
--- /dev/null
+++ b/src/ssdd/ssdd.8
@@ -0,0 +1,29 @@
+.TH SSDD 8 "June 13, 2019"
+.SH NAME
+ssdd \- have a tracer do a bunch of PTRACE_SINGLESTEPs
+.SH SYNOPSIS
+.B ssdd
+.RI "[nforks] [niters]"
+.SH DESCRIPTION
+Have a tracer do a bunch of PTRACE_SINGLESTEPs against
+a tracee as fast as possible.  Create several of these
+tracer/tracee pairs and see if they can be made to
+interfere with each other.
+The tracer waits on each PTRACE_SINGLESTEP with a waitpid(2)
+and checks that waitpid's return values for correctness.
+.SH OPTIONS
+.B nforks
+number of tracer/tracee pairs to fork off.
+Default is 10.
+.br
+.TP
+.B niters
+number of PTRACE_SINGLESTEP iterations to
+do before declaring success, for each tracer/
+tracee pair set up. Default is 10,000.
+
+.SH AUTHOR
+ssdd was written by Joe Korty <joe.korty@concurrent-rt.com>
+.PP
+This manual page was written by John Kacur <jkacur@redhat.com>
+
-- 
2.20.1

