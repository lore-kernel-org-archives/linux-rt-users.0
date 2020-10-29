Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B76BC4363A
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E082076D
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWfgL2/W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgJ2RlO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgJ2RlO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:41:14 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45DC0613D2
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:14 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id r7so2678970qkf.3
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=leRIDG02papUstmLrtBLIquBNWjJYmKb/wG67ywkCYw=;
        b=pWfgL2/W86Lo+VOzxtTgyd5/Od1W759F7mY7xH1sHiTCcccW/Bujlx7lIhjKDn8Xbh
         QC46Nwb0s09vcUL6qSgur0HJYLQg10Ot7XSZ5NhA4oQPjqNIn9vYFZdGbTuIc4pX5nAJ
         sOFLdTClnNMbR66bBAjhK67RS/I6BNExBVssAXvGzQwxuieE0iQJ6LIKauPZbrOMkUo6
         vMnkqv6rzGhXLRi1i/xt/6T9xSHWo52/PRJ5YNq/IlMAQ6MCDvIpqOvPoEmB6sK8S8ll
         2JylrQaa9i1JQkA2FY7PDnF1bspXD8k+U7aVAoEg3B8+/3WGbVzDw0WJIkBClAcR8H78
         x/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=leRIDG02papUstmLrtBLIquBNWjJYmKb/wG67ywkCYw=;
        b=EvePvL4YYXQTkrTxV0rvwtzK/9h4SNSxZxJdYI22d9wTA6weI5/hLLcrmuCHrEMjd6
         gDBVK+aqgOkeXwbyvrHKJMyO+u2DB+y7aaZt4M9SqZF0g5/BpWHGJZs2l6HMWBhpd4Jz
         QB9qKlhX+3CEgAs5rsoMcDnC/JMzbgA4VXlQB9B+O/XEu9ay3mr/A6lNVx0jwV5QNpDA
         18euOOqVZCs00wF8odzDCLA8bsOpn5pAnhhzdC9WhDs9g6XrHeDSK2qNdqv8GEjSQvSU
         ihUeindE8U0v4fY2fJCPtmgxGJ9Ccw0MEknpnpAGmjeY7Z+LzfE5Jq6x3sctqGf55BYm
         NUKQ==
X-Gm-Message-State: AOAM5303n67PS6Qs6iDEKlvBymIBu/0i5+diCirLntecwH07ixzSFKy1
        +l/efdmW3k6hYzYJH5c72fvFDWhiif+GAw==
X-Google-Smtp-Source: ABdhPJyA/pnlxe1y7jn/ku2klMCcgbFN3ESE0TLkMFq0uzRsSADEBKbm2GR2fNx2t7PXGhScGWUlJQ==
X-Received: by 2002:a37:aa49:: with SMTP id t70mr4749068qke.165.1603993273001;
        Thu, 29 Oct 2020 10:41:13 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id z13sm1472460qkl.2.2020.10.29.10.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 10:41:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 01/16] rt-tests: remove pi_tests.spec
Date:   Thu, 29 Oct 2020 13:40:42 -0400
Message-Id: <20201029174057.20033-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029174057.20033-1-jkacur@redhat.com>
References: <20201029174057.20033-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is an ancient spec file from way back before this program was
included in the rt-tests suite. There is no need to keep it around
anymore.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/pi_tests/pi_tests.spec | 81 --------------------------------------
 1 file changed, 81 deletions(-)
 delete mode 100644 src/pi_tests/pi_tests.spec

diff --git a/src/pi_tests/pi_tests.spec b/src/pi_tests/pi_tests.spec
deleted file mode 100644
index 7526faaadff1..000000000000
--- a/src/pi_tests/pi_tests.spec
+++ /dev/null
@@ -1,81 +0,0 @@
-Summary: Programs used to test Priority Inheritance Mutexes
-Name: pi_tests
-Version: 1.17
-Release: 1%{?dist}
-License: GPL
-Group: Development/Tools
-URL: http://people.redhat.com/~williams/tests
-Source0: %{name}-%{version}.tar.gz
-BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
-
-%define mandir usr/share/man
-
-%description
-The pi_tests package contains programs used to test the functionality of 
-the priority inheritance attribute of POSIX mutexes on the Linux kernel
-
-%prep
-%setup -q
-
-%build
-make all
-
-%install
-rm -rf $RPM_BUILD_ROOT
-mkdir $RPM_BUILD_ROOT
-install -D -m 755 classic_pi $RPM_BUILD_ROOT/usr/sbin/classic_pi
-install -D -m 755 pi_stress $RPM_BUILD_ROOT/usr/sbin/pi_stress
-install -D -m 644 pi_stress.8 $RPM_BUILD_ROOT/%{mandir}/man8/pi_stress.8
-gzip $RPM_BUILD_ROOT/%{mandir}/man8/pi_stress.8
-install -D -m 644 COPYING $RPM_BUILD_ROOT/usr/share/doc/%{name}-%{version}/COPYING
-install -D -m 644 README $RPM_BUILD_ROOT/usr/share/doc/%{name}-%{version}/README
-
-%clean
-rm -rf $RPM_BUILD_ROOT
-
-%files
-%defattr(-,root,root,-)
-/usr/sbin/classic_pi
-/usr/sbin/pi_stress
-%doc
-/usr/share/man/man8/pi_stress.8.gz
-/usr/share/doc/%{name}-%{version}/COPYING
-/usr/share/doc/%{name}-%{version}/README
-
-%changelog
-* Wed Jan  2 2008 Clark Williams <williams@redhat.com> - 1.17-1
-- fixed logic error with watchdog_check()
-
-* Wed Jul 11 2007 Clark Williams <williams@redhat.com> - 1.16-1
-- bumped version for packaging in RHEL-RT
-- added usage() to classic_pi
-- removed --signal option in pi_stress
-
-* Wed Jul 11 2007 Clark Williams <williams@redhat.com> - 1.15-1
-- added rpmlint target to Makefile
-- fixed rpmlint complaints in specfile
-
-* Wed Dec 12 2006 Clark Williams <williams@redhat.com> - 1.14-1
-- changed how pi_stress shutdown is handled
-- fixed dealing with --iterations shutdown
-
-* Thu Dec  7 2006 Clark Williams <williams@redhat.com> - 1.13-1
-- Added README and COPYING files
-
-* Wed Dec  6 2006 Clark Williams <williams@redhat.com> - 1.12-1
-- changed shutdown variable to volatile
-- bumped version
-
-* Mon Dec  4 2006 Clark Williams <williams@redhat.com> - 1.11-1
-- Modified priorities to be just above minimum (as opposed to just below max)
-
-* Thu Nov 30 2006 Clark Williams <williams@redhat.com> - 1.10-1
-- added timing logic to pi_stress.c
-- refactored function order in pi_stress.c
-
-* Wed Nov 29 2006 Clark Williams <williams@redhat.com> - 1.9-1
-- added --duration logic to pi_stress.c
-
-* Mon Nov 27 2006 Clark Williams <williams@redhat.com> - 1.8-1
-- Initial packaging.
-
-- 
2.26.2

