Return-Path: <SRS0=V9Xa=WK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D41C32753
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 18:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC272133F
	for <linux-rt-users@archiver.kernel.org>; Wed, 14 Aug 2019 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg5GoOpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbfHNSl1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:41:27 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51179 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbfHNSl0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 14 Aug 2019 14:41:26 -0400
Received: by mail-wm1-f43.google.com with SMTP id v15so157782wml.0
        for <linux-rt-users@vger.kernel.org>; Wed, 14 Aug 2019 11:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=sXM8LTKpUVvOk7Raf04HmeE0CAfC2bEP1Rz1LrZJ9NY=;
        b=Eg5GoOpKu2Zcw9I8lYOy6DTI0LZSf0d6swCNWWb8K+Hp+1uiQrdpCjOe/lRUCh0Yc0
         JTPStJPAtxYIbfm8Q2Rpm6ICydakJRD18KkyBuJDN3+azI5cFmC3YZY6uQSMrXHGCnIY
         HfLw7QXbNRNknOrCwTCOKfvAgaXTg5bvVSMiA7jBnx2jyDgzf/kGP4aCogtcim5ZNIrz
         TXGK/xsGloASHYGwtwEjtkZo9HlnPV4GZEijY4iSw0vAKs4uPEywpFZ2f6ubpU/I8vvL
         bw6CqD2tOkXRvZhnp7OPZAA/FcGtgXGdkbBWOBAI8zIYo3f+8NePCNuRtV2WTdH2mrPJ
         nVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=sXM8LTKpUVvOk7Raf04HmeE0CAfC2bEP1Rz1LrZJ9NY=;
        b=Va+lex9Z9i4RbJNBuHdf8JjlucIzPE5joLJhMh+5A5kfy8Bp3nJ4SByIXeLY5wt13n
         Y86aL0ru6rQfwcCF9i5FuhdYrVjCKAWiaq9gwkfAjeLMhhtDzJw8ogjnEnZpdlMd/v96
         ZUA+uAg4Jnnt1wd1MeRVeOQ0wDa2JNnjmuhnGaWpOBXAtJy7wfrJEzCZa0Q6GA5G9NsP
         3AzfMu3O+RVIUOoam+43y+2HPUv/8TBU9znrds41JOtfGQRG4W850sZQuMOa0JnfoRY8
         a8GecPg7hymu4VLHd0iIIIZNtb60Nf4MNTyvXTj0QxHm7EagyDYBx5WpkTDFnbUovUPE
         CaMg==
X-Gm-Message-State: APjAAAU/e3eZQyX0JbN7KOpaN3pcBqeWI2VlpXss2su7dVEF3F/GBvQM
        6p+VlcPvoBlxfEQEJk8vFsAVrH2I
X-Google-Smtp-Source: APXvYqzwshXVonSQniyFROSS7YiavX01XcCCvJbB2RJQDr+PsFvIsR/uJBqCKfDbvSlOSifq1CTVqg==
X-Received: by 2002:a1c:2015:: with SMTP id g21mr495620wmg.33.1565808083963;
        Wed, 14 Aug 2019 11:41:23 -0700 (PDT)
Received: from [192.168.0.19] (10.221.223.213.rev.sfr.net. [213.223.221.10])
        by smtp.gmail.com with ESMTPSA id f7sm1013121wrf.8.2019.08.14.11.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 11:41:23 -0700 (PDT)
Subject: Re: Little bug in cyclictest
To:     John Kacur <jkacur@redhat.com>
Cc:     williams@redhat.com, linux-rt-users@vger.kernel.org
References: <5d169fe2-b545-ae68-a946-4e36a613cbda@gmail.com>
 <alpine.LFD.2.21.1908141524020.5420@planxty>
From:   Rachid Koucha <rachid.koucha@gmail.com>
Message-ID: <7e292a1e-b52d-e8c6-37b0-05270df81539@gmail.com>
Date:   Wed, 14 Aug 2019 20:41:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1908141524020.5420@planxty>
Content-Type: multipart/mixed;
 boundary="------------E622D424F9DF57C185F7AF00"
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------E622D424F9DF57C185F7AF00
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Find attach the patch file :

$ cd rt-tests
$ patch -p1 < ../cyclictest_affinity_check.patch

On 14/08/2019 15:25, John Kacur wrote:
>
> On Wed, 14 Aug 2019, Rachid Koucha wrote:
>
>> Hi,
>>
>> First of all, many thanks for such useful tools.
>>
>> In the source code of cyclictest, I can see a mistake concerning the
>> error checking of pthread_setaffinity_np():
>>
>> Upon error, pthread functions return an error ant not -1. So, the
>> following code:
>>
>>     if (par->cpu != -1) {
>>         CPU_ZERO(&mask);
>>         CPU_SET(par->cpu, &mask);
>>         thread = pthread_self();
>>         if (pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
>>             warn("Could not set CPU affinity to CPU #%d\n",
>>                  par->cpu);
>>     }
>>
>> should be fixed as follow:
>>
>> int status;
>>
>>     if (par->cpu != -1) {
>>         CPU_ZERO(&mask);
>>         CPU_SET(par->cpu, &mask);
>>         thread = pthread_self();
>>         if ((status = pthread_setaffinity_np(thread, sizeof(mask), &mask)) != 0)
>>             warn("Could not set CPU affinity to CPU #%d: %s (%d)\n",                  par->cpu, strerror(status), status);
>>     }
>>
>>
>> Regards,
>>
> Thanks, that looks correct. Please generate a patch and I'll apply it.
>
> John Kacur


-- 


--------------E622D424F9DF57C185F7AF00
Content-Type: text/x-diff;
 name="cyclictest_affinity_check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cyclictest_affinity_check.patch"

--- old_rt-tests/src/cyclictest/cyclictest.c	2019-08-14 20:28:48.547725419 +0200
+++ new_rt-tests/src/cyclictest/cyclictest.c	2019-08-14 20:20:58.415297592 +0200
@@ -985,6 +985,7 @@
 	cpu_set_t mask;
 	pthread_t thread;
 	unsigned long smi_now, smi_old;
+        int status;
 
 	/* if we're running in numa mode, set our memory node */
 	if (par->node != -1)
@@ -994,9 +995,9 @@
 		CPU_ZERO(&mask);
 		CPU_SET(par->cpu, &mask);
 		thread = pthread_self();
-		if (pthread_setaffinity_np(thread, sizeof(mask), &mask) == -1)
-			warn("Could not set CPU affinity to CPU #%d\n",
-			     par->cpu);
+		if ((status = pthread_setaffinity_np(thread, sizeof(mask), &mask)) != 0)
+			warn("Could not set CPU affinity to CPU #%d: %s (%d)\n",
+			     par->cpu, strerror(status), status);
 	}
 
 	interval.tv_sec = par->interval / USEC_PER_SEC;

--------------E622D424F9DF57C185F7AF00--
