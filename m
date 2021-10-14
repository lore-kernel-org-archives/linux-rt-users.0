Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868E4C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC4A61166
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 07:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhJNHPl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 03:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhJNHPj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 03:15:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD95C061746
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s1so1697333plg.12
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 00:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8jym68pFwqGlrRHHiN1ouY0hmcUz+047RK9C2WLpiw=;
        b=VkahES9PNctCIuuH4Jm669xCwab0zFCAdY2G5EHLoM7Mi/n57YjC5MRWlJrxUHdMWS
         a0+L/3rW1hdCa6o/ZTpAp+SZ0H4p2zjikD2GIlKQqiYHQhCx2KNOoQROGH1v5ecLIS1k
         6UvmWV7YomRZUoTPJxZlVKe2ZtnkWlac+UH160UTtWJBvHGxCWkd5ZIQj6fq94uv5I0/
         TerhSIRbthsgGIzR7gEe1ULqH5xv5pBUjXIydLH5QBja1KQBnYJ4tw3EJQRRQ7waFL/Q
         ZEZP4KqOY9HohGyGxlNl3cvf1syoyeaec8TnttzYXqTEMgx7qPPf6V6vfSjadOwcLm7q
         Y7ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8jym68pFwqGlrRHHiN1ouY0hmcUz+047RK9C2WLpiw=;
        b=lcehQzyxq4+pOk0+FuL5/eNUJcgqO7XLBSg/0/tKFBR4/XMr2zy88qRUSoAeVEsGXW
         QQ35NWnLZBh+XBpOMKyQbtbwPY2qoW3c20UVSkZrvgsjZB5WEgEJPVaA5rIGGdtzApiW
         ovqHArjj89vYy0Yap9iIMnbO9/uYQ+0nlP72TjPICuQNtQo6cpanYmEpo606IVVz+a4j
         qeIW+cMuQJZrIo5nTeuyiBksNIwjhCmev5tgY/yBCe6KtvBjaJUjDL6lJSKvR7aeA108
         Dnj/67dY8qVvJKA4M37efZzom+72UQxW2V41I45AXB92FjSOgdQr7TzdaocTtqD3tIwC
         ZlTg==
X-Gm-Message-State: AOAM531+ht4kXpGuBhs9zN3q+i3UBnwtWtmsq5L6Q332cMs695ZGIGtI
        e2kL0F6onJhra2LSNTo0hPk=
X-Google-Smtp-Source: ABdhPJxNtQ0moJNfaz+t1r4UjDxDTqkrAqwHQXfhfe9kGu/q97ZHYI4jfltgtxcBujt1+t2hMKxmdg==
X-Received: by 2002:a17:902:e843:b0:13f:2212:d64c with SMTP id t3-20020a170902e84300b0013f2212d64cmr3615468plg.16.1634195614169;
        Thu, 14 Oct 2021 00:13:34 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id g10sm922959pfc.213.2021.10.14.00.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 00:13:33 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: [RFC 4/7] rt-tests: cyclictest: Drop unnecessary variable "bufsize"
Date:   Thu, 14 Oct 2021 16:12:44 +0900
Message-Id: <20211014071247.4165329-5-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211014071247.4165329-1-punitagrawal@gmail.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>

Two copies of "bufsize", initialised with the same value are declared
in enclosed blocks. Remove the redundant declaration.

Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
---
 src/cyclictest/cyclictest.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 721d242a1da0..9c67a3ce3034 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -2054,7 +2054,6 @@ int main(int argc, char **argv)
 			memset(stat->values, 0, bufsize);
 			par->bufmsk = VALBUF_SIZE - 1;
 			if (smi) {
-				int bufsize = VALBUF_SIZE * sizeof(long);
 				stat->smis = threadalloc(bufsize, node);
 				if (!stat->smis)
 					goto outall;
-- 
2.32.0

