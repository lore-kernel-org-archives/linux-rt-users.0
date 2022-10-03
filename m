Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CFFC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon,  3 Oct 2022 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJCRX1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 3 Oct 2022 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJCRXT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Oct 2022 13:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0380430540
        for <linux-rt-users@vger.kernel.org>; Mon,  3 Oct 2022 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664817797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZcKEyglz2TbKS11RyS2nvN0KWcDU1wuM3YnwQLNBo2g=;
        b=J+xEnY8b2j2O3sD3NYIb66ij3MOEQLju2Kff/L5lzqaCw9v4JmPzTZSM3/DiH0zPSSXb03
        r7gRnxUFYkIveBQ0tV1Ta9DTMk1DHdjhQi0BZfMfBdiEyvxmSUPefLPnrERDPoNuDffIk2
        9B3sRDKisa6m1E4d5hmj3knsrjk53Bs=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-108-M2TOUUuwNJKKXlK7XYpN3Q-1; Mon, 03 Oct 2022 13:23:16 -0400
X-MC-Unique: M2TOUUuwNJKKXlK7XYpN3Q-1
Received: by mail-qt1-f197.google.com with SMTP id e8-20020ac85988000000b0035c39dd5eb9so7684639qte.16
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Oct 2022 10:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ZcKEyglz2TbKS11RyS2nvN0KWcDU1wuM3YnwQLNBo2g=;
        b=0ejiVr+Ys8l0x5eEeEl4RgoBojDfUWQ+J4Urnhp0gyZqwLKzD7xuqfTNQJRSv1nBEm
         yP+8IPwQ6vJlaRRHqzr2HFeeuBoHDh9VDM64bAhtlyozI7dHujZqFO6fetEIpzEjX9Co
         AfLjsQ7zJuYYtQeW+04vQ8TZVmv556snzoqjrY9xgIxWGY2B3/tpOo8afwV7jkby9QKF
         9DDwASOz/hzaWCy1zwTscu83S+a5Y+fjYWeUGxBrnkqoX7d8LawCnQ4PEbWk5Bg/LvCi
         RmexZksXifZLWtisM3oJa7qUALA6/UFJ8hQc5G034U5QEPt94zcYvif7zgSBkTnUzUhb
         cHrA==
X-Gm-Message-State: ACrzQf1TrBc2TxhZ0TWiAzBvEzclq1mRExfHM0MtlcNnnKuLz09xjmqj
        5+YYjW67OCwu7Cn1v8ttkS2rjwLUJ8/gF5Q3/kcNa988UvPEAMynN8E8/gDEtKW88CI0ftH028i
        WlbMpGDv8v3WWWipVjZ08qCE5GRE=
X-Received: by 2002:a05:6214:f0b:b0:4af:9262:d52c with SMTP id gw11-20020a0562140f0b00b004af9262d52cmr16854201qvb.57.1664817794959;
        Mon, 03 Oct 2022 10:23:14 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7qcgzaUWumDfu5NTpxrYh6RI2AyvoF+HtSaDAGCLvDxpVt/UGtXGzaAVXPuKw1Kj+/faZGHQ==
X-Received: by 2002:a05:6214:f0b:b0:4af:9262:d52c with SMTP id gw11-20020a0562140f0b00b004af9262d52cmr16854184qvb.57.1664817794750;
        Mon, 03 Oct 2022 10:23:14 -0700 (PDT)
Received: from localhost (pool-100-0-210-47.bstnma.fios.verizon.net. [100.0.210.47])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a284c00b006cebda00630sm10429201qkp.60.2022.10.03.10.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:23:14 -0700 (PDT)
Date:   Mon, 3 Oct 2022 13:23:13 -0400
From:   Eric Chanudet <echanude@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: qcom-ipcc: Use generic_handle_irq_safe()
Message-ID: <20221003172313.vv3isog3nsc3r2pn@echanude>
References: <20220909162043.2734873-1-echanude@redhat.com>
 <YyBP+eNIBCN0OsGt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyBP+eNIBCN0OsGt@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Sep 13, 2022 at 11:40:09AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-09-09 12:20:43 [-0400], Eric Chanudet wrote:
> > PREEMPT_RT forces qcom-ipcc's handler to be threaded with interrupts
> > enabled, which triggers a warning in __handle_irq_event_percpu().
> > 
> > Use generic_handle_irq_safe() that can be called with or without
> > interrupts enabled instead.
> 
> wouldn't IRQF_NO_THREAD be a better match here?

Agreed, my apologies for the delay:
https://lore.kernel.org/linux-arm-msm/20221003170849.383005-1-echanude@redhat.com/

Thanks,

-- 
Eric Chanudet

