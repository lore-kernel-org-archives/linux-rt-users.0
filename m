Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82DDC61DA4
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Feb 2023 19:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjBNTkr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:40:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjBNTkq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Feb 2023 14:40:46 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AB82BEF2
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Feb 2023 11:40:45 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id j9so11256018qvt.0
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Feb 2023 11:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=97D1yA2DtmXwU4hKyuUPHXXHAaO69qSbdf0EotcEgSQ=;
        b=psnETVNLNni+OlSxN6HsXpbnOFV2SpDv/lq44Q602CmqS9YID7Lrw4GaMMB5NvU4cN
         Jz8s5JjXVbKjYy3YlJkbD5rwde5a/vfVQeDD4ZK5CZLDBgcAPNloVHlirQBbd+F5wciD
         BZO2myrFw8smJpG3C4FM267gQLtt34j+cxEAsX2yV4+ZUGLVS8AoMMDaYbQP7rG1xDVu
         M8GUGhW+BLYqzrvXBUpHmv6Wx7/JZ5xKZZPKkoBprBm7JPGRgBnoILfC7/UYGNncANph
         maAWNfJni+PAopZhhIiUIyEbQVBt+L3Eyz+Cl2t1AvDDUfo7oURo+faajcKp1hOR/H0M
         NItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97D1yA2DtmXwU4hKyuUPHXXHAaO69qSbdf0EotcEgSQ=;
        b=P94pYke646nvbqNMLFIJCE+JxGMgDrY0JTfzoC7P/SUiU3omLboRvrltEUiNMWF9Xw
         zMMOA/5yQ2WgvyTbiv43N8Dn1k+jZeEIx8mBmhIXwHVOjeSGOtsU56vtDQeXBvXRnlLr
         eFHfQTabEU2IdRkn7r6K09WWxPg89kCYqOFKH39GYaH6IfW5/kaKNOU3MmLt+UqPfaaK
         I0VF045JAeXjFlpQUViMvbjyclrLPZhYZmpUn4+r3S5+6HojL3qNDyLFk3GrLWR1yG0o
         gbcCglT78AzEnLUabVBwdl9yJfOWeAcG8zC5FpIZzS0iNZXND8itU7tQ3JmPpwwsBXcP
         I5Lw==
X-Gm-Message-State: AO0yUKUTxtLNud6RwS3jpKU1m1aFFDnkWN47P3rQk3NLk7ABM+m8HcrE
        y4fGBlj/UqQTzY1WP6AWT9Qs8fzopDQ=
X-Google-Smtp-Source: AK7set88M4EdQBTkmfU49TO/RdNjXtVvF0S6dwadWdus2uQQrQkCxMpxK/9j7ASQGd7ZYYZlduOmyQ==
X-Received: by 2002:a05:6214:2464:b0:537:7061:89d7 with SMTP id im4-20020a056214246400b00537706189d7mr7899223qvb.40.1676403643913;
        Tue, 14 Feb 2023 11:40:43 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id k6-20020a378806000000b0072c86374ddfsm12262415qkd.71.2023.02.14.11.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 11:40:43 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Makefile: Use sysconfig instead of distutils for PYLIB
Date:   Tue, 14 Feb 2023 14:40:23 -0500
Message-Id: <20230214194023.30946-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

distutils is deprecated in python. Change the Makefile to use sysconfig
instead

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 4df61ece123b..14c141dd56ab 100644
--- a/Makefile
+++ b/Makefile
@@ -34,7 +34,7 @@ CFLAGS ?= -Wall -Wno-nonnull -Wextra
 CPPFLAGS += -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=
 
-PYLIB  ?= $(shell python3 -c 'import distutils.sysconfig;  print (distutils.sysconfig.get_python_lib())')
+PYLIB  ?= $(shell python3 -c "import sysconfig;  print(sysconfig.get_path('platlib'))")
 
 # Check for errors, such as python3 not available
 ifeq (${PYLIB},)
-- 
2.39.1

