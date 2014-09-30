From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Tue, 30 Sep 2014 12:44:55 +0100
Message-ID: <CAKudYbMN0W2uiKN-TEMMkHLUNyeBP38syjg0x7DtAvj1fZq+YA@mail.gmail.com>
References: <542A88A8.7060800@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:48722 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbaI3Lo5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 30 Sep 2014 07:44:57 -0400
Received: by mail-lb0-f182.google.com with SMTP id z11so7805319lbi.41
        for <linux-rt-users@vger.kernel.org>; Tue, 30 Sep 2014 04:44:55 -0700 (PDT)
In-Reply-To: <542A88A8.7060800@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Sep 30, 2014 at 11:40 AM, Armin Steinhoff <armin@steinhoff.de> wrote:
> a "pthread_setschedparam" call of the code below terminates with an
> errno == 1  ... means "Operation not permitted"

At risk of asking the obvious: are you running as root, or does the
user running this code have RT priorities?

User priorities controlled by /etc/security/limits.conf : you can set
a groups max-rtprio like so:
@audio          -       rtprio          65

> KERNEL_EVENT_THREAD_PRIORITY is 55!
> How to solve that problem ?

Anything above 50 requrires changing limits.conf  or root IIRC.

HTH, -Harry

-- 

www.openavproductions.com
