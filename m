Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6310C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 18:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C042073C
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Nov 2020 18:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgA1JSmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbgKWSjz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Nov 2020 13:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgKWSjz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Nov 2020 13:39:55 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0845C0613CF
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Nov 2020 10:39:54 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id t5so14139695qtp.2
        for <linux-rt-users@vger.kernel.org>; Mon, 23 Nov 2020 10:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=lMtOfxxFTfp1fwkblUJ5OazgzQEXpDsO530XSsymG2I=;
        b=CgA1JSmdx2hjCXXfrguHLU8k1HsuAmXWZFOp/2R/CEowfAU6hTQPBpSjbl1zur51UW
         cOgropyfnaZ1MWYDXbOqHqBviNt0Cs671bdCymiFZgxKMneow0y/mBIcSRmt/I9mchfM
         Qnj7jNVNfOBaZxHuQaXm9wM39EWzdNrymm0LjjWJhPgxkGGc8QeSY8mGj9NFECzHhX/V
         FAszk7UpfyqQjlp49gczB6zxkyRY11DwmVMzuclo0BHgWtK7BK/ld5ny8qmP+YZil7ao
         o1pwBLKKkAYt1ny0WuAKgULvAMcUm5QxlbQPCYUsBDWZCb6gppXTb+RouKTTjEmL/Uz/
         uoYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=lMtOfxxFTfp1fwkblUJ5OazgzQEXpDsO530XSsymG2I=;
        b=nDboEug83jcz07CQRg8wAOoo0QvjXju3gS40GqiYXtKegHVwga5qjCEm3jhcTOu1pJ
         A3PyGhKSFihmegXUiFWH5S//yhKt2VUi0eikpdEzo7t/liyb9viqTR9rw4DqVa4St5tV
         4BLNB1kg6jQ9mp7+orGlgktJ2ebe+E7qO4w8x9Uftl2kmYuOZPnta5RD4J6kA/M2cj5g
         upY3ISjHUbkqzPjYs5wXb0ter27ouR6ljdIQUrHdafdkZq21pP99dMO8EcSxas6xRwY6
         +R+no1v2KjWXIkCVntTZUusZgUG4Jv9aqrE0N7b/A2rMjEQmw4Kxg+9mqrbuZihwvnSN
         eu1g==
X-Gm-Message-State: AOAM5304DKcYW2SpIr6nErmr3+1VpqcCcENLRcr9u9Uns3xyvD//7T7t
        Dc2RvNowXUxi6YXpsT9cstRTojAkpap+ag==
X-Google-Smtp-Source: ABdhPJyTViUQOf8mEkxogu92pVYfww2U2JnHozf8T1MqoL3wpFG4r4EswXr3E+08Oy7aXEKlHg3CmA==
X-Received: by 2002:ac8:4cc1:: with SMTP id l1mr522952qtv.128.1606156794199;
        Mon, 23 Nov 2020 10:39:54 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id p6sm9008884qkh.105.2020.11.23.10.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 10:39:53 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Mon, 23 Nov 2020 13:39:46 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH] rt-tests: Don't compress man pages by default
In-Reply-To: <87y2ivuirq.fsf@kurt>
Message-ID: <b524dda-d17b-5390-7b56-388297a34b9d@redhat.com>
References: <20201121051925.24507-1-jkacur@redhat.com> <87y2ivuirq.fsf@kurt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 21 Nov 2020, Kurt Kanzenbach wrote:

> On Sat Nov 21 2020, John Kacur wrote:
> > This patch changes the default behavior of the Makefile to install
> > man pages without compression. This allows distribution build systems to
> > use the kind of compression they wish to use without the Makefile
> > getting in the way.
> >
> > It is still possible to compress the man pages using the Makefile, for
> > example
> >
> > make MAN_COMPRESSION=gzip
> >
> > or
> >
> > make MAN_OMPRESSION=bzip2
> >
> > Signed-off-by: John Kacur <jkacur@redhat.com>
> 
> Yea, that's why I introduced that option in the first place :). Up to
> now I've used MAN_COMPRESSION=none for build systems.
> 
> Acked-by: Kurt Kanzenbach <kurt@linutronix.de>
> 
> Thanks,
> Kurt
> 

Added your comment and ack to the commit
Cheers!

John
