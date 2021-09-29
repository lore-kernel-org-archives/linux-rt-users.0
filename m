Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD57DC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Sep 2021 16:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E3161411
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Sep 2021 16:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343509AbhI2Qma (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbhI2Qm3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Sep 2021 12:42:29 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8831EC06161C
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2021 09:40:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z24so13235784lfu.13
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2021 09:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=92OZRnijSISfnOy3SDS1DFTSlSfPBIYczmXt9txVNHk=;
        b=fNGq/GmomAMe5fTEjDaHW+mS7a3IuOPNU+bxbhdAKqF5MaVXgKf6tvfay6qXaNi1rB
         /LeQrvfiq0SdPlSA7kDyHPtxjZpHPQSHBx4t5LSgowllQOQTIfX+Q99UU61mWmGyYvuC
         NjTb113xMGHpYe0nIDIvRk9CS/lXrBduN549MDjejPnotuEIWBCqT/wudbHoD7NCno0h
         hJHUMfcc2Esg3E1Q9VQma5LRkrxeq6MM/Gq6bvJHb2D2yW9EgtgsedXpkLWEFNhZdDTy
         SrWGy+jPzdvZXozsd6i9JT1auJXp/r1WFXws6//da0jWXVWkirXLVzm72a8N4wL3qEQ8
         K6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=92OZRnijSISfnOy3SDS1DFTSlSfPBIYczmXt9txVNHk=;
        b=Hpb62MgXHoDQzFNGOqhkf4+Wn5FbaViLILNalBFHQHHxZX5wfBiMBegyQ59uiu8IAb
         Q7khC6jrK/YoFWfsPzAz0wFhtwWbqFShIE5yIuEKpwQ4dd0kHZUQh3cg22oEH4TIjiCT
         +qIIwR4QJXGwjD7v8k5fQ3YEuPyHzI+9Mq9AcOKR1TSnTrRsSrvpy63KlK270Q/E64Ph
         i16xFw/SuenMMjOlRUBKOuSm9arVp43KrJGOBNsqFMtciIMRxda43l+oISAiIDctz8k8
         UJtFbn0yecAWeHrT6wqBUSCmWkQdidfS9BKwPIALlDTJSpo1788kzhOM11auWdKtQuiO
         GZMQ==
X-Gm-Message-State: AOAM533euhTwFDf4ZBVdBkdbMYh/7/s3bp4J5jLgXAgtx9QNy+6/RD4E
        xjNe4RuebB58YsIBZzSxzbID83TRVXe7bHcy++OJsJLQ4/SuZA==
X-Google-Smtp-Source: ABdhPJyI8b+DafipDgUAp2EJbsbIOSMtZ5etl/3Prx+0W+GEGafcwcXHNxcQHkP140xXw+vk3DVa4JWnUqiPYho43LE=
X-Received: by 2002:ac2:4c4e:: with SMTP id o14mr670453lfk.224.1632933645692;
 Wed, 29 Sep 2021 09:40:45 -0700 (PDT)
MIME-Version: 1.0
From:   Pierre FICHEUX <pierre.ficheux@smile.fr>
Date:   Wed, 29 Sep 2021 18:40:35 +0200
Message-ID: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
Subject: Strange problem with PREEMPT_RT
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I have a strange problem on a PREEMPT_RT system.

I have a process with 2 threads,

- 1 TR thread (10 ms period) which places 350 KB blocks in a fifo (1
block every 10 ms).
- 1 non-TR thread (SCHED_OTHER) which reads the block in the fifo and
writes it to the disk

If I run this on a powerful machine (HP Z4-i9, 14 cores, NVME disk,
CentOS 7 with 3.10 PREEMPT_RT kernel, yes that's ooold), the max
jitter WITH hackbench remains around 20 to 30 =C2=B5s while the max jitter
WITHOUT hackbench goes up to 350 =C2=B5s!

-> hackbench -p -g 20 -l 10000000

Running the program with  taskset 01 doesn't change anything
If I don't write the data to disk it doesn't change anything either.

The important jitters appear rather at the beginning (but sometimes also la=
ter).

Any ideas ?


thanks by advance

--
Pierre
