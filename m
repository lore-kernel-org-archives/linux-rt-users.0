Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED3CBC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC6D122CA1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgcb3wvL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgHGQsW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26275 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726787AbgHGQsP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 12:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596818894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5uaTvo6j9usJ7mGdDSjNCVzeTH3/9YOGpZH8iappgok=;
        b=hgcb3wvLYsDAKIot3o4um0EhO3gsWo4rgrmFEGLwpGLTP4hkqa2emNWugz2fnGF3IAvpW6
        F28Crha13DpB8vj26MLElho0lNebqh9fALblvWCIJoR+1soKB8j4yGuCTR/BMe9bsO13wv
        u0HG9kIw5Dc2ibkhASZ2QxnE5WODTSY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-IhSOLd17MwiKkjrzczZxIA-1; Fri, 07 Aug 2020 12:48:10 -0400
X-MC-Unique: IhSOLd17MwiKkjrzczZxIA-1
Received: by mail-ej1-f72.google.com with SMTP id g18so1145538ejm.4
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Aug 2020 09:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5uaTvo6j9usJ7mGdDSjNCVzeTH3/9YOGpZH8iappgok=;
        b=VjQv/Rij34ruhs64OKkl3Eiz9HZVhwYZcROEb1KSUNSKTucqLbu8BGxq1fMJv4CPkH
         D5EW4r098UmRDIcNXe5gW+L67pzkUd1ob/Hpyj1cNqL4hSNTEtvQgNaAwgtF4VPm9/7m
         wTQX3zXEmu+KD09OKbY98p9lgrUp8qegUzxt4TKFdlpp56yVFWTQd17Go/9gOWQ44W3v
         W61yB29QAb1YUX4a5uedqMgKFSrj/912Bujs3CXabs+MZH5LkYg4FXPDrsiMhq/+ygsX
         iAPo9P9ZfrfoIxzLq6vgqgzh0iMALhmycmzAYxtDtzYCfai8aYPvZZFE1y/UtjKis+hl
         8t2A==
X-Gm-Message-State: AOAM531AkzMYqyCDfbC3ELt4YeiN6G2vmoN0cvSIkVqXvuSZasTsno+4
        u3yJXN3BTtnOBeqI6w1Xy5nodurc+sBNyjQSNqEGY6poLbP1Mlp49fghqBbNhhnec1ycHBXVs+q
        6avY+M3/+36pials35tqIGzPQMGU=
X-Received: by 2002:a17:906:aad2:: with SMTP id kt18mr10449853ejb.537.1596818888963;
        Fri, 07 Aug 2020 09:48:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcfviELTbH8IfrCZg+pRReV0EoEKU9cNH9MLRePDcYmNJ6fqZI8EjqPkhFM1ikphH145ya/A==
X-Received: by 2002:a17:906:aad2:: with SMTP id kt18mr10449835ejb.537.1596818888809;
        Fri, 07 Aug 2020 09:48:08 -0700 (PDT)
Received: from x1.bristot.me (host-87-16-204-193.retail.telecomitalia.it. [87.16.204.193])
        by smtp.gmail.com with ESMTPSA id g25sm6232476ejh.110.2020.08.07.09.48.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 09:48:08 -0700 (PDT)
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
To:     peterz@infradead.org, luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
References: <20200807095051.385985-1-juri.lelli@redhat.com>
 <20200807095604.GO42956@localhost.localdomain>
 <20200807104618.GH2674@hirez.programming.kicks-ass.net>
 <20200807154941.2bb11408@nowhere>
 <20200807141118.GK2674@hirez.programming.kicks-ass.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <b4778352-9426-59f5-854d-942f4c345c91@redhat.com>
Date:   Fri, 7 Aug 2020 18:48:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807141118.GK2674@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/7/20 4:11 PM, peterz@infradead.org wrote:
> But I shelved all that after I heard about that other balancer idea
> Danial was suppose to be working on ;-)))

The PhD bureaucracy (and behind the scenes) were blocking me... but I am free
man now and will catch up on that ;-).

[ also because I made enough progress on this:

https://github.com/bristot/rtsl/

and can start other things. ]

-- Daniel

