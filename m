Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB104C43334
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Jul 2022 16:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbiGGQ6D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiGGQ54 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Jul 2022 12:57:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 069EC2D1F4
        for <linux-rt-users@vger.kernel.org>; Thu,  7 Jul 2022 09:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657213075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b5Se+ncO6ecEP2j0IGRLm2ErCWYimTOfWI6Y6AOlL5w=;
        b=R3owD50aAWyFvi+unNu7ZTDeC57bZ3/BSorHwyoqwBaHWSlr1AIlm0/eWdM0qz7MCqhaZl
        yZNyI08u7l2SWyjw4LbnHuIKQ4iC35HeSq1Twk6zLVg1ytA3CLo0jomz2wveS9Bk7R7aFL
        OyPa09wWEoviz2h5GdmGnzTValoxe6k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-1r89z-kXM3qrjqkr29sl7A-1; Thu, 07 Jul 2022 12:57:53 -0400
X-MC-Unique: 1r89z-kXM3qrjqkr29sl7A-1
Received: by mail-wm1-f70.google.com with SMTP id a6-20020a05600c348600b003a2d72b7a15so103601wmq.9
        for <linux-rt-users@vger.kernel.org>; Thu, 07 Jul 2022 09:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b5Se+ncO6ecEP2j0IGRLm2ErCWYimTOfWI6Y6AOlL5w=;
        b=LhkRlAq3MQHOg5a4nzzUFEJ3JtxPbqVjUVk7RzS2kgU8/IFZdkpK1Xr72tNMIkVbaw
         5Hq0YpjvxOhGTa/Axjn0qYvwB1k2MUb4VHJYwNwq+Eo2QQG23AnW3nETyJQiwO1oPnsz
         V1HlexCM0G7f8LMhAypqoSAj9uiNUhnBeMRVrjcvfOtJhwko6NQMcUEnqsD0CbEINvr8
         0m23z3I5+q76uXd5PZz6OLISGdR77+dY4pKiY4PUJXGAs1BS+kwFtXBTxcBOzdVzx109
         RipVCBm5dwzJYQcU0DoAMw4lmIASDNB5y+U73AxZtY9TNBif0rJflwqRqbaZB88/gLaC
         2L9g==
X-Gm-Message-State: AJIora94pVcvNq+XlTVhHLA+u2KDpgaAYK6k40h2VhXNRq5pJAqpyYjU
        d6Uxms0VgqV69Jy/eEUnWYWdc23xsmIzCEr7xdfshKsKVSFyphuS8JzGTG1nQbV+zF7760Nid/G
        Sy1TQRQ5n7IveJhJwb2DG/v/M9Q==
X-Received: by 2002:adf:f304:0:b0:21d:7656:83e5 with SMTP id i4-20020adff304000000b0021d765683e5mr14230061wro.407.1657213072537;
        Thu, 07 Jul 2022 09:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sigDFIJcjtmUc1O7k0RVKhIrrr7aDHeemIxnkS8BpfHtXpLin1X8wgxmCtbkdtLWp+U6eoIg==
X-Received: by 2002:adf:f304:0:b0:21d:7656:83e5 with SMTP id i4-20020adff304000000b0021d765683e5mr14230040wro.407.1657213072309;
        Thu, 07 Jul 2022 09:57:52 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id x2-20020adfdd82000000b0021d62e30a62sm14742505wrl.50.2022.07.07.09.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:57:51 -0700 (PDT)
Date:   Thu, 7 Jul 2022 17:57:50 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     rostedt@goodmis.org, cl@linux.com, pmladek@suse.com,
        mbenes@suse.cz, christophe.leroy@csgroup.eu,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, oleksandr@natalenko.name, neelx@redhat.com,
        daniel.thompson@linaro.org, hch@infradead.org, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] module: kallsyms: Ensure preemption in add_kallsyms()
 with PREEMPT_RT
Message-ID: <20220707165750.tk4fadpv3d4zr2mb@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220704161753.4033684-1-atomlin@redhat.com>
 <YsXNVSAtO+VDggcI@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsXNVSAtO+VDggcI@bombadil.infradead.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed 2022-07-06 10:58 -0700, Luis Chamberlain wrote:
> Hey Aaron, thanks again!

Hi Luis,

No problem :)

> On Mon, Jul 04, 2022 at 05:17:53PM +0100, Aaron Tomlin wrote:
> > To disable preemption in the context of add_kallsyms() is incorrect.
> 
> Why, what broke? Did this used to work? Was the commit in question a
> regression then? Clarifying all this will help a lot.

Sorry for the confusion! If I understand correctly, nothing broke
intrinsically.

Rather with commit 08126db5ff73 ("module: kallsyms: Fix suspicious rcu
usage") under PREEMPT_RT=y, by disabling preemption, I introduced an
unbounded latency since the loop is not fixed which is generally frowned
upon. So, I would say this was a regression since earlier preemption was
not disabled and we would dereference RCU-protected pointers explicitly
i.e. without using the more appropriate rcu_dereference() family
of primitives. That being said, these pointers cannot change in this
context as explained previously.

Would the above be suitable - just to confirm before I send another
iteration?


Kind regards,

-- 
Aaron Tomlin

