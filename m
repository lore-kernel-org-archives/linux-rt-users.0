Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8627BC4338F
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 15:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A0860BD3
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 15:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239116AbhHDPjr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 11:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbhHDPjq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 11:39:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A605C0613D5
        for <linux-rt-users@vger.kernel.org>; Wed,  4 Aug 2021 08:39:33 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so9304323pjr.1
        for <linux-rt-users@vger.kernel.org>; Wed, 04 Aug 2021 08:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9HvhKBIAckU62s2Uuatx7EBu63Q7v4yQnE6VGQx/1B8=;
        b=RXFWQwB0uXR3QN0OYi9F3PH/TF24Ek/4S5Hl5GykHL0A/xQCZgMrXoLhz/Eldmkl56
         Kq//r6LQZnNPvm+lqNljCdysmpVjqoSCxBaxFgPEY6j9Ulym7/fgyd1V6N6AxkcZris7
         2oRbJHWuwrqoMAazMJZnlr57T/i9GpDUDkdST+SviEoj47u7AOVgFDd/nJpa6y8dBwMN
         uu9hxu4eqUCuPlZjswQXcxFIS6WgjKMaI8bikSUxieMiKXJ6wTFkDEouGTsbCIhLmeCS
         Sq5okn2S44fBX1q0fnAAoTsnS/TqmGuB+KuYzhRIDoXum9/rEx+uUeD9GdRi1eIebURt
         Q9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9HvhKBIAckU62s2Uuatx7EBu63Q7v4yQnE6VGQx/1B8=;
        b=l8bw8axbZhmNVOLo+IPHEqcLOm8GumHI37gLFHqCV6NPiHp0RJLETzmeQYfUJKCbuv
         BSG0+XkwP2cG0vw6eR9Qwkry3QWJxmiCq4rr3C4kmYTocl0mE9PbnUYQjemmyXM7lRWh
         Etlh5tlBgcrw+QMPdZO8wLv0fLeBgkEzAk2bEoPOTju5zBX1/JqJkBEGD1I9Jj3r2q4v
         2hY+ITe40pz7zMensJjPVFncizgEnwLSIulcFqNcSdsPtANXbONNZzWo/isj6rZzp/+5
         JuYGMRckkVbdDTC8mfgyw/CQq5K4QzbuBPI+OQlt+OIhh2kpN8pKk1SQP7tDcPJvk4Bk
         LI0Q==
X-Gm-Message-State: AOAM533ZXQhF5B+KKuxUX4hDeVUOb3FV4McEzfVOG5NY7EsnJB499C2G
        3jmaN0GYhNpgzYI6vkOgjiOrcQ==
X-Google-Smtp-Source: ABdhPJwhyUlyEkVnqX8yuM7QqcstA/PNNT2jsrCxqQR3DMv0RG7ftFCD6gMMj42hfWrbvwwNCN+8vQ==
X-Received: by 2002:a17:902:8544:b029:12c:5752:b0ef with SMTP id d4-20020a1709028544b029012c5752b0efmr23388086plo.18.1628091572841;
        Wed, 04 Aug 2021 08:39:32 -0700 (PDT)
Received: from [192.168.1.116] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id y2sm3310366pfe.146.2021.08.04.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 08:39:32 -0700 (PDT)
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
 <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
 <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
Date:   Wed, 4 Aug 2021 09:39:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210804153308.oasahcxjmcw7vivo@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/4/21 9:33 AM, Sebastian Andrzej Siewior wrote:
> On 2021-08-04 08:23:55 [-0600], Jens Axboe wrote:
>> Totally untested, but I think the principle is sound. I'll run it through
>> some testing.
> 
> This is needed:
> 
> diff --git a/fs/io-wq.c b/fs/io-wq.c
> index 1192ee2abd982..77ec6896edaa5 100644
> --- a/fs/io-wq.c
> +++ b/fs/io-wq.c
> @@ -428,9 +428,9 @@ static struct io_wq_work *io_get_next_work(struct io_wqe *wqe)
>  	}
>  
>  	if (stall_hash != -1U) {
> -		raw_spin_unlock(&wqe->lock);
> +		raw_spin_unlock_irq(&wqe->lock);
>  		io_wait_on_hash(wqe, stall_hash);
> -		raw_spin_lock(&wqe->lock);
> +		raw_spin_lock_irq(&wqe->lock);
>  	}
>  
>  	return NULL;
> 
> 
> otherwise the spinlock_t lock in io_wait_on_hash() is acquired with
> disabled interrupts which is a no-no on -RT.
> With that it all looks good as far as I can tell.
> Thank you.

I'm confused, the waitqueue locks are always IRQ disabling.

-- 
Jens Axboe

