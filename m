Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8F0C4160E
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Mar 2021 17:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153CA64F0D
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Mar 2021 17:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhCOR4N (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Mar 2021 13:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhCORz4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Mar 2021 13:55:56 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DFCC06174A
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Mar 2021 10:55:56 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r7so10237198ilb.0
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Mar 2021 10:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aRZnF+SVo+5LNxhv7uWaebQV9isLKr+HlY3m+k4FF28=;
        b=faeX7ofqRAiWpGyVcrMF9QjeEszGXyLXmqG/8cZRU5VGsI6s4rdHRL2kG2TUBEtQ7m
         4CGajY1P6EROPIgOFvCiAabHsR1W9rVmZCvAZsTpYG7Mt8rWncGtLeZGQi5jRh5eFi1K
         LVbgv6prHJR/FEXwr2o8OQO4Io46cTjEp9F2rC9QiTV9Cq43wNHRu3FhWdLE4DT/MVwt
         nM3kUABkX8WFi2WqZRmpXYouqKweE3mUCjNy5IxnpAYeb1GreXgskhRIDkT03H2etulF
         uQZWxuUHMTdQ/ehFuvNF+JLgdGfNQTimRXYYi7opCCBWlu3onGnRpNQxTjj3ZC/qQx5W
         2rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aRZnF+SVo+5LNxhv7uWaebQV9isLKr+HlY3m+k4FF28=;
        b=SjhptlyrkOn6v/RItmSnaRQhaDd2qtLe9LB/3jAeSOUrnd5iWAU5/uVwC1k0oAGsrf
         bpI7iImPHLM32pOKSAWwskFGWddxC4ueoJKdpq7Ga7rKsDY+5VnMyX2mRLaPaoyKC9rS
         0dajrFby95oGQ3Jw0kXMCCuA6uEF+BTYDnCh8ZpkhyyCFtOPB2KIpzBq4tnnIqAKvlJt
         fEm6pjyZApioPO0gxcakt3a3XmlNLEFYOhseNr2oarrWXWDm2MnFelQBWUe6utLfy3zd
         6l9rneZkSDNdFbmAvWhu8wCCy8YPDqdWL8AsA1HlUx/kGzKPne2QDEGieC3aLyRKbxYA
         X+dQ==
X-Gm-Message-State: AOAM530C8vUq2mRPjfgWsjmXQh1sQFO3UdBExd30emjqokIQu5THjW/F
        OWAdBzWjJJr33LEyRrHcn9X8VAcoyTpjF/UUXXJk46AO
X-Google-Smtp-Source: ABdhPJy5Rlznjot+A7HVsQSWybSbPaoQLKRggY0DVbGZ7ttR6IRmvNK9zhZ0yPaothOoX3fVKVk6qrVQgq3P1wbEKrY=
X-Received: by 2002:a92:d843:: with SMTP id h3mr659319ilq.306.1615830955655;
 Mon, 15 Mar 2021 10:55:55 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Mon, 15 Mar 2021 23:25:43 +0530
Message-ID: <CAOuPNLjoAST=rQ4NmGkVjqxi3iNqPg2MmqjCdr6=8smUwryX8A@mail.gmail.com>
Subject: about preempt-rt patches
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,
I just wanted to know if this is the right list for posting
changes/discussions related to preempt-rt patch set and linux-rt in
general.
I am expecting someone to reply and confirm if this list is active.

Thanks,
Pintu
