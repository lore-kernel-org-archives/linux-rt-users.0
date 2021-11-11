Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21FCC433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B469961267
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhKKUpT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbhKKUpS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:45:18 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678BAC061766
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:29 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id b17so4847391qvl.9
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RCr04HCF5hZaZp2AKkVfQMUO0Oovq89CKtfLUbyGQtU=;
        b=nI0SYUX534mp3LsgeweuxoZBXjbP4SB99Fnu8nmrywmhgZ3mJ/f0QZLWI3Tx9YpM2+
         C79qjZHvSWy/XpjCSogrGDCpfa1z2vxBdGdcSL/pf54SE53zCjLeVwTE7lpobGSZdIzV
         eGCJVn/nQpScTNHiHYeFulBEHhsTl1nrZb3eurbQwcDaGme5GQQZD7iCMM/rIqLwUz3h
         sFxsr57kqFRNv7pGeEBZx6k9tawgPwhvlBXq6ngchhHg25rw39qkcVY9W+s/6n+tGwAt
         lpiOnQHhaWzXFT1TqrcJ5MKC/1Lf9YwJp3GwP578W3fFn4d7hsLHY3zOyDsndMzHUIeF
         9c/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RCr04HCF5hZaZp2AKkVfQMUO0Oovq89CKtfLUbyGQtU=;
        b=vs+FOzzdXbj7RVSIp5sBeeN4ls9X+MUGiiGZAHBzrP6e7bPwySfgxmkYKVs6dYx7Ek
         fzmzTjneGGR2AAI4epB7le9N6G2Gz7Ww4J0kyhL7D48jhTsj2Uux1S67UnaBvYgB0/Zw
         F23uwLeREhln9qDaMz+xUfzg6L0n3ZtAfvMHHTjRQMvTuN8pmtOlLpE4cRFHQU+WGZ2N
         /fy9gR5rRvSifsdP8U3VNgs8+9WF3muUYgaP80E+s8zNWBjtX5Sz8S8Bi+OmW9yeHRK9
         7ykP2gZHNxhUrP1UR1BY+Z73yJygdDCEk0dhKNy9OB18Fcx+RvvFSc9woHivXaELI69S
         KDfw==
X-Gm-Message-State: AOAM533pcd4zlT49LuDbEe+YdWeLV9YldOWyIvo5iQtUK0GxfYcpvy1y
        ZDxhyjJ1yAV3CKDAkPSONo57qOGnPkc=
X-Google-Smtp-Source: ABdhPJwrDmIIBKEHmQVmQu1Jk/w/RSPyJ06f1cWHFml2fDBnxiAqkH0Z/fCU2rpFLJ4uV/L//CzjbA==
X-Received: by 2002:a05:6214:29c5:: with SMTP id gh5mr9645656qvb.10.1636663348334;
        Thu, 11 Nov 2021 12:42:28 -0800 (PST)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id u27sm2282522qtc.58.2021.11.11.12.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:42:28 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 03/17] rt-tests:hwlatdetect.py: Remove unnecessary 'not'
Date:   Thu, 11 Nov 2021 15:41:53 -0500
Message-Id: <20211111204207.10167-3-jkacur@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211111204207.10167-1-jkacur@redhat.com>
References: <20211111204207.10167-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Remove unnecessary 'not'

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/hwlatdetect/hwlatdetect.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
index 66e132b8c2a5..5a66280fb01c 100755
--- a/src/hwlatdetect/hwlatdetect.py
+++ b/src/hwlatdetect/hwlatdetect.py
@@ -66,7 +66,7 @@ class DebugFS:
             return True
         debug("umounting debugfs")
         cmd = ['/bin/umount', self.mountpoint]
-        self.mounted = not (subprocess.call(cmd) == 0)
+        self.mounted = subprocess.call(cmd) != 0
         if self.mounted:
             raise RuntimeError("Failed to umount debugfs")
         return not self.mounted
-- 
2.31.1

