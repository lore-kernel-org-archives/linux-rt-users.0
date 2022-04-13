Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63613C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 13 Apr 2022 15:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiDMP0F (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiDMP0E (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 13 Apr 2022 11:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CC6247566
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Apr 2022 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649863421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qA1prfIALV2uYNqawseimiIaCav6Y48cmwk5I4FAyQs=;
        b=H4NtO4gwSg80CjOT579ObQy5aBb9DEnlilbeCBF4lCZzeVbL/wnkOO0/bb8+/JVOUj/jux
        7MD71D83meCRznF1QYCp2x6A5ddgvLQ/GoN8w7tZTrrGRsyX6YWYTdymH0tyVMhJz3a4Sg
        vg+pvXXvYmFGGxdpUSxxh6obUIhmBj0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-dzWC9sP8O-6SwckepRd4IA-1; Wed, 13 Apr 2022 11:23:40 -0400
X-MC-Unique: dzWC9sP8O-6SwckepRd4IA-1
Received: by mail-qk1-f200.google.com with SMTP id bq12-20020a05620a468c00b0069c6527969dso411795qkb.8
        for <linux-rt-users@vger.kernel.org>; Wed, 13 Apr 2022 08:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=qA1prfIALV2uYNqawseimiIaCav6Y48cmwk5I4FAyQs=;
        b=QSqk/nWt0edpIKCtQv/DEkSQfLpB04VVOWH4v4N3uEv6UsSdD21HQUhs/wbxxr94tc
         0XQYrBQ7Fz+WQHhrB44/xxM68JieoGwHLaOcLe6EXJ0OEWkLmDltaE+7fUdWV5ShatvS
         0qJUaUQ4jKxYUszMwzistNkw/PtShcWQFdxqhJZcbOwWzJ7rD/gf29lHzZ+UgVCTWq/A
         /padk0J/QaARCtSLYHd27vrNC6H4HH5fGYOXWHlGDHPZWeUGpAUQ+PBKADm6GtRV4s+a
         kHFI17Io+v/7uNRG57jM9HYTTdNurn3fIdYqCn51UyXdfAQLMbYM7hRqzNy1xJUdOa3J
         FdKQ==
X-Gm-Message-State: AOAM530bk8qxFtNMdJFjAPtiuhEqkABwrYBzylsNUxSk2U77mIdQuoqN
        0UXOmB9cC8d2OAbBIpCjEmxx4V04DgbVCKUVfnI3gYlkwaqpdAra2KXH/w/+b2W9Lv0NUzd6Pdw
        5UuDX2g84I2k7nm1ERnHKzPQvEko=
X-Received: by 2002:a05:6214:1bce:b0:441:2d37:1fd1 with SMTP id m14-20020a0562141bce00b004412d371fd1mr35857276qvc.10.1649863420116;
        Wed, 13 Apr 2022 08:23:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgvjqtyPbch4MDv6qpZMX38M7aI0oa8yDpKNYEDip9NYiHbhzW/lgehCpjePRv5Dgh15B6OQ==
X-Received: by 2002:a05:6214:1bce:b0:441:2d37:1fd1 with SMTP id m14-20020a0562141bce00b004412d371fd1mr35857215qvc.10.1649863419358;
        Wed, 13 Apr 2022 08:23:39 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-127.dsl.bell.ca. [174.88.121.127])
        by smtp.gmail.com with ESMTPSA id l19-20020a37f513000000b0069c5807ff10sm985701qkk.27.2022.04.13.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:23:37 -0700 (PDT)
Date:   Wed, 13 Apr 2022 11:23:36 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
cc:     linux-rt-users@vger.kernel.org, peterx@redhat.com,
        williams@redhat.com
Subject: Re: [PATCH] oslat: Print offending cpu number when above threshold
In-Reply-To: <20220412135518.531234-1-nsaenzju@redhat.com>
Message-ID: <73d8acad-92e9-2f4-71eb-de38e4b24375@redhat.com>
References: <20220412135518.531234-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 12 Apr 2022, Nicolas Saenz Julienne wrote:

> Knowing which CPU went above the trace threshold is useful information,
> even when not tracing. So let's print it.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>  src/oslat/oslat.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index aa0e9a7..55302f1 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -334,10 +334,10 @@ static void insert_bucket(struct thread *t, stamp_t value)
>  	assert(us > 0);
>  
>  	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
> -		char *line = "%s: Trace threshold (%d us) triggered with %u us!\n"
> +		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %u us!\n"
>  		    "Stopping the test.\n";
> -		tracemark(line, g.app_name, g.trace_threshold, us);
> -		err_quit(line, g.app_name, g.trace_threshold, us);
> +		tracemark(line, g.app_name, g.trace_threshold, t->core_i, us);
> +		err_quit(line, g.app_name, g.trace_threshold, t->core_i, us);
>  	}
>  
>  	/* Update max latency */
> -- 
> 2.35.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

