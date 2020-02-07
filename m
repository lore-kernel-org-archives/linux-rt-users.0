Return-Path: <SRS0=JiWK=33=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB82C2D0B1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 06:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE692214AF
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Feb 2020 06:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UU2+H2IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgBGG5Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:57:25 -0500
Received: from mout.gmx.net ([212.227.17.20]:36431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgBGG5Y (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Feb 2020 01:57:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581058607;
        bh=Cxt2NFUUUKFNwgSj+3EKjubjQDBZl2ubG2wWTCgxvOk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=UU2+H2INTgHiW18UhuVeNpQsrEN4Bk9TekrOMr5CEDFM8WIruuYXXiyhG6TL6tGs0
         Dnveg3l0XT8hSdcTLCbTu+tiZRCn1IN9i4UiYXFFybEcTfFU2UfT9QXIA2ZvL69rg7
         OH0CxkrZQMzjkXrdsYxO0qpqOSoNPHoQhRJ03m0c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.simpson.net ([185.191.217.186]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1ipXAD2oEE-00BbBv; Fri, 07
 Feb 2020 07:56:47 +0100
Message-ID: <1581058605.7924.15.camel@gmx.de>
Subject: Re: [ANNOUNCE] v5.4.17-rt9
From:   Mike Galbraith <efault@gmx.de>
To:     Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Fri, 07 Feb 2020 07:56:45 +0100
In-Reply-To: <a6a9ba66-4e63-8156-2e49-291087d9e847@ccrma.stanford.edu>
References: <20200204165811.imc5lvs3wt3soaw2@linutronix.de>
         <cda47e2f-fd9d-c4c8-7991-64fef38af0ef@ccrma.stanford.edu>
         <1581055866.25780.7.camel@gmx.de>
         <a6a9ba66-4e63-8156-2e49-291087d9e847@ccrma.stanford.edu>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BO5ks6TFtwNHziRW7yb9XKFELx1d7nAOLfvmVbkop1dsw1oV0Ku
 bNGV3hN2VGW/8oXQPP9KgVhzG+06oKS752R7iByV8hrhoSvBZrp+HP8ULGYmdZVwelFSuvo
 6WC1ZXcabY0FHSy4ea3J1k8prk1JWQKqQ8T4I5Bn5xzF1AaGXAB+HyoxAffaXFvHZFptA9E
 jJbhMA3GU/ShDJAAzafUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sMBm4OHA23s=:viaMJr38wpKsHKbhyCAlE0
 Sg8qT7EblFEPJyqEZfUZGhSq003H7ehQ7sY7bCe3q99rnmDtxQyI6XkkOYcDXglytRwX0CkQv
 PnnniGdbxvYre41Vn3mQ2KkiVX9zaf8g9OTGi92cBX2cVtM8pF7nJ+EGECWrI09jEIG/1jAnD
 Fc1zqNbwKJktHAvlfCWHLlB5vy5oLAz7hC+XQFx1h5g2eqEwY9nnb4XodJDgQdk/ub+hOKHyH
 35YF2y4+7vJk/1xrzKJs1P7oijOhXrgx3eJ50xJ5GMF7yMEYJyzJoz5wCdVYdQrOfVHL7f3v/
 GjHftI/xm2jHEWUYPtNLLJ+lL7kfdHLcz7bVNLEv1ukhNLXyxGSNN0uTea454fAZLxdR1ZpCq
 4zqsblY/FHPnSdq2YL5AJQ1zs0DVRB/d3loZlbIf2geD1BXRaT9M0+QjLN25sKgXI4kVU3Cdy
 D5S2YwVwLQEn+3t8v3Wkw4UqdqDQHr7K2iHbf5QqqhKeL08HOBR7fjqKhxNcl4f1ZcINwIshf
 49ci8TfvSoXGHysNtEkSOu1o5CaFiPfRvxd8IkCjheG6S/4Q6U17N07aX/rPT/DN02x39R2g+
 5SISnZ1PtmEHu8YSTRis6GKBoWyRVyPOYO3ulGK/D2tiwLgcQP4Jae+r7YCfwRBxVgWqmGAWZ
 0lRYi18jaWH+0o0GL9zACF35VJOBFoMp/nDQfPvlkjoYGg0cYX8Qut3HPeBktUCoDeHlZLMk5
 qtNtFEjok84WjNxWoBp1tfGCootyP0gW7JH6AMQej+phf+OszcPgfTHnJ5RDfJE0GjsPqHSu5
 /oHjMI18XLmc4eIBWqOF8s3Y21Tcmd0haBFIXnZFdJlxiz8t6RCwxyL+YhHsfsvMYnGF9AmYB
 4tnX/zFRKlCwc3Y0isMz5gzHZUy1D8Ui4Lq7sE5Gh3c0UTFSeBJGNeYpmMvaV0pNAYh/DwT/o
 VRc6ud94Ab5B49Nt79VJwJ81i7d4f3VCJMtT/z9UpRo6ra/e7MDBeCGdbuLW8+Uzd/pawiLeQ
 NhQo3msJ0DjuiuDH95Yz+jZ6B50UhZxjsIjavxN+MbmVWBYZ3XGbVQUUxRZj/mUz+3UieOyiu
 ExXQWztveVrPsHkaKXNhegcoLF1cY4AtdJDeLJThRd5sv4yvrMHCY1oIrOLvV+xYnxgYgKYVi
 DNKJJmXcFbm0Y4wbPikIkegaR4FXNl1XgSGMN4PJrOsjA52PqOd8XiOIr52WTjTI2Dg5AMucZ
 tWrQ9fClBhbEtElr+
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2020-02-06 at 22:13 -0800, Fernando Lopez-Lezcano wrote:
> On 2/6/20 10:11 PM, Mike Galbraith wrote:
> > On Thu, 2020-02-06 at 15:59 -0800, Fernando Lopez-Lezcano wrote:
> >> On 2/4/20 8:58 AM, Sebastian Andrzej Siewior wrote:
> >>> Dear RT folks!
> >>>
> >>> I'm pleased to announce the v5.4.17-rt9 patch set.
> >>
> >> Thanks!
> >> I see a continuous stream of these:
> >
> > (snips gripage)
> >
> > Yup, d67739268cf0 annoys RT locking if lockdep is enabled.  The below
> > shut it up for my i915 equipped lappy.
>
> Wow, Mike, thanks!, will try it out and report...
> (might take me a couple of days)

I suspect you could just change the IS_ENABLED line to exclude
CONFIG_PREEMPT_RT from the lockdep hack instead.  Replacing
local_irq_disable() with a local lock is the routine fix, but in this
case it more closely resembles putting a bandaid on a bandaid :)

	-Mike

