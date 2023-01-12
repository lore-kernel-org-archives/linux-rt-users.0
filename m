Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B97AC61DB3
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Jan 2023 10:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbjALKMA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Jan 2023 05:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237731AbjALKLJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Jan 2023 05:11:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D36C7;
        Thu, 12 Jan 2023 02:09:41 -0800 (PST)
Date:   Thu, 12 Jan 2023 11:09:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673518179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLAM5jl0W0wl/XlHApINoAqRk2rz+TLJ1Ghtr9ebUfE=;
        b=vcTGXdwHdoY4677vgiRLmUDxBn9xfcxcs9XzVWEFDZUqQg5YjgEAZnTPAy32VXxdUwDDTM
        ZWd3Uk/1xTms3FXpQSsdj8S1oJTDVovlO70fx1nF+672kQvXiiFOXhW11Uz5g+XO5iF7Ns
        u0H10Peg1Rv5Sr/ccv0XeZHOYn4JKfC3fUsfE6iDoKBraGrG3dYnwqE5acdKxsmLmBKMMi
        mr0VoXuU0fhBviSfOK0yqWLzauGele9lAq6VV9bjLQwOjFVN4n+PaC1wMe3qWshhSAj6U9
        FCnjkesFWpVDJ2MyhsRQyvzne5qBDHgaK0iufhvrFS+1/q0PT75CHqTdS9CiCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673518179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cLAM5jl0W0wl/XlHApINoAqRk2rz+TLJ1Ghtr9ebUfE=;
        b=VxWKJ/kxxAfgEhvPXtIgIePTtVsaN83zmhMIF+QXuZKqoBUw58ipVRZnmigKzDk3kl2+3o
        wBVlggp8D/vrAlAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michael Everitt <gentoo@veremit.xyz>
Cc:     Christian Eggers <ceggers@arri.de>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: linux-6.1-rt ?
Message-ID: <Y7/cYsEXHpCEGwwa@linutronix.de>
References: <12136223.O9o76ZdvQC@n95hx1g2>
 <208196df-d0b2-5cf6-29b3-4570a0946e77@veremit.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <208196df-d0b2-5cf6-29b3-4570a0946e77@veremit.xyz>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-01-11 09:44:45 [+0000], Michael Everitt wrote:
> On 11/01/2023 08:36, Christian Eggers wrote:
> > linux-6.1 seems to be the next LTS kernel [1]
> >=20
> > Are there any plans to release a -rt version of linux-6.1?
> >=20
> > regards
> > Christian
> >=20
> > [1] https://lore.kernel.org/lkml/Yz%2FZWBeNZvKenEVM@kroah.com/
> >=20
> >=20
>=20
> You probably want this: https://www.spinics.net/lists/linux-rt-users/msg2=
6345.html
>=20
> You may wish to wait for the maintainer to complete their processes!

There is a 6.1-RT but it hasn't been updated for a while. There should
be a 6.2-RT later today.
As for the link [1] it has not been confirmed nor denied that v6.1 will
be a LTS kernel. Once the version 6.1 left its Schr=C3=B6dinger state then
there will be an update (or not).

> Regards,
> veremitz/Michael.

Sebastian
