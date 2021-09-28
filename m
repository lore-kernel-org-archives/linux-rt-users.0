Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF13C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 01:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F73A6124B
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 01:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238461AbhI1BiG (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Sep 2021 21:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238428AbhI1BiF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Sep 2021 21:38:05 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262ADC061575
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Sep 2021 18:36:27 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h3so19513389pgb.7
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Sep 2021 18:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=FGYSmLM3tp/0IAZFWgckqzZGHiZeNvYEOhRW5uGGDbg=;
        b=bY/5ObSGDjNybSRB1Dt9fveWoMISSYPuuWdJfFaWQFWBcDtRe902ukZKzDvt2K8BAN
         jCfvlRcu2fyw6w0LD5328jv8ypNKRKFdDHys0mQaWWQulrjeYtffA+td5zmtf0kTFYOD
         TkR2iaBEzWxmPHaK1tO/JW1o4/tHGjD/xxs5PBOVDmsr7N2aIHPZPj42+WVJFMcbGDPy
         t81p9mL1HXLNaYzNaTpYb6aqSLlLjFJoWLAtjHIcgygOTHvHAdQpZ7xQWY9aSHkaT+/c
         z13ox4cM+qQ50TQVALi2R8gttpxYF6kumeX5FVT7VKujqT2NYJWRqA0D1saShFKDISXI
         atJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=FGYSmLM3tp/0IAZFWgckqzZGHiZeNvYEOhRW5uGGDbg=;
        b=Y6vcAomFnznVTMmEyDthK9/DvyDIYPVAS42H08bz2tX4eJzVAZI5VRCitG8+K8vwWM
         4qNpkDCLYVf/StxM6ao3rvseuEcUdzd2vUD3kXFj0/csdYrBJ4nnfWFbwGwQanEKThF1
         sO34Y6hF1lQEBk2RstQ/Pm5O5snr7w99aiVlZoEEGCqh9KfEjuZy1w+knN9/R+I8XgzJ
         sAntVIzMxnjVx7VcFoULSB2jw3qyRx/THXKvzXpCA7Lrv3W99It+/DliJpCifIM8Es9o
         kHA1qlfn2MhgTtjSSvDtz9iISAIFuXbKWjXRe1p3qV0roVl8ZatUiWlc5lqbkA84TmJm
         cR2A==
X-Gm-Message-State: AOAM533sDTyWVuaaZs9bxVAJtxYtiuMf7wnodoQltFznbFxbp61UQaC3
        6SxUhLllGDoVjt+NmTl2sFs=
X-Google-Smtp-Source: ABdhPJx7F3ob+mP3zotnSqepKWS/hT8Tq9iuPeC6ryjgTAIFk9AXagn4V4ftnXvokoiJDS9wHfpcYQ==
X-Received: by 2002:a63:e446:: with SMTP id i6mr2338324pgk.288.1632792986497;
        Mon, 27 Sep 2021 18:36:26 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id 23sm557102pjc.37.2021.09.27.18.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 18:36:25 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: Re: [PATCH v2 0/3] rteval: Fix issues with cyclictest.py module
References: <20210917085343.2775300-1-punitagrawal@gmail.com>
Date:   Tue, 28 Sep 2021 10:36:23 +0900
In-Reply-To: <20210917085343.2775300-1-punitagrawal@gmail.com> (Punit
        Agrawal's message of "Fri, 17 Sep 2021 17:53:40 +0900")
Message-ID: <87k0j15vmw.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

Punit Agrawal <punitagrawal@gmail.com> writes:

> Hi,
>
> Here's an updated version of the cyclictest fixes previously posted at
> [0]. The changes in this version are to address feedback received on
> the previous version.
>
> v1 -> v2:
> * Patch 1: Add an option (default off) to save cyclictest output
> * Patch 3: Sort cpus returned by online_cpus() in cyclictest.py module
>
> All feedback welcome.

Ping!

Perhaps this set slipped through the cracks.

> Thanks,
> Punit
>
> [0] https://lore.kernel.org/all/20210902092452.726905-1-punitagrawal@gmail.com/
>
> Punit Agrawal (3):
>   rteval: cyclictest.py Enable logging cyclictest output
>   rteval: cyclictest.py Parse max latencies from cyclictest output
>   rteval: cyclictest.py: Sort the list of cpus
>
>  rteval/modules/measurement/cyclictest.py | 44 ++++++++++++++++++++----
>  1 file changed, 37 insertions(+), 7 deletions(-)
