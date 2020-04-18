Return-Path: <SRS0=+wOD=6C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E65C38A29
	for <linux-rt-users@archiver.kernel.org>; Sat, 18 Apr 2020 14:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0205D21974
	for <linux-rt-users@archiver.kernel.org>; Sat, 18 Apr 2020 14:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kgxq1hDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDROki (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:40:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24724 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbgDROki (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 18 Apr 2020 10:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587220836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FsPiBNUlYne/0GyLinH9dQM8XJ8OvtFZ37+q7y5Mf6w=;
        b=Kgxq1hDyozjlvLBjUj98+3fYyAuyyY4ZHfPaYPwf0HwjhYkXGlGIS5tFmz5W6TYYTAH9xN
        TNKBnDi0ILpHomd3+zYHSLu+WHMLVzVuJFRPsLwjwrG1H2cUAKbsMNkupJX8yqkpBEMaln
        F9lT0WXnLTuYIhJRmjvyf4/rzWPrOQ4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-7L2kSOVoO26NqjyNB1qfiA-1; Sat, 18 Apr 2020 10:40:34 -0400
X-MC-Unique: 7L2kSOVoO26NqjyNB1qfiA-1
Received: by mail-qv1-f71.google.com with SMTP id f9so5202881qvt.14
        for <linux-rt-users@vger.kernel.org>; Sat, 18 Apr 2020 07:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FsPiBNUlYne/0GyLinH9dQM8XJ8OvtFZ37+q7y5Mf6w=;
        b=FcFp5Jl7jGRGSA4bFLePgVqfE91jqnn0KqaLQpChkou0bvjbTtl2uyuBTQQw/NuEwe
         2UaO7DyFHhLlASwn5pGIHJuehbTGXHv9lEj6D14ZJ4wbcp+tzV93DX6mfc9VEkwCvT3I
         Ry8dZ9ZXwvTRAFcywDxQoOwiiPJASR65fqN+FqKYy8MtBRtUYn47zPEi6HCN7Dhb7dhn
         vHdyjl7EkCInP8GQaX9Tc0zDsoVkdBwAutjQ7Ml4Dt+S91XJh9X+wbRtrMVbwpjU5q0D
         UxNW77Yqe6HKGPtNRV68SkksrORoc6P/Vb4ww4HCXwNGHz/J4+Uof9TSoSYR6mcibboJ
         3/RA==
X-Gm-Message-State: AGi0PuYjacxGVpF/nu8UNrRrCSUUcd9HHsRa+YkBTp/aQAl6HG1+6rIL
        XM4vTUiSjGmffzDaS4YadspYKnpsiTJkZrTM8QmhJlHttvQ9JymVmdgcW4pudiTbSSp3bkLikiQ
        DDmcIsZfeQzICbWhNNQH/UVdOU7c=
X-Received: by 2002:ac8:2aae:: with SMTP id b43mr8205926qta.111.1587220833036;
        Sat, 18 Apr 2020 07:40:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypJW7QfssM9rGQVBtDN/mS172/xAmxvVkn8p3841JZw9yvPRWm2jsILoYWWTlBu3FKMrCz12gg==
X-Received: by 2002:ac8:2aae:: with SMTP id b43mr8205900qta.111.1587220832746;
        Sat, 18 Apr 2020 07:40:32 -0700 (PDT)
Received: from trix.remote.csb ([75.142.250.213])
        by smtp.gmail.com with ESMTPSA id i6sm17680609qkk.123.2020.04.18.07.40.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 07:40:31 -0700 (PDT)
Subject: Re: [PATCH v2] Import a new test, jitterz
To:     Thomas Gleixner <tglx@linutronix.de>, jkacur@rehat.com,
        williams@redhat.com, lgoncalv@redhat.com
Cc:     linux-rt-users@vger.kernel.org
References: <20200401221310.7544-1-trix@redhat.com>
 <871rp6q07j.fsf@nanos.tec.linutronix.de>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4b20dd56-7106-d811-c643-28518bbbd038@redhat.com>
Date:   Sat, 18 Apr 2020 07:40:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <871rp6q07j.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

What changed.

A general cleanup of test.

A man page added.

More comments.

Addressing issues, see below.


On 4/1/20 4:02 PM, Thomas Gleixner wrote:
>
> The exact purpose of this is?
>
>> +
>> +#define CHECK_LOST_TIME()					\
>> +	do {							\
>> +		if (d >= dt_min) {				\

This is the update_buckets call, if time difference is greater than a threshold it is added to a bucket.

> Aside of having a \ at the last line, macros which rely on variable
> names at the call site are broken to begin with. What's so magic to hide
> this in a macro instead of writing a proper function?

This was changed to a function.

>> +static inline uint64_t tsc(void)
>> +{
>> +	uint64_t ret = 0;
>> +	uint32_t l, h;
>> +
>> +	__asm__ __volatile__("lfence");
>> +	__asm__ __volatile__("rdtsc" : "=a"(l), "=d"(h));
>> +	ret = ((uint64_t)h << 32) | l;
>> +	return ret;
>> +}
> Having x86 specific code in a generic test suite is a non starter.
If-def added to build of x86, else provide a runtime error.
> +	char *freq[2] = {
> +		"cpuinfo_cur_freq",
> +		/* assumes a busy wait will be run at the max freq */
> Assumptions in tools which are meant to provide useful output are really
> not useful at all.

These frequencies are only starting points, the test recalculates the frequency at runtime.


>> +			if (f) {
>> +				fscanf(f, "%lu", &fs);
> That definitely has never seen a 32bit compile.
Changed to use PRIu64 macro and verified on i386 compile.
> +
> +	if (fs == (uint64_t) -1) {
> So here you have a typecast but at the place where this is initialized
> this is not required, right?
Typecast removed.
>
>> +	return 0;
> As the above is completely unreadable gibberish I can only assume that I
> wasted time staring at a well done April 1st joke :)

Rewrite + comments should make the understanding the main loop easier.

Tom

