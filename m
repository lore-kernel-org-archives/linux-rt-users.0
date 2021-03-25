Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D39C433C1
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 10:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C476961A2D
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Mar 2021 10:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCYK0X (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Mar 2021 06:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCYKZ5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Mar 2021 06:25:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F028C06174A;
        Thu, 25 Mar 2021 03:25:56 -0700 (PDT)
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616667954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8M2cYuv+o8ckXgUJOh96RGdmsVojf8wOXGPODgVc1Zs=;
        b=3Sbwbe208oss5Dto7P9+g4FIcjvJbzjzL/YrRxhh8gwYPl8OBl9Iiv/PD2a8cSVCz5uwLe
        gI2v3SxO1Qonybwn1zev7I1DdpMGGm9poVMi3uyO04MVBvMt7/NDJO9pbCZNmyHB763sAO
        xl3mSQQlMhrAOeJiTL6fNxdRAb2o8yoHq9agfiDaZ3/mpQuy2U7sBe2AQzH6uinJbRSzTu
        g3T3NxFUU8IPLOwhpDMjPdU5/zlYcpL43gsRGKiyILBX7BlK0QQlppbK9ZSLb8widx38DJ
        Dh0b/tqzG7enwYJCoKxdhFNdBYdFWkgv/tQROPVkM0V02KNBFIPQ6Vp4xhmSKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616667954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8M2cYuv+o8ckXgUJOh96RGdmsVojf8wOXGPODgVc1Zs=;
        b=CuOkWlVa9rN+D2OszUYJTO1LS7KpW9zVcqMYEWIu6Nv95kXL6RDZBoS3+d5G84ZgL0eY2F
        3xXbts4/ynV1vhAQ==
To:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.12-rc3-rt3
In-Reply-To: <1f63f1fcea10fc179881384cd838b1c9e5207b82.camel@gmx.de>
References: <20210319223357.uknv2t5uvxvzb46x@linutronix.de> <1f63f1fcea10fc179881384cd838b1c9e5207b82.camel@gmx.de>
Date:   Thu, 25 Mar 2021 11:25:53 +0100
Message-ID: <87a6qr1qdq.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Sat Mar 20 2021, Mike Galbraith wrote:
> On Fri, 2021-03-19 at 23:33 +0100, Sebastian Andrzej Siewior wrote:
>> Dear RT folks!
>>
>> I'm pleased to announce the v5.12-rc3-rt3 patch set.
>
> My little rpi4b is fairly unhappy with 5.12-rt, whereas 5.11-rt works
> fine on it.  The below spew is endless, making boot endless.  I turned
> it into a WARN_ON_ONCE to see if the thing would finish boot, and
> surprisingly, it seems perfectly fine with that bad idea. Having not
> the foggiest clue what I'm doing down in arm arch-land, bug is in no
> immediate danger :)

Yeah, I've had the same issue with my Marvell
ESPRESSObin. WARN_ON_ONCE() made it boot and it runs without any
problems since then. Thanks!

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAmBcZTEACgkQeSpbgcuY
8KYH7A/+LkK+R/55nbQY4YUbuc5XajfaulCmr/hztxf2mGLX0xjiG1V8cYI2Cvcb
P4eoqa/yD4fVqT2pxdhseTfyNyphql1csIU5QwnbbfwrfH6GyKPwlMlc1U/ESH32
47lUab4sARRWW33p0m93f+lHTtUsjXmoP/wDxU0bkJeRLiNUPOwviSHO6rfSkhjg
YwUc5neNiwk9gPSUOcA4VetSMWyGwT0XJ0kM675maqD0XWrxg6u/uOME3oKPYbqB
XHfRvW58qi/1cVNZ5Af0uX7X82v1gxm5Oh9H67LZVd12Ym++fNCXkIVtPqJ9x8gs
jtU7U3OkudzeDZGp92J0tN17qSON7l44lmibxtpoKMvZ+A6k5rQZ8ZDNvtel3QN7
x89dk3emOKnikT7PiTblar0Gk9HiSmr9wD+83wgfG4gLZI5VZGuiSLlSqU4ceeLu
aoPX9aIQH4D/pEoZKXV+axgljaOxIpDOFVR0ec6NxNt/sl63h58cW4H0d3YZ2KYK
3Gvq82FqF+OAAP15Dwl3pklUOdkvHyhenz1Fo6zlbhqEpMo8fuV4kDeC/BXBHxrd
OxIb7UsBQn7pylNzVqac27WqlcssG1829FI8W+k1BIdVETRSBJeMl/mj5j1s8M0P
DiqvizVSOaWwSP6t1ltnJ6RgtHIPQjm7xLYNW4wf5qaU5McRilY=
=xK6B
-----END PGP SIGNATURE-----
--=-=-=--
