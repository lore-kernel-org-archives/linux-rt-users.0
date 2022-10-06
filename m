Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF903C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Oct 2022 19:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiJFTJa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 15:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiJFTJU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2022 15:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62E2606AF
        for <linux-rt-users@vger.kernel.org>; Thu,  6 Oct 2022 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665083359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4msz0RPjroIPvdhEPZqlzrvdxXuX3VI658evT0Z/580=;
        b=byF1Z/NyJR6PkOAEA1jrrxzUEXFlbxJoUjxh3T/t/kFGdcX+t0bddR5IOvNns77FQU6PHy
        WJSLdICUD6WHCTVwy3Huso1VnHzGgaupEIcJCmYnLZK9/MdMnYtqfvUr+k6psoxfSht7NF
        fo2mWqjWnV5McHTPIjZ4wbpjkDVQ3rY=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-440-7xhVBkaSOPSRDVRLzJQtCw-1; Thu, 06 Oct 2022 15:09:18 -0400
X-MC-Unique: 7xhVBkaSOPSRDVRLzJQtCw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1325c21d407so1478179fac.13
        for <linux-rt-users@vger.kernel.org>; Thu, 06 Oct 2022 12:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4msz0RPjroIPvdhEPZqlzrvdxXuX3VI658evT0Z/580=;
        b=XnoZpKLV/1iOE2n+/JQ7FUMVylz0Px7L9daBM7PPEPf6tWa8VnfJFK6WTn1YzBEgCO
         3PNSEvPHYLnb/sI3hCteFYSA5y1gLeynOjmz48D6iWN+yPkTxe4QzOlmBiY721eW8W//
         y7wD6CossRWs/a3NjfqUpxVmFQrNFeTNH2XBr52dPEZNRYrXbg2b5vAtBU6WyOr0Tp1X
         8IWqxoNYkVP5MVc7WHUVhLwkWTfXBdfvwZoba7vegQKJJmbETSeRJCJiYA2QiSL8wezR
         xxRBzJHpoA0QdCQsy4m2OjGUrk4pYfgTO10HZaU/fcf4+ea01mma4+4U9leCa02eQU0h
         8EEg==
X-Gm-Message-State: ACrzQf2yiaL6NrxBLMwO9eUAn2s133yakMOYT0d/tZLCTI2vma8WfskY
        4LXMcjor2iw0JbQ3C87DY+CS/by3kLF3LfLqP5Wq0Dxmegd7FE6ASR8lfbjR4Qd8mKUgrMTCGjJ
        JpJd/0nrveeaLLE9cg5CISuHvviw=
X-Received: by 2002:a9d:5a9b:0:b0:660:e857:b82f with SMTP id w27-20020a9d5a9b000000b00660e857b82fmr585522oth.241.1665083357326;
        Thu, 06 Oct 2022 12:09:17 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM40570OwbfPkviKJSAM28HRn8clY3t/YlF0scbU7MVJRX9nMFfxEF8Ik1lYacEkW6E1TgsQXg==
X-Received: by 2002:a9d:5a9b:0:b0:660:e857:b82f with SMTP id w27-20020a9d5a9b000000b00660e857b82fmr585507oth.241.1665083357077;
        Thu, 06 Oct 2022 12:09:17 -0700 (PDT)
Received: from localhost (pool-100-0-210-47.bstnma.fios.verizon.net. [100.0.210.47])
        by smtp.gmail.com with ESMTPSA id q19-20020a05687101d300b0012d6f3d370bsm205215oad.55.2022.10.06.12.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:09:16 -0700 (PDT)
Date:   Thu, 6 Oct 2022 15:09:15 -0400
From:   Eric Chanudet <echanude@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: qcom-ipcc: flag IRQ NO_THREAD
Message-ID: <20221006190915.2koau7vlnvinqk3b@echanude>
References: <20221003170849.383005-1-echanude@redhat.com>
 <Yzv/3vsIMtgu7noY@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzv/3vsIMtgu7noY@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Oct 04, 2022 at 11:41:50AM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-10-03 13:08:49 [-0400], Eric Chanudet wrote:
> > PREEMPT_RT forces qcom-ipcc's handler to be threaded with interrupts
> > enabled, which triggers a warning in __handle_irq_event_percpu():
> >     irq 173 handler irq_default_primary_handler+0x0/0x10 enabled interrupts
> >     WARNING: CPU: 0 PID: 77 at kernel/irq/handle.c:161 __handle_irq_event_percpu+0x4c4/0x4d0
> > 
> > Mark it IRQF_NO_THREAD to avoid running the handler in a threaded
> > context with threadirqs or PREEMPT_RT enabled.
> 
> The important bit of information is that this is a IRQ-multiplexer and
> such it must not be threaded. Otherwise its child-interrupts would be
> invoked from the thread handler which is not desired.
> This is noticed by PREEMPT_RT but also on a non-PREEMPT_RT kernel where
> `threadirqs' has been used.

Thank you, I will send a v2 shortly updating the description with the
above.

> Side note: Using request_irq() has the side effect that this interrupt
> pops-up in /proc/interrupts and the "child-interrupt", too. So you
> account two interrupts while "one" on the HW side occurred. 
> Maybe irq_set_chained_handler_and_data() would be better use.

I see.

> Either way, this addresses the problem,

-- 
Eric Chanudet

