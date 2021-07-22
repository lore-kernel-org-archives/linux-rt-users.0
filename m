Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E464C6377D
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jul 2021 18:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4984460E75
	for <linux-rt-users@archiver.kernel.org>; Thu, 22 Jul 2021 18:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhGVRvp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:51:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhGVRvn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Jul 2021 13:51:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80E3260E52;
        Thu, 22 Jul 2021 18:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626978738;
        bh=f+Xzx+cvZKHTFGwpY7JIGLwaDfSnqspVO2fRIGR6ADs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k28rRwb1XMOGOxr2Ec0NgAjsWGSLEn11EmQFvkgSx44zB0G/C4uyp0NND5A00ANRO
         deStNiGfjAuiytL7cd+KP3KnCWBpYllLa2M8VCQ79Z30g/QoQRsTfY9kKJ7oi57qZl
         HY6g512+f+ZQX13HXPRqY2GQcqOviXlDIyZZnqUPw4VxZfeJgOPTofnEhqtgWz+ITa
         1jPtv/CHb6SwYxGhDxIRZfG8GsSGwm2OVLDLcY7pe/cYVONuW+7t1cegJT5GG9cTY1
         jgayPaK1HdFIZNOVsnTJqxXxMWeSn9mNitR5goV17AdZbQc/0g9NdvUweAc7Psn2Nr
         yAt0/oCxCijKQ==
Date:   Thu, 22 Jul 2021 19:32:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 3/3] arm64/fpsimd: Fix FPSIMD context handling vs
 PREEMPT_RT
Message-ID: <20210722183210.GF5258@sirena.org.uk>
References: <20210722175157.1367122-1-valentin.schneider@arm.com>
 <20210722175157.1367122-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CXFpZVxO6m2Ol4tQ"
Content-Disposition: inline
In-Reply-To: <20210722175157.1367122-4-valentin.schneider@arm.com>
X-Cookie: Who's scruffy-looking?
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--CXFpZVxO6m2Ol4tQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 22, 2021 at 06:51:57PM +0100, Valentin Schneider wrote:
> Running v5.13-rt1 on my arm64 Juno board triggers:

Acked-by: Mark Brown <broonie@kernel.org>

> [   11.337654] WARNING: CPU: 4 PID: 1 at arch/arm64/kernel/fpsimd.c:296 task_fpsimd_load (arch/arm64/kernel/fpsimd.c:296 (discriminator 1))
> [   11.337692] Modules linked in:
> [   11.337705] CPU: 4 PID: 1 Comm: init Not tainted 5.13.0-rt1 #52
> [   11.337719] Hardware name: ARM Juno development board (r0) (DT)
> [   11.337727] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> [   11.337740] pc : task_fpsimd_load (arch/arm64/kernel/fpsimd.c:296 (discriminator 1))
> [   11.337755] lr : task_fpsimd_load (arch/arm64/kernel/fpsimd.c:296 (discriminator 3))
> [   11.337769] sp : ffff800012f4bdd0
> [   11.337775] x29: ffff800012f4bdd0 x28: ffff000800160000 x27: 0000000000000000
> [   11.337797] x26: 0000000000000000 x25: 0000000000000000 x24: ffff0008001606f0
> [   11.337816] x23: ffff000800160000 x22: ffff000800160700 x21: ffff000800160000

For readability it's probably better to not include the entire register
contents here - the backtrace ends up about as large as the actual
changelog, a good chunk of which is just the register contents.

--CXFpZVxO6m2Ol4tQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmD5uakACgkQJNaLcl1U
h9AXFQf/S9Uk8BsNr9Z+kVJ+rAhXbHiD71pa+gIempnKTu7eP6bY1H/w3nBPzQ+d
0W8+2R7vkpdnt4/QuAkmRk83w/h5lngAnQoxS+C9lb7kgcAy2WImWtzYZ2H3oqKD
Ww21EOX1mWTrlacFXk0a3syu7J9cVsQrr2UPD206ao0NPuL4r4nHu8uflbnMRl5c
LzAR7Tli81wysBGSo6vhl1IIDSJNdoWkUhpLMZ9MpGeWrGNTvgoguHiSf5zsND2y
7jSRCgbmwMWRjmFlqlYK4Q0tcE/4TSVl6xDrQ/JNUgi44h+4oJ3UZFB3zs0hKGNo
upjxPB5ojkXQrZmDdnhgsQAIUvRneQ==
=46wG
-----END PGP SIGNATURE-----

--CXFpZVxO6m2Ol4tQ--
