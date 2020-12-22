Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D93CC433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Dec 2020 17:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C120C23133
	for <linux-rt-users@archiver.kernel.org>; Tue, 22 Dec 2020 17:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgLVR1Y (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 22 Dec 2020 12:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbgLVR1Y (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 22 Dec 2020 12:27:24 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF89CC0613D3
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2020 09:26:38 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id n9so12696849ili.0
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Dec 2020 09:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4fVq23SxAZYkcGBwMWEQnJW5qQRsdYZJb6qZzNvSHZI=;
        b=XPePZ/of+LsaGpdBRYlP/FI21KNbRHfa+kMecXHAiEUJ0TA4J77xKaoCwQA8mg2bls
         qEhZLKGiOZZV6cZ9zNRD7dh7rCE/mzNUYo2czTnno5jQgObP0ALK4AloIDh5K3xnIXPT
         XLsgxOQaje4ehoowc9kKYOlG/24gyWHlzbngF3SN20CoNbV3vNe+5bi7IxfI7fsyIcN2
         yFKetVyQDItX03SMcJDtGzqjeU4I0QGjVfdDlDbgE3eUoXqRalaXllPjd13tQf/HSE5+
         32s6SoBGsLhMIbGoyUAevEF2UtrdTSBhE5rzmDRQ7UvpkMCDjT+rZEnyWY95y2mXq4h+
         4N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4fVq23SxAZYkcGBwMWEQnJW5qQRsdYZJb6qZzNvSHZI=;
        b=ll1ksQJFpg4qalHxlKoGvbm/r0hHqyr5EWaoqsXvh5EVFfVFA+4Cn3+o1M8vqk607F
         azfYYzLkHolY18B1JGh90ZELjZHRzRCbx3QQjORQ/OFZOwiMqFAw0PvQGS5yakP5BbGU
         nyoIMYAWrZxD+1zqqLtJIOrCSjuWTxnh71xUu7VJOK+mxG1OyrQTisf7wkqaUHcACUyQ
         IOYsoJOVZqzYSCszSGvif8OUt88hgvfpTIg0exzC+nMdfLO/QmUOYveduQsiOhzzvF1R
         G6rjtlvynHTdgE9OLuO1834lmxJcvzs1o1TWOMqNc+QyQe+1vTWjMz/ZXu2JqTk2JmgN
         x1oA==
X-Gm-Message-State: AOAM532giLjm2GfhtAFcgrK3T9yzWsnErXnfyTsuep2jEWMQ5iupBILD
        dJvW9Lrv4vRUET2y6YWXxXWa+/+wQgIHKAXxVBlzHg==
X-Google-Smtp-Source: ABdhPJx+eb8JMUpepuFDd7SPMvsuuuWPzxkuYInxHlhjHVhR8N4EDSUPHAocXUYGnZYdOL8D4xQPjYKN505l01aXCy0=
X-Received: by 2002:a92:ba08:: with SMTP id o8mr21607322ili.249.1608657998312;
 Tue, 22 Dec 2020 09:26:38 -0800 (PST)
MIME-Version: 1.0
References: <20201218141935.24151-1-dwagner@suse.de> <68c0b159-9460-4041-ba65-9cbc28b6a842@redhat.com>
In-Reply-To: <68c0b159-9460-4041-ba65-9cbc28b6a842@redhat.com>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Tue, 22 Dec 2020 09:26:27 -0800
Message-ID: <CAFzL-7tCyVb03ibT5NgOh+xUhEfMzSQB1efL6a114TVk9vfk+w@mail.gmail.com>
Subject: Re: [rt-tests v1 0/6] libnuma cleanups for cyclictest
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Dec 18, 2020 at 7:59 AM John Kacur <jkacur@redhat.com> wrote:
> I also maintain the rteval program which uses cyclictest for measuring
> performance while running loads, changes to the cyclictest API sometimes
> require me to tweak how rteval works.

What is the authoritative source of rteval?  I don't see it in
rt-tests, in kernel source or in Debian packages.

Thanks,
Alison Chaiken
Aurora Innovation
