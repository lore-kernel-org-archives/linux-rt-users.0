Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91837C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Apr 2022 15:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiDMP1B (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiDMP1A (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Apr 2022 11:27:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF2AA28E04
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Apr 2022 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649863471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PUJG5zflb74hfYve/Q3zrObnpwXnSTqydhPLEMNFu2U=;
        b=CU75YgbwzUdchxcUMHlgpeFrhPTlLl7ZuHvqmWgTLP0xW1DUXrwjQintZgw8fp/g5m6K+p
        9fwAFzGvWtrqGf5X8329gr5aPnCaw3qHBLAjbtQ9TXvwdHaHif1WBesyfdwDgruELninwU
        N8xMu4+qn07rIKHS4YiaZHdMv40+Hus=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-WtiAi3lQPDSXsAbcWqhk1w-1; Wed, 13 Apr 2022 11:24:30 -0400
X-MC-Unique: WtiAi3lQPDSXsAbcWqhk1w-1
Received: by mail-qk1-f200.google.com with SMTP id bp31-20020a05620a459f00b00699fabcc554so1364021qkb.12
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Apr 2022 08:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=PUJG5zflb74hfYve/Q3zrObnpwXnSTqydhPLEMNFu2U=;
        b=MGVkoskKDU0GvTwqiX8Zj/jh6y6kBtGtcExGlEnnV0VSHNJ7BnHT1nrQjvpFPos5Dq
         54gL6neCs8OwxTsr6HKaCZu7CFre13Nu3fpjpXOp0cKLuf4o5W02zk2Pr24pKVXvdDZ+
         ejvZadteFKTcFgmFoSWZGn1TDyYpnUKK7hAeTh0puHRP741uZwvqdxDAlhi8jcO3z5FZ
         O+5N50adwM9Wj4fu70rFtPO1peFflrbPG2p9UqHEie9eFhk9Z9r/QEpp2ZXTXNAqEui6
         vcEoot2YnyzOIsunBi+RMTizoYPf530/JdVTLlAUW5+tFE8/ILcVtbMpspjo1ahpkatT
         eXeQ==
X-Gm-Message-State: AOAM533NeNQw2XIZeJp2d9HQgRwV4kEwxjCLuaj3YdX4rEw7PGmko/vT
        NlxtGLV1wPQ966xHEj3QkYnNFzPoe0z64cHC/3gasOG8hX9p9fiWbnfKvLq5PXLkem6Oh2bH7DW
        /TkGWOxSo5GpRSytFIUIzV76ccQI=
X-Received: by 2002:a05:622a:285:b0:2e1:dcda:98fd with SMTP id z5-20020a05622a028500b002e1dcda98fdmr7726385qtw.625.1649863470176;
        Wed, 13 Apr 2022 08:24:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcMf1UDGRlW4rimO+JcNtQTnrf0JJlM3a0zIecFwRbljcSTjgHYYSeK0B+WPPFTF9Al2nfDQ==
X-Received: by 2002:a05:622a:285:b0:2e1:dcda:98fd with SMTP id z5-20020a05622a028500b002e1dcda98fdmr7726372qtw.625.1649863469966;
        Wed, 13 Apr 2022 08:24:29 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id i18-20020ac85c12000000b002eea9d556c9sm6634713qti.20.2022.04.13.08.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:24:29 -0700 (PDT)
Date:   Wed, 13 Apr 2022 11:24:28 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Peter Xu <peterx@redhat.com>
cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH] oslat: Print offending cpu number when above threshold
In-Reply-To: <YlWY1gK6AN1xPmG1@xz-m1.local>
Message-ID: <b61a3c63-80d0-188e-9775-16f21ae2a@redhat.com>
References: <20220412135518.531234-1-nsaenzju@redhat.com> <YlWY1gK6AN1xPmG1@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 12 Apr 2022, Peter Xu wrote:

> On Tue, Apr 12, 2022 at 03:55:18PM +0200, Nicolas Saenz Julienne wrote:
> > Knowing which CPU went above the trace threshold is useful information,
> > even when not tracing. So let's print it.
> > 
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> 
> -- 
> Peter Xu
> 
> 

Ack, added to the commit

