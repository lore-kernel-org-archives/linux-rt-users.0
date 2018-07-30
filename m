Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:48290 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730613AbeG3Wh2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 30 Jul 2018 18:37:28 -0400
Date: Mon, 30 Jul 2018 15:59:31 -0500
From: Julia Cartwright <julia@ni.com>
Subject: Re: How to apply RT patches to a kernel not listed in
 http://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/
Message-ID: <20180730205931.GL29574@jcartwri.amer.corp.natinst.com>
References: <CAF_dkJC2UqpDVGzF4K575_hZYii_-OL6H1h=nNO8mTQm4QK2SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF_dkJC2UqpDVGzF4K575_hZYii_-OL6H1h=nNO8mTQm4QK2SQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Patrick Doyle <wpdster@gmail.com>
Cc: linux-rt-users@vger.kernel.org

On Mon, Jul 30, 2018 at 03:22:32PM -0400, Patrick Doyle wrote:
> I have a choice of 4.9.87 or 4.9.109 in my vendor supplied kernel to
> which I would like to apply an RT patch set.  Unfortunately, neither
> kernel is listed as a target kernel for the patches archived at
> http://cdn.kernel.org/pub/linux/kernel/projects/rt/4.9/older/.  Also
> unfortunately, patch sets from nearby versioned kernels (such as
> patch-4.9.84 and patch-4.9.98) do not apply cleanly.

Most of the major vendors make available RT variants in their official
repos, have you checked with them?

> What would you (the ever helpful experts that live in the internet,
> always willing to offer advice) suggest that I do to address my
> dilemma?  Should I take the most recent (probably 4.9.98/rt76) branch,
> rebase it on 4.9.109, clean it up as best as I can (basically, get a
> kernel that compiles, and hopefully even runs) and submit the rebased
> patch set here for your review?

I'm in the process of cooking up a version ontop of v4.9.116 this week.
This doesn't directly address your problem, as it still may not apply
ontop of your v4.9.109 vendor kernel, but might get you closer.

   Julia
