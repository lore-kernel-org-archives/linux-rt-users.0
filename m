From: Alexander Dahl <ada@thorsis.com>
Subject: Re: [ANNOUNCE]  4.9.61-rt51
Date: Thu, 23 Nov 2017 09:09:43 +0100
Message-ID: <1514845.ahB3SCdmRW@ada>
References: <20171121103736.7998954a@gandalf.local.home>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.thorsis.com ([213.211.200.15]:52670 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751437AbdKWIT3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Nov 2017 03:19:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 05A843A350F
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Nov 2017 09:10:43 +0100 (CET)
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Pi22zPjt5nCD for <linux-rt-users@vger.kernel.org>;
        Thu, 23 Nov 2017 09:10:41 +0100 (CET)
In-Reply-To: <20171121103736.7998954a@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Steven,

Am Dienstag, 21. November 2017, 10:37:36 CET schrieb Steven Rostedt:
> You can get this release via the git tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
> 
>   branch: v4.9-rt
>   Head SHA1: d0bcb84cbec27d7eb876b6f1d1fffdb65ccefcd4

The last tag on the branch 'v4.9-rt' is 'v4.9.61-rt51'. The last tag on the 
branch 'v4.9-rt-rebase' however is 'v4.9.61-rt61-rebase'. In both cases the 
localversion is set to '-rt51'. So I guess just that's just a typo in one of 
the tags and the next localversion will be -rt52 as written in the rc2 for 
that you posted today?

Greets
Alex

