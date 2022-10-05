Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEE3C433FE
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Oct 2022 16:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiJEQDw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiJEQDv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Oct 2022 12:03:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DAF7B298
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Oct 2022 09:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664985829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsYClaGvaL7Fx71W4nNn+BSgQpEWK2jw1FtcTudbB+c=;
        b=IrlYylXk+nXiyxwjsDdju6dCaHVDbJ1mCyJL7Qek67r5kH+4NBKeuJA2+OUBFb0dVntPS2
        4ntOV84FC7EgyGIS0/styIb18PRUKBGStZRhmm4g14QXPp9Ux4PvFaAC44Nnfvl+cAVFk1
        6IKkgo9911rbTakddBuwmarPFlQ7QtU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-656-S7FeiXIpNFWKOboCaA2-fQ-1; Wed, 05 Oct 2022 12:03:41 -0400
X-MC-Unique: S7FeiXIpNFWKOboCaA2-fQ-1
Received: by mail-ed1-f72.google.com with SMTP id h11-20020a05640250cb00b004580ee86ca8so13596011edb.6
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Oct 2022 09:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zsYClaGvaL7Fx71W4nNn+BSgQpEWK2jw1FtcTudbB+c=;
        b=Suc6bRnMACgsXK2W14cwmyeoxWh4gKr7sveD5lLXtVksMCFrCzmV0z1rp/LruKKx6i
         NWHNUI3UcX7W/oiKkWPSnNxG0RXfMyGRMED/7xGtF4R+LPAVamRa2SL1D6aJ0KRIXBGo
         ybCuCn8Yo5l3SlZsjthlfXpHFOkH9X5jRo1cJx6xr6+jjo9aTJhMRD/H+E7Eh1qXcXfg
         N83k8rZCserNdTgRDPK685/kSAwMfCibKioWYxL+J4tpV1adLv+MnuSDdovB2Bdk1DDk
         4WmJ5eXmoB2K+3nAgHAEt/8ntKd7xkKPvUkRpSdJDR6c42hYm9+tC0FFmXQm/abEMyAT
         +ilQ==
X-Gm-Message-State: ACrzQf2pgRNOaeVAcZGkShCbPxM3wTeSgtosyUbRvhrJWLzE5f9mAnEf
        fncL8ltea/MndWO1VuAv+/UUi2+X2DchtYEi9iWif0yu8dCByNJBa62YWtW0k17yD0bmwfzHSQC
        Mlo0C8IJj4vBqG64Y0Hbj4dbBEPs=
X-Received: by 2002:a05:6402:5188:b0:452:5395:a271 with SMTP id q8-20020a056402518800b004525395a271mr417252edd.383.1664985820619;
        Wed, 05 Oct 2022 09:03:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7szg/4E4Z8Nqvvq6h4AucSiSBh4+4CV9Z6dDwtD1R7khIGcJ7iWLGY/L7UOKTLHQ8lbFZx4Q==
X-Received: by 2002:a05:6402:5188:b0:452:5395:a271 with SMTP id q8-20020a056402518800b004525395a271mr417219edd.383.1664985820180;
        Wed, 05 Oct 2022 09:03:40 -0700 (PDT)
Received: from [192.168.0.198] (host-79-50-96-115.retail.telecomitalia.it. [79.50.96.115])
        by smtp.gmail.com with ESMTPSA id ee32-20020a056402292000b0044e7862ab3fsm4154459edb.7.2022.10.05.09.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:03:39 -0700 (PDT)
Message-ID: <e86930e4-4b9c-cf18-5119-50c6910b76dd@redhat.com>
Date:   Wed, 5 Oct 2022 18:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: RCU stall warnings even with rcu_nocbs and rcu_nocb_poll
Content-Language: en-US
To:     Florent Carli <fcarli@gmail.com>, linux-rt-users@vger.kernel.org
References: <CAJuRqcBVvpTCrDTNPGeJVARYfVxGxVWGXqq7eYjJDzUmprcqBQ@mail.gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <CAJuRqcBVvpTCrDTNPGeJVARYfVxGxVWGXqq7eYjJDzUmprcqBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/5/22 18:01, Florent Carli wrote:
> Hello,
> 
> I'm trying to isolate some cores to run a CPU-bound real-time task and
> even though I'm using rcu_nocbs and rcu_nocb_poll, I can see the rcuc
> threads wake up, and I get RCU stall warnings on the isolated core.
> As per the documentation, if I use rcutree.kthread_prio with a
> priority > my RT task, then the rcu stall does not happen.
> 
> However I find it confusing: why are the rcuc threads woken up on the
> isolated cores despite using rcu_nocbs and rcu_nocb_poll? In my (very
> likely erroneous) understanding, I shouldn't have to fiddle with rcu
> priority... In other words, how come I get rcu stalls on cores that
> have no rcu callbacks?

Adding Joel because we had a chat about it during lpc...

> Thanks.
> 
-- Daniel

