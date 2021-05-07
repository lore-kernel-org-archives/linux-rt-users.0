Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2EBC433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E55C61460
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbhEGQdU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbhEGQdO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:33:14 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D04FC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:32:14 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id k127so9031667qkc.6
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ajBH5YG5RWHGqvgCkZb40f1vKnteiPuuLoDhYz5mvdU=;
        b=cfs/pVIoMHhdZDnQF62ADgzRDcVfK4zeidvABF681IOTbepWWmlHBQXuI6fJQlN665
         +dVMeH5Y4rmFtcitubK2wnrJEaGVdFC06T9oKlDkni5u3K6H7Gjq4kyMRw/vKUWLxrD7
         N/3yCzyUxPP2hM+ocvsJOTfdrqQusVWNLyt9xk9dpONsZdW+iTU35XO6O3qVGH6wZWbs
         8EgkkaeesnZUVjf6GcnnLs/AeNIZF0VJ+o4mg0DLQeeqJu5syNU3byCsyefv2GB763JI
         Xg7UdVfx7DajZOH8kr76r97kcstgfClASSYKAeLM4WusZ1EoJxhZZN72xGJh+0Eu8w1y
         pV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=ajBH5YG5RWHGqvgCkZb40f1vKnteiPuuLoDhYz5mvdU=;
        b=FKHtiMcB0K8Wzm5uDK2WakM+O0GD+1QrfOtYxLB5n79ogvC3ts1nL0O3xZCRLedMEC
         TVEgUol6icVnwZGcZ/ULAlo32CBQSNjj1kU8+bdyIHepn1nPLmjpUUR4/Gxexachkwnl
         gHyQPFd2G7s6lhRYtk2lZsMbInmx1GCy+BRQ70+9VCkqZXfal9iwIjc/i7OaHpocmb9W
         udwjLXauhvAczUo+CSLjYHgusA1wUPPkRGUm0vKesvkTh8nNLplZSfppyXrjAdgpfWyX
         AS9T0CWhHuZJjBVxne1lmCX6wB51Mc4zxOynGZ3wza9COIYfTEXBkm+/YRy4LgPVTVAN
         sJ5Q==
X-Gm-Message-State: AOAM531WnhGBt7Tuij2cXBYyxbMHhvOs1miK0fQHKUDZS1B6JdsmAc3i
        VFn1XG62EUnYAX/wU9fY0SQ=
X-Google-Smtp-Source: ABdhPJzHTrwDivmwnE9va10jBDBy6D51WXMr5aLdh5TKvuP18SzdXshxcGO+IbcS0zVD/PEsq6lAVQ==
X-Received: by 2002:a37:65ca:: with SMTP id z193mr10110283qkb.409.1620405133318;
        Fri, 07 May 2021 09:32:13 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id d19sm4980141qtd.29.2021.05.07.09.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:32:12 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:32:12 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 11/33] signaltest: Initialize rt-util
In-Reply-To: <20210320183829.1318-12-dwagner@suse.de>
Message-ID: <d6cd37a2-2f29-7e79-b04a-d66470723c0@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-12-dwagner@suse.de>
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
>  src/signaltest/signaltest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index e2ffc0bb8693..4da8436e4296 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -414,6 +414,7 @@ int main(int argc, char **argv)
>  	int status, cpu;
>  	int max_cpus = sysconf(_SC_NPROCESSORS_ONLN);
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
