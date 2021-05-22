Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDABAC2B9F2
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985DE613DF
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 May 2021 03:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhEVDqo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 May 2021 23:46:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231179AbhEVDqn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 May 2021 23:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621655118;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PT/UOA2Ey8aYOfmneXxbVDNYkZZpvwtuk4GhgN45YzA=;
        b=C9s1dtFSgKYYsQ3pBzEPs5WbhFNM3BS5PVyLVad/Il3M8phr1RuI9rEZMk9cwsEHHrmBKT
        gD56v0aj131nkueMupoEizkFgz8XmjpKLsvt6kQ9X1udcLW5/4ToOhgxX9nhh7RxaUKV4z
        k3Zmr6PFtTdspahfFi3TX7UH3//el6c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-OfCF3wIwPfqmaH7vT--GWA-1; Fri, 21 May 2021 23:45:17 -0400
X-MC-Unique: OfCF3wIwPfqmaH7vT--GWA-1
Received: by mail-qk1-f199.google.com with SMTP id s4-20020a3790040000b02902fa7aa987e8so18797142qkd.14
        for <linux-rt-users@vger.kernel.org>; Fri, 21 May 2021 20:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=PT/UOA2Ey8aYOfmneXxbVDNYkZZpvwtuk4GhgN45YzA=;
        b=dSNffjjytcn0ibWllvVUeHpd63THGyFWJGUlaAvIesWgGZdtvtLz73zl0uFuQ+FH+2
         PHS/n7osBQbZ3IVlFQ0LODBeEn5Y9G2eVYhnu3SXkSGJRuw4xXGLVxW8Qvn3PJHjiPxO
         KBLGpv3TJbGtH91GsnYK8HGurx0h/qf0dS//4kQ3HBO6Cwk2gKm6TJ8T5QYaF2kuX0z9
         /7Tu3Pr11MGsgWBzxUZaey5QY+mBphfIhgsgr3707DH8h3829W228Ab2laogcHmVBOSC
         uCOHhDFAEShvWAhgbr/DxTbnG0Fj9aGii9/D9XGhe3L9om8AwTPoKbLKlogN1mhBgrDm
         yTIQ==
X-Gm-Message-State: AOAM530rdeu7PcYQTZd9UnZbYXMw45u21LGiTAJERIxG9RSfsaLEXo36
        8Biyi1G5Tun/D4mxFyetWshj7O63qB5cNKj4Atyp/sDbBl406DR4Wf8TgMKDExmFhsz8UDYx4U2
        xR34Jj4/NY1oM8uOF39i0KgoTXSY=
X-Received: by 2002:a37:f612:: with SMTP id y18mr14858382qkj.436.1621655116587;
        Fri, 21 May 2021 20:45:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyy27ZWLiftJbVmRiBEr0iOwP7sX1lATW0cbwT3MyQex2v0C+DxpItefoPlY4pPvjMajKUXg==
X-Received: by 2002:a37:f612:: with SMTP id y18mr14858374qkj.436.1621655116451;
        Fri, 21 May 2021 20:45:16 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id v66sm6104077qkd.113.2021.05.21.20.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 20:45:16 -0700 (PDT)
Date:   Fri, 21 May 2021 23:45:15 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 18/23] rt-migrate-test: Add --json to man
 page
In-Reply-To: <20210519170945.21941-19-dwagner@suse.de>
Message-ID: <a1f69d7e-d31e-df73-27d0-d178842201a@redhat.com>
References: <20210519170945.21941-1-dwagner@suse.de> <20210519170945.21941-19-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 19 May 2021, Daniel Wagner wrote:

> Add the newly introduced --json command line to the man page.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/rt-migrate-test/rt-migrate-test.8 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/rt-migrate-test/rt-migrate-test.8 b/src/rt-migrate-test/rt-migrate-test.8
> index 5bbacb5333b8..53670e3757fa 100644
> --- a/src/rt-migrate-test/rt-migrate-test.8
> +++ b/src/rt-migrate-test/rt-migrate-test.8
> @@ -5,7 +5,7 @@
>  rt-migrate-test \- real-time task migration program
>  .SH SYNOPSIS
>  .LP
> -rt-migrate-test [-c|--check] [-D|--duration TIME] [-e|--equal] [-h|--help] [-l|--loops LOOPS] [-m|--maxerr TIME] [-p|--prio PRIO] [-r|--run-time TIME] [-s|--sleep-time TIME] [NR_TASKS]
> +rt-migrate-test [-c|--check] [-D|--duration TIME] [-e|--equal] [-h|--help] [--json FILENAME] [-l|--loops LOOPS] [-m|--maxerr TIME] [-p|--prio PRIO] [-r|--run-time TIME] [-s|--sleep-time TIME] [NR_TASKS]
>  .SH DESCRIPTION
>  Test real-time multiprocessor scheduling of tasks to ensure the highest priority tasks are running on all available CPUs
>  .SH OPTIONS
> @@ -31,6 +31,10 @@ Use equal prio for #CPU-1 tasks (requires > 2 CPUS)
>  Display usage
>  .br
>  .TP
> +.B \-\-json=FILENAME
> +Write final results into FILENAME, JSON formatted.
> +.br
> +.TP
>  .B \-l \-\-loops=LOOPS
>  Number of iterations to run (50)
>  .br
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

