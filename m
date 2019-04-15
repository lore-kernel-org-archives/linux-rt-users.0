Return-Path: <SRS0=uP6E=SR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB65EC10F0E
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 09:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFC82073F
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 09:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfDOJHI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Apr 2019 05:07:08 -0400
Received: from david.siemens.de ([192.35.17.14]:43455 "EHLO david.siemens.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfDOJHI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Apr 2019 05:07:08 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by david.siemens.de (8.15.2/8.15.2) with ESMTPS id x3F9725J020808
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 11:07:02 +0200
Received: from [139.25.69.33] ([139.25.69.33])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x3F96xJg018644;
        Mon, 15 Apr 2019 11:06:59 +0200
Subject: Re: [PATCH v1] rt-tests: Add --duration argument to tests
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20190312154738.10925-1-daniel.wagner@siemens.com>
 <alpine.LFD.2.21.1904051709150.8480@planxty>
From:   Daniel Wagner <daniel.wagner@siemens.com>
Message-ID: <5aa0dc82-b6db-bece-e2df-1c048801d2f6@siemens.com>
Date:   Mon, 15 Apr 2019 11:06:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1904051709150.8480@planxty>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On 05.04.19 17:11, John Kacur wrote:
> I like the idea, I am happy to apply it, but 
> this is a huge patch and it isn't applying cleanly> - could you break it up in separate patches for different tests?

Sure, will do.

> - somehow (maybe your text editor) has added a few dos style line endings

No idea what happened and I blame emacs :)

> - make sure this is against unstable/devel/latest

Maybe that was the error and I used an different branch. I'll rebase my
changes on this branch. Sorry for the inconveniences.

Thanks,
Daniel
