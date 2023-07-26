Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7785DC001DE
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jul 2023 14:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbjGZOtV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjGZOtU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jul 2023 10:49:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247C72116
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 07:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690382912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LhtcYX3wuelCL6PmJGK0gnTXE/rR5NT+NLoM4uAZns=;
        b=RX/nUskm9itmbHYOX3+5YTpxAGib4Ez3LGo491ekZR5koOj+mD2dtI4jj+9BFDhHIjHjG4
        gzKSUHZhl8nPs4ZCTSPITjwqo0GSjvYaq10EwyBSuF+k4t9iT9I67Rcn6Fxa/troMJPILS
        kyNb+/lnviwZB3tDzrMJ3ZqupBIB1jo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-nVGyVF35OBmA021h7BDvpg-1; Wed, 26 Jul 2023 10:48:30 -0400
X-MC-Unique: nVGyVF35OBmA021h7BDvpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 078C18870D8
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 14:48:30 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D57504094DC1;
        Wed, 26 Jul 2023 14:48:29 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     kcarcia@redhat.com, Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH 3/5] __init__: Added SPDX licence
Date:   Wed, 26 Jul 2023 10:48:24 -0400
Message-Id: <20230726144826.355643-4-ashelat@redhat.com>
In-Reply-To: <20230726144826.355643-1-ashelat@redhat.com>
References: <20230726144826.355643-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

__init__: Added SPDX licence
Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
---
 procfs/__init__.py | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/procfs/__init__.py b/procfs/__init__.py
index 071c54dacab8..99785e735d4a 100644
--- a/procfs/__init__.py
+++ b/procfs/__init__.py
@@ -1,22 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
 #! /usr/bin/python3
 # -*- python -*-
 # -*- coding: utf-8 -*-
 #
-# Copyright (C) 2008, 2009 Red Hat, Inc.
-#
-# This program is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; version 2 of the License.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-#
 """
 Copyright (c) 2008, 2009  Red Hat Inc.
 
-- 
2.39.3

