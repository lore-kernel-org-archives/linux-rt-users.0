Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BE2C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Jun 2022 15:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347222AbiF1Pjg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiF1Pjf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Jun 2022 11:39:35 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D0BB58
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jun 2022 08:39:32 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id z1so3285455qvp.9
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Jun 2022 08:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z5f7HYjN1Z1DdYINrKMciCcxaZ0VfQjvjITW4Uq1HyA=;
        b=PIuww35+PpKGPslIWQQTngDGANq85P7KB8KG+RzEKO7HYS74+TRR9MM/kIENB5TUhc
         8bCLz0h/hQu8/2gJZDolnJhyA9MTWF6VP+UeQ6ps/WHdHiZbN3aG64YNju02Vnee+X7i
         y/givlcYVw7UG8BgZWPeWVIwh1VagAsrlgdCLcJ0vAjFc9ImBuV2ClGEZGTzHkppgbsr
         4LqBQ2JzFzblvnUadOz7lRP3vYW8AWEb3UDFHXr4c7Ux77cRKTxmR84hdpuhQVIFB5Kz
         pzD3JwXJP++ijpNVFDR7+/pVTuq1B7fxfzj9q0lnjht0QGvPUwWA/KfJ/Ni2N7hAV/yj
         /r7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Z5f7HYjN1Z1DdYINrKMciCcxaZ0VfQjvjITW4Uq1HyA=;
        b=Fe9Yq7yKVR+8w5vkeHjqloXZ9/b5FqOOH+067yDftxFeZyx6dphvHrtQj00PULnHKE
         2Hi89oxKt9DMec+K7PCiS6nlDXAZkRc0nNPJkZN2Z+7O8hB4Iq6cH5WS4HpdjPigNQH2
         j+JiFQXQAuhrblSfejiiIreD5Duh9RQ2BykWCFhs3t7aiwe3qEPKkrV4i0qQ9qN1VuxX
         UnciB8U7FfmthvK7+xo5qtdobx/IagfR0octOjOZWKns8EyFXVNYdrRC7xkKe4KD5OVH
         dO8ZzUbWWrmC67pQtFLxdzGqxjAKL69BJnb3L6FExqBqkkfFKccxdh8HlfSJIctBzhi2
         YbJw==
X-Gm-Message-State: AJIora9rBlh+QAgqLcfOrFSeefaKl0xMki6iqIMKmBS8PV+Loxnv7O4l
        Xmez1uvpuotOJ0ZfGnNEnKQLeCQlhQU=
X-Google-Smtp-Source: AGRyM1uuKU/Qzwa7vXnMFrrqE9UwgDzWAjxA3AsNvXr1cW5A1ipUx7eUET5tT6hro3s5zTTqogx7HA==
X-Received: by 2002:ac8:5e50:0:b0:317:c68f:e32c with SMTP id i16-20020ac85e50000000b00317c68fe32cmr13455368qtx.132.1656430771274;
        Tue, 28 Jun 2022 08:39:31 -0700 (PDT)
Received: from localhost.localdomain (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a441200b006a701d8a43bsm3225154qkp.79.2022.06.28.08.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 08:39:30 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Clark Williams <williams@redhat.com>,
        Kate Carcia Poulin <kcarcia@redhat.com>,
        Leah Leshchinsky <lleshchi@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        John Kacur <jkacur@redhat.com>
Subject: [ANNOUNCE] rteval-v3.4
Date:   Tue, 28 Jun 2022 11:39:16 -0400
Message-Id: <20220628153916.18333-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I am pleased to announce version 3.4 of rteval

rteval-3.4 contains a number of fixes, users are encouraged to upgrade

Some changes from v3.3:
- The default number of buckets requested from cyclictest is increased
  to allow for a wider range of maximum latencies. Hopefully this is
  only an issue when running on a non-rt kernel.
- The cpumask policy has been loosened to match cyclictest, namely we
  don't restrict ourselves to cpus from the inherited environment,
  but depend on the kernel to tell us where we are not allowed to run.
- A problem was fixed in the report when dealing with an offline NUMA node
- Use systopology in kcompile to get a list of cpus on a node that
  properly deals with offline cpus
- Fix the --kcompile-source=TARBALL so that the user can specify a
  non-default kernel to compile as a load
- Fix passing a timeout value to stress-ng (needs to be a string)
- The default kernel has been changed to linux-5.18.1, because some
  older kernels fail to compile on newer tool chains.
- Popen was changed to be compatible with slightly older versions of
  python, python-3.6)
- modules signing is changed to sha512 for environments that don't allow
  sha1 signing

Special thanks to Valentin for his contributions regarding NUMA nodes and
fixing --kcompile-source

Thanks
John Kacur

To fetch

Clone
git://git.kernel.org/pub/scm/utils/rteval/rteval.git

Branch: main
Tag: v3.4

Tarballs available here:
https://kernel.org/pub/linux/utils/rteval

Older version tarballs are available here:
https://kernel.org/pub/linux/utils/rteval/older


John Kacur (16):
  rteval: Fix test misses threshold assignment
  rteval: Increase default buckets from 2000 to 3500
  rteval: Don't restrict measurement threads to inherited cpumask
  rteval: If the user doesn't specify a cpumask, use the inherited one
  rteval: Fix Popen for python3.6 where text=True is not available
  rteval: Fix allmodconfig build on machines that don't allow sha1
    signing
  rteval: kcompile: Use systopology to get a list of cpus on a node
  rteval: rteval-cmd: Use "with" with open
  rteval: misc.py: Use "with" for resource allocation
  rteval: stressng.py: Remove unnecessary list
  rteval: cyclictest.py: Use "with" with resource allocation
  rteval: systopology.py: Use "with" for resource allocation
  rteval: kcompile: Fix regular expression to match kernel prefix
  rteval: stressng: The stressng option should not be a string
  rteval: Change the default kernel to compile to linux-5.18.1
  rteval: update version number to v3.4

Valentin Schneider (2):
  rteval: systopology: Fix offline NUMA node parsing
  rteval: kcompile: Fix source tarball argument handling

 Makefile                                 |  2 +-
 doc/rteval.8                             |  2 +-
 rteval-cmd                               | 12 +++----
 rteval.spec                              |  2 +-
 rteval/misc.py                           | 28 ++++++++++-------
 rteval/modules/loads/kcompile.py         | 17 ++++++----
 rteval/modules/loads/stressng.py         |  5 +--
 rteval/modules/measurement/cyclictest.py | 40 +++++++++++-------------
 rteval/rteval.conf                       |  4 +--
 rteval/sysinfo/services.py               |  8 ++---
 rteval/systopology.py                    | 34 +++++++++++---------
 rteval/version.py                        |  2 +-
 12 files changed, 84 insertions(+), 72 deletions(-)

-- 
2.36.1

