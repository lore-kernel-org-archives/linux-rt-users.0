Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677FEC4363A
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8CCA2076E
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 17:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+Ji2hgk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PNCQ4nsI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgJ2Rq1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 13:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgJ2Rq0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 13:46:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B57DC0613CF
        for <linux-rt-users@vger.kernel.org>; Thu, 29 Oct 2020 10:46:26 -0700 (PDT)
Date:   Thu, 29 Oct 2020 18:46:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603993585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nTSoqZmtiMLmno8BSi3drf/mV29qjN47f9AM0QvL3/I=;
        b=I+Ji2hgkUj9zcW91nD7Vry3+/Pm3rXenVZul5A1oZvpeIhsGwjja2QZsxq91mHR6TggfCE
        fzfzU7cjUrppC5rQMKx1i4TVIc9lTUSuv8epuR32Uo6ioXyaxp2ztLy7mIHdj3PIC1ooIA
        ggKqLX4r69JJSnMbb+koAj4EwTwepoSS3MjMzaVpU8gWIOOMGu6JNYSpdvgAxWtQf1yDeo
        KpLm48oHYJ/I318CdFB8AsZypHk0My+JzPJ/EBwptINIWGQemrDQzYVcpzzjK95KDwHtam
        BXCG1MXFbPS97ZwjmmBg093/UhNZBEG/l85V3ff/x1B+NM6qVxZ2yhUKcXtEsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603993585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nTSoqZmtiMLmno8BSi3drf/mV29qjN47f9AM0QvL3/I=;
        b=PNCQ4nsIGBykUhSP//oujtBaamINT4s4RafUeIej9acbNXNNJuUvGBVMpPa9d4udpnwFu2
        YVp1d+GN/m8PdLBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     dieter@bieler.li, linux-rt-users@vger.kernel.org
Subject: Re: Error-Report rt-tests
Message-ID: <20201029174623.qrswktayb2dcepgx@linutronix.de>
References: <006101d6ab85$88d32f70$9a798e50$@bieler.li>
 <007501d6ab85$f3369910$d9a3cb30$@bieler.li>
 <20201028164059.m7ygqaikxqox6res@linutronix.de>
 <3cb8be1a-3e69-dbcc-363-30c1a15e3afd@redhat.com>
 <20201029155735.xsiqv6ocqemz6yiu@linutronix.de>
 <bed1ae81-a6e9-c255-60bc-c3f1f49a5ef8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bed1ae81-a6e9-c255-60bc-c3f1f49a5ef8@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-29 13:03:43 [-0400], John Kacur wrote:
> Right, ?= in the makefile means if it's not already set, then set it to 
> what comes next. You could just do make PYLIB=""
> in order to skip the python stuff.
> 
> On my fedora box if you were to set it by hand it would be
> make PYLIB="/usr/lib/python3.9/site-packages"

This make it complicated. Usually for python things you provide an egg
file or something like that. That long line above isn't that bad given
that you don't install yourself to /usr/lib/python3.9/site-packages. You
build a RPM page which throws it there and RPM package has build rules.

> John

Sebastian
