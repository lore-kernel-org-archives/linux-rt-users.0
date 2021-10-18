Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B389CC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 05:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D25260F25
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 05:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhJRF77 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 01:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhJRF77 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Oct 2021 01:59:59 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C505C06161C
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2021 22:57:48 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t184so1975721pgd.8
        for <linux-rt-users@vger.kernel.org>; Sun, 17 Oct 2021 22:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYu5U7ui4YRIV6RpMs2VblaNwGWibODlCn6OQiv6p88=;
        b=PAyMBRw1hRLxmP0WeGEFzEnXtonRbX+lVX8dQ39/FEMujE7iB9onOc0gsECkcDS14f
         T7ATdP9/BZc/CgXrYdIklOZ9LqAe3C/B65kRan/IAu7u5v3pkGceHSxEu35TgHNP2xSs
         poeI6Xbd+/k2OZWVHEfkzuwFz1Mlt4YyvshTINmjrciulhC+AsTCZqj3bJiiTFZPJQKY
         RVvHyzYVTEaGZwFfi+KZ0XSK4OjCNlngoTEzRHXcNM34h8+/TaoP1WdxflhFBA4FBd3n
         mcs0Sp3i+42XxFMtbPACifxY2QnsEVFz3yowEk//R5r/DC/uV1q3SwDEIJi0RiwN4m8a
         wUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cYu5U7ui4YRIV6RpMs2VblaNwGWibODlCn6OQiv6p88=;
        b=sSPEPc6wRVYnOoVU3x5UItULb9uuZ2GtTXmhBguCsxDJa88rlswz28X+yMpMvaZ/B+
         Erqh2NslVZVNAeqeUuy4S14xDAdcwjcF4/FFJU+QjhFQiOtfK/4J0IyheaymzTa6uvnG
         q6E65C7l6y+LxcqVF1M4rdbXeGMusI41+8bA/bRglWEfm8krJTJlxqRLnqC4Ys1mTKcx
         FwOgVGDq0Uio8LmCOvjEy0mL7pojYCDm2G0lZATa3ZFIhUCvTCOK0L+XInNt7gkufUJx
         aLbwCSn34tIHVtmYmlsqrzYGhKmHHQ++xC4G8QWpABLfjN10Zyxy/KAdPajlk4/afXAH
         OdbA==
X-Gm-Message-State: AOAM533wwf00jo/sykhsuO0C8RvAQ4C634dOsP2ZavQV7lY7TFkB9HXA
        pg7ZWcpzAFjgdRlw6bodd/NpK9fRaWY=
X-Google-Smtp-Source: ABdhPJwfZe5L69MA/EAuZDEdrH2Uh/f0kKpew3HgXhGlNq0RkW8S3cgpGe7W1S8Oo0JfqhmJ6ogL+w==
X-Received: by 2002:aa7:991e:0:b0:44c:a172:e670 with SMTP id z30-20020aa7991e000000b0044ca172e670mr26523818pff.10.1634536668049;
        Sun, 17 Oct 2021 22:57:48 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id w18sm12018408pfj.170.2021.10.17.22.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 22:57:47 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: [PATCH v3 0/4] rteval: Fix issues with cyclictest module
Date:   Mon, 18 Oct 2021 14:57:32 +0900
Message-Id: <20211018055736.412576-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Here's an updated version of the cyclictest fixes previously posted at
[0]. In addition, I've included a follow-up patch[1] that depends on
the previous patches in the series as well.

The combined changelog - 

v2 -> v3:
* Patch 1-3 - no change
* Patch 4 - updated author / Signed-off-by

The patches have been on the list for a few weeks now. It would be
great to see them merged if there are no issues.

Thanks,
Punit

[0] https://lore.kernel.org/all/20210917085343.2775300-1-punitagrawal@gmail.com/

Punit Agrawal (4):
  rteval: cyclictest.py Enable logging cyclictest output
  rteval: cyclictest.py Parse max latencies from cyclictest output
  rteval: cyclictest.py: Sort the list of cpus
  rteval: cyclictest.py: Skip statistics reporting in case of an
    overflow

 rteval/modules/measurement/cyclictest.py | 54 +++++++++++++++++++++---
 1 file changed, 47 insertions(+), 7 deletions(-)

-- 
2.33.0

