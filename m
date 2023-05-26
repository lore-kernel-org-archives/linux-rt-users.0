Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F9FC77B7C
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 May 2023 21:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbjEZVPM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 26 May 2023 17:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjEZVPL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 May 2023 17:15:11 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86796AD
        for <linux-rt-users@vger.kernel.org>; Fri, 26 May 2023 14:15:09 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f392680773so5930351cf.0
        for <linux-rt-users@vger.kernel.org>; Fri, 26 May 2023 14:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685135708; x=1687727708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+2q3niymOQSsm9prh1sGdALqd2LHiEOdSxWn6AEKa18=;
        b=dBmZT/JtzWa2TX1obTIlx4bpjrbQIZ/nUA/Kc3eJl3D5+GZ/pqsd29PfM9+/H9iF/e
         5dl8B91whMAC/2Ze9/o3Dtm4ZIQEBRjST3gZFm+VtfhmGcZS3YTEe5ed48ZZb6ZNoS6m
         RygvbP0aJ42HsZM9ndbqmUdqRrBgMYgiFC0gHeAnELmpqbbaH6/2CGypyGcO+xSj835X
         B7Snl/USkwkdmuU9cJFq2HAyydJn9HARzL6nBNbxEo0yUrJB71XutpnrZsQ/god4fT+K
         +ZTYSYf9ANFkAWNPzUIM427GobemWd1Z1F5W4UH9zaVVQQ4vIftNrIxLd77+iP5iMEq1
         jo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135708; x=1687727708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2q3niymOQSsm9prh1sGdALqd2LHiEOdSxWn6AEKa18=;
        b=Xd4OzK3CU2EebES0C/yBsvwGQO9yHFeT99lmUBQoa5hFvQcJKi5cr+cEFHA30k20iJ
         14woDmljlNdUY89oxfS98BBoF4+4VEYFbe+3OEehKgOLMFKmReBQlKsTP8XVT5Qe6gDP
         Ra1sBipQCXZEjHTh7RaDmU03ULD7UhvAnoM8c9qs143JplikAEOj6pqaQDxCRmGvVZ8K
         JK1POH7W3rKOPynq9+t4Ic2gmKvJIFJ+QaGnM/G2HWWC8oHBTZWCd9Xael+AdGz6KPc/
         6PL3jJGnv+KgDPau3oNvnELiunRLkLbwa6JzfIeuhN3FLfoL3AJCLMpzBt8IhkhhCtXa
         4FQw==
X-Gm-Message-State: AC+VfDy48rHI2J5SKcQHsv2OqVkx5LcNr7Dq/92r9KwhzjGo7BZVjs2l
        4zrB1aUmH9rcj4fsKETXqPldkP5tIIM=
X-Google-Smtp-Source: ACHHUZ4aMHZ1KsQtDv5AQCR+fTU5MGq3hcH2EJz/fxMFTw74A0ajblHSyXyqyEC52pFGCH6xl77x2A==
X-Received: by 2002:ac8:5916:0:b0:3f6:84ac:659f with SMTP id 22-20020ac85916000000b003f684ac659fmr3037975qty.29.1685135708153;
        Fri, 26 May 2023 14:15:08 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id jh18-20020a0562141fd200b0062382e1e228sm1497411qvb.49.2023.05.26.14.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 14:15:07 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Anubhav Shelat <ashelat@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: [PATCH] rteval: Fix the unit test in osinfo
Date:   Fri, 26 May 2023 17:14:44 -0400
Message-Id: <20230526211444.32063-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Fix the unit test in osinfo

The unit test will fail if /var/log/dmesg doesn't exist.

However, the copy_dmesg method in the OSInfo Class will just return
if the file doesn't exist.

Fix the unit test by mimicing this behaviour by continuing
if the /var/log/dmesg doesn't exist.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 rteval/sysinfo/osinfo.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/sysinfo/osinfo.py b/rteval/sysinfo/osinfo.py
index 7b7bfe9ce4ec..ead5e3939cfa 100644
--- a/rteval/sysinfo/osinfo.py
+++ b/rteval/sysinfo/osinfo.py
@@ -122,7 +122,7 @@ def unit_test(rootdir):
 
         print("Testing OSInfo::copy_dmesg('/tmp'): ", end=' ')
         osi.copy_dmesg('/tmp')
-        if os.path.isfile("/tmp/dmesg"):
+        if os.path.isfile("/tmp/dmesg") and os.path.isfile("/var/log/dmesg"):
             md5orig = subprocess.check_output(("md5sum", "/var/log/dmesg"))
             md5copy = subprocess.check_output(("md5sum", "/tmp/dmesg"))
             if md5orig.split(" ")[0] == md5copy.split(" ")[0]:
-- 
2.40.1

