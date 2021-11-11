Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC984C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C6361212
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhKKUpY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233821AbhKKUpX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:23 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CCFC061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:34 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 193so7018567qkh.10
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WZLgOq8F5tPhfhULIOExhg2KDius+GrjATYY/2Uk30=;
        b=VgjdphbAAMh6TywapcK32cq0RGCYWMXpSkSrk+JT7/1GapfjlaUn3fSv7AkOtR+aq9
         Ssyf7+pXPmUI1aUj8u5ZM6JIOmuKfTK8s9iqlzSRTFmUALMaE/tGY9T3a4rq2gwMb3X/
         Bj9U2bIcFlSI/T43pUjnL0Sj5bxYygX0BGE5kvDHmOw3aPg0ceOzDXHifNg1MiwPKJ/E
         Riml8XXU/rq0nsfdip616Mq7mppQLvg+iMba9l5v9EK4uPFmeLrCv5CWRMS0Ou7HcSVz
         u6Pk+d6JKXimGSSXepPnJ3rU3CXcRQ7vJ1QzIFcBKkVMS1D5pAuYgFkFt0i3X+RE9iEa
         Jhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/WZLgOq8F5tPhfhULIOExhg2KDius+GrjATYY/2Uk30=;
        b=68D1laJHY4GPlJ7JXakxnkcZIbuBIlkwMdu03CEauVktfXIEVqStFEZSfrkFXFQZDn
         0D5WyBjBjqwfTlSgTFX4yiVBofvEXoibYeteCoLGi1DV29f9mpyZd1JAgeKByTbNZz3y
         ObT49GiLaVcM6N7Ge2wjWSJ9TjEZIjhP82UJKW9R4nsz4cvX6JMVek+CHwa9MEGlsCbm
         TujxEIeSvMbiQ2ZY4EvEkv7jUmi3KnklLwnmPFC55IYqJ3uCi6sB2Aw01ruH/UZG3OPF
         rQ0V8SHo1Y1NwN9aIM8gAcozdR15rrUGx/X278XCZPDr+AnPav5aI6B12tWXMFOveSc4
         oHug==
X-Gm-Message-State: AOAM533l6IfnIVLbaPfj/lbbl+G43aetY1CTX7MjFsjlMgqqlRKmO37q
        hdrKrFVLwJ69M8CXvxJwZROuG7WghRE=
X-Google-Smtp-Source: ABdhPJysK9EECxG2VuIEqlwbrJIwIWZwZSFptIfxSe3sJzpy8sE5XI9WUjlOPhlczND7xkDC/9HMzA==
X-Received: by 2002:a37:a811:: with SMTP id r17mr8392457qke.305.1636663353112;
        Thu, 11 Nov 2021 12:42:33 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:32 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 09/17] rt-tests: hwlatdetect: Use python3 style super()
Date:   Thu, 11 Nov 2021 15:41:59 -0500
Message-Id: <20211111204207.10167-9-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Use python3 style super(), no need to specify __class__ and self

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index a530867777a7..7cd038ba913e 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -321,7 +321,7 @@ class Tracer(Detector):
         return os.path.join(path, Tracer.__field_translation[field])
 
     def __init__(self):
-        super(Tracer, self).__init__()
+        super().__init__()
         path = self.debugfs.getpath('tracing/hwlat_detector')
         if not os.path.exists(path):
             raise DetectorNotAvailable("hwlat", "hwlat tracer not available")
@@ -397,7 +397,7 @@ class Tracer(Detector):
 class Hwlat(Detector):
     '''class to wrap access to hwlat debugfs files'''
     def __init__(self):
-        super(Hwlat, self).__init__()
+        super().__init__()
         self.kmod = Kmod("hwlat_detector")
         self.type = "kmodule"
         self.kmod.load()
-- 
2.31.1

