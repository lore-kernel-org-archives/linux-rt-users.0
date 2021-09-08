Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C92C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 14:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A7C60FDA
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 14:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349349AbhIHOly (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 10:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231164AbhIHOlx (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 10:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631112045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2Z0PBWopu+3sO7NUdS3G+HCB3x9ygJtSuqYXc07qQLk=;
        b=AEHYMf6xX8MvgPjRnZSsfscOfVNNq1COy2pmbz3sWErjjDq50Y1POD0GBxh47eId78bzzC
        SZYjWKei9SlTJ6GV5srusdwa0mxdEdRrqd9ElCZrf5sBC0Ke+VAAiUSvnv0T9e+nWAY2ph
        oCz7S+G5J2+0TeJp4qRhVfocl4XPbTQ=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-wvGSTVghOp2R0iS0-1opYA-1; Wed, 08 Sep 2021 10:40:43 -0400
X-MC-Unique: wvGSTVghOp2R0iS0-1opYA-1
Received: by mail-io1-f72.google.com with SMTP id i26-20020a5e851a000000b005bb55343e9bso1982151ioj.7
        for <linux-rt-users@vger.kernel.org>; Wed, 08 Sep 2021 07:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Z0PBWopu+3sO7NUdS3G+HCB3x9ygJtSuqYXc07qQLk=;
        b=qhkPVHVujdDrvJjUYNvt9I9vRg+1B4GccrVkh5R/LHP7MRHI8Q6WhFRC3wpNJBeHKY
         9RG3Fsvboukd27NsKI4cLcBqWOVNVjJYqKraME/7tuCGdqAJTDomjPXPQfoa5gwUj+h9
         YIWBnUHO9klPxcEeQYdBhKh/yoTFuMEXqIth3i49jm6ntgWuyT+QYB8ok8hVD6ZH115u
         ocyVdIMKNpm7L2/IwfJiVE7L8Kj7JNososly310yfEZLRwdNXNHJ2q/pwLTZ6X9kE+Sl
         A2gzIAPfF7ZNpPpLrD/SPUApW0Jh+OP+FmpdCVs6ygjJRu7rWhGx4Ahtq1oHn/J2vDF3
         IKdQ==
X-Gm-Message-State: AOAM532qJQdE9LCL9kblINqnkuf5QRaC8k2pyHAKm9BTBS/WosIPxRIL
        Inp8D9T9t1oWVaCklRvtQuHikuHajTtnuehoqd0MdsFk8nwnW/2ns1vXfbcJi1pkjUGZ8Ypp8OG
        2TEv65NGKIwhIiFPDOu5MXh8spTA=
X-Received: by 2002:a05:6638:14cf:: with SMTP id l15mr4070656jak.8.1631112043245;
        Wed, 08 Sep 2021 07:40:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyQ3CsgbENCyYZWlVzrKw8LOQTM00OVM+rgIkCqD0DXDY4Wkvqsv2cFJidl7OXcBJbBIqucWA==
X-Received: by 2002:a05:6638:14cf:: with SMTP id l15mr4070641jak.8.1631112043043;
        Wed, 08 Sep 2021 07:40:43 -0700 (PDT)
Received: from t490s ([2607:fea8:56a3:500::ad7f])
        by smtp.gmail.com with ESMTPSA id l1sm723584ilc.65.2021.09.08.07.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 07:40:42 -0700 (PDT)
Date:   Wed, 8 Sep 2021 10:40:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jkacur@redhat.com
Subject: Re: [PATCH 1/3] oslat: rename cpu_mhz/cpu_hz to timer_mhz/cpu_hz
Message-ID: <YTjLaZez4azBeYLI@t490s>
References: <20210908100209.118609-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210908100209.118609-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello, Nicolas,

On Wed, Sep 08, 2021 at 12:02:07PM +0200, Nicolas Saenz Julienne wrote:
> 'cpu_mhz' in oslat actually represents the frequency at which the high
> frequency timer we measure with ticks. There is no need for it to match
> the CPU frequency, nor will do on all supported architectures. So rename
> it to 'timer_mhz' in order to better match reality.

But right now "cpu_mhz" is indeed the cpu frequency per mhz, isn't it?  As I
believe that's how "time stamp counter" defined on x86. :)

I don't know what's the corresponding register for aarch64 to read the
processor clock cycles out, I did a quick google and it tells me PMCCNTR, but
I've no solid idea.  Or do you mean for some reason we can't read that info out
from aarch64?

Thanks,

-- 
Peter Xu

