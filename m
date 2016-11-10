From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: Ubuntu 16.04 with Intel i7-6700
Date: Thu, 10 Nov 2016 10:01:58 +0100
Message-ID: <20161110100158.0b2df05b@archlinux.localdomain>
References: <CAK+oA4U8=YwZb5ewpZSDRO+FPv1EgvvbSgoumdooaunTXKsjCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail77c50.megamailservers.eu ([91.136.10.87]:42590 "EHLO
        mail70c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751664AbcKJJKG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Nov 2016 04:10:06 -0500
Received: from archlinux.localdomain (x5ce0d1bb.dyn.telefonica.de [92.224.209.187])
        (authenticated bits=0)
        by mail70c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id uAA91wCL001178
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Nov 2016 09:02:00 +0000
In-Reply-To: <CAK+oA4U8=YwZb5ewpZSDRO+FPv1EgvvbSgoumdooaunTXKsjCg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

by default Ubuntu starts everything that is contained in a packages,
that could be auto-started, let alone that an Ubuntu desktop flavours
install tons of services you unlikely need at all.

Consider to install Ubuntu from e.g. the server image, after
unchecking all recommended packages. Then install just what you need
and after installing a package, disable all unwanted auto-start stuff,
or use a distro, e.g. Arch Linux, that follows another approach and
btw. provides rt patched kernels.

Regarding Intel I don't have experiences, but I often read that
hyperthreading seems to cause issues.

Regards,
Ralf
