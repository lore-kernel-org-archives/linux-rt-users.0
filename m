Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADCAC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Sep 2021 22:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D774F61269
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Sep 2021 22:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346286AbhI2W35 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 18:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhI2W34 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Sep 2021 18:29:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2505DC06161C
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2021 15:28:15 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b22so2577096pls.1
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2021 15:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4z0GIh5JK3wKAj0ORkqbJGgKzM9mwUuFWd6cpi9gVRw=;
        b=nfacyzx47o08Kln0OnAnHNK7OQ70oJQbnvTv5mzYQXOdw6lroKF3tmmCAZaBrMIoj0
         IhihCzGkm/y+xXkWHBHL4DduDcDlg/i7V/lrbI1MOa8KDxLwprasqbRdezTJSBRPkCe/
         G1MV27BL3G7i4LqDXKglrNk5syfEcdU1OUdSy5w8ZDEhL4lUuerY2GZIm87TEr1o08sM
         c6yQMgL6xJ+yXXuZ5KCwYOstrdPYLXR8mprV3VXsZVkQPcHBBGrD4a4IqiVxGfCp1vX8
         CAdUJGR0SrtdEGoEWMlYhr//X3FRsmbT5mI/33DBwX+Aw9z5pC7cdgKmq0O/9aU5JLpb
         kNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=4z0GIh5JK3wKAj0ORkqbJGgKzM9mwUuFWd6cpi9gVRw=;
        b=rmNGNkHwQ8IGwJ++peBujWkmJRjwmdQJXmxjINDpxuhU8IbOuqlhDbwxH47v6armKV
         vxKigVa3MPGTI6Zgc2IsByj8VmwNqe/Brbb7qm18A9M1NLmwjlwMz0aJpTd85X302PbU
         c0StNCRBpkuNY5FLMx05yjVRi5muR3euNQU0Z1YhIASuruaq3KMUQzyh5VZG36EoVLvR
         b79MwVDdXnzOeaterP/40im/pSklbXuHN40MYSSSOhSP3pknfSuSogHVI0RNoqiiPLdo
         +TnbshnOLhS1swvJhI7Q2dOfhfsAz6yMgaCEagR3Y/gtjmWyR4ErVLtYp/E9i2a0qcF7
         XWDQ==
X-Gm-Message-State: AOAM531JVRlZr4NojzmB7KVBEGBNMdBFf1jrzybChssZVdXK+c02C78m
        tDXEC+s3ONOKeLOquhrL7d4=
X-Google-Smtp-Source: ABdhPJyo8oM+gbwJvWF69w/TAemCWKmH1tTvD2I/fUA480tmhXbu4I4A7oWA7YPmfRF6Xr38SL4blQ==
X-Received: by 2002:a17:902:708b:b0:13e:1a20:f1b0 with SMTP id z11-20020a170902708b00b0013e1a20f1b0mr825041plk.51.1632954494488;
        Wed, 29 Sep 2021 15:28:14 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id r7sm674235pff.112.2021.09.29.15.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:28:13 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, daniel.sangorrin@toshiba.co.jp,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Suresh Hegde <suresh.c11@toshiba-tsip.com>
Subject: Re: [PATCH v3] rt-tests: hwlatdetect: Gracefully handle lack of
 /dev/cpu_dma_latency
References: <20210929003709.3423639-1-punitagrawal@gmail.com>
        <8ec5eca-1152-20ab-c25-2625f563773@redhat.com>
Date:   Thu, 30 Sep 2021 07:28:11 +0900
In-Reply-To: <8ec5eca-1152-20ab-c25-2625f563773@redhat.com> (John Kacur's
        message of "Wed, 29 Sep 2021 11:09:57 -0400 (EDT)")
Message-ID: <874ka3585g.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John Kacur <jkacur@redhat.com> writes:

> On Wed, 29 Sep 2021, Punit Agrawal wrote:
>
>> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> 
>> On systems where cpu idle is disabled to reduce latencies,
>> "/dev/cpu_dma_latency" does not exist and leads to the following
>> exception report from python when using hwlatdetect.py -
>> 
>>     FileNotFoundError: [Errno 2] No such file or directory: '/dev/cpu_dma_latency
>> 
>> Update hwlatdetect to check whether the file exists before attemping
>> to write values to it. Also, make the related debug output conditional
>> to c-states support being enabled in the kernel.
>> 
>> While we are touching this part of the code, also address a couple of
>> minor issues in the code such as -
>> * correct typos
>> * reflow comment to fit 80-char column limit
>> 
>> Reported-by: Suresh Hegde <suresh.c11@toshiba-tsip.com>
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>> v2 -> v3:
>> * Address issues in comment
>> * Initialise self.dma_latency_handle in init()
>> * Make debug() statements conditional to /dev/cpu_dma_latency
>> ---
>>  src/hwlatdetect/hwlatdetect.py | 16 ++++++++++------
>>  1 file changed, 10 insertions(+), 6 deletions(-)
>> 
>> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
>> index 12228f45f852..56fd2af8641d 100755
>> --- a/src/hwlatdetect/hwlatdetect.py
>> +++ b/src/hwlatdetect/hwlatdetect.py
>> @@ -200,6 +200,7 @@ class Detector(object):
>>          if os.path.exists('/usr/sbin/rdmsr'):
>>              self.have_msr = True
>>              self.initsmi = self.getsmicounts()
>> +        self.dma_latency_handle = None
>>  
>>      def getsmicounts(self):
>>          counts = []
>> @@ -210,20 +211,23 @@ class Detector(object):
>>          return counts
>>  
>>      # methods for preventing/enabling c-state transitions
>> -    # openinging /dev/cpu_dma_latency and writeing a 32-bit zero to that file will prevent
>> -    # c-state transitions while the file descriptor is open.
>> +    #
>> +    # opening /dev/cpu_dma_latency and writing a 32-bit zero to that file will
>> +    # prevent c-state transitions while the file descriptor is open.
>> +    #
>>      # use c_states_off() to disable c-state transitions
>>      # use c_states_on() to close the file descriptor and re-enable c-states
>>      #
>>      def c_states_off(self):
>> -        self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
>> -        os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
>> -        debug("c-states disabled")
>> +        if os.path.exists("/dev/cpu_dma_latency"):
>> +            self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
>> +            os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
>> +            debug("c-states disabled")
>>  
>>      def c_states_on(self):
>>          if self.dma_latency_handle:
>>              os.close(self.dma_latency_handle)
>> -        debug("c-states enabled")
>> +            debug("c-states enabled")
>>  
>>      def cleanup(self):
>>          raise RuntimeError("must override base method 'cleanup'!")
>> -- 
>> 2.32.0
>> 
>> 
>
> Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks for applying the patch!
