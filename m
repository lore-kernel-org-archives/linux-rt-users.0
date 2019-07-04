Return-Path: <SRS0=a459=VB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3457DC06513
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jul 2019 10:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0893C218A3
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Jul 2019 10:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc8tZocV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfGDKuI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Jul 2019 06:50:08 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:41188 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfGDKuI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Jul 2019 06:50:08 -0400
Received: by mail-qt1-f180.google.com with SMTP id d17so6131328qtj.8
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Jul 2019 03:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=V1XJcE1++TfCrB9kgGgJP5MQbG9207rN/zn9NUDse7E=;
        b=Uc8tZocVCug6xzkwaIfc9/EQ3d7cYYgDSpxkrJFPWMUk629pb7rlKi89wikgHn87SD
         XnwlYASgfgW34tvaPwc0KlXF8xiLvkqfXrMBv0QN98oWUsLx94L4kOiNBw/PJOEvASDJ
         +Tii7lZigwzeI5AeIa3xVE6UHRlALfGIsPo1cbNsUATGIdSPFVvdFbWuqoKDqrfg7cSj
         g4Hzi8NoDB7+RMrTrSkoBeY8eKMgxOdTUUmMt5qGANhCGwsrthnFQv4zgsT82oDmSem7
         Janguq1EQcDsDBPYJpZ1C+6d9gXkBACNiYhZUoUE6ZAN1vgAnmYmLIieq1eZSZlLqKOJ
         XFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=V1XJcE1++TfCrB9kgGgJP5MQbG9207rN/zn9NUDse7E=;
        b=nTwnooTB5AfpJQVYDKXmRkpvm++2pCvwRDm8SMmZ21Q8sJPtFcKO+Q4ZvVAa/4hNOn
         q/14w0SMCGSHnPRyQJvAv9hJQKDE6IZIZ3ov1tc8uoG1heVj+Zjq5q3tKiJ1UvvaM7e7
         kn/qvCKiJHn4WKY57DtwajM9VAc2cUVl7nbLOAFc5CMLXERGfZZ9YS/Orwzb+34gpPyr
         gxSXgdnqn6QQzcze8+BTTooTl01tHFe5pb14it8I+UjaDanAdhTE/06nG+FZIkB76S3d
         HztYX2PVBaW/oxDfZ7jiI+gQil/X6rxdYgfYa/Eg3SZf6v76N8Wo6d+53qcyAckdC6An
         pv6A==
X-Gm-Message-State: APjAAAXSqQIyR8YDYeKxWPA3+r97WUobZT3sifWdGvMJp5VWB9/fx6te
        LHkYpaqTjyUBghU4rav52oZExwuR9n/8p7x1KKfvjA==
X-Google-Smtp-Source: APXvYqyoh8PN1sT5uf7tbEwcWXpICkmE5VlAmIjesEwZ+C6SoPzvRzMVbcscv0dpe9h/o52b5H+1IGtj6K4UOENbl/4=
X-Received: by 2002:aed:22af:: with SMTP id p44mr35698891qtc.348.1562237406725;
 Thu, 04 Jul 2019 03:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190703111728.cnvki7zcqbiteveh@linutronix.de>
In-Reply-To: <20190703111728.cnvki7zcqbiteveh@linutronix.de>
From:   Arve Barsnes <arve.barsnes@gmail.com>
Date:   Thu, 4 Jul 2019 12:49:55 +0200
Message-ID: <CAJjrzcU=+oLpYc4GezinG0q8BFeJfR2OP6MJvFB33WF9=AoA+Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] v5.0.21-rt15
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 3 Jul 2019 at 13:18, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Dear RT folks!
>
> I'm pleased to announce the v5.0.21-rt15 patch set.
>
> Changes since v5.0.21-rt14:
>
>   - Revert the replacement patch for wait_for_completion() and use the
>     old patch again. The alternative version caused a regression as
>     reported by Arve Barsnes, Corey Minyard, Kurt Kanzenbach and Steven
>     Rostedt.

Can confirm that this fixed my problem.

Regards,
Arve
