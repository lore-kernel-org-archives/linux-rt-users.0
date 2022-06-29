Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2EFC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Jun 2022 17:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiF2RfL (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Jun 2022 13:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbiF2RfJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Jun 2022 13:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8347C28E18
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 10:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656524107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+sh2n6JO8uSzu4Thu8m+JkICT7gIsxqvxuzmnYKGy0c=;
        b=Md8LF46Y0N4KnFPdYvdpGplbHoSt2RzH7ssowWEDAnwdCWkugL6OjnYLgm9MyiyC8S9BfJ
        LdepAWUUSNy92a2wL6LaY7CnwbDKzgIvjXaPly90uk9wmozVcAIb4f/8PEJHYt/Dv6Tnm1
        cJLZoGRvAgXwb9KBIo7yUUeLrlN06rE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-569-osL_vEzyNjiWbFI6N9-ctQ-1; Wed, 29 Jun 2022 13:35:05 -0400
X-MC-Unique: osL_vEzyNjiWbFI6N9-ctQ-1
Received: by mail-qk1-f198.google.com with SMTP id g194-20020a379dcb000000b006aef700d954so16869770qke.1
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Jun 2022 10:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=+sh2n6JO8uSzu4Thu8m+JkICT7gIsxqvxuzmnYKGy0c=;
        b=UUTtSbl7YEC/48WLYrcfKcbXXMxHDxAhvQ7WD3/UMGt0i+0cB/fBO0IRo76gdRLpPo
         wsyHPFG/cqUpUeMHU3pmyB9FY7T7Tvd94ZRH89ssqz7AxdWVEFTylCssJ2ZNxPJUwwSI
         Smn7vlIH+/HsBUieAjaG+jOf8JY0DrOswN881TEiICesih5u1gqljeBAgaXYMOXTeG72
         FRipItAO8mt22m195gB1FZkO5d5pVQCBNhNHThOpT523toh/utv4P/hITKlUCRxpv88i
         kB3IRvg8WD2UqNG7EXuXMmP+2vpwyz+i8Yjdp+ieDmZchYpsizcUQ704IogUsUSg2TOI
         7n8g==
X-Gm-Message-State: AJIora8H4LGOHb69/LTLDA7CmkbzAzlWbAOqHVolB6RsreUqN7m3KQFY
        CXSG18tUMR/pV9razG6xVAEPdbHH5cOUsTnDwShwjbuQFNApq6LpNU6ORssHwlmnDF5CLKHmKeZ
        tmSxduJ5Yqy2F1YZagEYB0PqN0g8=
X-Received: by 2002:ac8:75c5:0:b0:31a:f72e:df35 with SMTP id z5-20020ac875c5000000b0031af72edf35mr3539729qtq.361.1656524104631;
        Wed, 29 Jun 2022 10:35:04 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sKXwKjRC1cOYiy8Dlpb078QgCZIXKWeo1W4l42MF9tTE4uHRAfFqzV0WwbZN+vkyOetj5xNw==
X-Received: by 2002:ac8:75c5:0:b0:31a:f72e:df35 with SMTP id z5-20020ac875c5000000b0031af72edf35mr3539711qtq.361.1656524104440;
        Wed, 29 Jun 2022 10:35:04 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id q11-20020a05620a0d8b00b006a32bf19502sm13266894qkl.60.2022.06.29.10.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 10:35:03 -0700 (PDT)
Date:   Wed, 29 Jun 2022 13:35:02 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <wagi@monom.org>
cc:     Song Chen <chensong_2000@189.cn>, linux-rt-users@vger.kernel.org,
        williams@redhat.com
Subject: Re: [PATCH v2] sched_deadline/cyclicdeadline add tracelimit
In-Reply-To: <20220629170304.abppmxmie7yq3kmh@beryllium.lan>
Message-ID: <30f526bd-20e3-606a-e56-33342a55fe0@redhat.com>
References: <1655448052-12537-1-git-send-email-chensong_2000@189.cn> <20220629065848.zpppngaem7qqazzf@beryllium.lan> <8d2bbda3-492-a5c9-4efc-722bddbc7bf6@redhat.com> <20220629170304.abppmxmie7yq3kmh@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 29 Jun 2022, Daniel Wagner wrote:

> On Wed, Jun 29, 2022 at 11:34:40AM -0400, John Kacur wrote:
> > @Danel Wagner, is that just a comment or would you like a Reviewed-by ?
> 
> I just noticed that several option have been added to various tools an
> no one cared to add them to the manual patches. Makes a bit sad after
> spending time syncing all man pages up.
> 

Thanks Daniel
I should start requiring that before I pull in patches.

John

