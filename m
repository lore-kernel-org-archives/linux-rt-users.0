Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0165FC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D8361451
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238171AbhEGQ3n (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbhEGQ3j (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:29:39 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63321C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:28:38 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 5so1130997qvk.0
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=aBq+YcwG6yCVNLuBcqAThz47g9KTdpaYLMvD4ueq+v4=;
        b=KZH0fiZJLPwUOQZeZOJb3TX+cfE8DheXFU/Wgfx80HmknP9bfma58LGxjOhPVe4xMI
         CUL0ao6JurqnccFw+8rxTuNKb/Q6eJ2j/F5AKIEVngXZEnEsczzSTGDfe7YUSCCJ0uKs
         Lo/nFCmptXK6XN7fyzy8XhNXTyysY98g83GAo3Hm518o2kEn6lsR1mt6FGrbGtdo1PPT
         MTQWYE4bTlIdd9xfBsfeOGCPzDaLsN9A12vzQk30Nm2OUEfbHEUkYNItk5qMNsTxDxlZ
         Aw0Gou+Ds8TmwnEejFBJw/ftzgnZUwc0fqUKgmyPrz1Zme3A0y3keUL8gVxZuHY9muKj
         U/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=aBq+YcwG6yCVNLuBcqAThz47g9KTdpaYLMvD4ueq+v4=;
        b=dlW1xriOPHZfUULhr0E6zhlwdUkA1LdvxW4BM4S3rPP1gZARrX9rnogzuEY+3bVp7N
         sQowymG34Fz9XQnfOvsBkPyoAIhWLHOpddwr0oJmFhYmhkNqgFP0i8IVgu0hk7D0W0HF
         u1Nn0KIPWZjise+NC6TGbIa6HDHGSe+PiOb0js8OImvJBqmjnI5PWahAmpSD9T0ffeF/
         ZaOFuFFZBTNSmtSSt+rLPkYnbILO8qi6o6tHolgEZnW7SWBd7oRPkSk65y+oSxhshxTC
         D1zoPuupZqPwKWc+H7NkKgaPRw0pjbosgf8kLRL999QKYdNpRXrSfLCSgl1dD9FDiMNw
         ilbQ==
X-Gm-Message-State: AOAM531TAFFrXOVYg0m07k5UatHDIuT0Zk2VZ8FAK9yJmPAgB83xNbRf
        q5LBxl3bb4VxnzqmSNxr/eY=
X-Google-Smtp-Source: ABdhPJy/2I3KP62OYWEylxMu8inM5ZzwnqJwh5yr5fhKMAmx3GtCxro9BfsN41uUgB1vyV7J9/Jkxg==
X-Received: by 2002:a0c:bd2b:: with SMTP id m43mr10781816qvg.52.1620404917712;
        Fri, 07 May 2021 09:28:37 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id a20sm5100896qko.36.2021.05.07.09.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:28:37 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:28:36 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 05/33] cyclictest: Initialize rt-util
In-Reply-To: <20210320183829.1318-6-dwagner@suse.de>
Message-ID: <2757e864-d52d-14e7-9162-3a62f153f21@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-6-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Allow rt-util make a copy of the command line.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/cyclictest/cyclictest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index c43dd7cbbd64..e817af217952 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1778,6 +1778,7 @@ int main(int argc, char **argv)
>  	int i, ret = -1;
>  	int status;
>  
> +	rt_init(argc, argv);
>  	process_options(argc, argv, max_cpus);
>  
>  	if (check_privs())
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
