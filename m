Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCC4C43334
	for <linux-rt-users@archiver.kernel.org>; Tue, 19 Jul 2022 08:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbiGSIsP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 19 Jul 2022 04:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236955AbiGSIsE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 19 Jul 2022 04:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C74B53C8D6
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Jul 2022 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658220482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+a4ycFhjarx9mlzPS8D1+gxrl/DhKN12r6qeEGChLA=;
        b=OkJZF5fTZsy/VLhRP/AongwJgbteTv/P9BFiTNCRGc/xjoEZ1nVbScWPSXJUqPdEvYPUMk
        VDJjm+5gKMRm5iGDSEyj+iUksAjUb+Ff4qZwD8Xg1IogBObii7DYIMuz1bYEg5sr2SyKTS
        Kbu9LVs6lrmA8E+ZYff5yS9m44XUNDw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-604-0Yaf6dMGNfaUPrxOFFYK5Q-1; Tue, 19 Jul 2022 04:47:55 -0400
X-MC-Unique: 0Yaf6dMGNfaUPrxOFFYK5Q-1
Received: by mail-ed1-f69.google.com with SMTP id g7-20020a056402424700b0043ac55ccf15so9454963edb.4
        for <linux-rt-users@vger.kernel.org>; Tue, 19 Jul 2022 01:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T+a4ycFhjarx9mlzPS8D1+gxrl/DhKN12r6qeEGChLA=;
        b=MvOBEr4+gbpPuTWAkLyyuLVMWsHyNpE6uvM1SxHW+SC/YYMwtiJqCJeaUMjVer6HqO
         wiXkOavpTNvVwpLyqvzNV6C/qw1XExo4OE1mCq+fyyCAcjshonFdHxmFKhUm+4+ob8nT
         vpA9qZSL5IDi6SfFrsSDOnj7BHlmd7SvxEOoXJhmk3CJqGLIAymaNqkgplAJlfwI4Bcc
         iLVYS6JBv/UBZF1bHfBak06TI/Y1cVTc/rhkK3r5h+I2ekght77rQUqMYoQdwm/kmhhE
         wgvdrqBHJr1zm1AeeBk8wHsiO2i0OvghymxPyR3dtpahhNjLBEU1HT0vSnMtHinKdRwY
         qglQ==
X-Gm-Message-State: AJIora8NR8EdRFCGI8Ydsa6HuZW9xEiaciP0CwM/r+yXlL7rbzWdQsPG
        9K5ZyOnwzHSpBXW1lYhxRHcdWWRQaPT+bgtgTeJQF3Isyne77pr7KZj32YDabXpWrrpcUVMVIul
        9q7F1/yROZcqlsPl77AD6Y2vQ5Kg=
X-Received: by 2002:a17:906:58d0:b0:72e:e25a:46e7 with SMTP id e16-20020a17090658d000b0072ee25a46e7mr23821056ejs.459.1658220474638;
        Tue, 19 Jul 2022 01:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQHMU5eoA6/zvvcSw83C7AvpAZZ6w2gQJAz0OpyfqTXsmBvyBSiOUUf7stsy8sZJD7iFQfXg==
X-Received: by 2002:a17:906:58d0:b0:72e:e25a:46e7 with SMTP id e16-20020a17090658d000b0072ee25a46e7mr23821038ejs.459.1658220474380;
        Tue, 19 Jul 2022 01:47:54 -0700 (PDT)
Received: from [192.168.0.198] (host-80-104-20-93.retail.telecomitalia.it. [80.104.20.93])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b00722e50dab2csm6393555ejn.109.2022.07.19.01.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 01:47:54 -0700 (PDT)
Message-ID: <cff61541-2c12-964c-ad87-3852a5a1e8f8@redhat.com>
Date:   Tue, 19 Jul 2022 10:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] linux/wait: Fix __wait_event_hrtimeout for RT/DL tasks
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
References: <20220627095051.42470-1-juri.lelli@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220627095051.42470-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 6/27/22 11:50, Juri Lelli wrote:
> Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper on
> PREEMPT_RT) are not visible to hrtimer_start_range_ns, thus not
> accounted for by hrtimer_start_expires call paths. In particular,
> __wait_event_hrtimeout suffers from this problem as we have, for
> example:
> 
> fs/aio.c::read_events
>   wait_event_interruptible_hrtimeout
>     __wait_event_hrtimeout
>       hrtimer_init_sleeper_on_stack <- this might "mode |= HRTIMER_MODE_HARD"
>                                        on RT if task runs at RT/DL priority
>         hrtimer_start_range_ns
>           WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard)
>           fires since the latter doesn't see the change of mode done by
>           init_sleeper
> 
> Fix it by making __wait_event_hrtimeout call hrtimer_sleeper_start_expires,
> which is aware of the special RT/DL case, instead of hrtimer_start_range_ns.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
-- Daniel

