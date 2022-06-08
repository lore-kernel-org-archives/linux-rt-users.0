Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2892AC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Jun 2022 09:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235025AbiFHJxW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Jun 2022 05:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiFHJxD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Jun 2022 05:53:03 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D61414379
        for <linux-rt-users@vger.kernel.org>; Wed,  8 Jun 2022 02:22:59 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id x187so7933088ybe.2
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Jun 2022 02:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/HCJzSMnGgOUXmCdi9sz+yqdmAk8mocPKuc9AXUNIUk=;
        b=GQiVpAzNLACmqtDnhbLWigEDSiH4BR2Ssk5CVD/Xkk3DAT+w1jhQluGM536Yu9A3us
         y8YXni8ZXsAxJXdmaCvV7IBeqWHCiWZ6nSyEdErbAtFIGLywI7nYQcYTC/m6tduSNieq
         6aAp/EFkeXh8mTInT6D97O15/rt8Mfmr0pe6Zdbug9DGZD64+PG2FK24Ym0EHXxgNdcQ
         QbrEHiE58PktNoFqV/NrNzyXnHcUN3tMO8e8ivVF4W/f1vq6OmrgkZEeORTFFrN8OMQd
         zGvSeEEGv3Q8EH7l7tumTYk+K4d3R+33wYF+/DovlPmCiXHj/q40kWgfUBjm3wDjWtN9
         7N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/HCJzSMnGgOUXmCdi9sz+yqdmAk8mocPKuc9AXUNIUk=;
        b=H1NJxJ2QtsbJOVZRjmtbibqpQFvJN15buikWPXf9xXOc9bDWt7wiJ3b2OXR7mswvgi
         qHWwUM4yeEgcNBspe5ViKDC7dkuiqCl4BJ4Ol+pwM7q7aZp0kuJ8WsLBFlS5vH7qyzgg
         sucbtbKPZlok7n6ZNEQTQcddY6B80hLRjrpUZE9b9PMvVWPBz4i+mpsrieRcFTIWNXv3
         W7pdOGFru5sLClXiRMOuaeGv4zjR8Q6kOxhj7YfyDcQZN2jwQLlY++Z2C0Xyz4uHAyJL
         lBExPtX8O7xQMdF5ukkJLUASlbxzvn4nvIJKCzgBO/pjt8yij9/FGge6QMeFI5M08tY8
         0Jqw==
X-Gm-Message-State: AOAM530A8im/cSHyaDPAo7Tffw6HqdAwXXcOuleT+rIf7bATiOLpLC5N
        y+g+0ExYFXdcTsw7G9VRQtFG3V3eVKBGTHSWSnQ=
X-Google-Smtp-Source: ABdhPJyi5a3tmSo/59m+HusiX4MJpc9uFZ2PsskjfoQoTrqHa+1dLO7cllLGZ9/7OIEm4oolzMvRRkBHbSs2Udn6AJw=
X-Received: by 2002:a25:db42:0:b0:664:1a9a:eaba with SMTP id
 g63-20020a25db42000000b006641a9aeabamr247912ybf.354.1654680176386; Wed, 08
 Jun 2022 02:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <5c1e1916-6966-f54c-6af5-ad06ac945718@monom.org>
 <CAFLxGvzxBSaqFAMUzBVfAwWdHgARxZP5MaeQXUpWUPV6ypETvA@mail.gmail.com> <20220527161420.hr5sxxqepuhjeqoi@carbon.lan>
In-Reply-To: <20220527161420.hr5sxxqepuhjeqoi@carbon.lan>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 8 Jun 2022 11:22:44 +0200
Message-ID: <CAFLxGvxij=8vsgd0YRRYC-843xvdUb+iEYJJtqaemkpXeMqsHg@mail.gmail.com>
Subject: Re: [ANNOUNCE] High altitude realtime workshop 2022 edition
To:     Daniel Wagner <wagi@monom.org>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Xenomai <xenomai@xenomai.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, May 27, 2022 at 6:14 PM Daniel Wagner <wagi@monom.org> wrote:
> > Whoops, old date.
> > 10. June to 12. June 2022 it is.
> Here some more details about this event (hint if you want to attend
> please let us know).

Please prepare for bad weather, in the mountains the situation can
change quickly=E2=80=A6  The weather forecast predicts a small amount of
snow fall for Thursday, and there might still be snow fields left from
the winter near the summit.

Also keep in mind that we are still in a pandemic, so be very sure
that you're healthy (test yourself!) and be fully vaccinated.

--=20
Thanks,
//richard
