Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7BAC04A6A
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 14:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjHIOKU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 10:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjHIOKR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 10:10:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D31FC2;
        Wed,  9 Aug 2023 07:10:15 -0700 (PDT)
Date:   Wed, 9 Aug 2023 16:10:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691590213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=noWBD67sxwgfpDxVn5HQfHTCZ2nyTiiimOeqdbCjcso=;
        b=nvaYQJQUAdZmgsWOiEPU0GNhlbs+h5eGRuHTPIPkEjJvhBHQxWLiMVj4prAoZmCNVSylfh
        +0yVUYPXiGl/nWhTSttOxadCXt1cl+/ECge7VtSzySZZTdkFIXSvITb4BlwqeKHNgvOk/a
        TgJ+NVSwAiiVy1i3R1kijv+bZl7pV+ds++ugDURLy1L0RLZOFSZlsbo8OjD5md2qNrLFUO
        Uhr3A2zVTT03VE13n3KjYXn4ApKlRy1TBDIwew7Sb75j2IklfuU4kJzq2RnWubvLVh677t
        DOByC6jI+M0qLnKTXRN/jgAeesvsQZ3dW+vKnjjBmbUVxNJgEs2hOW0WQcQXSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691590213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=noWBD67sxwgfpDxVn5HQfHTCZ2nyTiiimOeqdbCjcso=;
        b=l4UB3n3d0OnxRzjXWtk2P/2NaElgb0we9EfCqpkGw9snoGAKFi/a4OTLUmc/4G0OjS0+7W
        zF6W7GdyczG7CUCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RT 0/3] Linux v4.14.320-rt152-rc1
Message-ID: <20230809141010.QbP3Wx1R@linutronix.de>
References: <20230808163520.305842-1-lgoncalv@redhat.com>
 <20230809081738.qhWKi8Os@linutronix.de>
 <ZNOZw6ubyVkrqw+J@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZNOZw6ubyVkrqw+J@uudg.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-08-09 10:50:59 [-0300], Luis Claudio R. Goncalves wrote:
> On Wed, Aug 09, 2023 at 10:17:38AM +0200, Sebastian Andrzej Siewior wrote:
> > Looks good, just a nitpick: If you add 2/3 you don't need 1/3.
>=20
> Agreed. I just kept 1/3 because I wanted to both give credit to Andr=C3=
=A9 Pribil
> for reporting the problem and also highlight the symptom he observed.
> Should I add that as a note on 2/3 and drop the first patch?

Sure. Instead of fixing that one incident (and there were of few of
those as far as I remember) it is more future proof to do what Steven
suggested.

> Thanks for reviewing the RC!
> Luis

Sebastian
