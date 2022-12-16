Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842C2C4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 16 Dec 2022 14:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiLPOO0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 16 Dec 2022 09:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiLPOOX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 16 Dec 2022 09:14:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46534BF43
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Dec 2022 06:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671200017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qG0RTQ0Lufr7P0nlKvEiW5+1t/mxLz6ftCQ96Os/jiU=;
        b=dMtyaBsThQlVKzxigYJq11gV53fQJzgpi2PmySaxdlr/qhgodIFtAqikFM6QPfWyVr+ZkQ
        ozI13ZTMRIO6qxVla3gSzwXSQhmYdsqL5wbGF71fQ/Yx6o5gLEyoViIyZcxmwBKU8KzkFs
        LVfG5Gz+0isHJuE+que9SEy1NH/mBqY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-98wLIk2LPGWi0Egmu65Xig-1; Fri, 16 Dec 2022 09:13:36 -0500
X-MC-Unique: 98wLIk2LPGWi0Egmu65Xig-1
Received: by mail-qk1-f198.google.com with SMTP id bl21-20020a05620a1a9500b006fa35db066aso1866294qkb.19
        for <linux-rt-users@vger.kernel.org>; Fri, 16 Dec 2022 06:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG0RTQ0Lufr7P0nlKvEiW5+1t/mxLz6ftCQ96Os/jiU=;
        b=dlUWJdMPAKMaIxyWmQJch7h+E+JAFgk1LdSmhd5qkuHKalI2I14rQR93/oZ52PDq+s
         zfpNsmhQftId0FwrgdnvZiv1P3hmW2Fll1H8xGt5VOTwpPXPcb08UBWt/wIQmmPY3LJW
         LW9x+c65LUgeadjz2djHQAGVEGQNPWlpcavrb4SvvcCfo1N6SNbIq5pg3qcjiIipMOFL
         vgcg6vUFyShZE43krINf0ZzmfyPJLXiHoTadZ8Im09jtwDJBQwrfi4p4eDvD4tX0sJ3x
         lyUNDG8tLvoxZpADV+pQ0p+Cv01b7lvgmpHcvmb4SXM40U2A6TZ3cAszHuB5cVIpzGlJ
         R6Gg==
X-Gm-Message-State: ANoB5pmcvaz1KJZZVNUC6GptkVl74cUmPmq+ND7wPf2Wo1fVrhvmNtW3
        hc93YRbbuxdi6PmjqcV6sh09DIVCwnGHKrbsXiUer1oq/XbDcIXuUwaIztHSur+bwPnNb4yj2+A
        4m12mO0bWrQ8miL4yVE5hJ1glEcs=
X-Received: by 2002:ac8:58ca:0:b0:3a8:a8e:c0e0 with SMTP id u10-20020ac858ca000000b003a80a8ec0e0mr51614595qta.8.1671200015747;
        Fri, 16 Dec 2022 06:13:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7K86tK0KkLvb028oLX6tmAK3Qiv95WtOD8YJePLr9hexYbI/9qlcvnBDrdI2fTfeY9TJBcxg==
X-Received: by 2002:ac8:58ca:0:b0:3a8:a8e:c0e0 with SMTP id u10-20020ac858ca000000b003a80a8ec0e0mr51614562qta.8.1671200015493;
        Fri, 16 Dec 2022 06:13:35 -0800 (PST)
Received: from fedora (modemcable149.19-202-24.mc.videotron.ca. [24.202.19.149])
        by smtp.gmail.com with ESMTPSA id r17-20020ac84251000000b003a50ef44a77sm1366328qtm.28.2022.12.16.06.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 06:13:34 -0800 (PST)
Date:   Fri, 16 Dec 2022 09:13:32 -0500
From:   Adrien Thierry <athierry@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-rt-users@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Eric Chanudet <echanude@redhat.com>,
        Brian Masney <bmasney@redhat.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH RFC] base: power: replace generic_pm_domain spinlock by
 raw spinlock
Message-ID: <Y5x9DEIsnLG7HoaQ@fedora>
References: <20220615203605.1068453-1-athierry@redhat.com>
 <cefad5f6-8aa4-acb8-231c-91170ec10bcf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cefad5f6-8aa4-acb8-231c-91170ec10bcf@linaro.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Krzysztof,

> I also hit it now on v6.1 RT kernel. I see no more discussions happened
> here. Do you have any progress on your side for this issue?

Unfortunately I haven't investigated more since June. I was hoping RT
people could chime in.

Best,

Adrien

