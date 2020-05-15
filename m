Return-Path: <SRS0=9HdY=65=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C02C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 May 2020 23:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 125B120657
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 May 2020 23:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurora.tech header.i=@aurora.tech header.b="bkug77YB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEOXrB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 May 2020 19:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726223AbgEOXrB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 May 2020 19:47:01 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8EDC061A0C
        for <linux-rt-users@vger.kernel.org>; Fri, 15 May 2020 16:47:00 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id l20so4243857ilj.10
        for <linux-rt-users@vger.kernel.org>; Fri, 15 May 2020 16:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=shkYjzOxhqIISQF1DH7hsCPmAppRe0nGB0Quka5/p0U=;
        b=bkug77YBSRUFmYSzRt0kE7cCQSbb6wervEYorV8VXJcGXlweWLruSwfYhiLr7f6joe
         9aJLoZfQLULVSyIcYg/Tt6Gr9JgaQKx5a4fgAJyGo+3rbHSHDbV/drrWtQ8CczCjyclJ
         Kb+Vd01QKiudRB2eytOqppATzt5A2qkXumfcnejlUjtcp1yzYE6MG/mv+Sa5jQL18/0O
         fTKyP1eBLzW4SVlA9mPx2O0vgVr73W2/tDOcZpTm4zdZnz0EUx101czk++2/vhf2pslI
         /r9W5ILzVbN+5Ewc3poX69hXvE+0FUBZy64i1mbXHRFdTW5Buh26zahQalwWbaTIsF/V
         duAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=shkYjzOxhqIISQF1DH7hsCPmAppRe0nGB0Quka5/p0U=;
        b=XRm9STDRwBh5op1HEuaf60DbzlBYj5U8KR2FqSEi+qf6VwwbUpXIKF6XTPZWpRsQqK
         hubthZiQhsYpxmBX8DxRoWeJZncZ7Ku2RbOtUdzGLaK0Sn0Gqn+NPTiYYiDjZ0Imay4u
         fzOiVEMkorvVfHSlt1QC2GcklO6sON876oVqXjzOzJ61dtEV71HSnmvnXDqDnAQj6Xx1
         6w7NozQy/gx1b5UYyrVZWfSw8juy0fv00vk/R170CVkZDH1nnWZdf7qdmJj2YI9Ui/C5
         WAwr6pRjLrNu+sCbmHuqZ8WRkYWzqmbMeiPV/cXxLzj7P/6Y3YqOMHUo5bezOyzJcrK/
         QN7g==
X-Gm-Message-State: AOAM5302ugW57HMtrVBeScX019Mh6iYKTeRdUGK4P5rJd5ecq3NbdUvR
        wZFDsq1Iht00KaDFT/ruVoZXZFTUTJSjIrA4OUZEQk8MeQ3L8A==
X-Google-Smtp-Source: ABdhPJwA963a0HLISzrHD2jyk4WM5yDsrqJwdGUstmtu1ugWHGrFWEkdmozbBM+jVaOXR5d5ejz/iOeNhD76Jp4toPk=
X-Received: by 2002:a92:1b0d:: with SMTP id b13mr6073841ilb.232.1589586419043;
 Fri, 15 May 2020 16:46:59 -0700 (PDT)
MIME-Version: 1.0
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Fri, 15 May 2020 16:46:48 -0700
Message-ID: <CAFzL-7tzwnBEnt_q2f0BPSAO3To_Zaxt4bLtfzKVOiyJTua45g@mail.gmail.com>
Subject: remove of ktimersoftd in linux-rt-devel 5.0
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

About a year ago the following commit greatly simplified softirqs:

commit 6f6ba7715a91877cf5fd2b357db3799baa331d9b
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed May 29 18:47:32 2019 +0200
    softirq: rework

It also removed ktimersoftd, without comment as far as I can see.  Is
it obvious that performance improvements due to lockless
synchronization render useless the earlier split of ktimersoftd from
ksoftirqd?   Is it now less likely that a large number of other
softirqs that are run immediately when hard IRQs terminate will use up
ksoftirqd's time slice and prevent the timer softirqs from getting a
chance to run?

Thanks,
Alison Chaiken
achaiken@aurora.tech
Aurora Innovation
