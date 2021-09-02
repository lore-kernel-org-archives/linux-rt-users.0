Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55737C432BE
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Sep 2021 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6FC610A1
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Sep 2021 09:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245055AbhIBJ0D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244932AbhIBJ0C (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Sep 2021 05:26:02 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B33C061575
        for <linux-rt-users@vger.kernel.org>; Thu,  2 Sep 2021 02:25:04 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g184so1292717pgc.6
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Sep 2021 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJT5/LMvK96krlkhgCUZyjpdicwtPVUZHzsrLmUWBIo=;
        b=OfrwvYYaXW90n3QR+2y7K/zlIH3C3UNHwSzixOSqxURbihIIOIE91gLrOfF0nWGFGc
         K2glCFpGQaxifQ3B3VCD68c9bSrITQidxV+ScNxHfa2ykjQgTryxGafdnJQvt1McgtUK
         l45KLRUoJlrI6bueozTkjNq246wXxJhRy7jy4A/Ai1DPstOlAGfqpKyPy/28UAFtGQ2S
         YbtpSzfMRVJjvmJJDh/byKBzYVCi1ld6fXNfoaEqJ8BuwN9tNz3Oj1wlBAWBrOM6Dvz1
         VJiuIXPlALBLNxJa36Mm4+st9sk68Zza8U21yQzZzZk0iB9I3CL/dQNNmzi5uJJA50E7
         1gSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yJT5/LMvK96krlkhgCUZyjpdicwtPVUZHzsrLmUWBIo=;
        b=XguwM90sNOWUBzKV/rMYmvpQEKhjp2o9YKKCdbMQ4jBo6QPE4JXgbXfUdLfhcsfHMu
         loEsog4zMuVCp1Uv2KLC6KDkUE+sVl4HHcjMzLUetnhcOJu/XnbJLkw0hQJwG9+JrALE
         mrZVhkT6leard1B+a89hmuZL53Xd3qU+7OXu+VN6BnBbkwOBYAu320e769fH7s+Penhh
         t1UrBGiDWhAoUjrL2hgE1ZGFOSmzzj7H/vD4HO6JnPm8MWQuZ+2Z31/MpJ7IoS8R2CWS
         BJU8pVHaMbf/bDiR9C7GjgGcGv1iRnH5IRRNAY9q3M77qWDYj6moTBYHPk4OlL8NYRFo
         T3Jg==
X-Gm-Message-State: AOAM533i0Obb1A5LHrQ7XJASye51nHWFcCG5hJROI0SzYOpb7Ol+JI/b
        A7ryWVXVXo0fC+gwWvZ9Ql9Zxvlhy+a+IA==
X-Google-Smtp-Source: ABdhPJz0c9Dofta+tXl3G4/WP/w1CKy41+n3u9qerB3q4cf/m2WJf2+SeEZso84DeLOdqM8yLtdFnQ==
X-Received: by 2002:a63:4610:: with SMTP id t16mr2286728pga.176.1630574703965;
        Thu, 02 Sep 2021 02:25:03 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 11sm1805806pgh.52.2021.09.02.02.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 02:25:03 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        Venkata.Pyla@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com
Subject: [PATCH 0/3] rteval: Fix issues with cyclictest.py module
Date:   Thu,  2 Sep 2021 18:24:49 +0900
Message-Id: <20210902092452.726905-1-punitagrawal@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

A few areas of improvements to the cyclictest module were noted while
using rteval to evaluate latencies. The following small set of patches
address these.

The first patch persists the output of "cyclictest" - which is helpful
in getting more information than what is reported by rteval. It can
also help sanity check rteval output when needed.

The second patch uses the max latencies reported by cyclictest vs only
relying on the histogram latencies.

The third patch fixes the ordering of reported latencies.

All feedback welcome.

Thanks,
Punit

Punit Agrawal (3):
  rteval: cyclictest.py Enable logging cyclictest output
  rteval: cyclictest.py Parse max latencies from cyclictest ouput
  rteval: misc.py: Sort the list of cpus returned by online_cpus()

 rteval/misc.py                           |  1 +
 rteval/modules/measurement/cyclictest.py | 36 +++++++++++++++++++-----
 2 files changed, 30 insertions(+), 7 deletions(-)

-- 
2.32.0

