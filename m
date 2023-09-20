Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5F3CE79AC
	for <linux-rt-users@archiver.kernel.org>; Wed, 20 Sep 2023 02:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjITCaf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Sep 2023 22:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITCae (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Sep 2023 22:30:34 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7634419B;
        Tue, 19 Sep 2023 19:30:04 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-578b407045bso1141264a12.0;
        Tue, 19 Sep 2023 19:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695177004; x=1695781804; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/fmSZqipDCEI0w3Jx49ar+j/HesxXy1cUewwtLpSnIs=;
        b=dwTjMujH5VaBKvC3hLS2jM3P1RTnovuVzR+RgiAXbyBsRQtDfnhS8KXio+AawvQYNU
         rDXj1J8RjNcuFpWKhExyyGtxTEX0Idt8PbYcaywS4sDmxceFL0Y1O0hhwfJB8PWG9xIe
         9aZHGwbOm8ZPdwIc2eR6W6g8URFI/4qvA7P3zTfftlgnDHjX7AB/HxDxS5VMZ4BYZGVo
         r1eLtpNClzw4ySwEbyANojAnshFt7uf7qYnXmaJUBZ5UMoq/2Wk2Pb08jmbYYeHDxOON
         Umnt+eUSzjZavm+9UNC66NonH4ALyRL2PrX0FqwPNaeHnpJUEA0goXJ8NwAWqBFsivSc
         yXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695177004; x=1695781804;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fmSZqipDCEI0w3Jx49ar+j/HesxXy1cUewwtLpSnIs=;
        b=VViW+EbczUYm7QMBt/I7vkoHRlj8RlgOY7njAwvGBrrOsCAf4RJDgjpz9Xhy9wr1Rg
         jcvErmITOoNf0r0NgBMVeM18gC41cVsPqBul/O6/Ztmjp1abPwJV4d60lLrpI+3DDvV3
         SdR89WFfA4Xny+yz1xrbVC/knuyEMxHNFtVjbG7/FOKFrm+n+IcN3dLn8wvpNhpTkDvX
         JH2fi6ywlrubZCpdV/+SLXgGTrYrVRbUEGlM1zZZoPMAJpz6zd94R+N9+oOQiPJkzaMu
         iQeJhRxEG3ZRZm0e8jSuh7T+v8T9GGYI2UT3RyThI2be7xtWWolW8jqnY0pIaWkNWmL7
         2zLQ==
X-Gm-Message-State: AOJu0Ywmr8H5cYF9Pc+oWSkJSa+s/7qyAbLzeGWf2ElrZRW0HPOOd8tD
        7bJw8uS7Or7Zwfhet4JkD3kLgI864kabTczP
X-Google-Smtp-Source: AGHT+IHp8TguCJKq8FV0I7l5G54VU0hzUd7uQ5jHkn8lW0pP8mU8yJAZPvD4+OuY3XWK4IirFRVciA==
X-Received: by 2002:a05:6a20:5649:b0:14c:4e31:97f3 with SMTP id is9-20020a056a20564900b0014c4e3197f3mr1172528pzc.59.1695177003755;
        Tue, 19 Sep 2023 19:30:03 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id c15-20020a17090a020f00b00273744e6eccsm288435pjc.12.2023.09.19.19.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:30:01 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:29:57 +0800
From:   Hangbin Liu <liuhangbin@gmail.com>
To:     Clark Williams <williams@redhat.com>
Cc:     Clark Williams <clrkwllms@kernel.org>, stable-rt@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: Please help backport 3c107f36db06 selftests/net: mv
 bpf/nat6to4.c to net folder to v6.1-rt
Message-ID: <ZQpZJcnMqQhNS4mP@Laptop-X1>
References: <ZQkdYYWScEnqagU1@Laptop-X1>
 <CAMLffL-SbDP=As=bocxsVFew+FBBOme69ZoxyYy7pYezdt8kTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMLffL-SbDP=As=bocxsVFew+FBBOme69ZoxyYy7pYezdt8kTw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Clark,
On Tue, Sep 19, 2023 at 06:27:47PM +0000, Clark Williams wrote:
> I just released v6.1.54-rt15 which contains this commit. Sorry for the long
> delay.

Thanks for your quick response.

Cheers
Hangbin
