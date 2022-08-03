Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C34BC19F28
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Aug 2022 09:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiHCJh2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 05:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiHCJh2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Aug 2022 05:37:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCB220F44
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Aug 2022 02:37:27 -0700 (PDT)
Date:   Wed, 3 Aug 2022 11:37:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659519446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XnXHSfqdfiOJ0VnZizRNXxI+Mags2VejXuMK9Mi8FQI=;
        b=bshQ2+yW90JwfAzdlnPZBvYJI4byje3sUdJ++BcdaYHHro5VdLjC1/0WNe25NjqDD+gYTg
        UrTRhsEjWE94X5Lqt3Kja2Kh15socqnBLi27A+uo40rAGbFFGgftzJes2+dbw2EuOyf8cg
        sLUvZXvV0+HVKRZNrj93JbXuAILEEp10xNC0GK4MawfZIf/ZqQwX3a1Kf61ZrCzvn5SkrZ
        HkP6fYxXNMvmmKhzCCPSwznJl1Kc16SwIN8IfLci3NgiUFWjWCGiGFIfTCyDQHkyFUslTD
        H45KPy3EPE6XH1hV28T3eeoa+uITo1m1XLjfBw8fslrk6sa4c0j/a/wYkFT5Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659519446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XnXHSfqdfiOJ0VnZizRNXxI+Mags2VejXuMK9Mi8FQI=;
        b=ZYONzJMpdNCaMtVM4/il5GMtostyvTaI/aGahd+gXFvBOh9fawz/ovfQVFkK0jI+PHBD8u
        tirsGcrrsp8iPPCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     David Oberhollenzer <goliath@infraroot.at>
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com, richard@nod.at
Subject: Re: [PATCH 0/4] Backport MEMCG changes from v5.17
Message-ID: <YupB1LN+Ksbj2x6r@linutronix.de>
References: <20220712112238.18824-1-goliath@infraroot.at>
 <Yuobh/+/Sv8VTjTP@linutronix.de>
 <9263b71b-369c-6ec3-c55a-ed498b44cf66@infraroot.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9263b71b-369c-6ec3-c55a-ed498b44cf66@infraroot.at>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-08-03 11:17:22 [+0200], David Oberhollenzer wrote:
> Hi Sebastian,
Hi David,

> this patch set is based on the one Richard submitted in late
> June, but was asked to use the changes from v5.17 instead
> of v5.16. I was under the impression that this meant to use
> the state of the code in v5.17 instead, as some of the back
> ported code was refactored a bit further upstream.

You refer to
    https://lore.kernel.org/all/1958751921.205825.1655985764383.JavaMail.zimbra@nod.at/T/#u
 
> I tried to stick to Richards patch set, picking the equivalent
> changes in mm from the git history, leading up to the v5.17.1-rt17
> tag in linux-rt-devel. So, except for the changes to make it work
> on v5.15.49-rt47 in linux-stable-rt, those patches should represent
> what ended up in 5.17.1-rt17, right?

I pointed out the patches from the queue that ended upstream.
After upstream's review a few things changed like the revert of the
user/irq context and so on. For simplicity reasons I would prefer to
stick with one solution and not add the intermediate patches, that I had
in the queue before I was able to settle with upstream on something, to
release that is maintained for a longer period. So any problems that pop
in 5.15 should be same as in later releases.

The patches I mentioned ended up in v5.18 and were part of the latest
v5.17-RT releases including v5.17.1-rt17, yes.

> Greetings,
> 
> David

Sebastian
