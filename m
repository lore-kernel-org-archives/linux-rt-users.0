Return-Path: <SRS0=P7c/=4J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8661AC35669
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5712D2073A
	for <linux-rt-users@archiver.kernel.org>; Fri, 21 Feb 2020 21:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7rsq60N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBUVA6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Feb 2020 16:00:58 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35116 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgBUVA6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Feb 2020 16:00:58 -0500
Received: by mail-qk1-f195.google.com with SMTP id l13so461345qkk.2
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Feb 2020 13:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/M5YAeNI/RvgOduvJ7pu14nLhLBKZxhvhrYEQBQyAtY=;
        b=b7rsq60NFLOjmx/onPS2AFGZqeEGZiWLYH/6iBtELyPraeHPTv5TI03gbDeModMZgh
         lfx6w2oS+2EuLsqMBPhG1ZHS8PjYYMPaoz95YDXkgiDZNz7b/+idY/+1JE6sZSKFqoCw
         aPm/9mliPwy/+oyBn2U2agxJtcCXhhzqnfpGzgBa5LEx2B62dLifE6ODvZMRu1w3mqWS
         DgaH/uNmtZ8e8tNiDAlJltcxhdFvug4uPjJQsLWH05Hzo8C+3K30yOL43ocxpydtV3b7
         FXtkFJEhN6+r1D9ckSjz9wSg36HlC3BRPOCaaPWTN4J7QBpNO/NXy9gXJd1iLeU83s1/
         MleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=/M5YAeNI/RvgOduvJ7pu14nLhLBKZxhvhrYEQBQyAtY=;
        b=BXXmNJdJmUADOPRD8colT+1coohMm7Nvw5tSOVJCMPRkvUFsz893Dx0y+MlWL+2ny7
         IEwgYqm/UIF47psTC0mbfLc4vl6f/bUInPP4IlPBPkmRQRvwiO8648vh5ibU0BUnvrTd
         61FRR5CCiCqp81tKMPjGgxkUwNHLL9caXdBJeGJh40vwFZvCxUUr08UIIiGrFi3PpO5q
         QJSsveP2hhkNA1RALyRhBjpRFbJ209d4ig6/Oa9CrFjYyRSt1Cn0uDCbmnu6tN0SO8un
         r1RUZvX4iMH+nOjpdifYt8hPr13kEG3USmMEPsipbrohd7gJEGjQFxqdANzH04+Dl9AI
         OMmw==
X-Gm-Message-State: APjAAAWtXr87kGGeKf4xQKqeO7iGOGee9Qq5c2W7TCyZ//Lqr/Op0s6o
        VecZUuqqnEt+f/C4OZ0NcE6gfzM17lo=
X-Google-Smtp-Source: APXvYqz3GB7I/ob44JZ32yblgl4BnJ2VT5kbn5SjBQJ5X2kncML4f/d+27v9IoCW1BYuaRkhrNQy8A==
X-Received: by 2002:a05:620a:2159:: with SMTP id m25mr19858513qkm.457.1582318857464;
        Fri, 21 Feb 2020 13:00:57 -0800 (PST)
Received: from planxty.redhat.com (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id h14sm2018561qke.99.2020.02.21.13.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 13:00:56 -0800 (PST)
From:   John Kacur <jkacur@redhat.com>
To:     rt-users <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Add get_cyclictest_snapshot to Makefile
Date:   Fri, 21 Feb 2020 16:00:47 -0500
Message-Id: <20200221210047.14107-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add get_cyclictest_snapshot to Makefile

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index ecbd5b1cb98b..ba73d97cd9b1 100644
--- a/Makefile
+++ b/Makefile
@@ -122,7 +122,7 @@ $(OBJDIR)/%.d: %.c | $(OBJDIR)
 	@$(CC) -MM $(CFLAGS) $(CPPFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@ || rm -f $@
 
 .PHONY: all
-all: $(TARGETS) hwlatdetect | $(OBJDIR)
+all: $(TARGETS) hwlatdetect get_cyclictest_snapshot | $(OBJDIR)
 
 $(OBJDIR):
 	mkdir $(OBJDIR)
@@ -149,6 +149,10 @@ hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 	chmod +x src/hwlatdetect/hwlatdetect.py
 	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
 
+get_cyclictest_snapshot: src/cyclictest/get_cyclictest_snapshot.py
+	chmod +x src/cyclictest/get_cyclictest_snapshot.py
+	ln -s src/cyclictest/get_cyclictest_snapshot.py get_cyclictest_snapshot
+
 rt-migrate-test: $(OBJDIR)/rt-migrate-test.o $(OBJDIR)/librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
@@ -194,6 +198,7 @@ clean:
 	for F in $(CLEANUP); do find -type f -name $$F | xargs rm -f; done
 	rm -f rt-tests-*.tar
 	rm -f hwlatdetect
+	rm -f get_cyclictest_snapshot
 	rm -f tags
 
 RPMDIRS = BUILD BUILDROOT RPMS SRPMS SPECS
@@ -207,7 +212,7 @@ rebuild:
 	$(MAKE) all
 
 .PHONY: install
-install: all install_manpages install_hwlatdetect
+install: all install_manpages install_hwlatdetect install_get_cyclictest_snapshot
 	mkdir -p "$(DESTDIR)$(bindir)"
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
 	install src/queuelat/get_cpuinfo_mhz.sh "$(DESTDIR)$(bindir)"
@@ -222,6 +227,15 @@ install_hwlatdetect: hwlatdetect
 		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
 	fi
 
+.PHONY: install_get_cyclictest_snapshot
+install_get_cyclictest_snapshot: get_cyclictest_snapshot
+	if test -n "${PYLIB}" ; then \
+		mkdir -p "${DESTDIR}${bindir}" ; \
+		install -D -m 755 src/cyclictest/get_cyclictest_snapshot.py ${DESTDIR}${PYLIB}/get_cyclictest_snapshot.py ; \
+		rm -f "${DESTDIR}${bindir}/get_cyclictest_snapshot" ; \
+		ln -s ${PYLIB}/get_cyclictest_snapshot.py "${DESTDIR}${bindir}/get_cyclictest_snapshot" ; \
+	fi
+
 .PHONY: install_manpages
 install_manpages: $(MANPAGES)
 	mkdir -p "$(DESTDIR)$(mandir)/man8"
-- 
2.20.1

