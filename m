Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C48C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jul 2022 13:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbiGZNf6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiGZNf6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jul 2022 09:35:58 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3EB25EF
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:35:56 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 125so11171960iou.6
        for <linux-rt-users@vger.kernel.org>; Tue, 26 Jul 2022 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7+quYizL8yYqMBMSlsrCTzvpUI0ApDmRgPSAyrOWX/E=;
        b=Ybx6Ac1aSmMi5XUAVCuyAPAHtghSq7SipMzZ8f/F1QjuaYZfn0Kl/XSldNYVEr2yhn
         1BgHZoGKN0VP/ZrhAbu9k04Ukkg4O2XuUHyJ9E9taoGIbmZfKAlsrJwnbRxlWx5cUMMR
         2MBKo28pgJB3pCHThR4Q6ZGC/pWg9QEi6qeYn+0Dzx0dooehvCbOSAHAvEY9I25luqsi
         hyFCo6Z+kYOcImGqVk0bFYSxOBDaoQqjny1zkDlEhKDrkjNn+FxQovYMyzJ8wHJGfR1W
         +oxpBdhZFWgKTei/rSwH8Bglinax1TATRtwSdfbliBaN7GzGiXlQGKFplyqD1KAavyW1
         HoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=7+quYizL8yYqMBMSlsrCTzvpUI0ApDmRgPSAyrOWX/E=;
        b=Umft7GUtpgAVWUVa3RtVQ/d9kin5sKLbTrw1WP0F7OQMr7XL0wVWCcABB4GFWMjDEt
         wsZDefrdFfYeoGS1C2IY+QTDYlChysPAvx4nwI8IMYa7V8LvVzSceLVycpkWKhauCVwj
         gw/zhkIFci/J6mfpKP77kGHHusUv9a5pox4HHJb87Ax5bhiypOtyliDkm+3ImZc9uqeW
         50ECWcWOe99oWLSnXIAJHVFeVMc40EuWMKeGdh99Cjhh7n2RUWl1658c3BZZ1Y09E5Un
         76YYisWWP9H/ZM6DhIJQxVbY95/+PNVcHVmIcrgAsUQikZ7iiB2Crql+TmtAfG7Ha8g3
         tnCQ==
X-Gm-Message-State: AJIora+G+TlHYZY0k1lJkieKLpfc1AktgHJGdZc8paaIopfWImvyhizE
        vrSbDKj2kmqP+QSveoVBpkj/fY7nJF4=
X-Google-Smtp-Source: AGRyM1t5zBQLsqYCU5iyuT5nnb+fMTS6nfPkuvcSfMZCGWO4vB9+SXKpByzUq74OiUf6U3qYs9liYw==
X-Received: by 2002:a05:6638:196:b0:33f:58f0:f4c4 with SMTP id a22-20020a056638019600b0033f58f0f4c4mr6786072jaq.135.1658842556112;
        Tue, 26 Jul 2022 06:35:56 -0700 (PDT)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-09-184-147-143-180.dsl.bell.ca. [184.147.143.180])
        by smtp.gmail.com with ESMTPSA id e42-20020a02212a000000b00339ceeec5edsm6617760jaa.12.2022.07.26.06.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 06:35:55 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Manasi Godse <magodse@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/6] Create more common interfaces in misc and use them
Date:   Tue, 26 Jul 2022 09:35:29 -0400
Message-Id: <20220726133535.10824-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The purpose of these patches is to reduce the number of interfaces that
do the same thing and standardize on the functions in systopology. This
has already been to some degree with past patches, but is not complete.

In particular I added the method online_cpus() to class SysTopology
and the function collapse_cpulist() to the file systopology.py

Then I visited each file that imported from misc and made use of the new
interfaces. This leaves only the function cpuinfo() in misc. I have not
yet removed the duplicate functions in misc, but that will be done in a
subsequent set of patches.

While making use of the interfaces in systopology from various other
files, I took the opportunity to clean-up the files, namely I used
f-strings instead of regular strings for readability, added some
docstrings to functions and methods, and made use of the more
pythonesque "in" instead of chained "ifs"


John Kacur (6):
  rteval: Create common  functions in CpuList and SysTopology
  rteval: Make use of systopology instead of misc in rteval-cmd
  rteval: Make use of systopology instead of misc in hackbench
  rteval: Make use of systopology instead of misc in kcompile
  rteval: Make use of systopology instead of misc in stressng module
  rteval: Make use of systopology instead of misc in cyclictest

 rteval-cmd                               | 45 ++++++------
 rteval/modules/loads/hackbench.py        | 30 ++++----
 rteval/modules/loads/kcompile.py         | 86 +++++++++++-----------
 rteval/modules/loads/stressng.py         | 15 ++--
 rteval/modules/measurement/cyclictest.py | 67 ++++++++++--------
 rteval/systopology.py                    | 90 +++++++++++++++++++-----
 6 files changed, 201 insertions(+), 132 deletions(-)

-- 
2.37.1

