Return-Path: <SRS0=VkLV=WS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBBC3A59D
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 06:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D36221848
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Aug 2019 06:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXqfggaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfHVGtZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 02:49:25 -0400
Received: from mail-pf1-f179.google.com ([209.85.210.179]:40741 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfHVGtZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 02:49:25 -0400
Received: by mail-pf1-f179.google.com with SMTP id w16so3258069pfn.7
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Aug 2019 23:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J/X3sFKUObbEu0RUOEMXMX9UodobpZfo1y+y/xKA/qQ=;
        b=rXqfggaI3lR7hUSzozqrYFv7K+ivJF92MKcQvL5wEP8QO+oW/1P7TEyMsMimkRfx9C
         QqMD2aWs3VerK9KwLN+0UNZ6Dt5S5uhnv/PRJ92Sc+Xz7LnxOcQ97TTHD+IhLtdMtVLV
         m4oqPYpSJzwT4cg1umbRY8v0pZy7Db5bKD7M4Gp+rZP13TOL3w+FB5MOIb35pBtNXpEh
         6Sg4RhXsMkTCW9WeLdiY0MuXmWzJEDu1NIYNCSEL5JVa0IkTj3SYRCwIcVGD/GrgdB81
         B4+nlkkD2b5ZB2HYWOSPlq4tl+6oy+wifenyfCPpWjqND6K1KJaByz2Zvl88eZ9Xoj4u
         Tl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J/X3sFKUObbEu0RUOEMXMX9UodobpZfo1y+y/xKA/qQ=;
        b=Vvo2zY5d2156/Rwns2yg89kxd1nxRhbfdjVfFSL8CPZqsQYIr9lmo7Qo7JDcczqjCB
         GigmJZtpUNBceT4pKvrS5bb5GTpzEORvXbUM5DCMVrFTeHEm9TYbqn+HTJoV+VNuD2zw
         zIQecrR0ucUj3qa+LE8p/Y1bc8NHnf4hBoM04P3V8TgFb87kKCFA9yhVb1EBpybTSRjj
         3IDvxQcSryw2bjPnAKSQhzzCEaTcfI3IJttgzfRle9IaV/4Yup+/DcYCvF8YmzSh2Zmu
         9TlvbmfhUjYUhJlIhQhO/Y7l6Dts9Qi0uNo7we5ua/TjuO8tCIePk8lBPUYOwAjip69x
         hVJA==
X-Gm-Message-State: APjAAAVsTICFMu63yNxFQY6yUDc3XSjLepdX/uUzwTtU0M9MraGSod+3
        UfW+taHv9ypXAezJxkyp3FZpby1gu7Q=
X-Google-Smtp-Source: APXvYqzH4eZm0L0oEFJVnaEJ7/V90e122fJg3NtKb1kn9lKGpVnwrOnHNFVym9QZrzNYQvjQ0FvcxQ==
X-Received: by 2002:a63:89c2:: with SMTP id v185mr32241938pgd.241.1566456564737;
        Wed, 21 Aug 2019 23:49:24 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:53::2:ea40])
        by smtp.gmail.com with ESMTPSA id u7sm25927995pfm.96.2019.08.21.23.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 23:49:24 -0700 (PDT)
From:   Afzal Mohammed <afzal.mohd.ma@gmail.com>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>
Subject: [PATCH 2/2] rt-tests: Let git ignore cscope generated files
Date:   Thu, 22 Aug 2019 12:19:19 +0530
Message-Id: <9365886de54b1570a82428bda0543d588e076e87.1566455869.git.afzal.mohd.ma@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <eb3b222b7741d16bf45735f59015c40fcbb31ba2.1566455869.git.afzal.mohd.ma@gmail.com>
References: <eb3b222b7741d16bf45735f59015c40fcbb31ba2.1566455869.git.afzal.mohd.ma@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Let git ignore cscope generated files

Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index aa9b82c..f7574ef 100644
--- a/.gitignore
+++ b/.gitignore
@@ -38,3 +38,4 @@ SRPMS
 rt-tests.spec
 tags
 TAGS
+cscope.*
-- 
2.23.0

