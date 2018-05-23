Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.monom.org ([188.138.9.77]:53756 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932380AbeEWKkK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 May 2018 06:40:10 -0400
Subject: Re: How to investigate different timings of 2 HW with same kernel ?
References: <CAJ2oMhJmqTn5S-6Pk7j3-dwQMgK1Aii=B_spJFJmaj4iGOVGYw@mail.gmail.com>
 <893c67d2-576d-7033-53dc-85daa5379b73@monom.org>
 <CAJ2oMh+tCSVT9mHkEzDP25FdwgBKkLCx3oLnkq+9ch6wpk1nhA@mail.gmail.com>
From: Daniel Wagner <wagi@monom.org>
Message-ID: <5f49c939-47cd-faaa-4eda-b3f3ad0f4597@monom.org>
Date: Wed, 23 May 2018 12:40:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ2oMh+tCSVT9mHkEzDP25FdwgBKkLCx3oLnkq+9ch6wpk1nhA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

Hi Ran,

> If this is the case, it probably means that is using a more standard
> tool for rt-test like  cyclictest, would have been better.

Yes, it rules out one of the variables in the equation. Though
cyclictest has a lot of option which is also source of confusion.

Thanks,
Daniel
