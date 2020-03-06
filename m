Return-Path: <SRS0=FXzI=4X=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE121C10F00
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 16:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E1B2073D
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Mar 2020 16:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9mDUv3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCFQkq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:40:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30592 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726185AbgCFQkq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Mar 2020 11:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583512845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6T1pIh4v84pRnMnOK5YaqTVOjseRTNUeuhNMfVC6DA=;
        b=a9mDUv3d+pLne/XmO0QvLtlJW6QuT5sCWNJL1LpAyt0/xgbwQu3g/vgY7y21EQC3k5XKq6
        YUFnjs/8R3dYvA96BUzZEZMhQv9IO4nEUKB8vp0YM5UDRBa9CM5SgiKkKQ9cH+xyRlFY8g
        0dQpu8c6oTuRRJzOmLa0ECN/UPgA9eI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-Hkz2ClOXPweTchZYLQDoTA-1; Fri, 06 Mar 2020 11:40:44 -0500
X-MC-Unique: Hkz2ClOXPweTchZYLQDoTA-1
Received: by mail-qv1-f70.google.com with SMTP id r9so1668580qvs.19
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Mar 2020 08:40:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W6T1pIh4v84pRnMnOK5YaqTVOjseRTNUeuhNMfVC6DA=;
        b=cH58df4s/3XPtZ9lSGnbnJsAkw04UgM1CE4fnDR5znB28PYBmtfYc0/t7aRzbLyAUg
         Mu2CiYCftyqBIcV68QV6pc0YO/yDDR6HnI6VV4RXZq9WIy1bhl3S460z6Hv4awscH+h9
         usvW1mD3PQcRvdQRC8MbM9O7KZXvn0PFBVWtChKqghn0iKFFhohgfjEDPRLF2FDGYtNV
         iN/lu9Hoij2eUxeTY9Kzx7YoDIoIyh8z5Sp0MjegpOyhe8LbMOTvXpcD8Y32Kyh/YViH
         /89RU8gSjXoNMU1oF0WLH9yyg9IlcoRcENa1O4QlMCkroKYzn+aUB29CkrMKTxLEAbcU
         BRQA==
X-Gm-Message-State: ANhLgQ1FQlKPUWNC8qNe9LX9vAdZFvnnxtEdGGYUgKfEmnFwNiDlPzIP
        hzEDCo6YNH9HA+LN6BUK2PZ3ydPNqcNhCIsA+OYApY0Hv76gsDza1hh6WMjcefUM+GKinwLUxHk
        RI7ziGaDDuJ9OtqZp6GoVvdSsZxs=
X-Received: by 2002:a05:620a:49:: with SMTP id t9mr3723079qkt.193.1583512843273;
        Fri, 06 Mar 2020 08:40:43 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsC2j+aCw6OVS2IopwsqguZB0MqItWqYLdFom2xHFB6PvWpyuxFn+o6AVEdFRGzeNnwbiVINw==
X-Received: by 2002:a05:620a:49:: with SMTP id t9mr3723054qkt.193.1583512842961;
        Fri, 06 Mar 2020 08:40:42 -0800 (PST)
Received: from x1.bristot.me ([87.19.200.153])
        by smtp.gmail.com with ESMTPSA id v12sm16466453qti.84.2020.03.06.08.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 08:40:42 -0800 (PST)
Subject: Re: [PATCH RT] mm: Warn on memory allocation in non-preemptible
 context on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200306160315.irbxjl3md4edsf7x@linutronix.de>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <67d03e4c-09be-ff63-1cde-1398aec730a8@redhat.com>
Date:   Fri, 6 Mar 2020 17:40:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200306160315.irbxjl3md4edsf7x@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 3/6/20 5:03 PM, Sebastian Andrzej Siewior wrote:
> The memory allocation via kmalloc(, GFP_ATOMIC) in atomic context
> (disabled preemption or interrupts) is not allowed on RT because the
> buddy allocator is using sleeping locks which can't be acquired in this
> context.
> Such an an allocation may not trigger a warning in the buddy allocator
> if it is always satisfied in the SLUB allocator.
> 
> Add a warning on RT if a memory allocation was attempted in not
> preemptible region.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel

