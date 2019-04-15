Return-Path: <SRS0=uP6E=SR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B74C10F0E
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 10:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BC320684
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Apr 2019 10:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfDOKpT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:45:19 -0400
Received: from thoth.sbs.de ([192.35.17.2]:54400 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbfDOKpT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Apr 2019 06:45:19 -0400
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id x3FAjE9O011707
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 12:45:14 +0200
Received: from [139.25.69.33] ([139.25.69.33])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id x3FAjEbp014911;
        Mon, 15 Apr 2019 12:45:14 +0200
Subject: Re: [PATCH] srt_create: Make sure series output is sorted
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
References: <1555090299.12566.35.camel@kernel.org>
From:   Daniel Wagner <daniel.wagner@siemens.com>
Message-ID: <a5e77810-7ab9-d3c1-0a14-a2067e528fee@siemens.com>
Date:   Mon, 15 Apr 2019 12:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555090299.12566.35.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Tom,

On 12.04.19 19:31, Tom Zanussi wrote:
> Hi Daniel,
> 
> I actually used your stable-rt-tools srt tool this time to do the
> latest 3.18-rt update release - overall it works well and did the job
> nicely!

Glad you tried it! Thanks!

> I did run into one serious problem in that the series file that gets
> created for the patches tarball lists the patches in essentially random
> order on my system, so using it to apply the series with quilt failed
> immediately.  The patch below fixes the problem for me.

Oh, something I haven't written a test yet for it :(

> There were a few other things I ran into which boiled down to
> essentially lack of documentation and/or informative enough error
> messages, and one or two things having to do with my workflow on two
> separate machines that I'll have to think about.  I'll write some
> patches addressing those and sent when I get the chance.

Sure, just send them. I am sure I forgot a few things to document or
described it wrongly. Also I think the workflow could be improved. I am
not so happy with the 'OLD_TAG NEW_TAG' arguments stuff. It would be
cool if the tool would figure that out on itself.

> Anyway, thanks for the useful tool!

:)

Patch applied.

Thanks,
Daniel

