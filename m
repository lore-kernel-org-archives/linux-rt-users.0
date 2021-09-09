Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8578FC433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60859610E9
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 18:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242783AbhIISHE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 14:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231431AbhIISHD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Sep 2021 14:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631210753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M34VSFok6fU9lkZEVFXK9h9xRLzuLfo1QX+EOqmOROQ=;
        b=Ab+TSirXoyFMcCsiwRsApPv70XNfURc1gFUxlZ02ORgoMuFaBzOqgwqYSwKIuf1OvoXtU4
        //d93zp2SvjVJ4lAedrL4+DA0R9uWlqOwU2uoZfoStGids/dBUPHtXPjp+IkT6HmXHM+OW
        EaWRRYNbwVUUX6ZH6EVdlQlRRS51J34=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-dLIxCZBFMqmYlbDxICJmAg-1; Thu, 09 Sep 2021 14:05:52 -0400
X-MC-Unique: dLIxCZBFMqmYlbDxICJmAg-1
Received: by mail-io1-f72.google.com with SMTP id n8-20020a6b7708000000b005bd491bdb6aso2553019iom.5
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Sep 2021 11:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M34VSFok6fU9lkZEVFXK9h9xRLzuLfo1QX+EOqmOROQ=;
        b=abL01D7Ssg6e0zmpso1S2PNKkq3fByRiMYcm3K3hqubzRf/9UfaGWAmxoNDsvIq0DG
         ULaRLn7MC8juBaWHRyq61vnoZu9EKxC3O6pKW9wx5nulaHdXUDtXFramM4t1tVO6lh32
         vN3u3C53AMKywU7gqwsTngoXSj6dSlxX2MGOclOShjV2YxZe3l2F8SQ7PM3N8tEwj6x+
         eckG1d/qv5j2ndh5ODEX/B2LC0OlHCcf6/21iCmg9y7sJHvhZd/ooEPVLlDqbh/dL53A
         y2bOON+jQBYkR4LS2jkCX1tqoVXiZN5YVu6NDyJhJKr3KiztOfcexhqwaQXoywgNGK7F
         aPwg==
X-Gm-Message-State: AOAM530tceBH1WUMDQChXHOHn91+ym3wqjVbiHDuvUGolvLGvbUYDpO7
        AyF2LNF0nsh+GJoQNjy7KsI2qy0uQbrUSaZbnKx6H4E3vMlU9Bj2huZoSBxEyWLlYFn/9yyGlcJ
        3R1gdqitmjTIaIZsdqwc9XaapYj8=
X-Received: by 2002:a02:6d10:: with SMTP id m16mr1038684jac.60.1631210751323;
        Thu, 09 Sep 2021 11:05:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD/oG20/1yYVkcpNtlyRGwwTBsLxP3aLjfqj509dcAV31vYdItintm8HJ05+wbVJYClVfc/w==
X-Received: by 2002:a02:6d10:: with SMTP id m16mr1038670jac.60.1631210751114;
        Thu, 09 Sep 2021 11:05:51 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id r18sm1278225ioa.13.2021.09.09.11.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 11:05:50 -0700 (PDT)
Date:   Thu, 9 Sep 2021 14:05:49 -0400
From:   Peter Xu <peterx@redhat.com>
To:     nsaenzju@redhat.com
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 1/3] oslat: rename cpu_mhz/cpu_hz to timer_mhz/cpu_hz
Message-ID: <YTpM/R3zv7RQDwYt@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
 <YTjLaZez4azBeYLI@t490s>
 <dc800f41878a9240cc9b9629ed1a4c1551514fac.camel@redhat.com>
 <YTj4Pb0peVbzFQQa@t490s>
 <c6f2c1e5f3b41714349373278b64aac91c5c35fc.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c6f2c1e5f3b41714349373278b64aac91c5c35fc.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Sep 09, 2021 at 11:41:22AM +0200, nsaenzju@redhat.com wrote:
> How about 'counter_[m]hz'? If not I'm fine with 'clock_[m]hz'.

'counter_[m]hz' looks good to me too.  Thanks.

-- 
Peter Xu

