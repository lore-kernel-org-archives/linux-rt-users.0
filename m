Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DA3C07E95
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Jul 2021 17:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E4A61CC9
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Jul 2021 17:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhGGRrq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:47:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29060 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGGRrp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Jul 2021 13:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625679904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4qy9aQHEumAn0rPLbQmdaoN3/7rHyK2IjApUMQu0v0E=;
        b=dPfe2IdHRwggLON1hk0cnrHfymxnJ5pGAeGtLOfREcEsuoKoGLA+gnV8aMBm2RCByO/xe+
        7yX4US99W3tLwm0gzdpRrnEn6pio+cOlcvhxDXMhUDP6rAWsOflxd0/e6o/1+TXnKPz33T
        WzPOsHsSW7etTGhCXo21IgugmZb9Lm8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-hDbwnNZ8P9eE-4AE1TYMgw-1; Wed, 07 Jul 2021 13:45:03 -0400
X-MC-Unique: hDbwnNZ8P9eE-4AE1TYMgw-1
Received: by mail-qv1-f72.google.com with SMTP id f12-20020a0562141d2cb02902ba007211abso2166544qvd.12
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Jul 2021 10:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4qy9aQHEumAn0rPLbQmdaoN3/7rHyK2IjApUMQu0v0E=;
        b=TiID36jWtCXJB81IBi4+Pt48qL/mNji09lEW9lMfIvuuVLKlMFasxt8uFkLRNDq9k9
         6EK4gWLBznOEEdqU+DX7Z2OmM0+Yji2DbkF3Zjp65+8lzELJQBJzfU4Ndi2H7RgddYru
         3IGnaF7L3rrJRVaJr71i2psbtcc6AeDk2jNRTrAhhBRYe9PvgDfMQXqLLqi4cCargCqc
         vMUIN2R0uzGcM3KIISIanPjQQcUe+sbMAIcgOMkzKzRjW2zuIpbTxEFHvzUkcultaLpx
         26Q48mxtPWbyQ5iNkf3iJ6XyNJq1/X6tC1v5G2Z9wiVdDVOmRj6y79QEyYxLjm1364uv
         S8Aw==
X-Gm-Message-State: AOAM531TCMWLZVUDzlPt/3vWIjTV+oSPeVhnVcF0+xaPz6aynb+CpaYr
        UZic8lbQ4vt1LwtTHVw2G1NrHRAu4EAwOSk6Lu2mpXdVkhZ7GD11jM6f3v1g5EuyxTejKTFuUF9
        dnfdX4/wEj7fRcrN3PMHHISmW/Wo=
X-Received: by 2002:ac8:4f51:: with SMTP id i17mr22293606qtw.257.1625679902812;
        Wed, 07 Jul 2021 10:45:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdrZWDopEu60mpkDtqzdGb49DlvMkP9ePLStNXf2N9sWw5zqDmhpHa5PIZwPZfiGSU7QuZnA==
X-Received: by 2002:ac8:4f51:: with SMTP id i17mr22293593qtw.257.1625679902612;
        Wed, 07 Jul 2021 10:45:02 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id r10sm1672807qtm.87.2021.07.07.10.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 10:45:01 -0700 (PDT)
Date:   Wed, 7 Jul 2021 13:45:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 2/2] oslat: Don't take trace_threshold into account
 during preheat
Message-ID: <YOXoHTxdH2kxM95u@t490s>
References: <20210707084849.304329-1-nsaenzju@redhat.com>
 <20210707084849.304329-2-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707084849.304329-2-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jul 07, 2021 at 10:48:49AM +0200, Nicolas Saenz Julienne wrote:
> The point of preheat is to make sure CPUs are out of idle and running at
> max frequency by the time the real test starts. So it's expected to
> incur into extra latencies we don't really mean to measure. With this in
> mind, it doesn't make sense to take into account the trace threshold
> during that run. So don't do it.
> 
> Note that this has been observed in practice. The threshold would be hit
> during preheat but not during the real test.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

