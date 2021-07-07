Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245BAC07E95
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Jul 2021 17:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0626161CC8
	for <linux-rt-users@archiver.kernel.org>; Wed,  7 Jul 2021 17:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhGGRri (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23590 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGGRri (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 7 Jul 2021 13:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625679897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ASBMI3YqFfJd0pwpCSCqh14J8lrvzc20tWvatewDL9c=;
        b=Oz8HCfVMdQD9tF9PG8J0bXjK10P3KiXlHySbzU0N98whim55fCiNT+9WJa9/mDfZEA1yjl
        3eeQD58p5TebMxMBG1grb6V2EzedVEs0+p16KWH3bL7zAhgIr/jDJpnBwP8fZZdNwsiXno
        Oc0niWe4IJt5rNOpe3ZXwq7xqK4HzPY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-v8I4qk9iMuW4ucGJNT4o8A-1; Wed, 07 Jul 2021 13:44:55 -0400
X-MC-Unique: v8I4qk9iMuW4ucGJNT4o8A-1
Received: by mail-qk1-f198.google.com with SMTP id o14-20020a05620a0d4eb02903a5eee61155so2056218qkl.9
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Jul 2021 10:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ASBMI3YqFfJd0pwpCSCqh14J8lrvzc20tWvatewDL9c=;
        b=HZ2PSN6WZKYMpmznMjYms0ubisIntZj8aZFEJVMZHJXiaHw0VWY6PdvujRwmhQc5ig
         rnJx414wlH/UjgfZzB4bn8UINYZgKnblvzIqHY0dGtZ/gef3hOSFuGjX0Q0qtmtV3ytQ
         Dw9kYZJLPJ0p+sBJdvRLbVUdbpBbZo2Kv4ETfLWlbf5+RnDP4zNW7fPjY0lQuIukUXMK
         JTro/Mh2IYSJL1bbyEQb4R9+rBiz9wJA3mxebZlkA3FFwrYhtqStuMCMa6qoFAEuFUfH
         gIRjloHVu5zE3hXAq7DWQyc82MqA7zCffu6oVrtB3MIaNPUgJuTpuzpwGA0D4drGZrTV
         EAnA==
X-Gm-Message-State: AOAM530aC6McAlxiXIy2MxeKFydKPufoaB20jwhePbs9EI6xV46LKroy
        WYzjxlAPFOCjcK724QIQA9NNHZXedul2tu1ONHIc3tz2Oflma6ZPr4CyW1GOeJ9BxKWw1u2ihTo
        Yyzqtzp9W06TE6ra8pyC7tZj3Vd8=
X-Received: by 2002:a05:6214:d01:: with SMTP id 1mr24830319qvh.57.1625679895457;
        Wed, 07 Jul 2021 10:44:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6jkpPmEgz9HElN4wZRtY0ZbYzoMJhkD6T5NYSIPNkRYhMK2QyCMnXvJN1xDoRQZaz5cfDTQ==
X-Received: by 2002:a05:6214:d01:: with SMTP id 1mr24830299qvh.57.1625679895186;
        Wed, 07 Jul 2021 10:44:55 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id u22sm2874273qkp.85.2021.07.07.10.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 10:44:54 -0700 (PDT)
Date:   Wed, 7 Jul 2021 13:44:53 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 1/2] oslat: Remove redundant include
Message-ID: <YOXoFUS8TljxgPYn@t490s>
References: <20210707084849.304329-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707084849.304329-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Jul 07, 2021 at 10:48:48AM +0200, Nicolas Saenz Julienne wrote:
> inttypes.h is already included above.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

