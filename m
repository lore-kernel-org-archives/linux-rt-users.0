Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE774C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 14:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66DF60F39
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 14:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235173AbhKLOdS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 09:33:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56950 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbhKLOdO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Nov 2021 09:33:14 -0500
Date:   Fri, 12 Nov 2021 15:30:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636727422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I37K4kE/SSZ3LANG/W6JO2Wx6xJnFVocNggfyhSfs94=;
        b=Cl7xRPK742yOa0kD8g/tnKjC5kjhUSGi0hioKhVb8n8F/E0HiRtzWx2EP1Q1C8wEXA+nam
        YwGJi5jX/tfAhMq179EANHDMM245zpl0ZKmdALVUhNw+xi8wpYpJhGtfiAbOLkQPurBiTm
        tyKY8LxBRD81WtOQuSgoeq0f1xFpqIGCCqnXiE2vik3+ypo5xs9XJxXk3oO04xIA/uCIH/
        YxGCVWVHTIaN6IQetfL0V8D9sg+0YtDZj5vAdHVebwdzyd0eIm7zGvABsf2KU8dwQoSbaA
        SfyBE/TEaD3EdC89Aw46YE2m6lzSAUjtniNDuUNDhv4kx3kR3V6glnn43QvaxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636727422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I37K4kE/SSZ3LANG/W6JO2Wx6xJnFVocNggfyhSfs94=;
        b=Kj3enviRm+Z56LEUQT7WRfoOI1cTuLTPj/9qLbYAiMKzZ4Eh1Qx6G5udDMDHXX3kMFP74f
        le2LefqeTiJkZSCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Gylstorff Quirin <quirin.gylstorff@siemens.com>
Cc:     linux-rt-users@vger.kernel.org,
        "Kiszka, Jan (CT RDA IOT SES-DE)" <jan.kiszka@siemens.com>,
        SCHILD HENNING Z003BPMR <henning.schild@siemens.com>
Subject: Re: Questions to CI Testing the RT-Kernel
Message-ID: <20211112143020.ci72q3yfamjx6pgt@linutronix.de>
References: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <290ce1c2-9298-7b98-1717-771c2602687e@siemens.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-08 11:28:15 [+0100], Gylstorff Quirin wrote:
> Dear all,
Hi,

> Our questions are:
>=20
> From what I found the RT-Project also uses the combination of cyclictest
> with hackbench for testing or are there currently any other tests
> specifically for real-time executed?
>=20
> Are there recommended tests that should be added to the CI testing of a
> RT-Kernel?

In general you want to have two categories:
- A debug run with lots of debug switches enabled like lockdep,
  debug-objects and what not.

- A "production" run where all of those expensive debug swiches are off.
  That "sleeping while atomic" is cheap and could remain enabled.

In these two types of config you want to run tests. As mentioned here
hackbench, stress-ng, =E2=80=A6 is a good start. You want also make sure th=
at
you "use" all of your hardware that could be used in "production"
including disk, i2c, gpio, =E2=80=A6 and what else might be there.

While doing this, you don't want see any warnings in your debug config.
In your production config you want also to measure the responsibility/
latency of the system. cyclictest is good and simple but depending on
your usecase it might also include the latency of IPC communication,
ping-ping of network communication, etc.

Sebastian
