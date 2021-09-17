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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61301C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 08:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34CA661056
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Sep 2021 08:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbhIQIzO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 04:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbhIQIzO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Sep 2021 04:55:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6806AC061574
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2021 01:53:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so9534627pjc.3
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Sep 2021 01:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vACTPDaRhB7RJSdhy4x29t85XCndNRJS1IbHxaCnj9c=;
        b=aztLS72yb7PwGVpAvRnXw2ycGkS8MP2lngBTdwIhy1lWESURIq0d4kZJeNIQN+uhBD
         k0zFm5z8HJ6X0jkw4LIghLFahBrAIcERESwPs92eAmrGcUQRI9IhKPgH4XjyTNN8C4vn
         r/8BaWSwupRGq6GNqM+1mUoWGZZLadcdF84gXHKklu+ax35z/TATynRWNOQ84eAI9Qj4
         kVbQnXcV6Nic9NQRt2h664rQlL6rtdEy4OR6QjLCq/3Hi6SE5zPvg+nl+aUfuselwEj4
         2E9rFQnXBRpBA4uSwzLiJUR1okWZq2tu2uJ+AeiABU2+Ya8eBe0gCcn8avljVJJJ1+hn
         ln/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vACTPDaRhB7RJSdhy4x29t85XCndNRJS1IbHxaCnj9c=;
        b=XTCq2THUtJ7HGzMmkj4iQe9NRPRdRW2b1nZhpYyN8sIYPu5vmunlnDosPr9ex9sngk
         yN/lRQrhc+oPly09CtjuDxxJSKNMXpdzsfFG7cUxa0ff9PRqRcvHtRXDRZ1FEXde1yk/
         M03QApL1RBC857QQZK9GtM7S6dxv3zXIlRyoBKGcFSpoi++R9V/1TtUxy9Tp6oKLaNHf
         ZuYdpheA7oCcxESECleiQIdgo7JfbGn+MdEbdrElkgyCdp6/+fpOWTAFXpGUjvsZTXGH
         /e0ur1hUGP6DHEo65CjV+JOgehOZ3r2t4ZBjG6g4w7cUY4oLYYv0XAlsT5bSj4ZNJnHi
         7Uyw==
X-Gm-Message-State: AOAM531EDuIT9r7/ZIRLvKhQUl3cQMzDZzusY6wVvxAjHTbdNhsvTuTk
        5OJrtvS+FdJ8DCk18THVsY8=
X-Google-Smtp-Source: ABdhPJzv6OdGJXLHW+4xws59VyZnHeq1aBMGI8VKfjBe7XXXXpvDVlqdiaXp6OzMbiBvfedK1UiCAQ==
X-Received: by 2002:a17:902:7681:b0:13a:356c:d0e7 with SMTP id m1-20020a170902768100b0013a356cd0e7mr8712713pll.72.1631868831722;
        Fri, 17 Sep 2021 01:53:51 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id k29sm5473656pfp.200.2021.09.17.01.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 01:53:51 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: [PATCH v2 0/3] rteval: Fix issues with cyclictest.py module
Date:   Fri, 17 Sep 2021 17:53:40 +0900
Message-Id: <20210917085343.2775300-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Here's an updated version of the cyclictest fixes previously posted at
[0]. The changes in this version are to address feedback received on
the previous version.

v1 -> v2:
* Patch 1: Add an option (default off) to save cyclictest output
* Patch 3: Sort cpus returned by online_cpus() in cyclictest.py module

All feedback welcome.

Thanks,
Punit

[0] https://lore.kernel.org/all/20210902092452.726905-1-punitagrawal@gmail.com/

Punit Agrawal (3):
  rteval: cyclictest.py Enable logging cyclictest output
  rteval: cyclictest.py Parse max latencies from cyclictest output
  rteval: cyclictest.py: Sort the list of cpus

 rteval/modules/measurement/cyclictest.py | 44 ++++++++++++++++++++----
 1 file changed, 37 insertions(+), 7 deletions(-)

-- 
2.32.0

