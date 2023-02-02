Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39AFC05027
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Feb 2023 15:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjBBPNj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 Feb 2023 10:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbjBBPNc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Feb 2023 10:13:32 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57B8A27A
        for <linux-rt-users@vger.kernel.org>; Thu,  2 Feb 2023 07:13:28 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mc11so6779526ejb.10
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Feb 2023 07:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=austral-dynamics-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q+9GJtZqkE90Ar5eE4zM5X1g+FOHEkle+W3ufiyC2jY=;
        b=okskez3kupN6Q0F8mytILm95dkXaAnYpYrVsvTlX3QOquWHKSjLb3E8wbv2T8uKuAD
         LCLrOaBw3PrVnQUh55oIOnRDPlMUvJo1IjOUCv7T27svcYH5QIBy0qj4PdfuQdBA8EcF
         3VjSvZ84yDju2ylWtigzYD9hxIBv3JmJC4MQ9fiLLtH7AS4dH2hwb0FH7LLse7+9Jpfv
         4wGra8/cJFzKIMYCMI5qUrxkcKUIkZIdgbTpPZsKXT/dWyliv1reu2l9BX+eZmAqX7jm
         k88Jnv8DkZoFtPZ+3LyipQqJ3IRG1Ta8mMNS8lfkZEPX5hY7OM/ukWesOrFuv4NY7MLQ
         Cl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+9GJtZqkE90Ar5eE4zM5X1g+FOHEkle+W3ufiyC2jY=;
        b=H48rUIp+Rzi5QcKwvGYJHq2/PFswX8fZuQrZaNQrMfb0gilaisOmczVCNaR8xu5wIZ
         pgSCfQ/QpNwLyPUchPsojvGCI1KRS7BKHeBiKvMjSm4dIkM8F/SC6fzLXHMiKiZrsnk6
         /JJ+9e5d9BD+Kpco7IPuAe+1QxR6iqO/buAOCqMneS8rpX5l76/6bZPp+h7IDbk8KjLI
         WyRhie9S+hXC5rcTa0SJ3NpTB8Vux26RH/9bhYVg+nPuozhOSIMzv1xTafoEDZ3tJhwC
         tIL9MBphWJfkETHpzDCwU+hMXZGoVfKFKdv39p4XoDRiofZaS0ZBKBs4MTpMiedp11MM
         q77w==
X-Gm-Message-State: AO0yUKU3n5qrRmppSZV1fc2K0/W4lhpvrVD2gW7D9fgO/e4ZD88gS8ZY
        lP2ZULz3nCf/IxBZiSgsEW6Qvt9WfZvvD6XfKLSGDXiqoXDAVMXBoRg=
X-Google-Smtp-Source: AK7set9aTHzKdPm1Olhfp88n38k9xPn1txqbQy9rniZgbPtrdTPhKr7Iy8nMiGNZFCgtajlr3VYLdcZ/W2We+DvXmKU=
X-Received: by 2002:a17:906:13c7:b0:889:310a:3fdd with SMTP id
 g7-20020a17090613c700b00889310a3fddmr2085156ejc.22.1675350807099; Thu, 02 Feb
 2023 07:13:27 -0800 (PST)
MIME-Version: 1.0
References: <CAKkbJ-wOuKFZzmHL8wwap7160HdeoqQwkppGFwCc3Ah5GP94oA@mail.gmail.com>
In-Reply-To: <CAKkbJ-wOuKFZzmHL8wwap7160HdeoqQwkppGFwCc3Ah5GP94oA@mail.gmail.com>
From:   Michel Macena Oliveira <michel@austral-dynamics.com>
Date:   Thu, 2 Feb 2023 12:13:05 -0300
Message-ID: <CAKkbJ-zUtR9xpPhsXYGfhJBqD1Ut80p4FEmPgR8nVOv7AQBL-w@mail.gmail.com>
Subject: Re: Out of Memory problem with kernel 5.16.2 and RT ptach
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I solved my problem by changing the compression method in the
initramfs.conf file to xz ( COMPRESS=xz) ,updating initramfs  and
updating GRUB after.

Commands:
-> sudo update-initramfs -u -k version
in my case: sudo update-initramfs -u -k 5.15.86-rt56

->sudo update-grub

Important to say that I'm using version 5.15.86-rt56 now.  Also, I
noticed before solving the problem that the initrd.img-"version"-rt"x"
was a big file with
around 700 MB size, after changing the compression method and updating
initramfs it is with 56,1 Mb now.

I hope this helps,
Michel
