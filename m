Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FF3C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 08:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE4E61027
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 08:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbhJOIHa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 04:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbhJOIH3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Oct 2021 04:07:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B2C061760
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Oct 2021 01:05:23 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v8so3583865pfu.11
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Oct 2021 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sLh4Ri9Fy1pgdI+tnEzbxoxa4T/oDJpyU3GLrNySNVM=;
        b=jvyUZLOqWbOYCO2MHO2ZqVsd+f4hrbgYbq9WKTSwfAXRDWFMKp6ykrzCgabRSsp21k
         ItSeCSHsSoqt5agHiSgHV0DgswOzDxXKIXUn0VssYlz9SinCgCYD4/7Yvs/6uUszEECP
         L8N0J5Ep1FVboPj1SBgWSsXqdUnJ83whqEnOnJfegJvvR3Ie64wOa1Pp/uacbFAq4DmX
         FC/rpHEbifsVHxEiselDv/hbZn14928rkCzCQg+YMgOgd3pD2QnEzDH3yANuCkVVLVJ0
         7X5+cwR+C18qN0MrGSaYZ1ggmWqgzmyNljQ7IQKWyIQGotUBvIDJA0hOcy8J8Xj6xtMB
         mBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=sLh4Ri9Fy1pgdI+tnEzbxoxa4T/oDJpyU3GLrNySNVM=;
        b=YNMxOl9bvOEt4W8hmndIQw1ebuQp9QoVFkK7A/7RRBGAUxWESh3pyavec7sI9LNjBx
         gWLujacESFqyUJt91mtDFDQYjk1BH45VYoZM6uzZrg+9bdTqq2CBY1EmJlGnMyr5/QdE
         Gu6oE7eBWXGS15msDQ3okG1POsu8yVlmCAEZdK2Q31KIwq4zBV8PpKpR4Qv0+8HB6e1L
         e8CkCmpQEcnpNHcBEMmHpRiyGAqhJBtP1mPnMQ1dXn5CXeePN+A/PxEiOH6VBVOi3xq0
         QOO2x6SIcntwJ3y84irMCBhVTFDpKX4rA8m+rl+UifsDyoZxAwTyA73OPIrVdm47vyzY
         6ANQ==
X-Gm-Message-State: AOAM5317D0iQkRAYCfHSGw148NOk/y2V5M053thA+QNi0xJ4wBDJtXpe
        oC2XV91wb+Ues8a8SGXJpAI=
X-Google-Smtp-Source: ABdhPJwXnZp7M13BTrt+cktxRHzbOLLwWHQoJ/ivNATqbEo3GcSTCB/BQCOAXgwTfHVUsl9HQUgOOQ==
X-Received: by 2002:a05:6a00:1312:b0:44c:becf:b329 with SMTP id j18-20020a056a00131200b0044cbecfb329mr10054857pfu.5.1634285122604;
        Fri, 15 Oct 2021 01:05:22 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id k14sm4490111pji.45.2021.10.15.01.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 01:05:21 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 4/7] rt-tests: cyclictest: Drop unnecessary variable
 "bufsize"
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
        <20211014071247.4165329-5-punitagrawal@gmail.com>
        <d6cff5d3-1a9b-2b92-6a10-65b3b3af7d89@redhat.com>
Date:   Fri, 15 Oct 2021 17:05:19 +0900
In-Reply-To: <d6cff5d3-1a9b-2b92-6a10-65b3b3af7d89@redhat.com> (John Kacur's
        message of "Thu, 14 Oct 2021 14:29:51 -0400 (EDT)")
Message-ID: <87lf2u1znk.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> On Thu, 14 Oct 2021, Punit Agrawal wrote:
>
>> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> 
>> Two copies of "bufsize", initialised with the same value are declared
>> in enclosed blocks. Remove the redundant declaration.
>> 
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>>  src/cyclictest/cyclictest.c | 1 -
>>  1 file changed, 1 deletion(-)
>> 
>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
>> index 721d242a1da0..9c67a3ce3034 100644
>> --- a/src/cyclictest/cyclictest.c
>> +++ b/src/cyclictest/cyclictest.c
>> @@ -2054,7 +2054,6 @@ int main(int argc, char **argv)
>>  			memset(stat->values, 0, bufsize);
>>  			par->bufmsk = VALBUF_SIZE - 1;
>>  			if (smi) {
>> -				int bufsize = VALBUF_SIZE * sizeof(long);
>>  				stat->smis = threadalloc(bufsize, node);
>>  				if (!stat->smis)
>>  					goto outall;
>> -- 
>> 2.32.0
>> 
>> 
> NACK: two different scopes, two different variables.

If they had different values or if the inner scope was not dependent
(nested) I would agree.

But no strong opinion - I'll drop this one.
