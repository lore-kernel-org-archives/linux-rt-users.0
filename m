Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52778EB64DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Jun 2023 15:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjFTPxf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Jun 2023 11:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjFTPxe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Jun 2023 11:53:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0144F4;
        Tue, 20 Jun 2023 08:53:33 -0700 (PDT)
Date:   Tue, 20 Jun 2023 17:53:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687276412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8j6pwnylz+InGT1r1+A4jY+CzUPLe5e9Bq6HCRJbEiw=;
        b=FZwrDfYT4uML+1nOdwxzxdtEd6ge0pgCUEXUL4MPNXmyGMu69/HmyxflKgI9S7UOhlh6Fr
        mpcidhoP0deeS8c4ZkpYU+ottTHOa0JjZVni8aMuEKPrQ08gAs4f9EiU0klwwA9sp82/ok
        W470gqSD2Tr1DdxqUc5rT0LFtQmcQnm31c6r8/gI6nYC2Dhb6eSpIggxXVCwDeh7AMnL5a
        BSFZ4ca4vGX/LfYgENFZCzIuNj/YI41ugk/Pz53gCfdvhoJHKycidJ5I2Emyv9l0Q3S7LF
        q5CW+ck/YYPMgANzUq6Q/vKR95ePFY08PKnQwqvcJOt02jrkaDj5x0endWqmMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687276412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8j6pwnylz+InGT1r1+A4jY+CzUPLe5e9Bq6HCRJbEiw=;
        b=eFGayox60aRAOBeeI39Trx4zcqWvG4/uM2apX4W1tY1cJSuuyqwq17DJ4NAMfaF/8ZSnbh
        hDfGIWudTrwmjeDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Jeff Brady <jeffreyjbrady@gmail.com>
Subject: Re: [PATCH RT 3/3] Linux 5.10.180-rt89-rc1
Message-ID: <20230620155331.QmYyGFc8@linutronix.de>
References: <20230609011104.967128-1-lgoncalv@redhat.com>
 <20230609011104.967128-4-lgoncalv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230609011104.967128-4-lgoncalv@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-06-08 22:11:04 [-0300], Luis Claudio R. Goncalves wrote:
> v5.10.180-rt89-rc1 stable review patch.
> If anyone has any objections, please let me know.

Thank you, this looks good. Looking at it again made realize that I need
something like 2/3 in my tree, too.

Sebastian
