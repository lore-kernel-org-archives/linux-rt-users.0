Return-Path: <SRS0=mM24=5W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542D4C2BA1A
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Apr 2020 22:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1E8206C3
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Apr 2020 22:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9BxBe/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgDFWOP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:14:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:60895 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbgDFWOP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Apr 2020 18:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mzfQbmzvAQS3PQzkOkxWlGKKfC55vsfBJaPV4eL5iX0=;
        b=c9BxBe/RmKaJNTzioC1fToWLvrLUOZ+ja8JXlYPI+TxM01ShzK/3UcveTAGT35LfXiuRNE
        0wpXNT+Bj+2DAACh5DnokI7pxf8BJknH9GsJDgxOQfWB7PsbFb2sI2SSWkM4+5z2FgpaUc
        x1ie9K1W5ux1dh8k4TZCOKp0gsU23jA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Jpl38GJoNIGzyBhM9vBk0A-1; Mon, 06 Apr 2020 18:14:07 -0400
X-MC-Unique: Jpl38GJoNIGzyBhM9vBk0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B8C518AB2C2
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Apr 2020 22:14:06 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-112-46.phx2.redhat.com [10.3.112.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 128E010021B3;
        Mon,  6 Apr 2020 22:14:05 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Scott Wood <swood@redhat.com>
Subject: [RTEVAL PATCH 1/3] Makefile: Remove non-distutil install leftovers
Date:   Mon,  6 Apr 2020 17:14:03 -0500
Message-Id: <20200406221405.3043-1-swood@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

setup.py installs into /usr/local by default, but the makefile
is still creating directories in /usr that it doesn't install
anything into.  Worse, the uninstall target removes things
from /usr rather than what was installed by "make install".

Signed-off-by: Scott Wood <swood@redhat.com>
---
 Makefile | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/Makefile b/Makefile
index f784ba778bc3..f91e6e06a9a4 100644
--- a/Makefile
+++ b/Makefile
@@ -15,9 +15,6 @@ XMLRPCDIR :=3D server
 DESTDIR	:=3D
 PREFIX  :=3D      /usr
 DATADIR	:=3D	$(DESTDIR)/$(PREFIX)/share
-CONFDIR	:=3D	$(DESTDIR)/etc
-MANDIR	:=3D	$(DESTDIR)/$(PREFIX)/share/man
-PYLIB	:=3D 	$(DESTDIR)$(shell $(PYTHON) -c 'import distutils.sysconfig; =
 print distutils.sysconfig.get_python_lib()')
 LOADDIR	:=3D	loadsource
=20
 KLOAD	:=3D	$(LOADDIR)/linux-5.1.tar.xz
@@ -60,17 +57,6 @@ install_loads:	$(LOADS)
=20
 installdirs:
 	[ -d $(DATADIR)/rteval ] || mkdir -p $(DATADIR)/rteval
-	[ -d $(CONFDIR) ] || mkdir -p $(CONFDIR)
-	[ -d $(MANDIR)/man8 ]  || mkdir -p $(MANDIR)/man8
-	[ -d $(PYLIB) ]   || mkdir -p $(PYLIB)
-	[ -d $(DESTDIR)/usr/bin ] || mkdir -p $(DESTDIR)/usr/bin
-
-uninstall:
-	rm -f /usr/bin/rteval
-	rm -f $(CONFDIR)/rteval.conf
-	rm -f $(MANDIR)/man8/rteval.8.gz
-	rm -rf $(PYLIB)/rteval
-	rm -rf $(DATADIR)/rteval
=20
 tarfile: rteval-$(VERSION).tar.bz2
=20
--=20
2.18.2

