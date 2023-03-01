Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAB2C64ED6
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Mar 2023 06:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCAGYo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Mar 2023 01:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCAGYn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Mar 2023 01:24:43 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A3DEC72
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Feb 2023 22:24:42 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id s22so16257778lfi.9
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Feb 2023 22:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677651881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oi0bG15H/b3BpOAboVLRVxGrsqqWKyh3K8hsh1fVLGc=;
        b=lsmzwaCkDtafTeaqlsf0P5xiOHHEU4ftkvl+SB446M7P/XA6AE5rv0r9uqGSdg9iCw
         Za10BCNMEsuJX1IEnS3KnVOcAlaDn3wQ60hR5/oiuDSlEF1ki2gAAZcO/k80hEikGkfl
         mz2ol3BmZhjBQLKBYRGFL3ozN1IRdjyUQ8ZzvvMXytIcP+5EMIEvAsQakdH/PFXe/mkh
         VkAGpvx88G01VBgcC2b0ZXOUcZ/rtPongxF3S2aDGGOBZff5TUiQhprQWFUSjHdzCJkY
         w+OM3BiSoe/qxyghxTqJa0H/zI5de3wnZTEW8Gzf+9/KgmvGqzeL1B5kBisG3m7KOpff
         Z02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677651881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oi0bG15H/b3BpOAboVLRVxGrsqqWKyh3K8hsh1fVLGc=;
        b=tCuSK0Ahe+f6Cf7txg3eQmmSepGiOdtOlbQO5X8ceLtVxhdY1P+sUfHk//vgsk40IN
         RIua22nIPXi+WLIfOysl5EX7yb8Y2RE0jwffLnUuV7nVvSavmSxKcDiTzP86aZcX9ENm
         jDZaVlumdPqDXbuXoM1hm/PlEZ6YhWSa4jGVZRdVPIBpqErTNjAnv4BNlZR31OmEZ+3Z
         S9MZnOYwf7e6tIeLVwBJNLL7WPj6iDIOlSEkkFMZnIsfvzQ5KYxYCk8g3ANfyPOtbaaX
         IqnKm3ySuhxY14rauJ1ePl8RFqQKVcxbwrMLw2PKwotBDEzd2r9NY7TT9HJtUDzYyhWt
         3fWw==
X-Gm-Message-State: AO0yUKULB0jtCq0rXKb3haGObHaBcU+EC6MP6F7vK4j3HJYVaMJ0e/jw
        PFTFa30eWclxI+d5CtoUkBqgNJSO1S0wIqgG388uOC+B
X-Google-Smtp-Source: AK7set8QE81c93yHSOtf40cWMNGcn+klRFIMheXPuin+avSRsZ7vbruipOYCGcOEM97h+ugNydHcJlTH1Bsdqw0ZVaA=
X-Received: by 2002:ac2:4437:0:b0:4d5:ca32:6aec with SMTP id
 w23-20020ac24437000000b004d5ca326aecmr1509564lfl.12.1677651880563; Tue, 28
 Feb 2023 22:24:40 -0800 (PST)
MIME-Version: 1.0
References: <Y/yrHe4OIYcWFbNO@linutronix.de> <20230228230009.89787-1-brennanlamoreaux@gmail.com>
In-Reply-To: <20230228230009.89787-1-brennanlamoreaux@gmail.com>
From:   =?UTF-8?B?RnLDqWTDqXJpYyBNYXJ0aW5zb25z?= 
        <frederic.martinsons@gmail.com>
Date:   Wed, 1 Mar 2023 07:24:29 +0100
Message-ID: <CA+cAkerw6kqhibwacCxwtu4u_U3pBYF0xcRrOVZh1T=++vURbw@mail.gmail.com>
Subject: Re: Kernel lock during cryptsetup luksClose
To:     "Brennan Lamoreaux (VMware)" <brennanlamoreaux@gmail.com>
Cc:     bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 1 Mar 2023 at 00:00, Brennan Lamoreaux (VMware)
<brennanlamoreaux@gmail.com> wrote:
>
> I just posted a fix for a workqueue related deadlock in put_unbound_pool in the 4.19-rt kernel here:
> https://lore.kernel.org/linux-rt-users/20230228224938.88035-1-brennanlamoreaux@gmail.com
>
> Can you give this a shot and see if it fixes your problem?

Hey, thank you for this patch. I currently have no access to my test board.
But I'll happily test this patch tomorrow for sure.
