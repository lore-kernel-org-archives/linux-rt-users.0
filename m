Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C73C43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 13:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiFXNiA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 09:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiFXNht (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 09:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D698B54BF1
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656077858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iihGsDJaCfgB0U9H9bTk3P+5uHXU2Udgo4mdhsEY1hk=;
        b=Royy/kYSZQmbA8kjAokE+eg67UWwe37hREQM4pAAKdvjOxKJdJ/Nc/7waUVv9pfXgk0qWq
        mBO+ZUUq3HLE9NYqMiI3JUiglLRwiSwLwSkl494rV9mXJ+nffqdlipTAHZHO8eL9Sp4N4V
        QRNoHE2e3XrD9PjIfqJASy/GpWvrJ6g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-dcmSBeTONJaeKq1k7a3rgA-1; Fri, 24 Jun 2022 09:37:37 -0400
X-MC-Unique: dcmSBeTONJaeKq1k7a3rgA-1
Received: by mail-wm1-f71.google.com with SMTP id bg6-20020a05600c3c8600b003a03d5d19e4so381788wmb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 06:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iihGsDJaCfgB0U9H9bTk3P+5uHXU2Udgo4mdhsEY1hk=;
        b=jklTQcCGg+bUPuraO1pt390E8b6rPLFYA29sfsGQ75wbkGpAtExNGXgca+NBadBZMq
         wBVhDNUJbC8O4VHV67CNnEQrONoCmq7Y23b0Mgi5dTGSl3yCKLHQmoGZv+grtOQg75Uy
         l4fPC4FU11otKTYc23koqv85SnmAB0AGjXQ6zmGosiZduUVJAZN2NW98nbLYFJGud5dF
         tr1EYAt88k/tBflCTTELd+pIPP4s404CSE8tyO5L7uNlVDEY0dXpMfjxTMUF9Mz1T2PX
         w8nyrbOrudSNdXgmREUbyb5B9TeeDb+Gt+3UlIWm3k4Jm1F2hq4YOdTqeouj+0462ccy
         yOMg==
X-Gm-Message-State: AJIora+yte9bxCpYZmpfR+0Yo1I/TaXxT85SdPdkGfJnZKF8EyrtVOHG
        /4GvJKD3ExZlmZxxr/aoWi/3lBywSE47dLIl0ZQz8Erjd0Kw2Pfl0Jryh6MnBmm1dsCS95dbBzf
        aXSfiOSWN2r+Tp/zop+ZtTmQ1s5M=
X-Received: by 2002:a05:6000:1373:b0:21b:ae65:cd38 with SMTP id q19-20020a056000137300b0021bae65cd38mr5758324wrz.323.1656077855326;
        Fri, 24 Jun 2022 06:37:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t5kxEQLYP7f2/L7To0n1AeI7/BBSZOapMMFe+ZmhaXEaq7njP/DHXIEAivdtbuhzGRbNBfxw==
X-Received: by 2002:a05:6000:1373:b0:21b:ae65:cd38 with SMTP id q19-20020a056000137300b0021bae65cd38mr5758301wrz.323.1656077855110;
        Fri, 24 Jun 2022 06:37:35 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id h6-20020adffd46000000b0021b96cdf68fsm2300843wrs.97.2022.06.24.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 06:37:34 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>, Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <jlelli@redhat.com>,
        "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH v2] panic, kexec: Make __crash_kexec() NMI safe
In-Reply-To: <YrUTsJiIQb583fKy@MiWiFi-R3L-srv>
References: <20220620111520.1039685-1-vschneid@redhat.com>
 <YrUTsJiIQb583fKy@MiWiFi-R3L-srv>
Date:   Fri, 24 Jun 2022 14:37:33 +0100
Message-ID: <xhsmhsfnu5giq.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 24/06/22 09:30, Baoquan He wrote:
> On 06/20/22 at 12:15pm, Valentin Schneider wrote:
>> @@ -94,14 +94,20 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>>  	/*
>>  	 * Because we write directly to the reserved memory region when loading
>>  	 * crash kernels we need a mutex here to prevent multiple crash kernels
>> -	 * from attempting to load simultaneously, and to prevent a crash kernel
>> -	 * from loading over the top of a in use crash kernel.
>> -	 *
>> -	 * KISS: always take the mutex.
>> +	 * from attempting to load simultaneously.
>>  	 */
>>  	if (!mutex_trylock(&kexec_mutex))
>>  		return -EBUSY;
>
> So kexec_mutex is degenerated to only avoid simultaneous loading,
> should we rename to reflect that?, e.g kexec_load_mutex.
>

It's also serializing crash_get_memory_size() and crash_shrink_memory();
more generally it should still be the preferred serialization mechanism as
it's a "proper" lock visible by instrumentation, the atomic variable is a
side character for the NMI case.

