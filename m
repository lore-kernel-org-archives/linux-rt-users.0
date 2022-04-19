Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C8DC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Apr 2022 16:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354486AbiDSQRz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354482AbiDSQRw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Apr 2022 12:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 330D1B7F9
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650384907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QMMLV+aQ8jiYUAcGfbODPuNoPXpnRo47CDI6W0o+6/8=;
        b=WXpnsrwflhGcDvdoVYELZF+Tb/F40b3DoxMftYQmlhWBtCY7kCWKPtmB8WtVLl0IudWtGJ
        O71jwMOm9+hIaSYu+C439a8gTTNVK2j1v92Kfi9pdAgjtDAiBdc+YWgH2WU8uvLBuOFjvU
        qHMK6d+02/BLnDgrQZYHqWLZND202dg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-dWqOmsPWNaOYXjla-ikOPw-1; Tue, 19 Apr 2022 12:14:57 -0400
X-MC-Unique: dWqOmsPWNaOYXjla-ikOPw-1
Received: by mail-wm1-f72.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso1560410wmh.2
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Apr 2022 09:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMMLV+aQ8jiYUAcGfbODPuNoPXpnRo47CDI6W0o+6/8=;
        b=ArVf1kR/pi4HFatPXawi1OCOgI8IVDgosDJdbyCUS2+tfcUaAQJ1uR5kbeHZ9bHu0t
         Arua+blrSJ6hUbmyKbYjLGLIqzpJXxNt6MCc4ZWVzaDt61J3jBB0hFtUxZyrS4Q+WSzK
         VCmBTqiaySQlA+GyOLJgEB/YTFs+FIgxFk1U8oRP/JiAdN7q5KnM0hL26gbwkPeVObBM
         2THhJ4K6uWM8l7uGv+H9JOOPK92E3RFU315l9erPC76e5R0awa/yRLbFoJfy+02owIqd
         lc88HjDcSZFUZtDh4mGTMjwJh2p0VB7gj+8uwErryNNCG+5jdhHKIhnlpTDy9cyGWQCJ
         WJYw==
X-Gm-Message-State: AOAM533B7huT6jMPT320Tm9zklCGFHAeCFNBIbX4dtOlCAq6At82et5l
        793ihQsoNzGYp3PtE3ZP7JzH6kH59d94cjO7rZBkgtKNQxnrvlM3H1zHIC3bY+L0mUG7oTy6qHI
        uStw5okyl4cQu1s0pyT9yg6x3/YPVVFDAy3srXAN2cDFJ+HUZJbzPYwp2DCDBVW5deWrsnTdV5Z
        jQzEE=
X-Received: by 2002:a05:600c:4f53:b0:392:e99:3002 with SMTP id m19-20020a05600c4f5300b003920e993002mr16844475wmq.35.1650384896257;
        Tue, 19 Apr 2022 09:14:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCM0WEFGlMdjdBiXiBEEc5owN2kPNoXXL23G6VrMBtdOQo8nvEqlPdHvA6QmZ1uHh+NGz6lw==
X-Received: by 2002:a05:600c:4f53:b0:392:e99:3002 with SMTP id m19-20020a05600c4f5300b003920e993002mr16844458wmq.35.1650384896032;
        Tue, 19 Apr 2022 09:14:56 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600018ad00b0020a87feadfcsm8682381wri.84.2022.04.19.09.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:14:55 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     John Kacur <jkacur@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: [PATCH 1/3] rteval: systopology: Fix offline NUMA node parsing
Date:   Tue, 19 Apr 2022 17:14:41 +0100
Message-Id: <20220419161443.89674-2-vschneid@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220419161443.89674-1-vschneid@redhat.com>
References: <20220419161443.89674-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

An offline NUMA node will report in its cpulist an empty
string. Unfortunately, "".split(sep=x) with x != None returns a list
containing an empty string rather than an empty list, which causes
CpuList._expand_cpulist() to try to run int(''), which ends up in the
following exception:

  ValueError: invalid literal for int() with base 10: ''

Prevent this by adding an early empty-string check.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 rteval/systopology.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/rteval/systopology.py b/rteval/systopology.py
index bf794ce..b2da7bb 100644
--- a/rteval/systopology.py
+++ b/rteval/systopology.py
@@ -103,6 +103,10 @@ class CpuList:
         don't error check against online cpus
         """
         result = []
+
+        if not cpulist:
+            return result
+
         for part in cpulist.split(','):
             if '-' in part:
                 a, b = part.split('-')
-- 
2.27.0

