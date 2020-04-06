Return-Path: <SRS0=mM24=5W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C3DC2BA80
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Apr 2020 22:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2786206C3
	for <linux-rt-users@archiver.kernel.org>; Mon,  6 Apr 2020 22:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GE9W8lRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDFWOL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:14:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50841 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726197AbgDFWOL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 6 Apr 2020 18:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7zWvV0Prq3af9RG69osMbfKg9IZ985DwVcY+H/0K6no=;
        b=GE9W8lRYdwe8/m/4IUfDnpPnZFH2iLveM3aCDN+oGMDPjWR+Q4lh2QJaIW4Q2Pr6zfskx4
        49ZcS5YY4jOYFe4CX7n+9uowWLMn+awzEvKcJnkIWHo2JNm/qAkZ3vFuGtClf257sNO1hK
        0pGx5yDEy4DgPg7PN32Je8IZqIBhzI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-0lBzL-QmPhWU9jvT64_mtQ-1; Mon, 06 Apr 2020 18:14:08 -0400
X-MC-Unique: 0lBzL-QmPhWU9jvT64_mtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C353D800D4E
        for <linux-rt-users@vger.kernel.org>; Mon,  6 Apr 2020 22:14:07 +0000 (UTC)
Received: from t460p.redhat.com (ovpn-112-46.phx2.redhat.com [10.3.112.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B94110021B3;
        Mon,  6 Apr 2020 22:14:07 +0000 (UTC)
From:   Scott Wood <swood@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Scott Wood <swood@redhat.com>
Subject: [RTEVAL PATCH 3/3] modules: Don't abort if a workload isn't running
Date:   Mon,  6 Apr 2020 17:14:05 -0500
Message-Id: <20200406221405.3043-3-swood@redhat.com>
In-Reply-To: <20200406221405.3043-1-swood@redhat.com>
References: <20200406221405.3043-1-swood@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Each module is responsible for respawning the load when it finishes.  The
only thing that the additional check at the rtevalModulePrototype level
accomplishes is introducing a race condition that will kill rteval if a
load ends after _WorkloadTask() checks, but before the check in the
caller.

Signed-off-by: Scott Wood <swood@redhat.com>
---
 rteval/modules/__init__.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index 0feb8a916179..5ae7cd488406 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -189,9 +189,6 @@ class rtevalModulePrototype(threading.Thread):
=20
                 if self.shouldStop():
                     break
-                if not self.WorkloadAlive():
-                    self._log(Log.DEBUG, "%s workload stopped running." =
% self._module_type)
-                    break
                 time.sleep(self.__sleeptime)
=20
             self.__timestamps["runloop_stop"] =3D datetime.now()
--=20
2.18.2

