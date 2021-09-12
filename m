Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3E8C433EF
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 15:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB76361056
	for <linux-rt-users@archiver.kernel.org>; Sun, 12 Sep 2021 15:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbhILPEc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 12 Sep 2021 11:04:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229653AbhILPEb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 12 Sep 2021 11:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631458996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ORjicB+Vghncbm6K6JrlpHDsuSpAskK8pB5qmmeSqzk=;
        b=aW2HHsCuA5WMEerWvI/V26P8KKBL6CpqGCNUIJ78YGMRZBFB/QaMxZmOb6p1RmrFPAKz4l
        HolhC3WPNiJTQbkEUy0+V4783QX/1+ZXe8vjipQy+tENjOZrUPYR9DgYC6sFaL0+uhT911
        ayznNZXH8ACMYqdDtzBocDkZD4Rni7A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-7G8nWU7cOFu6tHtY3OyLEA-1; Sun, 12 Sep 2021 11:03:15 -0400
X-MC-Unique: 7G8nWU7cOFu6tHtY3OyLEA-1
Received: by mail-qv1-f70.google.com with SMTP id h9-20020a05621413a900b0037a2d3eaf8fso54100341qvz.8
        for <linux-rt-users@vger.kernel.org>; Sun, 12 Sep 2021 08:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ORjicB+Vghncbm6K6JrlpHDsuSpAskK8pB5qmmeSqzk=;
        b=for/nXAajwFNp323EzDbY2LdroT/bAbOG3yQHVdvIj4d+U4SNcWBiULouFueuwsO9O
         8Zk7RQ+IpoKwnpYi2k+I1ew8V3dbmscdgpVZTJVaTMXWbqUCKEanoT8lzKHjrXEKptc1
         b4SNENFY388IxJFcwegxMI1q9l2BYFMu2sVnuPHBSZFGk/dRFhlpB0a64BHKuWOmJhB1
         msQgNYGG95VHan5LsnnCDXtflm+hcPRi1SHu1UbdaJnCMNvcXT0/SqVHtPeUCCqtqfiW
         WVbBMQPTp9iVlC0Gvel5D69ZddqpWekE0L5xj1HtQ4udall54wzShZMJ8FhtoxiQ8qoR
         hI4w==
X-Gm-Message-State: AOAM530kVWw9mzsat682ZfLBK0ZLN2bEN4fR1wzT212uBWUxSSc0KXpJ
        a3mz5t0wCXRKQmRv4ibKF8fkLaTT5MJRG+le5Ppp/ZOaki7tki5RtYO0nIf78WfaELkzZSVt31C
        zuxW/NsplSFqeABTsqBqdbXvFEhc=
X-Received: by 2002:a05:620a:1aaa:: with SMTP id bl42mr6184270qkb.469.1631458994487;
        Sun, 12 Sep 2021 08:03:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoPa8IOzNRgGWTmmOPnHVwloGyXKyI42cErUnhZT7aRLprO47HEyD8PftCjaQ/tP+kZ7gmyA==
X-Received: by 2002:a05:620a:1aaa:: with SMTP id bl42mr6184256qkb.469.1631458994317;
        Sun, 12 Sep 2021 08:03:14 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id 9sm3272972qkc.52.2021.09.12.08.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 08:03:13 -0700 (PDT)
Date:   Sun, 12 Sep 2021 11:03:12 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        Venkata.Pyla@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com
Subject: Re: [PATCH 1/3] rteval: cyclictest.py Enable logging cyclictest
 output
In-Reply-To: <20210902092452.726905-2-punitagrawal@gmail.com>
Message-ID: <175ea621-2245-5c79-16e7-feccbc906ed8@redhat.com>
References: <20210902092452.726905-1-punitagrawal@gmail.com> <20210902092452.726905-2-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 2 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> The cyclictest.py module uses a temporary file to store the output
> from "cyclictest" which is deleted at the end of the run. As the
> collected log contains more information than what is being reported by
> rteval it would make sense to persist the logs. It can also be useful
> to sanity check the results reported by rteval.
> 
> With this goal, create a persistent file named
> "cyclictest.stdout" (instead of a tempfile) to capture the cyclictest
> logs. The file is stored in the same location as the logs from the
> other modules.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/modules/measurement/cyclictest.py | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index b1755d4f4421..0037c3ad07bd 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -197,6 +197,7 @@ class Cyclictest(rtevalModulePrototype):
>          self.__numanodes = int(self.__cfg.setdefault('numanodes', 0))
>          self.__priority = int(self.__cfg.setdefault('priority', 95))
>          self.__buckets = int(self.__cfg.setdefault('buckets', 2000))
> +        self.__reportdir = self.__cfg.setdefault('reportdir', os.getcwd())
>          self.__numcores = 0
>          self.__cpus = []
>          self.__cyclicdata = {}
> @@ -255,6 +256,8 @@ class Cyclictest(rtevalModulePrototype):
>          mounts.close()
>          return ret
>  
> +    def _open_logfile(self, name):
> +        return open(os.path.join(self.__reportdir, "logs", name), 'w+b')
>  
>      def _WorkloadSetup(self):
>          self.__cyclicprocess = None
> @@ -288,7 +291,7 @@ class Cyclictest(rtevalModulePrototype):
>              self.__cmd.append("--tracemark")
>  
>          # Buffer for cyclictest data written to stdout
> -        self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
> +        self.__cyclicoutput = self._open_logfile('cyclictest.stdout')
>  
>  
>      def _WorkloadTask(self):
> -- 
> 2.32.0
> 
> 

This is the kind of information that is interesting to developers of 
rteval, but is less interesting to general users who are simply testing 
whether their machines are capable of being used for realtime performance. 
For these people, this would just create large files to be deleted.

I would consider this perhaps with a command line flag explaining this is 
an option for rteval developers.

John

