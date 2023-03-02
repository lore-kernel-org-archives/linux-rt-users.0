Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC78C678D4
	for <linux-rt-users@archiver.kernel.org>; Thu,  2 Mar 2023 08:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCBIHA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 03:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCBIG6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 2 Mar 2023 03:06:58 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EC834038
        for <linux-rt-users@vger.kernel.org>; Thu,  2 Mar 2023 00:06:54 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id f16so16706624ljq.10
        for <linux-rt-users@vger.kernel.org>; Thu, 02 Mar 2023 00:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677744413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuthGlmubqR6VRWQRt8JmyV2YlX5j1mT0Uhiy5bDzjM=;
        b=dIAXIcX5yVVn3EFFw7iDxbLoKKwHdILVEjRW6hBJ2/8AYkRCUa+ttFOtvLis0XGXaU
         7SC6D4cfVvZ8btyLcnO2/mJWc2PKG5ho0guctZY7g+bXCnogdJlOBj46ANMQT766fz3i
         yHM7DGHfl9KiDU2ejHX2G75wTZ4JmLP/RJaIFLuujcm3KuPo25qE2+9JOFPaRvNkhQd2
         l4fjz6dnpr0PrgxxmUUTu3J3p8qjErmkgDCnK1kAma5KEV8Iv0xsHcFKT8ArIS6+IUX5
         rMcs4ZPjlUo9EGH34itahOKH4/44FurxB7rJ/q09vZk7H1gjg4vZk1DvLwoM+HsgpQOU
         D7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677744413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuthGlmubqR6VRWQRt8JmyV2YlX5j1mT0Uhiy5bDzjM=;
        b=ZbzPZMxV+v4OwumBCG2P55kl+LqTV/4R3yci7T44yxthZolOEE6M5QX/Trytk6iuWo
         5hbWS+J/ybeDEKQ2igmjIlM8ATYZsRGASDN3afI+Yvv6zub7SaKsDxjazhs8XaNNLyrr
         6AWieUclrswwb29xuI5s3xYH1L2MRpxvkLT7snxgtyXAhcWRVYlbUb2UAvFJNe91obAB
         C7GBxO+4RUvTM0wfwH0y6DB0j1JNIy+hlpUz0BYT7McoivjbVtwrtWFO4DbvTTeUl8W6
         C19Z8SkVMghmKA8nclMfOypVTk7Z1NMwgNUEdhPSDU2IlnTZ2mWE/8xIilLasAL/5PQU
         5urw==
X-Gm-Message-State: AO0yUKWDb1A0srhDYTbtgD7TfLgyhGd9yGKgwTDu+G5eNxT33dd+ulV2
        niKPiSe/qMja+Ykn7Iz9AAflTeJ5ScOdIKKY8vTLkYC2
X-Google-Smtp-Source: AK7set8z+v9whDVh2Uw6IiL84qSmBG4rVEyLFroHk76E9NPLsxmFW2E05aiBixOnmWJgQVkYZhVUvv6rJ7irk2TA5HY=
X-Received: by 2002:a05:651c:b9b:b0:295:9dc0:f204 with SMTP id
 bg27-20020a05651c0b9b00b002959dc0f204mr2972200ljb.9.1677744412572; Thu, 02
 Mar 2023 00:06:52 -0800 (PST)
MIME-Version: 1.0
References: <Y/yrHe4OIYcWFbNO@linutronix.de> <20230228230009.89787-1-brennanlamoreaux@gmail.com>
 <CA+cAkerw6kqhibwacCxwtu4u_U3pBYF0xcRrOVZh1T=++vURbw@mail.gmail.com>
In-Reply-To: <CA+cAkerw6kqhibwacCxwtu4u_U3pBYF0xcRrOVZh1T=++vURbw@mail.gmail.com>
From:   =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= 
        <frederic.martinsons@gmail.com>
Date:   Thu, 2 Mar 2023 09:06:41 +0100
Message-ID: <CA+cAkerXmfVYAKoO7FU8aPwvZQ5hDPH_-RZgF1==H1LwtteovA@mail.gmail.com>
Subject: Re: Kernel lock during cryptsetup luksClose
To:     "Brennan Lamoreaux (VMware)" <brennanlamoreaux@gmail.com>
Cc:     bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 1 Mar 2023 at 07:24, Fr=C3=A9d=C3=A9ric Martinsons
<frederic.martinsons@gmail.com> wrote:
>
> On Wed, 1 Mar 2023 at 00:00, Brennan Lamoreaux (VMware)
> <brennanlamoreaux@gmail.com> wrote:
> >
> > I just posted a fix for a workqueue related deadlock in put_unbound_poo=
l in the 4.19-rt kernel here:
> > https://lore.kernel.org/linux-rt-users/20230228224938.88035-1-brennanla=
moreaux@gmail.com
> >
> > Can you give this a shot and see if it fixes your problem?
>
> Hey, thank you for this patch. I currently have no access to my test boar=
d.
> But I'll happily test this patch tomorrow for sure.

The patch you provided works perfectly in my case, no more blocking.
Thanks.

For my curiosity, do you know why I fell in this case ? The bug
requires specific timing or it only
appears during usage of device mapper in kernel ?
