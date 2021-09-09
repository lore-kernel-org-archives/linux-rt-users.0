Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9898CC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 08:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7388E61131
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 08:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhIIIHK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 04:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhIIIHJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 04:07:09 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05D7C06175F
        for <linux-rt-users@vger.kernel.org>; Thu,  9 Sep 2021 01:06:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s11so980633pgr.11
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 01:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FNo2BbQz32Oee1F+cuiooxQJ5lt3s9i9NJ7wzI9VzpE=;
        b=BUKpvgESyKyqZ+EDa1w7vDW0fFIN23nX0RIrOedkpM+XGYmJLRN1a7c+/d1Vuqa292
         5YaQxmHroyzPMQU+pHGbS3SNpaLfSH2h1bkBhSuzDZbdnthXaAk/r9VguF6rYnM1q0VI
         XcSod0VDpy+HqAgDbYFvf1yB++xR9SSmtzRAwK+ams2l41KlNHF/oNimmq767zR9jX5y
         4NhPo0ynixROE71GjIK/iHUiXpjW5qDokWIeOUqUG8BjnUOhkvFXEqI9tIXgXErNMmtt
         xSPKJlNyiFJSQBgabpUJ45UndkR+X6cGqlRR7G/9u9mfgnx/QONpuZTLy4vPBOcpo5YJ
         dP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FNo2BbQz32Oee1F+cuiooxQJ5lt3s9i9NJ7wzI9VzpE=;
        b=ApsBHdSzUtKroNrMaKrdonnaJQnR13opXnQWVIC47xyFkS3pWjmOGV+DKBN/qgj5jt
         5cl4uILqInHfX7WVCVWK7/n31GJiYtYewiQ5VOP6qW0/Cx4Ovf/MUyngSr0/+SgXfMb+
         jVyJ2Xyr60uopcd9kSkd/Fui16ub4oNDc2tBU7ijSGsockq8C2XSfd1ShD3y1mOV0/j0
         bbNqhdTekYenqFle8mzLUrBWcAo9hSHf4EktIovpG4eWRByUOYdwmXyWfvpCWkHnlqnD
         hbkE0BYeny7CtnwBqSCaWHYbqnaHlgaPs80Psk86WbTCWDwsJ0rv6bQTZw93CuB9c7DD
         HYkQ==
X-Gm-Message-State: AOAM532buItozshaNphWoOZowoHSM/gV4pPc4ViGy8ulbyi7v7Ostfu8
        +xaS2onl5R7q7Donkhsw3/94AQZm5xU=
X-Google-Smtp-Source: ABdhPJxZgAKgTNYIeNZbbxy93JcNAE+5K0bn4273DBD/2AHePr2X8Jf9h1G3vZ+N4UpBrm+lW+loeg==
X-Received: by 2002:a63:1504:: with SMTP id v4mr1520019pgl.151.1631174759971;
        Thu, 09 Sep 2021 01:05:59 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id g140sm1305926pfb.100.2021.09.09.01.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 01:05:59 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: [PATCH 0/2] rteval: Miscellaneous fixes
Date:   Thu,  9 Sep 2021 17:05:45 +0900
Message-Id: <20210909080547.1331581-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Since the previous two patchsets fixing blockers[0], [1], I
encountered a couple of more benign issues - noticed when staring at
the generated report - summary.xml.

The first patch fixes a problem with incorrect detection of RT
kernels. I've tried to retain the old behaviour in case somebody is
still using older kernels. The change can be made more robust if
that's no longer needed.

The second patch fixes an issue with incorrect detection of init
system and container environment. This is a result of change in how
strings are treated in python3 (compared to python2).

As usual, all feedback welcome.

Thanks,
Punit

[0] https://lore.kernel.org/all/20210901080816.721731-1-punitagrawal@gmail.com/
[1] https://lore.kernel.org/all/20210902092452.726905-1-punitagrawal@gmail.com/

Punit Agrawal (2):
  rteval: osinfo.py: Fix RT kernel detection
  rteval: services.py: Fix incorrect detection of container environment

 rteval/sysinfo/osinfo.py   | 2 +-
 rteval/sysinfo/services.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.32.0

