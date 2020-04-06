Return-Path: <SRS0=mM24=5W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBECC2BA1A
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Apr 2020 22:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B9820768
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Apr 2020 22:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VPFrrRsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgDFWOL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:14:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34146 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726112AbgDFWOK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Apr 2020 18:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzNY+qF58JOwi8aBjFFdtObYqQrbOu3aZRdg3ZWVM9s=;
        b=VPFrrRsTz2ExrTEhoyV+dGzFhSY9Vx3MVtnL71oySw0yAogH3/lQUwVUVrA5Fum8lkE/pi
        S9JRAO2Mcyc5rpbd/bSa5zmnuBVcpD0yDkvJmCqP4GejbrJgXwuwjtNgMTVdZhwrQvF55G
        v6l9lYReF+eVDBOEN6usXKcdAi/MM6w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-iS2-8pl4M6SBSoxeAw2FSQ-1; Mon, 06 Apr 2020 18:14:08 -0400
X-MC-Unique: iS2-8pl4M6SBSoxeAw2FSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C1F9149C0
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Apr 2020 22:14:07 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-112-46.phx2.redhat.com [10.3.112.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA2FD10021B3;
        Mon,  6 Apr 2020 22:14:06 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Scott Wood <swood@redhat.com>
Subject: [RTEVAL PATCH 2/3] Makefile: Use parentheses around print args
Date:   Mon,  6 Apr 2020 17:14:04 -0500
Message-Id: <20200406221405.3043-2-swood@redhat.com>
In-Reply-To: <20200406221405.3043-1-swood@redhat.com>
References: <20200406221405.3043-1-swood@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Otherwise, this fails on python3.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index f91e6e06a9a4..479bda8d8674 100644
--- a/Makefile
+++ b/Makefile
@@ -5,7 +5,7 @@ else
 	PYTHON =3D python2
 endif
 PACKAGE :=3D	rteval
-VERSION :=3D      $(shell $(PYTHON) -c "from rteval import RTEVAL_VERSIO=
N; print RTEVAL_VERSION")
+VERSION :=3D      $(shell $(PYTHON) -c "from rteval import RTEVAL_VERSIO=
N; print(RTEVAL_VERSION)")
 D	:=3D	10
=20
 # XML-RPC related files
--=20
2.18.2

