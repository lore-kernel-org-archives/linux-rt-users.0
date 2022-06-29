Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7856C43334
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jun 2022 12:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiF2MXf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiF2MXc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jun 2022 08:23:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DE23338BC
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656505410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D4xckCgJ4Bw0w9xbbVbINWepGBRVBzb5aJNwu4HG9GY=;
        b=F3S2hu8ZUrmB8GOmNcWX1q+CUEKr91CQfXUIZeeL7yt0oYJq9I4VDSRIOHV9FQLbWCBdt8
        V4axvDv0KDsniNl7+Ajl/Gwxrz9PNzqloN9vsrQetV28ga5RHhThyc1d6KFO1XrB60ZnHH
        PCYpYEwafYd2xgQ7MZ4IYbPYbYloW6w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-597-WXXmwLknPtWZwUN07easSA-1; Wed, 29 Jun 2022 08:23:26 -0400
X-MC-Unique: WXXmwLknPtWZwUN07easSA-1
Received: by mail-wr1-f70.google.com with SMTP id n5-20020adf8b05000000b00219ece7272bso2378437wra.8
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 05:23:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=D4xckCgJ4Bw0w9xbbVbINWepGBRVBzb5aJNwu4HG9GY=;
        b=EnG8u2J9Blf7YdJUJ/gwD0TZoWAxkizKtAFMeRHBiDqr3LPTrQKnwE4/RlezW0BJWf
         zImRZrC9lF0ZFE2jCp8YA/oUhmlEjY4zp5PzDLfi9iy9ZAB6+ZIIwbJdbDJyi7at05gC
         AIsitIA2/jBXFsaxsnlthtlvP4isv8O74U1hkaHU9Zg63aLWD4tP1XfwoeaOanlOtkxh
         3T9oYxzzaH0KQgPjLD2WcpuFS+x27osZhetwuyYHTBkBG9xzR9PY/GH1xoEUEJU428Mk
         Xe8u6wp86Wvr7AOcZfiadaoIPMCi030mhbqHBAQU+XrtEu+Koq6MQSX7zepQ1nd2x3VC
         HbXw==
X-Gm-Message-State: AJIora9gJ6DMhmZ3vecsqmLRFVT9i5lJ1De8/zCRd5sZGWE/o9HU6QSF
        eZ80J+i3aLqsJ9Z87EjFAAxP7b5bbLugSSdzl1EOirl60h8OmAnejLgqdz1HuUAHKxufz9p1Coe
        yIjY6ap/ksA7kzBi2llYv+9T+gjc=
X-Received: by 2002:a05:6000:1281:b0:21b:9c01:df79 with SMTP id f1-20020a056000128100b0021b9c01df79mr2793332wrx.563.1656505405768;
        Wed, 29 Jun 2022 05:23:25 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v9pJO/EqSfuHhWYEuTzIM+Ml0Cf5xYU+IXYXEoEGJo5PASFAvTCOcpNz8z35DuzQpGGt5rXw==
X-Received: by 2002:a05:6000:1281:b0:21b:9c01:df79 with SMTP id f1-20020a056000128100b0021b9c01df79mr2793306wrx.563.1656505405591;
        Wed, 29 Jun 2022 05:23:25 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o12-20020a1c750c000000b003a04b248896sm2888552wmc.35.2022.06.29.05.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 05:23:24 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <20220629115539.GB12720@pathway.suse.cz>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <87r13c7jyp.fsf@email.froward.int.ebiederm.org>
 <xhsmhpmiu5lch.mognet@vschneid.remote.csb>
 <xhsmhmtdw66cr.mognet@vschneid.remote.csb>
 <20220629115539.GB12720@pathway.suse.cz>
Date:   Wed, 29 Jun 2022 13:23:08 +0100
Message-ID: <xhsmhk08z64lv.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 29/06/22 13:55, Petr Mladek wrote:
> On Tue 2022-06-28 18:33:08, Valentin Schneider wrote:
>>
>> 8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()") was
>> straightforward enough because it turned
>>
>>         if (xchg(&lock, 1))
>>                 return -EBUSY;
>>
>> into
>>
>>         if (!mutex_trylock(&lock))
>>                 return -EBUSY;
>>
>> Now, most of the kexec_mutex uses are trylocks, except for:
>> - crash_get_memory_size()
>> - crash_shrink_memory()
>>
>> I really don't want to go down the route of turning those into cmpxchg
>> try-loops, would it be acceptable to make those use trylocks (i.e. return
>> -EBUSY if the cmpxchg fails)?
>
> IMHO, -EBUSY is acceptable for both crash_get_memory_size()
> and crash_shrink_memory(). They are used in the sysfs interface.
>
>> Otherwise, we keep the mutexes for functions like those which go nowhere
>> near an NMI.
>
> If we go this way then I would hide the locking into some wrappers,
> like crash_kexec_trylock()/unlock() that would do both mutex
> and xchg. The xchg part might be hidden in a separate wrapper
> __crash_kexec_trylock()/unlock() or
> crash_kexec_atomic_trylock()/unlock().
>

Makes sense, thanks. I've started playing with the trylock/-EBUSY approach,
I'll toss it out if I don't end up hating it.

> Best Regards,
> Petr

