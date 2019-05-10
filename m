Return-Path: <SRS0=J4zX=TK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6A1C04A6B
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 May 2019 12:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2A1E20850
	for <linux-rt-users@archiver.kernel.org>; Fri, 10 May 2019 12:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekAXYyXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfEJMI2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 10 May 2019 08:08:28 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33228 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfEJMI2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 10 May 2019 08:08:28 -0400
Received: by mail-ot1-f68.google.com with SMTP id 66so5365972otq.0;
        Fri, 10 May 2019 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YbCl65MSgp87W10JhHwLPXqBtuU9y/s5j/l66J39gyM=;
        b=ekAXYyXt/rxl3zEoSfFTEhFySRcywqbuGR9RlhBScdj522Rlm7wyAnWQkBRug/L0l8
         46EuskQ2aKaNacgVA1O/S1doQy2m54dB3krDkjbREtsvyqzozcmlizmrvrEE2ClQ6E8T
         LLbnl7Q74MXO7gVd0Z5YWe/Fu50wpl5RZaRC+QK9eaYIewqmflDYiT/fnUOLHfqoIVJp
         AAgFrzIZygUIBDKjgiWTcjca9HYyXHYtZ2aLtjOrnS4qfBZUBVGeUgOWPHALJK2z+rsW
         t8rDMjEUmuMmsC1jbA37+ZodGfmp30KLB9d1+5cwe5I1L8ODSA+oBaDkb4zoTsya13pI
         AjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=YbCl65MSgp87W10JhHwLPXqBtuU9y/s5j/l66J39gyM=;
        b=MVUOm5qkyEWmQJFuVQiQW6xQ2XflUihBWJMc3ScdUwszyIr+72ZUTKs32KOJ2uJ003
         syFszKwatJopZUgyxJJY5R2hG/HGGv96d3BjN0Js+DqxlMCyUj8Qqat7EYMMhPteZYJP
         tyJC32Ydx0rpg6ckMtSp6mYWHrCugl/plgGaSFMlzOZEadsTLuiilNHfFamimThN2eEf
         B/RIER6bBtkqcjXLFh8l7PUUlbfORMGyu581qHh899et8tZtmRj4nnRzL/qjAMmHiTGh
         VOmHXYbdl7cr45zO9QqSkI4T6akXLIhQsd+2SDn8UDgRLA0pr0+RNkmUQ6yznewi8YqO
         Co+Q==
X-Gm-Message-State: APjAAAUeVOm0bYSagHbqXXf4L1fqPvYX5/DTxL0KwKi9GIm7LxtMKAAu
        Ym0nCkxt9lyIY28Hav1kuA==
X-Google-Smtp-Source: APXvYqzcrCHTgVPYdjcKmTwSHJ+7XA+Ql+lh3XG6B0+VesUS/7Ra/hADwDdPm6QKNnVfhNuGKWxCRA==
X-Received: by 2002:a05:6830:150f:: with SMTP id k15mr295066otp.349.1557490107053;
        Fri, 10 May 2019 05:08:27 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id o5sm1877406otl.44.2019.05.10.05.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 05:08:26 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:d5e:aa5a:44d8:6907])
        by serve.minyard.net (Postfix) with ESMTPSA id C43A618190F;
        Fri, 10 May 2019 12:08:25 +0000 (UTC)
Date:   Fri, 10 May 2019 07:08:24 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH RT v2] Fix a lockup in wait_for_completion() and friends
Message-ID: <20190510120824.GL16145@minyard.net>
Reply-To: minyard@acm.org
References: <20190509193320.21105-1-minyard@acm.org>
 <20190510103318.6cieoifz27eph4n5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510103318.6cieoifz27eph4n5@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, May 10, 2019 at 12:33:18PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-05-09 14:33:20 [-0500], minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > The function call do_wait_for_common() has a race condition that
> > can result in lockups waiting for completions.  Adding the thread
> > to (and removing the thread from) the wait queue for the completion
> > is done outside the do loop in that function.  However, if the thread
> > is woken up, the swake_up_locked() function will delete the entry
> > from the wait queue.  If that happens and another thread sneaks
> > in and decrements the done count in the completion to zero, the
> > loop will go around again, but the thread will no longer be in the
> > wait queue, so there is no way to wake it up.
> 
> applied, thank you.
> 
> Sebastian

Thanks a bunch.  Do I need to do anything for backports?  I'm pretty
sure this goes back to 4.4.

-corey
