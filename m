Return-Path: <SRS0=ak3V=4O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DCAC4BA18
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Feb 2020 17:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CDD20801
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Feb 2020 17:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="vEI6zMuC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgBZRki (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:40:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43078 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgBZRkh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Feb 2020 12:40:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so308567oif.10
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Feb 2020 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eXtFjPsAzZNkY+1riPx3cd+gPghh3vhUFXBaqSg+4sY=;
        b=vEI6zMuCGpfEYwGyk+fqe43mF2pmQ5nAlJBuJO0/xJS6ZRnHY2cAI9p4Xw+8J4jWJz
         ktPEBroTmUppvIEBlcDya1zyEKdALXMU0OuZgvDXFmED+2/4fomglC1cCsyKhGMMcUN3
         1yyZTJ9/1CcLohkZZcZigcUXSp2h+qoL4XzmDubAwAQh9hnpA/vusLXLaRh0TmOADgfQ
         +yrE8+hp6rlP5YtB0kEe/ujG7JWHXbNTa/T0o+v/4ZqyFGp2B9Nxz09tIcWwpe7BzLPo
         HzXexZPaHs+SM6Mv6Ph5pPvSo04ElCAoA89ALuhFTocIkrRMX4nkMfkLVl1IwlUtryed
         yIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eXtFjPsAzZNkY+1riPx3cd+gPghh3vhUFXBaqSg+4sY=;
        b=m1+G9LNybQNiKDrzGNhw4WUs98ip7rpkrRQOCRzBs2n1GEwWU42B75hX2czxqRsioF
         PVso6nNrR0R34sv/DnoLyXFnmv7tc1SI+vuEc9rMm8pdC+SqrFJ84Yd8+DfIG6A1gm3E
         kftbr4f9a/seRWq81DandOaUnQVdBaB0jhig6XzdJrExCaXzDrg2KC56t4hcNrxE8y2L
         9qGNCURcr8oILJbmHjf1ZAjopKlzOCQ8qxeOTt3GpFzOe7xneM3YDFi8P5zrAKvfFhKy
         3rfznYawr6MxqAJDB/m7LyCBMz4cqIiqopMbd6t87F5Dnzsefuj4vCISiYwwdN+gQbba
         zwbQ==
X-Gm-Message-State: APjAAAX48jlhciEI6y/7pS/dK0Ud6i7r/NbG7muzPGnieSvTyJsIpVwb
        e3W+5EcsRKN4Og/BrUN4BSDkUJEs5iM=
X-Google-Smtp-Source: APXvYqyDrpVQ4wjOGFhywwfJrDp8KVjP1tLUh4Zd4sxwZXMXgOhN0Jz/qj8O0uJ12D2yhaViLYpWZw==
X-Received: by 2002:aca:458:: with SMTP id 85mr127413oie.56.1582738836330;
        Wed, 26 Feb 2020 09:40:36 -0800 (PST)
Received: from ?IPv6:2600:1700:4c90:60a0:29bf:408e:9a00:9f0b? ([2600:1700:4c90:60a0:29bf:408e:9a00:9f0b])
        by smtp.gmail.com with ESMTPSA id 96sm1005014otn.29.2020.02.26.09.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2020 09:40:35 -0800 (PST)
Subject: Re: [rt-tests][PATCH] rt-tests: make manpages builds reproducible
To:     John Kacur <jkacur@redhat.com>
Cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
References: <20200225234230.17232-1-jpuhlman@mvista.com>
 <alpine.LFD.2.21.2002261217460.9967@planxty>
From:   "Jeremy A. Puhlman" <jpuhlman@mvista.com>
Message-ID: <3688e9ae-69b9-7237-59e8-9c1f316b5fa8@mvista.com>
Date:   Wed, 26 Feb 2020 09:40:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.2002261217460.9967@planxty>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 2/26/2020 9:18 AM, John Kacur wrote:
>
> On Tue, 25 Feb 2020, Jeremy A. Puhlman wrote:
>
>> From: Jeremy Puhlman <jpuhlman@mvista.com>
>>
>> Add -n to gzip call to make the build output
>> of the manpages reproducible.
>>
>> Signed-off-by: Jeremy A. Puhlman <jpuhlman@mvista.com>
>> ---
>>   Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Makefile b/Makefile
>> index 8747971..1b37ba7 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -181,7 +181,7 @@ ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
>>   	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>>   
>>   %.8.gz: %.8
>> -	gzip -c $< > $@
>> +	gzip -nc $< > $@
>>   
>>   %.8.bz2: %.8
>>   	bzip2 -c $< > $@
>> -- 
>> 2.20.1
>>
>>
> Could you explain to me how this makes the build output of manpages more
> reproducible?

gzip adds the name of the file(not really an issue) and the modification 
time into the header of the
gzipped archive.  Different modification times can cause the archives to 
have different md5sums even
though the content is identical.  Adding -n causes the archives to 
always be identical regardless of when
they are built so long as the content is identical. Its less of an 
issue(provided the build system in question
doesn't touch or modify the man pages) when you are building from 
released tarballs, but if you build
from git, the modification time of the file is when the file was checked 
out.

Tools like rpm will object to the files being installed(like say 
multilib versions of the same packages) together
due different md5sums and the fact that they are not elf binaries, even 
though the files are the same.


-- 
Jeremy A. Puhlman
jpuhlman@mvista.com

