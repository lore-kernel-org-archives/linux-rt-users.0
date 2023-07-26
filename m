Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27A4C0015E
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jul 2023 15:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234465AbjGZPPq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jul 2023 11:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234930AbjGZPP0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jul 2023 11:15:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D333C0C
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690384381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kLDwsn7PR47my1Mi6W/SZKiXszm7iofaqJ9tjAQzE+Y=;
        b=EJBOgyEbvCpkYuvfDDYd/b1RoPgV+yJpoBegRJQn9LlnlniTXgTa9OUOGkJ35StRzlNI+L
        ecm0+ZdT6aZenRny0gGQywAMNmH5hgVVUacD0tvRNjO5Ck4p7b5FlGxCcSWXJoyZhxzIv4
        8JgyVuDS+HQN8NcJ3E+s0BV+lPePryk=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-KKcvC3HrMlidcd4u0nDqGg-1; Wed, 26 Jul 2023 11:06:34 -0400
X-MC-Unique: KKcvC3HrMlidcd4u0nDqGg-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a4261fc598so14458994b6e.2
        for <linux-rt-users@vger.kernel.org>; Wed, 26 Jul 2023 08:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690383993; x=1690988793;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kLDwsn7PR47my1Mi6W/SZKiXszm7iofaqJ9tjAQzE+Y=;
        b=e7v1UgfKUaZ0X0T1N2lQLJ3RWjnga7twXUQaB4hZkuldb4cS00r1qJSF9WSlh8ZrPf
         5b8G6eb6HNuWins5FhZG4fw7P1kZLHJsa3iOVSvjTRkmlvrCBevtBn825CZJT4g/Lid+
         A28s+2aYF5pMkf/up/hsrBLxzLWoWDPVE92pLP+SasCgtqMCTbVoX+LPTxnJkeLatrzU
         keI3b+7bNBuqdEOPS0meFiCupS+E0ZqepP3lDznL/TZCvFOeOc9xK3PCLQQ9KVCaHKbx
         9N8UHR/MWgZzX4H+BRR5mJfVyDhdQwFf1BJYwPH7pIWv8ZS8Caiw8U6YjiTQ8JlkL80B
         1Rqg==
X-Gm-Message-State: ABy/qLZgGsEDr9kudPP3eVIZql4gml8ZXmn0tT0qGiVkeyDFwmQw36hd
        gaHRicJAqj+4mBZlYgl8YDV+0ZC5jV+cmc/+VqMQQbJIfI+2y/Bz7hYKwnXPZkVidsGrAQNw3tr
        4RM6nemQx7AtV+epNnwAN4cXeZBQ=
X-Received: by 2002:a05:6808:2189:b0:39a:bd0e:43d with SMTP id be9-20020a056808218900b0039abd0e043dmr2949737oib.36.1690383993448;
        Wed, 26 Jul 2023 08:06:33 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHiACBmrV+ZermeCZHOmyGxhQsRPbJiPOTK6DF7B0NeYLiLjWreNwiELj/McoFQyeOTQ4VOgw==
X-Received: by 2002:a05:6808:2189:b0:39a:bd0e:43d with SMTP id be9-20020a056808218900b0039abd0e043dmr2949721oib.36.1690383993228;
        Wed, 26 Jul 2023 08:06:33 -0700 (PDT)
Received: from fionn ([184.147.142.236])
        by smtp.gmail.com with ESMTPSA id k9-20020a0cf289000000b006263a9e7c63sm3082862qvl.104.2023.07.26.08.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 08:06:32 -0700 (PDT)
Date:   Wed, 26 Jul 2023 11:06:23 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Anubhav Shelat <ashelat@redhat.com>
cc:     linux-rt-users@vger.kernel.org, kcarcia@redhat.com
Subject: Re: [PATCH 0/5] Cover letter
In-Reply-To: <20230726144826.355643-1-ashelat@redhat.com>
Message-ID: <3c36af3-2345-ddd-de9-922d7af9b1@redhat.com>
References: <20230726144826.355643-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 26 Jul 2023, Anubhav Shelat wrote:

> Added SPDX licence to python files in python-linux-procfs
> 
> Anubhav Shelat (5):
>   bitmasklist_test: Added SPDX licence
>   setup: Added SPDX licence
>   __init__: Added SPDX licence
>   procfs: Added SPDX licence
>   utilist: Added SPDX licence
> 
>  bitmasklist_test.py |  1 +
>  procfs/__init__.py  | 16 +---------------
>  procfs/procfs.py    | 14 +-------------
>  procfs/utilist.py   | 14 +-------------
>  setup.py            |  1 +
>  5 files changed, 5 insertions(+), 41 deletions(-)
> 
> -- 
> 2.39.3
> 
> 
Thanks for the patches, however, this is the wrong mailing list!
Please send them here instead.
https://lists.fedorahosted.org/archives/list/tuna-devel@lists.fedorahosted.org/

John

