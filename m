Return-Path: <SRS0=hsO6=AK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9202C433E1
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Jun 2020 18:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7008206A5
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Jun 2020 18:55:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8x6aysV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728686AbgF2Szo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:55:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgF2SzU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Jun 2020 14:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593456919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IRNIV4x43P6HErryarebd5FQz8VopUKzf076Ub4cEhw=;
        b=X8x6aysVFVe8YFVhCEmUfJRQ0p8IteM8r0KfEtdIzRJXebemoPOpgVk9PmFw5+q1RAqeiE
        dlMu7KrzsZ4zc4fdXbNYAnrQuME4wPHLgFAbnxqe/rXB7sTU6CZKGfqYUivNX0byQ3+V6a
        vntnh5Ohk0wTgsLP66a1K4lHuNxKu08=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-nXMt7SjSP_-NzPh9JE9AVQ-1; Mon, 29 Jun 2020 08:54:02 -0400
X-MC-Unique: nXMt7SjSP_-NzPh9JE9AVQ-1
Received: by mail-wr1-f69.google.com with SMTP id o25so16449624wro.16
        for <linux-rt-users@vger.kernel.org>; Mon, 29 Jun 2020 05:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IRNIV4x43P6HErryarebd5FQz8VopUKzf076Ub4cEhw=;
        b=UTlfr0JM7ypPzQLwCXbWQkuFQDA/BhjsEGc9Zf0WL5Nf0vogAVNy4cmH+x9xVdvxtl
         xF+R/KgSDy5F7TomFiYz/1etcN90yx+vbDD12exUywI1QYyeURM2J/GX2nDXi6W+Msq2
         dK23oIEzz5rjNugfp9yl7cz2ie9tZExBAvESlrYLePeqR8dMpwv1bcZ067cefpycvzY8
         +0g3iwguvzIJpFHTu0KRr8oKTINQ/YuVRU3bVI8/PG0xjEOnwbzcNa4D6eakjmpQ/FiS
         csvMhPvYviug8wbTyxn8oNlobPSgOwRvjGYuUk1ppAN1HPulDt1bZgUxe7SGAqGv0LkU
         y1YQ==
X-Gm-Message-State: AOAM533ZWL8v87UPCPC/GhBJWU2LNk2oSpnA/AUwcwkv7CmNFgkXDCll
        Jy1StnKd1TFgvcLQusHxTWCWYdYeF/7mhiuMAmMhv8CJOecvT6Ru2+x276k7jRqwh8/mOGX4Y0p
        w/tlyrKWkrDA8TTPjoe5v2ObOqUY=
X-Received: by 2002:a1c:5418:: with SMTP id i24mr16011214wmb.47.1593435239276;
        Mon, 29 Jun 2020 05:53:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCGDvr+eGI0QiQBdG3VZDI0bqn2iCa/GHXZRlpJW0cXI/cAOmdxZFkRYH9FPz3OcQeGVb3lA==
X-Received: by 2002:a1c:5418:: with SMTP id i24mr16011199wmb.47.1593435239033;
        Mon, 29 Jun 2020 05:53:59 -0700 (PDT)
Received: from localhost.localdomain ([151.29.8.241])
        by smtp.gmail.com with ESMTPSA id x13sm50975152wre.83.2020.06.29.05.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:53:58 -0700 (PDT)
Date:   Mon, 29 Jun 2020 14:53:56 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200629125356.GB9670@localhost.localdomain>
References: <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
 <20200520184710.GO10078@localhost.localdomain>
 <20200521004443.GB15455@lenoir>
 <20200521170020.GQ10078@localhost.localdomain>
 <20200615210743.GA21371@lenoir>
 <20200616065757.GA446382@localhost.localdomain>
 <20200616204649.GA4914@lenoir>
 <20200629123651.GA9670@localhost.localdomain>
 <20200629124207.GA6088@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629124207.GA6088@lenoir>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 29/06/20 14:42, Frederic Weisbecker wrote:
> On Mon, Jun 29, 2020 at 02:36:51PM +0200, Juri Lelli wrote:
> > Hi,
> > 
> > On 16/06/20 22:46, Frederic Weisbecker wrote:
> > > On Tue, Jun 16, 2020 at 08:57:57AM +0200, Juri Lelli wrote:
> > > > Sure. Let me know if you find anything.
> > > 
> > > I managed to reproduce. With "threadirqs" and without
> > > "tsc=reliable". I see tons of spurious TIMER softirqs.
> > > Investigation begins! I'll let you know.
> > 
> > Gentle ping. Any new findings about this issue?
> 
> Yep, I'm working on a series to reduce timer softirqs. I'm almost
> done, should post it soon.

Great!

Looking forward to it.

Best,

Juri

