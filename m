Return-Path: <SRS0=M6fR=3F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E768DC33CB1
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jan 2020 09:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77B12073A
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jan 2020 09:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbgAPJYE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Jan 2020 04:24:04 -0500
Received: from mail.monom.org ([188.138.9.77]:57924 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgAPJYE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Jan 2020 04:24:04 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id D7F4C5006C0;
        Thu, 16 Jan 2020 10:24:01 +0100 (CET)
Received: from [192.168.154.174] (b9168f78.cgn.dg-w.de [185.22.143.120])
        by mail.monom.org (Postfix) with ESMTPSA id B40F2500305;
        Thu, 16 Jan 2020 10:24:01 +0100 (CET)
From:   Daniel Wagner <wagi@monom.org>
Subject: Re: Any maintainers or developers looking for help?
To:     Greg Gallagher <greg@embeddedgreg.com>
Cc:     linux-rt-users@vger.kernel.org
References: <CALLqZ8QK5kJqwxZ-zze-OcwFCAWY5gDOmy_UwqUm89HE3rZ_gQ@mail.gmail.com>
Message-ID: <559de2dd-c9fa-d5d0-af05-3537be9a9a79@monom.org>
Date:   Thu, 16 Jan 2020 10:24:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CALLqZ8QK5kJqwxZ-zze-OcwFCAWY5gDOmy_UwqUm89HE3rZ_gQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Greg,

On Wed, Jan 15, 2020 at 01:06:30PM -0500, Greg Gallagher wrote:
> Hi RT users and developers,
>    I was wondering if any RT maintainers or developers that are on
> this list need any help with tasks that they haven't had a chance to
> do (documentation, small fixes, testing etc)?  I've been working with
> RTOS's, Linux and C for the past ten years, I've contribute to smaller
> open source projects in the past.  I'm still a novice when it comes to
> working with the open source community and I'm reaching out to the
> list since if possible I'd like to work with someone to start.  I know
> that not everyone has time to help but I thought I would reach out and
> see if I could help someone clear out some old tasks that need to be
> completed in exchange for some help getting started contributing to
> the RT project.

One thing which could be a good starting point is testing the various
devel-rt and stable-rt releases. There are a bunch of tests tools in
rt-tests (which could also some love). I am sure you will find things
which are not working in either the kernel or in the rt-tests.

Another related thing is automate the testing. For example I'm using
LAVA[1] to orchistrate my small lab with Linaro's test-definitions[2]
as test harness. Everthing is duck taped together but works pretty
awesome for me. I've created a small (but horrible) python script
which allows me to configure, build and submit the binaries for
testing to LAVA in one go.

Thanks,
Daniel

[1] https://github.com/igaw/lava-docker-compose/tree/lithium-setup
[2] https://github.com/igaw/test-definitions/tree/preempt-rt
