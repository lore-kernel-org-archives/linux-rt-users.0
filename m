Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A04C432BE
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 07:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB76261AA4
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 07:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhHPHLb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 16 Aug 2021 03:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbhHPHLa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 16 Aug 2021 03:11:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AEDC0613C1
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Aug 2021 00:10:59 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id k8so3114758wrn.3
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Aug 2021 00:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rtst-co-kr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cbsbtRZejCc4mPnIMVCWz2hc+huf8vDsF/6Wv9wV/v0=;
        b=NhnqEEjV2m+6v1JyhMCpWBc4c7UBfYDb6vxCaJ4aZwlQSoUetc+iB+Jq9Lj8VqbfGR
         Fz+vKN/d6Bcio3yVrq/b4CWYLAHD6hqQhmg3B2xXL6ASA1VQDqlQmN+L5COXk7jdo9MX
         Qii4RWnsVCULQ79UsTz8g5DzyRwpUgz9I996OoO0KKjS2CEWjX6FcpnPU+d7qQNWIFjt
         JoLC6Qoq4PtPcbqoASKC/dleSevZ3nn3D2qyc1PcZp7kH1aOEbTOhJla6l9ecQAZXjYp
         /qt8DEWzJKyoyl0XZGLqt8cl3KIgVQ1wYPjRY4XEbcFx6Mfcin3wTq4/UHiiXxYJGXHr
         fqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cbsbtRZejCc4mPnIMVCWz2hc+huf8vDsF/6Wv9wV/v0=;
        b=YsinYC97CyQvUKCGo0w0Ra19KgzrPvfFMMpjz2KeoxpNkxiY+wKpdF0+4DMai5XHgc
         faBKlzAvRTi/5wV61eAHVMM7viigjZNYdWqIRM34jYq+Qfgv+tug+NnyKkwyhKnnPmfJ
         lzlmjsgv+kJAqpKqteXVl3dIjx1U/Xw7MC72TJ81sDg4fef/sQzYonc4K56rGdcP13uO
         C+g+KoBZ5Aemgrzw19GuN4VIGk+LmnnE93F+NuhAxghn0he1jISzE0Li+jG2zULGi2Mx
         qXxM7QdZRwufZ8itItrXJ+Dft6o43Gk8T3yQjOyOcJYuizp1B3t38kpTvoYZ4Xy2x27T
         vWhA==
X-Gm-Message-State: AOAM531POwDkhp5iBkhoPJlxWu6t66pHxFrF+vi8QsPAw8+giSRdngqm
        912CCMn5eBTNyWJbSeZUUZuNShCYB2T0+b6EM5SJAw==
X-Google-Smtp-Source: ABdhPJwfOoNxjlXg+kHZxykUgcTU9HMx4Imqgavf+bxZm7Zrbp7SRiI5qTRVlASkzaS0yBKAMoESdGFXMG1L06Jl4HQ=
X-Received: by 2002:adf:9d92:: with SMTP id p18mr16745767wre.20.1629097857627;
 Mon, 16 Aug 2021 00:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210810060228.GA3326442@ubuntu> <20210816005205.GA3907@nchen> <YRn2GPsT8vB/NF/p@kroah.com>
In-Reply-To: <YRn2GPsT8vB/NF/p@kroah.com>
From:   Jeaho Hwang <jhhwang@rtst.co.kr>
Date:   Mon, 16 Aug 2021 16:10:46 +0900
Message-ID: <CAJk_X9iiqHJJK3weqRgLVmYGKEhLnfeUv9iATWCk8xfFpTVHPw@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: fix RT issue for udc
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

2021=EB=85=84 8=EC=9B=94 16=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 2:22, G=
reg Kroah-Hartman <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Mon, Aug 16, 2021 at 08:52:06AM +0800, Peter Chen wrote:
> > On 21-08-10 15:02:28, Jeaho Hwang wrote:
> > > hw_ep_prime sometimes fails if irq occurs while it rus on RT kernel.
> > > to prevent local_irq_save should keep the function from irqs.
> > >
> > > I am not sure where is the best to submit this patch, between RT and =
USB
> > > community so sending to both. thanks.
> >
> > Greg, do you have any suggestions about it, the RT kernel schedules the=
 interrupt
> > handler (top-half) out which causes the USB hardware atomic sequences a=
re broken,
> > these hardware operations needs to be executed within limited time.
>
> Try working with the RT developers on this.

Then do you think those kinds of patches should be applied to linux-rt
instead of mainline?

--=20
=ED=99=A9=EC=9E=AC=ED=98=B8, Jay Hwang, linux team manager of RTst
010-7242-1593
