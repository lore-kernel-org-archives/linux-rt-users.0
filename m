Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55EFC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 07:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE143610F7
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 07:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbhKIHFJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 02:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbhKIHFI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Nov 2021 02:05:08 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33985C061764
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Nov 2021 23:02:23 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q126so13677733pgq.13
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Nov 2021 23:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UYhojKZjhv6FwOIxWvPtOdqdaJE/WiFWevUeDg2U3pQ=;
        b=C6y2C8YEusks5jrCajDOOJOGbAa3kLPeegiCYQTuuRvGnMwWvGj9mTFPACFdWsr0RF
         NdfXL4a1DoLFVxYiboFsxJ+4JIphZGjvplvplUzyfN7Rlemto/o6IbMmNX3BNo4IlFqI
         yfPyr2vWVHjB0u5q3DKEgmYmnpM019dDSd+JWVilZkkVflgcJOYKS4TUGSSMvMs7mCk/
         B5yM1grxEjmz6c/p8AgeetKg1pD5dwtlHn6U+zGdCA6+78k3oNg7LRRTYqhBx0QGUKhr
         0KqndillzY+wcKeqHPhl93O9RFHUQ6duHCyPibdu2kFilWb6ZhoQQY8jZhx0r7uL9wKB
         V1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=UYhojKZjhv6FwOIxWvPtOdqdaJE/WiFWevUeDg2U3pQ=;
        b=n5v4MTx4k6eUwJaDJyJt+yJ9u/A0U7FwTWpshUHyLTiU/pFN0fMgxD3RcpRsM5VggS
         xV8E+30BQxxZSIYAUXWol36BWqpTh5mWemcw5nMVHGTXs8dUw4BViwRJ0Wtp4FyD4Azf
         ngW4jlniYf7hvbNpaP4epciz6Y+IZ9fXF3roqw0Xl5D0VEzh2KuG6ZgYKHpiRxoxXUKU
         JJAxuL+QcyLofHMzDEcR5As01wWCrh0XbVfixlOcLeprP1/Yt8N0pkzihwC5avsBuAVA
         Yp1k6WAvQmqN0MzMC/VkVM/YnC6zQOChcqtvUgBFIbr0Y10TpwjuX/8jzKiA7qbCM9E5
         Dgkg==
X-Gm-Message-State: AOAM530hAX+8jWfxPkNnRXXfewRQSNfWEhZnJpn31GOEfubut4UMK1VC
        pQGUFAAG53kE617kfGOY50VVrNLgzrU=
X-Google-Smtp-Source: ABdhPJzcfbRTubWUp0oEi+HKNy1IvLuQZ32PuYnToouKxWrFw4D40ITXdUJhSGgxgMtwSlTgxFRzNg==
X-Received: by 2002:aa7:83c9:0:b0:481:1d47:3362 with SMTP id j9-20020aa783c9000000b004811d473362mr5676455pfn.5.1636441342657;
        Mon, 08 Nov 2021 23:02:22 -0800 (PST)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id u9sm1306706pfl.118.2021.11.08.23.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 23:02:21 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [PATCH v3 1/4] rteval: cyclictest.py Enable logging cyclictest
 output
References: <20211018055736.412576-1-punitagrawal@gmail.com>
        <20211018055736.412576-2-punitagrawal@gmail.com>
Date:   Tue, 09 Nov 2021 16:02:20 +0900
In-Reply-To: <20211018055736.412576-2-punitagrawal@gmail.com> (Punit Agrawal's
        message of "Mon, 18 Oct 2021 14:57:33 +0900")
Message-ID: <87v91195hf.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Punit Agrawal <punitagrawal@gmail.com> writes:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>
> The cyclictest.py module uses a temporary file to store the output
> from "cyclictest" which is deleted at the end of the run. As the
> collected log contains information that can be useful for development
> or debugging, having the ability to persist the logs is useful.
>
> With this goal, introduce a configuration option for the cyclictest.py
> module, "savelogs", that can be used to enable persisting the
> cyclictest output to a logfile. As the logs an be quite large, the
> default is to not save them.
>
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/modules/measurement/cyclictest.py | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index b1755d4f4421..ee1de883d844 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -197,6 +197,8 @@ class Cyclictest(rtevalModulePrototype):
>          self.__numanodes = int(self.__cfg.setdefault('numanodes', 0))
>          self.__priority = int(self.__cfg.setdefault('priority', 95))
>          self.__buckets = int(self.__cfg.setdefault('buckets', 2000))
> +        self.__reportdir = self.__cfg.setdefault('reportdir', os.getcwd())
> +        self.__save_logs = self.__cfg.setdefault('savelogs', False)
>          self.__numcores = 0
>          self.__cpus = []
>          self.__cyclicdata = {}
> @@ -255,6 +257,8 @@ class Cyclictest(rtevalModulePrototype):
>          mounts.close()
>          return ret
>  
> +    def _open_logfile(self, name):
> +        return open(os.path.join(self.__reportdir, "logs", name), 'w+b')
>  
>      def _WorkloadSetup(self):
>          self.__cyclicprocess = None
> @@ -288,7 +292,10 @@ class Cyclictest(rtevalModulePrototype):
>              self.__cmd.append("--tracemark")
>  
>          # Buffer for cyclictest data written to stdout
> -        self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
> +        if self.__save_logs:
> +            self.__cyclicoutput = self._open_logfile('cyclictest.stdout')
> +        else:
> +            self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
>  
>  
>      def _WorkloadTask(self):

Ping!

This patch was missed when reviewing / merging the other patches in the
series. Please consider merging if there are no issues.

Thanks.

(and apologies for the extra messages)
