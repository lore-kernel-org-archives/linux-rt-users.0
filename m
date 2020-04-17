Return-Path: <SRS0=XNcY=6B=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8924FC2BB1D
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Apr 2020 23:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0D522240
	for <linux-rt-users@archiver.kernel.org>; Fri, 17 Apr 2020 23:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5wS1+SZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgDQXkq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 17 Apr 2020 19:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgDQXkq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Apr 2020 19:40:46 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE146C061A0C
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2020 16:40:44 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id e25so3793032ljg.5
        for <linux-rt-users@vger.kernel.org>; Fri, 17 Apr 2020 16:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=S0XswGMUmTE491Cwj5/yLKpYA12yCAipsSi7de5p/jQ=;
        b=T5wS1+SZjPg8tYz2dwBi/WatvekWVvRMJQz9q8nV40mMWO9eQ1BQWB86m7nrzimoJN
         9cbSYXmVYof4QIsFSGRBd6TKFlPV+gbSmGE6FHxH/TCronZ/8TY8fKd48SMWUf+rIDb+
         D2IT/hCcV9JmGXB6vJprvzdwgFwcpiSQtNVnSqzYXeCJiYaSyjXIW0ueWut4jHCCQXOG
         KDsWvRI7BG9Skxp/C6EV7U/6umXEBLf4RHRJveLR0jlnlr7Sd9rf5gBAn+0I2+UfQtWi
         0SKv63QXfl0dLI3/61ZHm14lGTNf8dAnBd3KTV6Q0yIa+VeY07TThZqMm2ILQeT/X1fU
         VfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=S0XswGMUmTE491Cwj5/yLKpYA12yCAipsSi7de5p/jQ=;
        b=PZ/a6iAY9SZ4MCLjNRHDcGoDcXNjjTvYWLz4SuwzqleEhM55r9TtiUS0ViJfLnLZ82
         t7gbFORl7fWpZqXc6+4+N2hSV04borjWsdVUYJIaIRs1ARg16hCy5g0v0E8ByGDHAXzE
         Zz6djBcE09ayWFd/MVpuqVQXndfYAL6MwaGn9Lb8ovbf//TmfAsxku5BxW3m7WyVMhFB
         r9lq0pSeqj/76wyjuAdaxpb6AUP+HZvx63MJqcNXZPoW8bBzF+vnWQc1Vga6e5g01N5b
         5VVY3uLPnMJTdZJv8Xy3RxzqH4G9MFzhGZs7OhZupoRh4X3ud+U3cpXNGoxcf9Lx/CMA
         KBLg==
X-Gm-Message-State: AGi0PuYbEtllZNKHfT33vBEwaqLB3emMfed8zQscJeylm7d9JTBZEWWa
        5xFw9qc8z5Z2lXO9mrMRycIvbVM9sAvpTbhfujwi+Q==
X-Google-Smtp-Source: APiQypLDO4bheAuElb5r8uz0bGa0pzpxHVWnE9i70n4/xEUGM06pqTC0t62rs4qIb2lwukANi9RubDxAkqyIfgB+GI0=
X-Received: by 2002:a2e:9752:: with SMTP id f18mr3590540ljj.181.1587166842945;
 Fri, 17 Apr 2020 16:40:42 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Fri, 17 Apr 2020 19:40:31 -0400
Message-ID: <CAD56B7fTCFwAwENEGHDJXADwjzXxcB=aQGAa5KZJMNCtNYHHCQ@mail.gmail.com>
Subject: v5.6.4-rt3 on arm64
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Folks,

I finally got our Fuego test system turned back on, and I'm happy to
report good cyclictest latencies with 5.6.4-rt3 on arm64 (Zynq
Ultrascale+). 13us with a shielded 1 hour test.

I'll try and keep this on and report anything unusual that I see.

Nice work everyone!

-Paul
