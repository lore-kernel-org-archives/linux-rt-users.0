Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2671DC7112B
	for <linux-rt-users@archiver.kernel.org>; Fri, 18 Aug 2023 09:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358903AbjHRJK4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358986AbjHRJKy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 18 Aug 2023 05:10:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05C5FE
        for <linux-rt-users@vger.kernel.org>; Fri, 18 Aug 2023 02:10:53 -0700 (PDT)
Date:   Fri, 18 Aug 2023 11:10:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692349852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=366j56/vZn5QvNYPy+FACrsn4iWOIMJR1+vJsRL/oFI=;
        b=ClhyigUpp/6CnXzfsJ1LT7GeLmwFGiiOQJybnMVd+6MDPPy9NIAL2O+f7UGOEuE2lFtQ9e
        3GTZ3ngMqqckDk4JcIF1y+gu49dX447omnVUvTLog1ay2kEgWOOn3vLgZ55JaxO7MyJ0/v
        Ue6CyH4jejuaNupu1tNOD8aH2XJSifnYNyCZa1bGtfVGTOfpMz0H5YNgulBnDRCOVqeFd/
        FTYZNVF1lfP0BgkA5oh/HlLLDqcP5tk8DOp+0WrWUJ83u3p9zdmmtjF8IIowZiy4/0zEvj
        do2xN8EcUle7WGOFtptFt445e00W5iZaHTy+VJjreVXjzdrh565E79VmAfnpSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692349852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=366j56/vZn5QvNYPy+FACrsn4iWOIMJR1+vJsRL/oFI=;
        b=7fMjiHIER9J2Z0WHDOLgwA4GYMme273ghbdxvvmGEaxariAs7WeAyUY65rPF8ma5vTQckD
        7eryqojLTlrFfsDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     =?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Wrong link target for 5.15-rt on website
Message-ID: <20230818091051.JktEDnLS@linutronix.de>
References: <VI1PR0102MB3136359075B0312101B31333FC17A@VI1PR0102MB3136.eurprd01.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <VI1PR0102MB3136359075B0312101B31333FC17A@VI1PR0102MB3136.eurprd01.prod.exchangelabs.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-08-14 08:58:32 [+0000], J=C3=B6rg Sommer wrote:
> Hi,
Hi,

> at the page
> https://wiki.linuxfoundation.org/realtime/preempt_rt_versions, the
> link for 5.15-rt on the right side points
> to=C2=A0https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.10 and not =
to
> 5.15. Can someone fix this?

Just looked at it and it seems to have been already corrected.

> Kind regards
>=20
> J=C3=B6rg Sommer
>=20
> Software Developer / Programmierer

Sebastian
