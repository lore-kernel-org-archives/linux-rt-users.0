Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA1EC433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 08:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982F661184
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 08:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbhJOIZk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 04:25:40 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:56256 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhJOIZI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Oct 2021 04:25:08 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E79B618BD;
        Fri, 15 Oct 2021 10:22:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1634286178; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=JPgSDG5I9o6xHmpjKVzilCOcZk5995CHFhUH4VgF+es=;
        b=MKi+05q3WR9dtFTSoKU+qtP5xhgq6ATbzg4W1l6wqsz2d3X75XcTCTDpF6i0yS4VW8NQ41
        jwd/DtNpf7XTbVXp+5KaoBxI8B6slZF/gXxgXHmyUdSModXmTRJkSFcTOxWkuqpqLkyLzZ
        TmpfryGQxZgdjgGnkINSYfcwwsbmbAVXvUchpMevHPNjoT7fmxsqUyL4dqiIJ8Ryrm//Tq
        Hu9/5FxyOaQYo88pZb4hjtpb+7Fn6IBRVSO/wMnbgg8oXzYR9l4ZAQPGL9bHAN8muYrFLV
        /CQbjn3ekSByMrfwuo8meVEtCQPQW4A3La+7dwHUervaUTwNKrxpSc0RUqfwaw==
Date:   Fri, 15 Oct 2021 10:22:51 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Punit Agrawal <punitagrawal@gmail.com>
Cc:     jkacur@redhat.com, Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        williams@redhat.com, linux-rt-users@vger.kernel.org
Subject: Re: [RFC 7/7] rt-tests: cyclictest: Add support to report standard
 deviation
Message-ID: <20211015082251.wmyknmgnxjqc3jb4@carbon.lan>
References: <20211014071247.4165329-1-punitagrawal@gmail.com>
 <20211014071247.4165329-8-punitagrawal@gmail.com>
 <20211014115043.s3zf5p3s7dglvcjb@carbon.lan>
 <87r1cm1zz8.fsf@stealth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1cm1zz8.fsf@stealth>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Oct 15, 2021 at 04:58:19PM +0900, Punit Agrawal wrote:
> Sure, I can bump up the version to 1.1 - minor update as it's adding a
> new field rather than changing existing ones. Or "2" if that is
> preferred.

I'd say we just increment the number to 2 and don't any semantic meaning
to the version number. Instead push the compatible checks to the user
side. I suspect many don't care anyway.

BTW, I've noticed we print the version number wrong. Currently,
'cyclictest --version' will print 'V 2.20' instead 'V 2.2'. The printf
formatting string is wrong. Same in the JSON output.  If you don't mind
you could update this well when you are updating file version
string. Thanks!

> I can look at adding support for standard deviation to the other tools
> if there's interest once the cyclictest changes have been merged.

Yeah, there a couple of tests which quite similar. So you might just
have to move the newly added code to util.h(?) and add the calls to the
tests.. It shouldn't be too difficult just a bit of repetitive
work. Probably a good starting point for an intern :)

> Thanks for taking a look.

Thanks for contributing!

Daniel
