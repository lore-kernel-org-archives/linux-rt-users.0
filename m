Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3B9C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 06:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6764D61159
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 06:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbhKIHBy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 02:01:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243326AbhKIHBx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Nov 2021 02:01:53 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04390C061764
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Nov 2021 22:59:08 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id f5so17597234pgc.12
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Nov 2021 22:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NzoT6iDfQkhPbwv2S+NaIBBNrUTf0DdamaTT4JXKxTQ=;
        b=GUSJu2btJQX/XLIzNxyWuwsquQLf+aLAWyWlCiDGjRaiicvoWC9p2Hplc+MzHwnmZx
         aCyvaoRtzQO8HgdeHqbFUO1JDPRKyXZ8I2tWPK0pjYd0X1X05Q6ZuM6TOi8a76o7dFGf
         w6BZjusFt9Ay1/XNd13pDjlQnPJTi7yLosTKcGtvUDs4jvazIC4L8sMKniaaddGcy8et
         PnrtPaAS5/VTiK2NuO+0VLepz9TQxuaCpM79NNVFAyTSmZr4H0PzJGAZYUCzxKpamR90
         RmjcmUInFtUoQLZTyNfKddVzULbUlwDXZwhPP+Tb6zk4mPkbILC1LC6K3Cnlye4y9ip+
         khdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=NzoT6iDfQkhPbwv2S+NaIBBNrUTf0DdamaTT4JXKxTQ=;
        b=ooMIr8Hk8c59xDSnE/c8Z1sS0gISFAFQ/zM2QzSyeXM36jRoZq8WvZwLAMgRpTR+6t
         Q16pgzonhHKHrXz1vcd6u5+YKqbO9T56Dn3QGx4DmXmAzQW8hJhS828F21d8/4YX1XuL
         R4x1CbOyteco/ph9t/LqZPkRQjkyRMYW/ZnXqZuicnGN5TDZpVU0susNXNTbzv/wO8T3
         Sd+E+nC0Y59dA3/v9NOJGfUuEJUGJiE+l+4Yg6S4F/7vamzEIGQyaEqFxyv+6JNgGPBI
         INojknthkW0PPXWNZaXb9S00Tssa695Eq7hzZNd27JpcS21F9Y0ZJ0ZiwLcv2Ud3d55T
         bXiA==
X-Gm-Message-State: AOAM533IPHSwt0xjT+gv7rC+nGDILAYJ5t2X0qkMfbkmka2L5z9c/f/N
        QaVDdM8iU3WveDU1SimKqFdnhdU4Ne4=
X-Google-Smtp-Source: ABdhPJzM6YCqOOeWCRvLDp2xFwuQaCJl3sbwPTiO6MJkqn+l34MKo94jIcyYJvYXn1FCi1jBVfUdIg==
X-Received: by 2002:a63:e710:: with SMTP id b16mr4207316pgi.38.1636441147466;
        Mon, 08 Nov 2021 22:59:07 -0800 (PST)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id z2sm19081140pfh.135.2021.11.08.22.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 22:59:06 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: Re: [PATCH v2 1/3] rteval: cyclictest.py Enable logging cyclictest
 output
References: <20210917085343.2775300-1-punitagrawal@gmail.com>
        <20210917085343.2775300-2-punitagrawal@gmail.com>
Date:   Tue, 09 Nov 2021 15:59:04 +0900
In-Reply-To: <20210917085343.2775300-2-punitagrawal@gmail.com> (Punit
        Agrawal's message of "Fri, 17 Sep 2021 17:53:41 +0900")
Message-ID: <87a6idak7b.fsf@stealth>
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
series.
