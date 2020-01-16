Return-Path: <SRS0=M6fR=3F=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B88C33CB1
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jan 2020 16:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D257C2087E
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Jan 2020 16:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLl4dSJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgAPQAn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:00:43 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37725 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgAPQAn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Jan 2020 11:00:43 -0500
Received: by mail-qt1-f193.google.com with SMTP id w47so19242370qtk.4
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jan 2020 08:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5guGcHWpqmvlvLPoir8oZVFU3RzuI9bXWQAhV6+tSA0=;
        b=tLl4dSJBxsimAbIriCToqeGJZWj3Gd4542fxrBoS4oBlybXNSGp0COXjY/++47EWdT
         8xUgQNkThvbjO+6DkELwlkAPB7BDsl5vb8Nxr2Rom3i+7lfJEHVqbRA95iae6WfiRsJH
         QQcwpmASYCPwqd4VApQLpEdGJRHqa8Ra65zFRGnqbMQkWU/KFbl9eZUWjih/nrCzc12B
         HsrEtjC17idte75o/1r1uneXWAIwEEsJ8uMb2x6ABrS0ccANrh3Os2O29l3kwhtZwG4u
         2Pf0yT9Ke4glyPxqY+Y4qaJ8XdLKZZNZX6f1ECnJqEnEi57iV55a5j2WxshrPLiqr03R
         1b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=5guGcHWpqmvlvLPoir8oZVFU3RzuI9bXWQAhV6+tSA0=;
        b=Zp8uP1eJZhjMkbigtJK/amJQlcgUPhREGxC7PNgTKHri1fYzMohDFLd7Hc4aP2LZUD
         jbPyBCLRo0lHfgHTk5wNq78g15KHD+m04npLg3PkZmkCfcAhcdi34JixzsrawIFHjmvF
         IVT+MEElTe4FjuyZS8d1xKUnzI4sKH97sMVfJYn8cMPJzGl+O7FY4/RZo5aquNJiqLws
         LZeRSvIvfWdIASewy/ARlRAFCvMvOozQ35DApPYJwG3mFn5k8FIhSMhxDa+KV2C52D9A
         2jL3knAW+wVrzRRba1nKl1E0WC8/lk8g6C00MG0v7f9AI6RWQtXRRTz1doJhmcKMeCAA
         icYQ==
X-Gm-Message-State: APjAAAW/vbOjrqFQyoBmMY+BnXagF7RSS5qcQ5FHEj7enFexwelPuk3T
        RZMBDaIW5C1v7sfqo5TQF6GbP0SCUsk=
X-Google-Smtp-Source: APXvYqx9AbnNMReWIA87fpzwKEsDyzk7U6Pep1E+C25MlV3QyyvHciLTgV0LfObG8QmHeh9hbHzKkA==
X-Received: by 2002:ac8:4693:: with SMTP id g19mr3113636qto.295.1579190442479;
        Thu, 16 Jan 2020 08:00:42 -0800 (PST)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id z1sm240959qtq.69.2020.01.16.08.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 08:00:41 -0800 (PST)
Date:   Thu, 16 Jan 2020 17:00:34 +0100 (CET)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Greg Gallagher <greg@embeddedgreg.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: Any maintainers or developers looking for help?
In-Reply-To: <CALLqZ8QK5kJqwxZ-zze-OcwFCAWY5gDOmy_UwqUm89HE3rZ_gQ@mail.gmail.com>
Message-ID: <alpine.LFD.2.21.2001161659020.7528@planxty>
References: <CALLqZ8QK5kJqwxZ-zze-OcwFCAWY5gDOmy_UwqUm89HE3rZ_gQ@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 15 Jan 2020, Greg Gallagher wrote:

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
> 
> Thanks everyone for their time and sorry to spam the list,
> 
> Greg
> 

This is almost always the wrong approach. If you are interested in 
real-time then start working with the kernel and supporting software, and 
then if you see things that don't work the way you would like, or you have 
ideas for improvements, then submit patches.

Cheers

John
