Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B17C001DF
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Aug 2023 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjHGTbP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Aug 2023 15:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHGTbP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Aug 2023 15:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEA21717
        for <linux-rt-users@vger.kernel.org>; Mon,  7 Aug 2023 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691436628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uBw4mbV0n5CHJTT93sh7px+x2h6v80hNyKF0sUR1CQ0=;
        b=fo+Y4E+TMAAQChkGyWimW0oM/b9cE9OQfn42VSz/lrkPDQPiWF4NPIhUGhCOiZaNgTbLQG
        iQ+EGPSd2NI+aGOPtQtbct02y5WlpaZYH9RdZveXbJjHH8UWXPlSfokdEMsKgtZ0SYWVM2
        7UqeTX8ogyhtrRgmd7LR9Au6Q/tcwq8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-A9OC5HvSN8qtdlehNjxwYQ-1; Mon, 07 Aug 2023 15:19:11 -0400
X-MC-Unique: A9OC5HvSN8qtdlehNjxwYQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-63cf9d48006so59431186d6.1
        for <linux-rt-users@vger.kernel.org>; Mon, 07 Aug 2023 12:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691435933; x=1692040733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBw4mbV0n5CHJTT93sh7px+x2h6v80hNyKF0sUR1CQ0=;
        b=DMfu2sQ9PYG70gtgKV3cqO3h+Vlf/wVO6s51gERqZYU5x1W//gyzig+ULWvJXRWjgS
         7isvhb9vxe4gA/ZbtGzra4kpCdhMx23LFABxasPNcY9Fi1qgONYgmI/rm/UzO1rgmajP
         myI1DQEo3580kp29DoiFrdfvp7dJMDTee8KVlHjtrGb1qEonPcCfonAhlsDrkPyYXBxi
         YkvykFstJ3QoOyUZNe4Er1vqj6JoEo7qY4JjgqCpFjmA4AZC6y0651QM/BCN9eTejGQS
         IQxztpTjhpgroML/32ycNOwgPlBMUGjFhmasdvzGDikXwry6Ua1HJfqyGiznAmMcJHUo
         hTqw==
X-Gm-Message-State: AOJu0YxgEbFFFefuMGWFkSA6F8n6QI9iWUQpoa9CUR4qbuQXaxptqsLs
        lmgCQUZp7T6R4nYROKAD9qb/6JbkFxqHUIMqJiPXVGesM1h2tr2UYMq4CMKTrzRXnaM8Q7QrKks
        tBU8sDNJCh0XvPRjcUcgEv67T/4U=
X-Received: by 2002:a0c:e0cc:0:b0:633:45e2:5603 with SMTP id x12-20020a0ce0cc000000b0063345e25603mr9893924qvk.60.1691435933472;
        Mon, 07 Aug 2023 12:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf08IuAF1M+sWXoajzIojAHG+tZ0mzMymTkRHCnxLwdLNIOx7LjEpAHQQPbeGpQrMmO5ygPQ==
X-Received: by 2002:a0c:e0cc:0:b0:633:45e2:5603 with SMTP id x12-20020a0ce0cc000000b0063345e25603mr9893910qvk.60.1691435933263;
        Mon, 07 Aug 2023 12:18:53 -0700 (PDT)
Received: from thinkpad2021 ([64.99.149.73])
        by smtp.gmail.com with ESMTPSA id b12-20020a0cf04c000000b00631f02c2279sm3069007qvl.90.2023.08.07.12.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 12:18:52 -0700 (PDT)
Date:   Mon, 7 Aug 2023 15:18:50 -0400
From:   "John B. Wyatt IV" <jwyatt@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, jlelli@redhat.com,
        vschneid@redhat.com, pauld@redhat.com, rt-maint@redhat.com
Subject: Re: [preempt-rt] BUG: sleeping function called from invalid context
 at drivers/gpu/drm/i915/gt/uc/intel_guc.h
Message-ID: <ZNFDmq43NqttzJca@thinkpad2021>
References: <ZKyngsXKztAU9J3r@thinkpad2021>
 <20230807133354.-t5iv19T@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807133354.-t5iv19T@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Aug 07, 2023 at 03:33:54PM +0200, Sebastian Andrzej Siewior wrote:
> 
> Could you try v6.4.6-rt8+ and check if it still there or gone?
> 
> Sebastian
>

Just checked. I do not see the call traces in dmesg now.

This also resolves a long (20+ minute) boot issue I had + stuttering in
the graphical interface.

Thank you for asking about that Sebastian.

John

