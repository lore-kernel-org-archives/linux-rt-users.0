Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E478C433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Mar 2021 08:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 418A264FB5
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Mar 2021 08:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbhCPIsq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Mar 2021 04:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbhCPIsg (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Mar 2021 04:48:36 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB65C06174A
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Mar 2021 01:48:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dx17so70798592ejb.2
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Mar 2021 01:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xCpnq3gbL8lwbT1KFE/q0OPcY16sm0kM+EsY2/AF1lQ=;
        b=k6FfmygOp0Vh3HDPq9pWguPMiGyyllxy7Td4d+ZF9jUYDGeWapXNRcgbQE9KUw/FEg
         DcjePNzfLNX5RUGL3nKx86Yc/ktOEwYgZNOLzn3ir1+fkr8SUlzC87aDW/NGqccY+Rre
         2JFLmIRfmwY7ybeuIXL/oWisXaNXbqwEcp50ENNe30jexWk83ZA1NmFdiU7R4tbtXrCQ
         hVexMUZU3gzgHl4t3h49dr4+tszQnFxUlc4cvSjnclpH5s4s+7m+Q0HdRZusVl8SLiFI
         Wg1Q6uFBtwPp+eHKZKvKCojBZLz1Z0Dp0taBPUTBFULK48z0pW0dZDz9UEKGZ+FvzMwR
         CwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xCpnq3gbL8lwbT1KFE/q0OPcY16sm0kM+EsY2/AF1lQ=;
        b=nvc8IacF23AlurHs/cdrMOaA2qCOEnWEEwwtZzfIiBTXmrnmFBop5HgoFexfPWv/l+
         GMVP7qoNeb+JuvEw5ohSGEH92lbozYQiDyzZ+GSTkl8CfZmrxx9g8pJAorQxKFlJwZQ6
         /cJbIdrD6/iX+/v8afNwH4+RxczTM9X9Iy3vtnQJpyauKyqxeNhl7pC0cTu0OwGMKhkM
         mlwrkcN0ucRwRpV8q1znd04OQByEsspEojoLLUEIy0wmbw/3/FINVVsOpl4MbEugax1H
         drhrd0UpxylcoYq09a3s2ZvTShPLzPRQpe5lJsBCXZKPNbAOZaXYUSjcBs2Zp5G8hR2A
         tcNg==
X-Gm-Message-State: AOAM5335ihCcer9XgrNBMIicCSSAQrO7mx6V1s+sy0LNRFk6P3fSeqxD
        swO0PW9sEM/dA3IDFGDAkXGfNuJJLMXSGJdrCI3o5zsQ
X-Google-Smtp-Source: ABdhPJxfkIA3IlHQBjeQHlTA3KekPBtjIK9F1+ulaeifN5suXaiQQIjSTtf6VkNEPYuar43DG9mWJ4stmQEseZ/qZX0=
X-Received: by 2002:a17:907:a04f:: with SMTP id gz15mr28180916ejc.293.1615884514464;
 Tue, 16 Mar 2021 01:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjoAST=rQ4NmGkVjqxi3iNqPg2MmqjCdr6=8smUwryX8A@mail.gmail.com>
 <YFBOQdCxc9QyBk2Z@lx-t490>
In-Reply-To: <YFBOQdCxc9QyBk2Z@lx-t490>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 16 Mar 2021 14:18:23 +0530
Message-ID: <CAOuPNLg2Dbhh9oa7kSSuabEYb9oqmtZy85ZES1Regq3dcuKWpQ@mail.gmail.com>
Subject: Re: about preempt-rt patches
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear Ahmed,

Thank you so much for the confirmation.
Yes I already saw those list and even the rt.wiki pages.

Actually I have subscribed to linux-rt-users mailing list almost one
year but I havent got any response/updates.
So, I had a doubt whether this list is active or not.

Thank you,
Pintu

On Tue, 16 Mar 2021 at 11:50, Ahmed S. Darwish <a.darwish@linutronix.de> wrote:
>
> On Mon, Mar 15, 2021, Pintu Agarwal wrote:
> >
> > I just wanted to know if this is the right list for posting
> > changes/discussions related to preempt-rt patch set and linux-rt in
> > general.
> >
>
> Yes, this is the right list.
>
> In the future, don't waste people's time by asking questions like this.
> Just check the mailing list's archive and its meta pages:
>
>     https://lore.kernel.org/linux-rt-users
>     https://wiki.linuxfoundation.org/realtime/communication/mailinglists
>
> Good luck,
>
> --
> Ahmed S. Darwish
