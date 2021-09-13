Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ABCC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 07:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C861260F6F
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Sep 2021 07:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbhIMHsi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Sep 2021 03:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbhIMHsh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Sep 2021 03:48:37 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75421C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 00:47:22 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id bg1so5229995plb.13
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Sep 2021 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3B67r0J9OP8vSU1fa4hopoY0Ku5RtUAloA5vhiryD4w=;
        b=PfuGSzC4gslXNrlCk7VsWNRA/tmspGxr02fS/jyIIy0lF2zpL2MGxUvzGE2kXbU2yW
         a/SQLs37XVDMo/s2X/4864g8KiaGhShEwUeg9Om/CLn4YHpmoCasCneGLG8nf/oAQ1TH
         +8gT/NMEKpGZYPiLrHgo04mbM+TMnd6+ng6VuIIplLwe3orklWPYXi/AHZimEdZU1aX8
         Cuoi+A8Yx953cPer7M9sECpaDaANjLtCM9jQDvKMXzSO8ONicF9HNbADw4sIr7kLlfDA
         rGBiQ7ComBs6jpb8AaPh9vEiiSEsRFY1MK5o1cu12h7T2GVtoyOYdMX6k2t1ab+SksSn
         nGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=3B67r0J9OP8vSU1fa4hopoY0Ku5RtUAloA5vhiryD4w=;
        b=dUHVEwiV7u/AeE+fmCdQytew7KYpLPeR/Oy9fs10gwfd0600XnQ0YNprEtwCc9k6ro
         joxtYEXtjQe913f9ufm3ushSM2W7jwfjFNEP5C/bBxa9cvn4305Y+IEwObcRdPQtUUAn
         k4Y7feBHxTU1+BHnN8Ovqnn/kGFdAAgNL8ix5GEUFJdoqAQdTpbOMov0RRBGY8WfSXKq
         SjZ+f4FQ0WFEAVAkrffvgW5pqENkYzGHzOtNpWvS5mlVWxm351eQSYbQHLnDortj+cjM
         SruwIcrX0GqZBtzOnunTGqeDP4JPDBVzaup3w4gQNKchnG0bPmCrpXqsaWhs30lEG+3K
         B5TQ==
X-Gm-Message-State: AOAM53147EP4tE25+sgPUwHdqLcz6PjstfQNRjka0c54tlV22GVDMnMf
        5lhewMsEnpOlnuyhklppbIc=
X-Google-Smtp-Source: ABdhPJzNlgjRftQ4yvEtzOKAq6O4BCllHY6uOawW2ihmL35oS46iaDaFN/MRhXCuT4VU1wsoh2wfNQ==
X-Received: by 2002:a17:902:aa88:b0:13a:95d:d059 with SMTP id d8-20020a170902aa8800b0013a095dd059mr9401366plr.65.1631519241925;
        Mon, 13 Sep 2021 00:47:21 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id t2sm3255384pje.5.2021.09.13.00.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 00:47:21 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: Re: [PATCH 2/2] rteval: services.py: Fix incorrect detection of
 container environment
References: <20210909080547.1331581-1-punitagrawal@gmail.com>
        <20210909080547.1331581-3-punitagrawal@gmail.com>
        <d18a85b5-d591-a21b-c7fc-93655f7963c@redhat.com>
Date:   Mon, 13 Sep 2021 16:47:19 +0900
In-Reply-To: <d18a85b5-d591-a21b-c7fc-93655f7963c@redhat.com> (John Kacur's
        message of "Sun, 12 Sep 2021 10:59:34 -0400 (EDT)")
Message-ID: <87y2809at4.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> On Thu, 9 Sep 2021, Punit Agrawal wrote:
>
>> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> 
>> rteval mistakenly detects that it is running inside a container even
>> though it is running directly on the host. On further investigation
>> this was found to be due to change in behaviour around byte strings
>> and strings when going from python2 to python3.
>> 
>> In python3 byte strings are not equivalent to strings, i.e., b'' == ''
>> is False. The string comparison functions in services.py are still
>> relying on the old behaviour in python2 where they were equivalent.
>> 
>> Update the byte string processing by converting them to string.
>> 
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>>  rteval/sysinfo/services.py | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> diff --git a/rteval/sysinfo/services.py b/rteval/sysinfo/services.py
>> index 06ff5ae9cd0c..94857aea6be4 100644
>> --- a/rteval/sysinfo/services.py
>> +++ b/rteval/sysinfo/services.py
>> @@ -83,8 +83,8 @@ class SystemServices:
>>          self.__log(Log.DEBUG, "cmd: %s" % cmd)
>>          c = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
>>          for p in c.stdout:
>> -            # p are lines like "servicename.service status"
>> -            v = p.strip().split()
>> +            # p are lines like b'servicename.service status'
>> +            v = p.decode().strip().split()
>>              ret_services[v[0].split('.')[0]] = v[1]
>>          return ret_services
>>  
>> @@ -92,7 +92,7 @@ class SystemServices:
>>      def services_get(self):
>>          cmd = [getcmdpath('ps'), '-ocomm=', '1']
>>          c = subprocess.Popen(cmd, stdout=subprocess.PIPE)
>> -        self.__init = c.stdout.read().strip()
>> +        self.__init = c.stdout.read().decode().strip()
>>          if self.__init == 'systemd':
>>              self.__log(Log.DEBUG, "Using systemd to get services status")
>>              return self.__get_services_systemd()
>> -- 
>> 2.32.0
>> 
>> 
>
> Thanks, this looks good, I'm wondering however if the same result could be 
> achieved by appending text=True to the subprocess command in each of those
> methods? Would you like to test that and send me a new patch?

Thanks for the suggestion - I missed the "text=True" in the Popen() when
going through the documentation.

I will send a new version converting all Popen() sites in the file.

[...]

