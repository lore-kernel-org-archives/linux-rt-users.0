Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CBDC7EE32
	for <linux-rt-users@archiver.kernel.org>; Fri,  3 Mar 2023 21:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCCVKB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 3 Mar 2023 16:10:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjCCVJx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Mar 2023 16:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EDC1BAF7
        for <linux-rt-users@vger.kernel.org>; Fri,  3 Mar 2023 13:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677877745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mfz1hJ8AL9LXpiPiehNov0ezHpeXs0Q3lHhQcPFh1aw=;
        b=d8KmpuRrzimwrbQgBaehaCchlOi3OY3hsEKevS+nH4AKU1vJECHxPbcQlCmdffEPPeNEOS
        Oqa/N0c1lh9dO9j4P/EvnWFqs1mXTMY1x0QnRBkqbiNZwGb2gJyrxw+Mnsy7kty8lo7Nsu
        BaM0p5dlfPaDfGKqzz/AqbmkDi03TyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-h6DF5OKLNwm8z9ZslBiTIQ-1; Fri, 03 Mar 2023 16:09:03 -0500
X-MC-Unique: h6DF5OKLNwm8z9ZslBiTIQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82D37101A52E;
        Fri,  3 Mar 2023 21:09:03 +0000 (UTC)
Received: from localhost (unknown [10.22.17.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 34225492C3E;
        Fri,  3 Mar 2023 21:09:03 +0000 (UTC)
Date:   Fri, 3 Mar 2023 18:09:01 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Aaron Simmons <paleozogt@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: preempt-rt + live patching + arm64
Message-ID: <ZAJh7aqeAY3NjR5x@uudg.org>
References: <CAAajkiYTEvxpV_Vg6rj6es=rJEidNEpEgWciY2TNqRqzVmb1MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAajkiYTEvxpV_Vg6rj6es=rJEidNEpEgWciY2TNqRqzVmb1MQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Mar 03, 2023 at 10:16:46AM -0700, Aaron Simmons wrote:
> I'm trying to bring preempt-rt into a kernel that has had
> live-patching for arm64 applied.  Specifically, this patch:
>    https://lkml.org/lkml/2021/6/4/1169
> 
> There's a conflict in some definitions of arm64's thread_info.h:
>     ++<<<<<<< HEAD
>     +#define TIF_PATCH_PENDING     7       /* pending live patching update */
>     ++=======
>     + #define TIF_NEED_RESCHED_LAZY 7
>     ++>>>>>>> 3fc990649e4f (PREEMPT_RT 5.15.93-rt58)
> 
> It appears that the TIF_XXX range is getting crowded. :)
> 
> Resolving the conflict seems straightforward -- I should just give
> TIF_NEED_RESCHED_LAZY a new value.  But I wanted to double-check --
> does the range of these values matter?

If the new bit youa re adding is used in _TIF_WORK_MASK amke sure it is
contiguous with the other bits in the mask. For reference:

    https://lore.kernel.org/all/Y8lCspFtQ0wg6uCy@uudg.org/

Luis
 
> I see over in 32-bit arm's thread_info.h a comment about the "range of
> 0..15" being important, but I'm not sure if that applies to 64-bit or
> not.
> 
> 
> Thanks,
> aaron
> 
---end quoted text---

