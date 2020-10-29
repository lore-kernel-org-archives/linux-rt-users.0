Return-Path: <SRS0=4gYA=EE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1B3C4363A
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 15:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62462204FD
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Oct 2020 15:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E/cPwjyT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c6ozP1tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgJ2P5i (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Oct 2020 11:57:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34452 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgJ2P5i (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Oct 2020 11:57:38 -0400
Date:   Thu, 29 Oct 2020 16:57:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603987056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTZOa+//aMH74VL0z77wkXBp4M05tDrOUAallEy6SFE=;
        b=E/cPwjyTZX3uLIvo6i6y6EeLehNIs8bJtlfccqTLIWQ8aR9+vFJh/IWMzntqtoSrJTz9YE
        CSIMT0DQdF/Iv/FmJRYvL4RBzFflx431BgbrgFvVkUeDN4sZBv8Jw+s9xoWDGO9IjPnfon
        QKHcusUjmYajL9zPJ9j+fUnLASMCSezA+55Y9MEsWX9jn0B1f7xpcYOKPZyx4yFRJ6raqD
        rzMfFdtpOxABxhQLx3vZCVWFhu2I/40fI6zaphx9cQQ3KKRuTcWZXM0kF/MvWSOtHgxRlt
        Tfmc9wYNlI0vKF5pJzqRta4KsRfVkQtkwoWPKkDg/aCDHL9dvRZNI5VCPRbqsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603987056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GTZOa+//aMH74VL0z77wkXBp4M05tDrOUAallEy6SFE=;
        b=c6ozP1tbzVEYvlYA6y9BhD8ND1Qul16f0dHplnJ9Qz2MhCkOSx3A06KdPRiLP1e85xEoBj
        LDlXkDFzcR2m/qDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     dieter@bieler.li, linux-rt-users@vger.kernel.org
Subject: Re: Error-Report rt-tests
Message-ID: <20201029155735.xsiqv6ocqemz6yiu@linutronix.de>
References: <006101d6ab85$88d32f70$9a798e50$@bieler.li>
 <007501d6ab85$f3369910$d9a3cb30$@bieler.li>
 <20201028164059.m7ygqaikxqox6res@linutronix.de>
 <3cb8be1a-3e69-dbcc-363-30c1a15e3afd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3cb8be1a-3e69-dbcc-363-30c1a15e3afd@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-10-29 11:33:57 [-0400], John Kacur wrote:
> 
> It's a bit odd because the libraries are static.
> Isn't that quite an old version of glibc as well?

It looks like Ubuntu 20.04 / Focal Fossa. The glibc version above is
when the symbol was first introduced.

It builds on i386/Debian Sid, just tested. Noticed this however:
|~/rt-tests$ make
|Traceback (most recent call last):
|  File "<string>", line 1, in <module>
|ModuleNotFoundError: No module named 'distutils.sysconfig'
|make: Nothing to be done for 'all'.
|~/rt-tests$ python3 -V
|Python 3.8.6

wouldn't it work to just keep "PYLIB  ?=" and the caller passes what he
needs?

> John

Sebastian
