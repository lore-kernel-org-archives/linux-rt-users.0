From: Alexander Dahl <ada@thorsis.com>
Subject: Re: kernel 4.9.39
Date: Wed, 20 Sep 2017 10:18:03 +0200
Message-ID: <7139918.Kz6vm8i5iO@ada>
References: <CAEYdEeRhQ+OTQcuM4a0pTQ4JkVNftp6Q8jwQDD4hMS9JFzHR+Q@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.thorsis.com ([213.211.200.15]:49331 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751578AbdITIXw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 20 Sep 2017 04:23:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 18EB23A2214
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Sep 2017 10:18:42 +0200 (CEST)
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0QKj6aEi0zfS for <linux-rt-users@vger.kernel.org>;
        Wed, 20 Sep 2017 10:18:38 +0200 (CEST)
In-Reply-To: <CAEYdEeRhQ+OTQcuM4a0pTQ4JkVNftp6Q8jwQDD4hMS9JFzHR+Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hei hei,

Am Dienstag, 19. September 2017, 23:13:56 CEST schrieb Brian Wrenn:
> foreseeable future, we only can use 4.9.34 or 4.9.39.  I looked on the
> PREEMPT-RT site's list of patches, but I don't see one for either of
> those versions.  Just for the sake of trying, I attempted to patch
> 4.9.39 with 4.9.40-rt30, but to no surprise that failed.
> 
> Do I have any other options?  Does a non-published PREEMPT-RT patch
> that would successfully patch 4.9.39 exist somewhere I haven't looked?

In Git I see tags for those version in the linux-rt-devel tree:

v4.9.30-rt21-rebase
v4.9.33-rt23-rebase

And those in the linux-stable-rt tree:

v4.9.35-rt25-rebase

And there are even non-rebased tags for 4.9.34 and 4.9.39, maybe you can 
export a working patch stack just from Git?

Greets
Alex

