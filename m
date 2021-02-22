Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C19C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 22:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D310A64E4A
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 22:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhBVWIl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Feb 2021 17:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBVWIk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Feb 2021 17:08:40 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4355DC061574
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 14:08:00 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id 81so14333523qkf.4
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2021 14:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dVmsHHj/eK2Nv4sfbnsJx+SG+o3dWmaq0r9QoLNia6w=;
        b=QCF/cOFoylmubugpeXXnTaVM9KDuAPXAxKl81ImRifN4YevSIYMpVr825kuTlBPNG3
         dQvO2d/sypAo3eQNgy1DpINe5aILTGOw1kmGvVS/JiNaYho1T2Iket0MPfP+LMWgAmAn
         8nQT6SruLg2OeonI4dOELPKaBPFZrW/nq/ytdV9fTnWpHqpzcJeAIaAZ6t6Px+p7W98J
         cJHSjWaoLLx75NJbDvUPmcYoZ7JyHSU+fizoYprTAA44SoXHpUzCHCxTczokmk8orEQa
         LofUrgTdI1NZOrBZw/xfWaQfDqbuA29L+kirgu06AF9KP4I8nR7+iIAb55F7Uk/zp064
         qLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=dVmsHHj/eK2Nv4sfbnsJx+SG+o3dWmaq0r9QoLNia6w=;
        b=PQV7LwOyfXIOW2lsEr67Px2ClMbrwvTDiOvQ3sqzIOlvkoaiil5SZoVVKg148PhtwR
         FkWUKbzocejQxfI+8XXM3786QFuTZZWNn6tsR2/amr0w6hr+/RPyMpCKkjP5QAoka1tp
         hnQxF9z5kHEkahPoCwiYiPYRjilyuzwaulLG9EbWZhFbz5AQuFEb7Ryv4eMwbeKFiip2
         L6QU+pDXplDX7Fd1WUHjN9ILw6r58bbwXRSZy4KX+oHDeQqAhvdpIVdCtmkUkqMR2Jye
         YJeHF+rXJj+jLUdxi/zXqsEaL5hJ0fsiYA/j92tWNHUMlNrRspwVQ3ze3D7cChJfE4W7
         tNEw==
X-Gm-Message-State: AOAM5309VE0cfb5dDv242NcmTxU98Y1UXhbz9UXcWcA5HEWsPLLm6k6u
        jaj2T9CpSE63N65ICficmkB7e5RColgonalw
X-Google-Smtp-Source: ABdhPJzRz5so5wsW6XhedxYa0YzVaFa1dCZ26/p3kYfk6F9b0oWTyGX/FZRRC6PLrzmwyigMQ2EEqA==
X-Received: by 2002:ae9:c10a:: with SMTP id z10mr24331674qki.4.1614031679417;
        Mon, 22 Feb 2021 14:07:59 -0800 (PST)
Received: from fionn.redhat.com (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id o5sm13278352qkh.59.2021.02.22.14.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 14:07:59 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From:   John Kacur <jkacur@redhat.com>
To:     RT <linux-rt-users@vger.kernel.org>,
        Christian Eggers <ceggers@arri.de>
Cc:     Daniel Wagner <wagi@monom.org>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>
Subject: [PATCH 0/2] Fix for machines without numa
Date:   Mon, 22 Feb 2021 17:07:48 -0500
Message-Id: <20210222220750.12911-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Trying to return the code to a state where numa is required at compile
time but not at runtime

- The first patch should allow cyclictest to run on a machine
without numa.

- The second patch is a clean-up of some old code

The code is pushed in git to branch unstable/devel/no-numa-runtime
so that people can test before I integrate the code back in the main
branch

Thanks

John

John Kacur (2):
  rt-tests: Don't assume numa is available at runtime
  rt-tests: remove rt_numa_bitmask_count in rt_numa.h

 src/cyclictest/cyclictest.c |  8 ++------
 src/cyclictest/rt_numa.h    | 12 ------------
 src/lib/rt-numa.c           | 17 +++++++++++------
 src/signaltest/signaltest.c |  8 ++------
 4 files changed, 15 insertions(+), 30 deletions(-)

-- 
2.26.2

