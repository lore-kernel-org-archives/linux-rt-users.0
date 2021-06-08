Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEF2C47082
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 09:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7768D61278
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 09:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhFHJdC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 05:33:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhFHJdB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 05:33:01 -0400
Date:   Tue, 8 Jun 2021 11:31:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623144668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Slf2w+xlv5rkyaGAjS+mTx33qFu3Rci7aniqOL0llzI=;
        b=xw02e3vLB8KbbkrMhGqTT8JkvUoxfXcny6NxfDWluaZo/bLu1uMw7ULJlRG+vNASuNcDur
        NqeWT4BArPeljnbeHuifq3Q+8OD1lyHUJ9lnPRi54Nrvue2VDmkkE8SHGZPIMzayWtB86I
        1VgbA+KBF6HRjVGcG67BbIuxEPOLdFv+OMSpGjPUeDjruVpCjPKG63ayujpv+p6uSkAaY4
        aCTjqXYNmb8J3LXmsy0jrDAs+cQtqIBqyOEbmhJ6C2pCwPTe4v0VGoYVkQHbIYSWhzJvq0
        9OzCW+9fEKxemOjYdUItusV9OH7z86UR5CK8lWrfyiRAQWcjDoffL8U9ZViJFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623144668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Slf2w+xlv5rkyaGAjS+mTx33qFu3Rci7aniqOL0llzI=;
        b=PaW0Z0WN1NDJuivmQkUAzmLc2EL2fpRAW3gD/UO7ZspI6G9YigO6whl6lfD0l1Rx5g3unU
        bn77AiCc1iE6xLAw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Christoph Mathys <eraserix@gmail.com>
Cc:     Linux RT Users <linux-rt-users@vger.kernel.org>
Subject: Re: Hung task in 4.9 using kvm 5.2
Message-ID: <YL842Rg3yRcTpW2r@lx-t490>
References: <CALqGcGpVOTGK+WDwqvX=W9140p8xrdAWn01vB8zb_6=mATSjHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALqGcGpVOTGK+WDwqvX=W9140p8xrdAWn01vB8zb_6=mATSjHw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jun 07, 2021, Christoph Mathys wrote:
>
> When running kvm 5.2 on 4.9-rt (I've yet to verify if !RT is also
> affected), kvm gets stuck regulary requiring a reboot. I get the
> hung_task warning below.
>
> Any thoughts on how to avoid this problem?
>

Did you try running the same configuration with lockdep ON?

Thanks,
Ahmed Darwish
