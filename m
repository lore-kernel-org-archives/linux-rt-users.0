Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FEAC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 14:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7374A60F6D
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 14:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346008AbhIMPA0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345634AbhIMO7F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 10:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631545068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzfDzorn/BIeCCK4m4RhPbAGyXR20sDwHZGFo23fvcY=;
        b=IzwfrNlFigEfVBvmUzD8ZVemqM/WddeAbcWucCkzghQfgcqhDq9BwXZw04LBYYa95PTaj+
        zS9f5CW4p//WKIgZKcwUTmh0BMH6aTW+oGi/ytKahyS1HTmIyFRvzAS+3D5ADCt+rdKgOD
        AJ83J2DKh2b9VerOAdcfWwcyB0ZOVX4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-G8ztrLamPJyw8FDbH3QR-g-1; Mon, 13 Sep 2021 10:57:47 -0400
X-MC-Unique: G8ztrLamPJyw8FDbH3QR-g-1
Received: by mail-il1-f200.google.com with SMTP id x7-20020a920607000000b002302afca41bso9483414ilg.6
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 07:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lzfDzorn/BIeCCK4m4RhPbAGyXR20sDwHZGFo23fvcY=;
        b=zPwaCAnFC99jM4E3+MKEUj/OPYwbhFxPaBc42afv8FnRhD0k1Ns2a9TjWiE6oszvBf
         H3cHHIDcjiPNA3HP7liDikyYcb3UPH8KA0QeThpMg8NDplDDY1w9tEu6C5ARLEDYMv+u
         /su396XA70Ie+IM6veB5NMdfz/ysEMocRC/X8KB3l2ItnrJdaNIakUkrJwp8kD17AvvL
         097scfQv4MT6zCriAKHkiFqdBPhM6QvzMfVXejqpXEOzzquDohG1tpKc4EKOidbf5Ych
         l219WqGtr5IlRZlHhUskCRRPBRK+EDH26vHZRPvXrThLwB0rWZJ1Ldotn5mBURaaYqwP
         wy6w==
X-Gm-Message-State: AOAM5305gZrpMsfGUk17Azt1E5yDDaqaUUmu8i79FX+KpZCqOGq3YBNU
        zrWvlmuq0v2rkLL8JcXivKbvypUqabNFEQD8b3n4jo9LGokWq2kRMlYPLFx7OG3Ck22A2CudtVz
        Y84FbEw83wUt5oa6VxZdgMtuf9VQ=
X-Received: by 2002:a05:6e02:198d:: with SMTP id g13mr8607150ilf.319.1631545066090;
        Mon, 13 Sep 2021 07:57:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI1DD7EYcRCgWWSTFDPhmesN+BD3aGC8azV13EyUQLWWIHrv2pmp07BmV7yLqVqUHfRLTzOQ==
X-Received: by 2002:a05:6e02:198d:: with SMTP id g13mr8607135ilf.319.1631545065878;
        Mon, 13 Sep 2021 07:57:45 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::d35a])
        by smtp.gmail.com with ESMTPSA id r8sm4809270iov.39.2021.09.13.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:57:45 -0700 (PDT)
Date:   Mon, 13 Sep 2021 10:57:43 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH v2 1/3] oslat: Rename cpu_mhz/cpu_hz to
 counter_mhz/counter_hz
Message-ID: <YT9m5wvfB24aQujM@t490s>
References: <20210913083908.48408-1-nsaenzju@redhat.com>
 <c12367eb-8766-6826-b2d8-70cafbf04e4e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c12367eb-8766-6826-b2d8-70cafbf04e4e@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Sep 13, 2021 at 09:35:29AM -0400, John Kacur wrote:
> Waiting for a Signed-off-by: from Peter Xu before I integrate these.

All 3 patches:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

