Return-Path: <SRS0=koMT=DI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F712C4727E
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Oct 2020 19:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDD520872
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Oct 2020 19:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgJATA5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Oct 2020 15:00:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:20875 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729412AbgJATAc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Oct 2020 15:00:32 -0400
IronPort-SDR: KZmjeRMchhajMpUuijoZyjoev2AusVJH7TeFKqz3pnUgm+Df8Y9QN9SCxe5OI3Qqxzalq2+r/2
 Am60HSBYpgIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="163668663"
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="163668663"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 12:00:27 -0700
IronPort-SDR: nY1GFRypI+1AIb8+Ahqe2yjqXnsClG69KKtVAbVxwgQLunkeKIJaZskeB+s/hSGriFa+0ZZ9GQ
 12TAxr1qg5Uw==
X-IronPort-AV: E=Sophos;i="5.77,324,1596524400"; 
   d="scan'208";a="308753859"
Received: from akshayka-mobl.amr.corp.intel.com ([10.251.155.101])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 12:00:25 -0700
Subject: Re: rt-tests v1.9 fails to compile on architectures that aren't
 x86_64, i386 or PPC64
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
References: <62cb6195-7116-db1d-2af2-264dbd854ddb@linux.intel.com>
 <20200930154522.GD107801@xz-x1>
From:   Randy Witt <randy.e.witt@linux.intel.com>
Message-ID: <a7cfa682-af20-6b7c-ccd8-cb9ef6303fa8@linux.intel.com>
Date:   Thu, 1 Oct 2020 12:00:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200930154522.GD107801@xz-x1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 9/30/20 8:45 AM, Peter Xu wrote:
> Hi, Randy,
> 
> On Mon, Sep 28, 2020 at 03:14:23PM -0700, Randy Witt wrote:
>> With the addition of the oslat test in v1.9, "make" with no arguments will
>> fail on any architecture that isn't x86_64, i386 or PPC64. This is due to
>> the #error added here https://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git/tree/src/oslat/oslat.c?h=v1.9#n72.
>>
>> Since there is no build time configuration to turn off particular tests, is
>> the expected workflow to specify the set of desired tests as make arguments?
>>
>> In the absence of some sort of configure script, should there be a variable
>> that allows for tests to be removed from the set of TARGETS?
> 
> I think we can, but instead of maintaining this knowledge both in the build
> system and in oslat.c, I'm thinking maybe we can simply do that in oslat.c, let
> it build but dump an error message for any unsupported archs.  Patch attached.

Sorry I didn't have time to respond yesterday. I think this patch is a good 
solution. It's much better than having to know the set of compatible tests.

> Another solution (as mentioned by John offlist) is we implement a common frc()
> like fetching the time.  However since the __measure_cpu_hz() will always try
> to calculate the cpu HZ, then the HZ could be confusing then.  Considering the
> "read the processor clock" operation should still be the ideal implementation
> for frc() (and I really doubt whether there'll be real need to run oslat on
> other archs...), maybe we can use the simple way for now.

Would you be willing to help me understand why it wouldn't be useful for other 
archs? I am most likely missing something obvious, and apologize if that's the case.

> What do you think?
> 
> Thanks,
> 

