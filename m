Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A9C001DF
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Aug 2023 06:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242223AbjHPG6q (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Aug 2023 02:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242222AbjHPG6d (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Aug 2023 02:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999251BCC
        for <linux-rt-users@vger.kernel.org>; Tue, 15 Aug 2023 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692169069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uirw3bW3wGzCOJW96S1woJbAT052Eof2zw9pXt3cFno=;
        b=WSvHwg4XWo0uIXQEhGCNlqqMkmeygqDTD4ZLcsp1azRf/rLDL2UiQqe2ytWBsS/MBqw+oZ
        njd26PmCUMNeWTH/MoNBlLccJ9uPp9h/XmoClax5BIFxpp8i6EWMhIcT1twi2EEVaY06XF
        R2NjyvuNxhBzZAHmhHiYbW7g/MY9qkc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-_ZcNLLv9MTCjCsSyTsTQqw-1; Wed, 16 Aug 2023 02:57:48 -0400
X-MC-Unique: _ZcNLLv9MTCjCsSyTsTQqw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3ACF3C0218E
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Aug 2023 06:57:47 +0000 (UTC)
Received: from fedora.. (unknown [10.43.17.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5714A40C207A;
        Wed, 16 Aug 2023 06:57:47 +0000 (UTC)
From:   Tomas Glozar <tglozar@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     jkacur@redhat.com, Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH 1/2] rteval: Support custom argument default value help
Date:   Wed, 16 Aug 2023 08:57:39 +0200
Message-ID: <20230816065740.283407-2-tglozar@redhat.com>
In-Reply-To: <20230816065740.283407-1-tglozar@redhat.com>
References: <20230816065740.283407-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Add an optional default_value option to sets returned from
ModuleParameters to specify a different default value help text than
the value of default field.

This is useful for cases where the default value depends on
the environment

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 rteval/modules/__init__.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rteval/modules/__init__.py b/rteval/modules/__init__.py
index e7025ce..469d0f0 100644
--- a/rteval/modules/__init__.py
+++ b/rteval/modules/__init__.py
@@ -307,12 +307,13 @@ the information provided by the module"""
                 if default is None:
                     default = 'default' in s and s['default'] or None
 
+                default_text = s['default_text'] if 'default_text' in s else default
 
                 grparser.add_argument('--%s-%s' % (shortmod, o),
                                     dest="%s___%s" % (shortmod, o),
                                     action='store',
                                     help='%s%s' % (descr,
-                                                   default and ' (default: %s)' % default or ''),
+                                                   default and ' (default: %s)' % default_text or ''),
                                     default=default,
                                     metavar=metavar)
 
-- 
2.41.0

