Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728E3C61DA4
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Mar 2023 18:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjCMSrH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 14:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbjCMSrE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Mar 2023 14:47:04 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0171085378
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Mar 2023 11:46:27 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s20so16942184lfb.11
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Mar 2023 11:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678733163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=57RyQlIvWaG1P/RwfcpGpaTeJFVVEIj4zWPHAtkEJQM=;
        b=gv811+140FLhnLRoI2jVbeGfLyLT34vRzLQZb0F2K2mp03Bsvr8Ji5o69B3F6WBUwb
         xpn5nevAmptB77H5gaFwJPUqnJDbXCnTe6BCWrEQ23ENdKb/l2Ii4EIjvEUL4bzjyadG
         v+LmUBKy0XV4iQK73+eGFmAFw6Df8gTtA5fkIThNUbgZSYeH5HlV2MTiU+9kEhcM8oZK
         AS8BRY7ZYW2cf3+a3FhUrFubFTFr2ykiWr3boVBOtR/fhTBYUG2/BIq4onEUN4GqFCCj
         QZs1LHhmFTh1Zd9RxGJRRmG+U2cYTQTXlJD8CG0J8zQg5PTxVuMj0Pf2sa//5HpYehJ5
         Ufyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678733163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=57RyQlIvWaG1P/RwfcpGpaTeJFVVEIj4zWPHAtkEJQM=;
        b=7gQyke+bGqtznhddkSRVpvE2mUhuWIp7ItVVspj/EVJQaAls22tSwxdZNvCu8lBSJL
         C/k7DVHcuGjUkhWeH4+c6SpRLbAURJqsVaCldeojRcoyAQmDhMw6sNgCL3xL72kBjeJm
         gVACgji6ADNWFHhNmcC4Ih2bZLcDkfVmaXv0YYwtJnMKvFjrL1Ku28HUCf2tLy3mBzBL
         nvRJiTE08R1bcjNJIYG0/wtipTxEgl7wxRzFkDVBegjzPcER4N1pOoi4EcjOTLR4e8aD
         q4Yw1Fr8/RFUvv58O7FVRQ6rBZfBDXt85I4P8NrilGuIUoKYN45PE+uF2stKMIai2WxF
         82dA==
X-Gm-Message-State: AO0yUKXUPWiC3oBlWVe+jKZxpw1BfBKpU4A68ivhiPSnBlq+9QX1qZ6M
        QeGxt1EV32ddg+MS1/Afmsg3/FUCNlv9DYKWgC/fEG7kMfM=
X-Google-Smtp-Source: AK7set+e/GrxG+DlxfTesvapp/NEiK1KSBH7ZFzzvg52c5FyH5s+R5uIU85V5MEpAAoMELIxdt+ovFXnHyT6fqrwe2c=
X-Received: by 2002:ac2:44cd:0:b0:4d5:ca32:6ed8 with SMTP id
 d13-20020ac244cd000000b004d5ca326ed8mr3894740lfm.6.1678732460273; Mon, 13 Mar
 2023 11:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <Y/yrHe4OIYcWFbNO@linutronix.de> <20230228230009.89787-1-brennanlamoreaux@gmail.com>
 <CA+cAkerw6kqhibwacCxwtu4u_U3pBYF0xcRrOVZh1T=++vURbw@mail.gmail.com>
 <CA+cAkerXmfVYAKoO7FU8aPwvZQ5hDPH_-RZgF1==H1LwtteovA@mail.gmail.com> <20230313094143.5t28jqkB@linutronix.de>
In-Reply-To: <20230313094143.5t28jqkB@linutronix.de>
From:   =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= 
        <frederic.martinsons@gmail.com>
Date:   Mon, 13 Mar 2023 19:34:08 +0100
Message-ID: <CA+cAkepNt8+7tZPhckeym5HyGULHcp0gdevoGjeAaMX_sE9Hxw@mail.gmail.com>
Subject: Re: Kernel lock during cryptsetup luksClose
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Brennan Lamoreaux (VMware)" <brennanlamoreaux@gmail.com>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thank you very much for your help on this.

On Mon, 13 Mar 2023 at 10:41, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-03-02 09:06:41 [+0100], Fr=C3=A9d=C3=A9ric Martinsons wrote:
> >
> > For my curiosity, do you know why I fell in this case ? The bug
> > requires specific timing or it only
> > appears during usage of device mapper in kernel ?
>
> It always happens if a specific worker pool is removed and this happens
> on luksClose. The problem was introduced by a backport, which touched
> this corner.
>
> Sebastian
