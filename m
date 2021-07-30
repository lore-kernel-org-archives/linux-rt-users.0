Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68CBC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 03:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869B660EB5
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 03:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbhG3DFA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 23:05:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232725AbhG3DFA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jul 2021 23:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627614295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u1aJvhb/LGgbYaz7lG4GfWvYRcxIaDmmwhpx62PdZ30=;
        b=GiGap75yXG3qGjsSktjvobTTsgT1tNIhq9TzfvkMpcLklv6ObcFuJ50nYpvopMHsUSpxnU
        PzWnsDyH+x0JeS++GY6NRcTZRtsl+wWcaPoQVvh6bPcuFWcbTXH5TKtVoQbqdHt15T6AlW
        +iI2qTXP/nQiudclB2QhjIHrQVzAgjo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-iJbaEnDCNBGvJUXfM5_5Ng-1; Thu, 29 Jul 2021 23:04:54 -0400
X-MC-Unique: iJbaEnDCNBGvJUXfM5_5Ng-1
Received: by mail-qt1-f200.google.com with SMTP id o7-20020ac87c470000b029025f8084df09so3691519qtv.6
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Jul 2021 20:04:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=u1aJvhb/LGgbYaz7lG4GfWvYRcxIaDmmwhpx62PdZ30=;
        b=LhFelgfUSB+GNWQBUYaPjMxlq+AJoOxful/+eiysTknqOdZFSogP/FUg0XECmHyN1i
         zs8+5ouuqCzxR7foDaamuIFHUeymXzNEnFr+yLU7VL0f0IZKCEHgIXE7R/xbmI2SiSDY
         3zD1KNeOrSFFGJFciZ2Ndzi3AkWI2eOrH8lxq93RmsvlWPg2HTJcP41I4GWrrd1xHRob
         3C4DYuolLxRgpeT7nJqblebeUj/qoihAfR/7TphBKNyq1ieQlXe/SYCdbnIoTVj3tjNu
         PFnYHstoyFa6+rimLV5GQENtzDiTdwbR2fws68DdXx+lAh+woqpMVWF25bJ827Utvnr9
         Og6g==
X-Gm-Message-State: AOAM530AeW60F0+960WjgNVIlzl9ADWkRQWbwH4mGnBWPQcC7xklsb+C
        VGeQNL9ADWXKzo86Mra/9ghLj4v2qd1qT7cLMIZJvBI3uD3o6wfABRAswY+qu492GMonLDe3/Ew
        yodfEyDDe12pA9sTnGnJVZZ2TARY=
X-Received: by 2002:ac8:479a:: with SMTP id k26mr492457qtq.119.1627614293430;
        Thu, 29 Jul 2021 20:04:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyN6ql8dRJ6NchSHuIaxItdcP4seCljCecHg2ZhxKiEIMj4XoeEADVoRLBqkHghcRxI51ecaQ==
X-Received: by 2002:ac8:479a:: with SMTP id k26mr492448qtq.119.1627614293253;
        Thu, 29 Jul 2021 20:04:53 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id g76sm213733qke.127.2021.07.29.20.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 20:04:52 -0700 (PDT)
Date:   Thu, 29 Jul 2021 23:04:49 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Jeff Epler <jepler@unpythonic.net>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Subject: Re: [PATCH] rteval: Add __contains__ in rtevalConfig
In-Reply-To: <20210730005457.c5kog456adkun4bd@unpythonic.net>
Message-ID: <f2c80c7-3c3-f2b-203c-689c3793bf6@redhat.com>
References: <20210729220713.822137-1-jkacur@redhat.com> <20210730005457.c5kog456adkun4bd@unpythonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 29 Jul 2021, Jeff Epler wrote:

> On Thu, Jul 29, 2021 at 06:07:13PM -0400, John Kacur wrote:
> > Add the __contains__ function to the rtevalCfgSection class  to make "in"
> > function correctly.
> 
> Thank you.  A possible correction:
> 
> I believe the correct implementation (to delegate the 'in' operation to
> the dictionary-like object self.__cfgdata) is
> 
>     def __contains__(self, key):
>         return key in self.__cfgdata
> 
> I mocked a bit of rtevalCfgSection with your implementation:
> 	class rtevalCfgSection:
> 	    def __init__(self, cfgdata):
> 		self.__cfgdata = cfgdata
> 
> 	    def __contains__(self, key):
> 		if key in self.__cfgdata.keys():
> 		    return self.__cfgdata[key]
> 		return None
> 
> and then tried it with some carefully chosen values
> 
> >>> d = {1: 'x', 2: 'y', 3: None, 4: False}
> >>> r = rtevalConfig.rtevalCfgSection(d)
> >>> 1 in d, 1 in r
> (True, True)
> >>> 9 in d, 9 in r
> (False, False)
> >>> 3 in d, 3 in r
> (True, False)
> 
> With the corrected implementation, the results would always be the same,
> not different in the '3' case.
> 
> Additionally, my version avoids extra operation on the underlying
> dictionary.
> 
> Jeff
> 

Your version is simpler and correct in the case where the item is None
Integrating your version into the patch and resending, thanks!

