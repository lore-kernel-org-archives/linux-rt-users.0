Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF04C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F0C6120D
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbhKKUpZ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhKKUpY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:24 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1EDC061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:34 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id r8so7051232qkp.4
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/70NDWtFADJZ2D5orO4XuXW8lgm63Lh3F5Fn6MJhWmM=;
        b=K/0dS9TYfoVY9y8ftPaJZXehQo+oRVevrPdVNx+TEgLJCJ17vjl4Ieolp8+GiHGfw7
         Qa+SSznkdDMUoCUohCZ4TGesUKGr3ESWwK30Wxw7ZjvKM6cEiAI2+JNTZKR1F/J5cVjP
         9GWUYmBQEWTGoUAS5HmSH9P+sK5SmWWUDGPJytqHec3Tbte+cCXN67GqionzKtOgiHGm
         JJA7fDwsM8qlEXN0VlkE+3IwFEg30wLhouy6ZCzBj9dfgGtLIpKAjDo1P432VUQtAsVo
         FK4ZAKkqz71aaWL98dXj4R7SXGtqy3LXSBl86qm04573gDhDipYWgfgiH8ZkWUkRFwME
         CuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/70NDWtFADJZ2D5orO4XuXW8lgm63Lh3F5Fn6MJhWmM=;
        b=HmST8rWalAbdAL7Ya764TjBx3WxmoZqP1zEPhEK6MWTaA5kH5bG0BgIzItcOnJd8pV
         igjo5yRC1uRhJjanKcnHgZ6SojAUr6+8kvvuoE80D3+mM9mhNy0zmMMs3pG9o2kzY6yc
         gBKrV5eU3xTeJGpYVswRltgB01KyUl58yn162AJCSWw8Y/KICsNN1qa6FVQbBmrKBWul
         6wRrgXnPovPX0Ekx46p2PS/GvXffoP4FdvffFLcjqo3RRZUXRhgJ8Qag7vlsad9HNt9J
         CgjvsTKV7tcWtj+b06Fx6N3a6DI34wTCPRYVAZOYJmFzqAUzd3BLMnn+sqF1sFerfJs/
         mZ4A==
X-Gm-Message-State: AOAM531d3avwAjgLyrnFWhhAENaCY1OXELkyF4qKid36AYoRNPtlFJ/8
        5GYlQKstqV7/3YI1pQRMGN7yLyPIRto=
X-Google-Smtp-Source: ABdhPJwMmDi6EcBsdXKrCAxpIwySRdr77RaAUR3GVIbV9KIgCoAwMjN0GqiPxu1eSNey33hA18XKaw==
X-Received: by 2002:a37:f911:: with SMTP id l17mr8138639qkj.513.1636663353822;
        Thu, 11 Nov 2021 12:42:33 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:33 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 10/17] rt-tests: hwlatdetect: Keep consistent name from abstract method
Date:   Thu, 11 Nov 2021 15:42:00 -0500
Message-Id: <20211111204207.10167-10-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Keep the variable name consistent between the abstract method and the
method overriding it.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 7cd038ba913e..c07ddbb0e89e 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -239,7 +239,7 @@ class Detector:
         '''set a value in a debugfs field'''
         raise RuntimeError("must override base method 'set'!")
 
-    def save(self, reportfile=None):
+    def save(self, output=None):
         '''save sample data to reportfile'''
         raise RuntimeError("must override base method 'save'!")
 
-- 
2.31.1

