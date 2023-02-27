Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871DEC64ED6
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Feb 2023 13:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjB0NIX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Feb 2023 08:08:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjB0NIW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Feb 2023 08:08:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590421D91C
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Feb 2023 05:07:45 -0800 (PST)
Date:   Mon, 27 Feb 2023 14:07:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677503263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obO/SQkWBeEE3l7wth+4ItzmUQFXvZh3jr9i7iqgu1Y=;
        b=uT6H62SLZjxMAnCv2OPfcL6f31cU6mgDzUyqydQ7swXqJYA5Kr5iHb6O5FjOuNCJg0imtw
        WWcyR1yrDCIFMN6JcIMfDGUqthfSnCscx8GE0dZ4AjmVmD9jjHboR6p7nITfFG03DoO+ed
        avjUqLX5CKCdI+e3p0mWo2bS0FzNI/DIePKa5pqQdIKUZvFsiktQaWGZlElOWskF4KWZoX
        xCthOw1kO0KpWcoXmyVVbxkZKf+q05IKSE9GT2BfYLlR6a2sgQxnp9JF1aen9Pb7gqE+rL
        I0Is0GXdjBrQIZxB1yCCPZEhJdQJuuwWAioWQInZgHnTcWw+76iAWCU1gr4GSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677503263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=obO/SQkWBeEE3l7wth+4ItzmUQFXvZh3jr9i7iqgu1Y=;
        b=9qrAJ5ifbYqMlE5Is4KPt9jT4vzCQqyuwlp2fdF5o49GfPTc19rWeoTwTXE9xTehvMVr8F
        75AAl9adP1sxYECQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     =?utf-8?B?RnLDqWTDqXJpYw==?= Martinsons 
        <frederic.martinsons@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Kernel lock during cryptsetup luksClose
Message-ID: <Y/yrHe4OIYcWFbNO@linutronix.de>
References: <CA+cAkeoDrm-33JkuL6nQa7s7foqdCWvwt9Y9PZa5Qj58gATqtQ@mail.gmail.com>
 <CA+cAkeq+z8D3j7FQFrW4BxfS97a490B_U3yskYm8+oatYfxZAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CA+cAkeq+z8D3j7FQFrW4BxfS97a490B_U3yskYm8+oatYfxZAg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-02-27 10:52:59 [+0100], Fr=C3=A9d=C3=A9ric Martinsons wrote:
> I don't know how to go deeper to understand why preempt-rt is blocking
> of this, any ideas ?

The blocking / wake mechanism is different. There should be only one
waiter so the rcuwait_wait_*() mechanism has to work. The previously
used swait* may add multiple waiters to the queue but also wakes only
one waiter at a time.

> Another question is about the impact of reverting commit
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/co=
mmit/?h=3Dv4.19-rt&id=3D7fcfa8b616d360ab9ea1da94c2200f0708e0188b
> , what are the risk of doing that ?

That has been used before and the rcu-wait mechanism is what we use
upstream. That revert should case no harm.
I would need to reproduce this to figure out if this is a generic
problem or if the backport is bad.
Basically speaking (and you could add printks to figure that out)
manage_workers() should wake on task and that should be the one waiting
in put_unbound_pool(). But this is somehow not happening based on your
description.

Sebastian
