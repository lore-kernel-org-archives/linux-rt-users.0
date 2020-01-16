Return-Path: <SRS0=M6fR=3F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33011C33CB1
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jan 2020 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F247B20730
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jan 2020 15:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedgreg-com.20150623.gappssmtp.com header.i=@embeddedgreg-com.20150623.gappssmtp.com header.b="SU/sHxkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgAPPMv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:12:51 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46428 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPPMv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Jan 2020 10:12:51 -0500
Received: by mail-oi1-f170.google.com with SMTP id 13so19108869oij.13
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jan 2020 07:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=embeddedgreg-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zLe95t6KVHkRB2vNcWc1gJozl5Yqy8EQ3cBiS7d11uI=;
        b=SU/sHxkb8ohphM15DWv+ukXy21gKRWv6FugwAqqBILIRkmrFvfxiGJa54FcG3ldwBu
         QBTmpiMZbTqcSBRHXIp+pT3O5YrMy8YtHBYDlO2O8jKKxZzA+4VT4/llWvg7hChDH4is
         U20kJ75Dd6jULSadUomYxKBMgoM9aeADI+nFCZeG1wj5uGiR1yzfEcu64bPm6AzG6DQw
         vJj+E8TsEposZgfWbS4t5HNlpq/gKJEzjlutp5w/8Y64+9goQZKxxm/cV+9N+BvG+ptV
         7UL+LDCFZwu/IVe0xUjLobkKrUByu1cjsM4qd1erKsntQqt3Zthf1d8C1oR+gVy/RtLh
         Ml0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zLe95t6KVHkRB2vNcWc1gJozl5Yqy8EQ3cBiS7d11uI=;
        b=tq8s4zEmjMUfRVQxlHzPoJay2XAAI9RHjQQDu+qb0wg3Q7u4+5ij189XgFlSufo/cw
         1cHjkMW8m9QvzXHE7eLqZAU8s8LT5qPwmLfs4pF60bCmXf5AFiWPmuSYaFN/GJp2froU
         Fm0mHjbDCwmz6PdzSf1uiEe+OqtjagfqukYYpmSwhdc7crCiKJXH+uSTOFCZf0X1DWe1
         xsldXThwWt729ebkRsSuH6yj43uZRYtpHcyHKiABaH1KmQFrhWRVxIUPL4vHsE6XUvx3
         4G3+eiBg7R4M3vajLL54kMhNjoDfk8ROjlhhNlMQGOioN3x7CkMSJITM/dQZDl2DzWPN
         X9MA==
X-Gm-Message-State: APjAAAWWi0DXxMA9tlkq9SPXGS5t2b3WiHlehDQ0BpQM4ozp6xFqdm6T
        qZYxwh44HmWTfhC5jrAvNCp9mgPWSKgueabGW2g5rP8e0JA=
X-Google-Smtp-Source: APXvYqwTV3MjK+P+Cmhy6h2uWHeQSRKagY+FUf7xgHvUOheH/jPSQ0DLXSPrQByyRFRW8Cj+gfLVedvSsbVMqgMaI0A=
X-Received: by 2002:a05:6808:3d0:: with SMTP id o16mr4401535oie.79.1579187570390;
 Thu, 16 Jan 2020 07:12:50 -0800 (PST)
MIME-Version: 1.0
References: <CALLqZ8QK5kJqwxZ-zze-OcwFCAWY5gDOmy_UwqUm89HE3rZ_gQ@mail.gmail.com>
 <559de2dd-c9fa-d5d0-af05-3537be9a9a79@monom.org>
In-Reply-To: <559de2dd-c9fa-d5d0-af05-3537be9a9a79@monom.org>
From:   Greg Gallagher <greg@embeddedgreg.com>
Date:   Thu, 16 Jan 2020 10:12:39 -0500
Message-ID: <CALLqZ8RW10upgssYB7q486JqRuZOJw+uYwyZnROFQvUZP0M-pA@mail.gmail.com>
Subject: Re: Any maintainers or developers looking for help?
To:     Daniel Wagner <wagi@monom.org>
Cc:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Daniel,

On Thu, Jan 16, 2020 at 4:24 AM Daniel Wagner <wagi@monom.org> wrote:
>
> Hi Greg,
>
> On Wed, Jan 15, 2020 at 01:06:30PM -0500, Greg Gallagher wrote:
> > Hi RT users and developers,
> >    I was wondering if any RT maintainers or developers that are on
> > this list need any help with tasks that they haven't had a chance to
> > do (documentation, small fixes, testing etc)?  I've been working with
> > RTOS's, Linux and C for the past ten years, I've contribute to smaller
> > open source projects in the past.  I'm still a novice when it comes to
> > working with the open source community and I'm reaching out to the
> > list since if possible I'd like to work with someone to start.  I know
> > that not everyone has time to help but I thought I would reach out and
> > see if I could help someone clear out some old tasks that need to be
> > completed in exchange for some help getting started contributing to
> > the RT project.
>
> One thing which could be a good starting point is testing the various
> devel-rt and stable-rt releases. There are a bunch of tests tools in
> rt-tests (which could also some love). I am sure you will find things
> which are not working in either the kernel or in the rt-tests.
>
> Another related thing is automate the testing. For example I'm using
> LAVA[1] to orchistrate my small lab with Linaro's test-definitions[2]
> as test harness. Everthing is duck taped together but works pretty
> awesome for me. I've created a small (but horrible) python script
> which allows me to configure, build and submit the binaries for
> testing to LAVA in one go.
>
> Thanks,
> Daniel
>
> [1] https://github.com/igaw/lava-docker-compose/tree/lithium-setup
> [2] https://github.com/igaw/test-definitions/tree/preempt-rt

I will start looking at what you mentioned above. Thanks for replying,
I=E2=80=99ll post back once I=E2=80=99ve made some progress.

Thanks

Greg
